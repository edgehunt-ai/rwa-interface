import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../app/providers/idempotent_command_guard.dart';
import '../../../../data/api/idempotency_key.dart';
import '../../../../app/providers/observability_providers.dart';
import '../../../../app/providers/session_scope.dart';
import '../../../../domain/models/api_failure.dart';
import '../../../../domain/models/decimal_value.dart';
import '../../../../domain/models/self_custodial_withdrawal.dart';
import '../../../../domain/models/portfolio_asset.dart';
import '../../../../domain/models/withdrawal.dart';
import '../../../../domain/models/wallet.dart';
import '../../../../domain/models/wallet_action_execution.dart';
import '../../../../domain/repositories/portfolio_repository.dart';
import 'funding_execution_validation.dart';
import '../../account/providers/account_providers.dart';

final selfCustodialWithdrawalProvider = FutureProvider.autoDispose
    .family<SelfCustodialWithdrawalSummary, String>(
      (ref, id) =>
          ref.watch(fundingRepositoryProvider).getSelfCustodialWithdrawal(id),
    );

final selfCustodialWithdrawalCommandsProvider = Provider((ref) {
  ref.watch(sessionGenerationProvider);
  return SelfCustodialWithdrawalCommands(ref);
});

final class SelfCustodialWithdrawalCommands {
  SelfCustodialWithdrawalCommands(this._ref);
  final Ref _ref;
  final _guard = IdempotentCommandGuard();
  final Map<String, WalletActionExecution> _executions = {};
  final Map<String, GasPaymentMode> _executionModes = {};
  final Set<String> _authorizationSubmissions = {};

  /// Creates the server-side intent so its frozen transaction and gas estimate
  /// can be reviewed. Never signs: the user confirms the observed fee first.
  /// Confirming the same [attempt] twice replays one idempotency key, so a
  /// repeated tap cannot leave a second intent behind. A gas estimate is only
  /// observed while creating, so returning to the form and reviewing again
  /// raises [attempt] to obtain a fresh observation — otherwise a wallet that
  /// topped up its native balance would keep replaying the stale one.
  Future<PreparedSelfCustodialWithdrawal> prepare({
    required WithdrawalQuote quote,
    int attempt = 0,
  }) {
    _validateRequest(quote);
    return _runObserved(
      operation: 'prepare_self_custodial_withdrawal',
      context: const {'stage': 'prepare'},
      successContext: (prepared) => {'withdrawal_id': prepared.withdrawalId},
      command: () => _prepare(quote, attempt: attempt),
    );
  }

  Future<PreparedSelfCustodialWithdrawal> _prepare(
    WithdrawalQuote quote, {
    required int attempt,
  }) => _guard.run(
    operation: 'self-custodial-withdrawal-prepare',
    fingerprint: '${quote.intent.fingerprint}|$attempt',
    command: (createKey) async {
      final wallet = await _findWallet(quote.intent.chain);
      final asset = await _findAsset(quote, wallet: wallet);
      // The endpoint takes the canonical EVM identity, never the opaque
      // `asset_id` that /v1/portfolio/assets returns; that one is rejected
      // with 422.
      final assetId = asset.canonicalEvmId;
      if (assetId == null) {
        throw StateError('Asset has no canonical EVM identity');
      }
      final prepared = await _ref
          .read(fundingRepositoryProvider)
          .createSelfCustodialWithdrawal(
            walletId: wallet.walletId,
            assetId: assetId,
            chain: wallet.chain,
            amount: quote.intent.amount.value,
            destinationAddress: quote.intent.address,
            idempotencyKey: createKey,
          );
      _validatePrepared(
        prepared,
        assetId: assetId,
        asset: asset,
        wallet: wallet,
        quote: quote,
      );
      return prepared;
    },
  );

  /// Runs the platform-sponsored path: the server freezes an execution, the
  /// wallet authorizes that exact Privy request, and the server relays it so
  /// the platform pays gas.
  ///
  /// Throws [SponsoredGasUnavailable] when sponsorship is refused before any
  /// broadcast — the contract requires a fresh user confirmation before the
  /// user-paid fallback in [executeUserPaid] may run.
  Future<SelfCustodialWithdrawalSummary> execute({
    required WithdrawalQuote quote,
    required PreparedSelfCustodialWithdrawal prepared,
  }) => _runObserved(
    operation: 'execute_self_custodial_withdrawal',
    context: {
      'withdrawal_id': prepared.withdrawalId,
      'mode': GasPaymentMode.appSponsored.name,
      'stage': 'execute',
    },
    command: () => _executeRelay(
      quote: quote,
      prepared: prepared,
      mode: GasPaymentMode.appSponsored,
    ),
  );

  /// Explicitly confirmed user-paid gas; only the backend publishes the call.
  Future<SelfCustodialWithdrawalSummary> executeUserPaid({
    required WithdrawalQuote quote,
    required PreparedSelfCustodialWithdrawal prepared,
  }) => _runObserved(
    operation: 'execute_user_paid_self_custodial_withdrawal',
    context: {
      'withdrawal_id': prepared.withdrawalId,
      'mode': GasPaymentMode.userPaidNative.name,
      'stage': 'execute',
    },
    command: () => _executeRelay(
      quote: quote,
      prepared: prepared,
      mode: GasPaymentMode.userPaidNative,
    ),
  );

  Future<SelfCustodialWithdrawalSummary> _executeRelay({
    required WithdrawalQuote quote,
    required PreparedSelfCustodialWithdrawal prepared,
    required GasPaymentMode mode,
  }) => _guard.run(
    operation: 'self-custodial-withdrawal-execute',
    fingerprint: '${quote.intent.fingerprint}|${prepared.withdrawalId}',
    command: (key) async {
      final repository = _ref.read(walletActionExecutionRepositoryProvider);
      final withdrawalId = prepared.withdrawalId;
      var execution = _executions[withdrawalId];
      if (execution != null) {
        final current = await repository.get(execution.executionId);
        _validateExecution(
          current,
          prepared,
          execution.mode,
          previous: execution,
        );
        execution = current;
        _executions[withdrawalId] = current;
        if (_authorizationSubmissions.contains(current.executionId)) {
          return _reload(withdrawalId);
        }
        if (current.mode != mode) {
          if (current.mode != GasPaymentMode.appSponsored ||
              !current.requiresUserPaidFallback ||
              !current.gasPayment.fallbackAllowed) {
            return _reload(withdrawalId);
          }
          execution = null;
        }
      } else if (_executionModes[withdrawalId] case final previousMode?) {
        if (previousMode != mode) {
          throw StateError(
            'Unresolved execution must be observed before changing gas mode',
          );
        }
      }
      if (execution == null) {
        if (mode == GasPaymentMode.userPaidNative) _requireGasBalance(prepared);
        _executionModes[withdrawalId] = mode;
        final created = await repository.createSelfCustodialWithdrawalExecution(
          withdrawalId: withdrawalId,
          mode: mode,
          idempotencyKey: scopedIdempotencyKey('$key-${mode.name}'),
        );
        _validateExecution(created, prepared, mode);
        _executions[withdrawalId] = created;
        execution = await repository.get(created.executionId);
        _validateExecution(execution, prepared, mode, previous: created);
        _executions[withdrawalId] = execution;
      }
      if (mode == GasPaymentMode.appSponsored &&
          execution.requiresUserPaidFallback) {
        throw SponsoredGasUnavailable(
          executionId: execution.executionId,
          gasPayment: execution.gasPayment,
        );
      }
      if (!execution.awaitsAuthorization) return _reload(withdrawalId);
      validateFundingAuthorization(execution);
      if (!prepared.transaction.validUntil.isAfter(DateTime.now().toUtc()) ||
          execution.authorizationExpiresAt!.isAfter(
            prepared.transaction.validUntil,
          )) {
        throw StateError(
          'Authorization exceeds the frozen withdrawal lifetime',
        );
      }
      final signature = await _ref
          .read(walletAuthorizationSignerProvider)
          .signWalletAuthorization(
            expectedSigner: prepared.transaction.from,
            request: execution.authorization!,
          );
      // A lost submission response is possible delivery, never permission to sign again.
      _authorizationSubmissions.add(execution.executionId);
      await repository.submitAuthorization(
        executionId: execution.executionId,
        signature: signature,
        idempotencyKey: scopedIdempotencyKey('$key-${mode.name}-authorization'),
      );
      return _reload(withdrawalId);
    },
  );

  /// The wallet must be able to pay the observed gas before the user is ever
  /// asked to sign a transaction they fund themselves.
  void _requireGasBalance(PreparedSelfCustodialWithdrawal prepared) {
    final gas = prepared.gas;
    if (gas != null && !gas.canPayGas) throw InsufficientWithdrawalGas(gas);
  }

  Future<SelfCustodialWithdrawalSummary> _reload(String withdrawalId) async {
    _ref.invalidate(selfCustodialWithdrawalProvider(withdrawalId));
    return _ref
        .read(fundingRepositoryProvider)
        .getSelfCustodialWithdrawal(withdrawalId);
  }

  /// Reports a historical hash as evidence only; never signs or publishes.
  Future<SelfCustodialWithdrawalSummary> submit({
    required String withdrawalId,
    required String txHash,
    String? executionId,
  }) => _runObserved(
    operation: 'submit_self_custodial_withdrawal',
    context: {
      'withdrawal_id': withdrawalId,
      'execution_id': ?executionId,
      'stage': 'submit',
    },
    command: () => _submit(
      withdrawalId: withdrawalId,
      txHash: txHash,
      executionId: executionId,
    ),
  );

  Future<SelfCustodialWithdrawalSummary> _submit({
    required String withdrawalId,
    required String txHash,
    String? executionId,
  }) async {
    final result = await _guard.run(
      operation: 'self-custodial-withdrawal-submit',
      fingerprint: '$withdrawalId|$txHash',
      command: (key) async {
        if (executionId != null) {
          await _ref
              .read(walletActionExecutionRepositoryProvider)
              .submitTransactionHash(
                executionId: executionId,
                txHash: txHash,
                idempotencyKey: key,
              );
          return _reload(withdrawalId);
        }
        return _ref
            .read(fundingRepositoryProvider)
            .submitSelfCustodialWithdrawal(
              id: withdrawalId,
              txHash: txHash,
              idempotencyKey: key,
            );
      },
    );
    _ref.invalidate(selfCustodialWithdrawalProvider(withdrawalId));
    return result;
  }

  Future<T> _runObserved<T>({
    required String operation,
    Map<String, String> context = const {},
    Map<String, String> Function(T result)? successContext,
    required Future<T> Function() command,
  }) async {
    final reporter = _ref.read(observabilityReporterProvider);
    final stopwatch = Stopwatch()..start();
    reporter.recordOperation(operation, outcome: 'started', context: context);
    try {
      final result = await command();
      reporter.recordOperation(
        operation,
        outcome: 'succeeded',
        context: {...context, ...?successContext?.call(result)},
        duration: stopwatch.elapsed,
      );
      return result;
    } on ApiFailure catch (failure, stackTrace) {
      reporter.recordApiFailure(
        operation: operation,
        failure: failure,
        stackTrace: stackTrace,
        context: context,
        duration: stopwatch.elapsed,
      );
      rethrow;
    } on InsufficientWithdrawalGas {
      reporter.recordOperation(
        operation,
        outcome: 'blocked',
        context: context,
        duration: stopwatch.elapsed,
      );
      rethrow;
    } on SponsoredGasUnavailable {
      reporter.recordOperation(
        operation,
        outcome: 'fallback_required',
        context: context,
        duration: stopwatch.elapsed,
      );
      rethrow;
    } on Object catch (error, stackTrace) {
      reporter.recordError(
        operation: operation,
        error: error,
        stackTrace: stackTrace,
        context: context,
        duration: stopwatch.elapsed,
      );
      rethrow;
    }
  }

  Future<PortfolioAsset> _findAsset(
    WithdrawalQuote quote, {
    required Wallet wallet,
  }) async {
    final repository = _ref.read(portfolioRepositoryProvider);
    if (repository is! PortfolioAssetsRepository) {
      throw StateError('Portfolio asset metadata is unavailable');
    }
    final assetsRepository = repository as PortfolioAssetsRepository;
    final assets = await assetsRepository.listAssets();
    final matches = assets
        .where(
          (asset) =>
              asset.symbol.toUpperCase() ==
                  quote.intent.amount.asset?.toUpperCase() &&
              asset.normalizedNetwork == normalizeChainLabel(wallet.chain) &&
              asset.walletId == wallet.walletId &&
              asset.contractAddress != null &&
              !asset.native &&
              quote.intent.amount.scale <= asset.decimals,
        )
        .toList(growable: false);
    if (matches.length != 1) {
      throw StateError('No unique withdrawable asset is available');
    }
    final available = matches.single.withdrawalAvailableBalance;
    if (available == null || available.compareTo(quote.intent.amount) < 0) {
      throw StateError('Insufficient available withdrawal balance');
    }
    return matches.single;
  }

  Future<Wallet> _findWallet(String chain) async {
    final page = await _ref.read(walletsProvider(null).future);
    final matches = page.items
        .where(
          (wallet) =>
              wallet.status == WalletState.active &&
              normalizeChainLabel(wallet.chain) == normalizeChainLabel(chain),
        )
        .toList(growable: false);
    if (matches.length != 1) {
      throw StateError('No unique active withdrawal wallet is available');
    }
    return matches.single;
  }

  void _validateRequest(WithdrawalQuote quote) {
    if (!_evmAddress.hasMatch(quote.intent.address) ||
        quote.intent.amount.compareTo(
              DecimalValue(
                '0',
                asset: quote.intent.amount.asset,
                unit: quote.intent.amount.unit,
              ),
            ) <=
            0) {
      throw ArgumentError('Invalid self-custodial withdrawal request');
    }
  }

  void _validatePrepared(
    PreparedSelfCustodialWithdrawal prepared, {
    required String assetId,
    required PortfolioAsset asset,
    required Wallet wallet,
    required WithdrawalQuote quote,
  }) {
    final transaction = prepared.transaction;
    if (prepared.status != SelfCustodialWithdrawalState.awaitingSubmission ||
        prepared.assetSymbol.toUpperCase() !=
            quote.intent.amount.asset?.toUpperCase() ||
        prepared.amount.compareTo(quote.intent.amount) != 0 ||
        prepared.sourceWalletId != wallet.walletId ||
        prepared.assetId.toLowerCase() != assetId.toLowerCase() ||
        normalizeChainLabel(prepared.chain) !=
            normalizeChainLabel(quote.intent.chain) ||
        prepared.destinationAddress.toLowerCase() !=
            quote.intent.address.toLowerCase() ||
        transaction.from.toLowerCase() != wallet.address.toLowerCase() ||
        !_matchesChainId(quote.intent.chain, transaction.chainId) ||
        transaction.to.toLowerCase() != asset.contractAddress!.toLowerCase() ||
        transaction.value.toLowerCase() != '0x0' ||
        prepared.transaction.payloadHash.isEmpty ||
        !RegExp(r'^0x[0-9a-fA-F]+$').hasMatch(transaction.data) ||
        !transaction.validUntil.isAfter(DateTime.now().toUtc())) {
      throw StateError('Server withdrawal transaction failed validation');
    }
  }

  void _validateExecution(
    WalletActionExecution execution,
    PreparedSelfCustodialWithdrawal prepared,
    GasPaymentMode mode, {
    WalletActionExecution? previous,
  }) => validateFundingExecution(
    execution: execution,
    resourceId: prepared.withdrawalId,
    mode: mode,
    chainId: prepared.transaction.chainId,
    from: prepared.transaction.from,
    transaction: FrozenTransaction(
      to: prepared.transaction.to,
      data: prepared.transaction.data,
      value: prepared.transaction.value,
    ),
    previous: previous,
  );

  bool _matchesChainId(String chain, int chainId) =>
      switch (normalizeChainLabel(chain)) {
        'ethereum' => chainId == 1,
        'arbitrum' => chainId == 42161 || chainId == 421614,
        'base' => chainId == 8453,
        'bsc' => chainId == 56 || chainId == 97,
        _ => false,
      };
}

final _evmAddress = RegExp(r'^0x[0-9a-fA-F]{40}$');
