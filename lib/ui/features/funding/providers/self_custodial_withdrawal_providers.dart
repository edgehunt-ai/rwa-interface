import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../app/providers/idempotent_command_guard.dart';
import '../../../../app/providers/observability_providers.dart';
import '../../../../app/providers/auth_providers.dart';
import '../../../../app/providers/session_scope.dart';
import '../../../../domain/models/api_failure.dart';
import '../../../../domain/models/decimal_value.dart';
import '../../../../domain/models/self_custodial_withdrawal.dart';
import '../../../../domain/models/portfolio_asset.dart';
import '../../../../domain/models/withdrawal.dart';
import '../../../../domain/models/wallet.dart';
import '../../../../domain/models/wallet_action_execution.dart';
import '../../../../domain/repositories/portfolio_repository.dart';
import '../../../../domain/services/embedded_wallet_transaction_sender.dart';
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
  final Map<String, _PendingWithdrawalSubmission> _pendingSubmissions = {};

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
  }) => _guard.run(
    operation: 'self-custodial-withdrawal-prepare',
    fingerprint: '${quote.intent.fingerprint}|$attempt',
    command: (createKey) async {
      _validateRequest(quote);
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
    required Future<bool> Function(GasPaymentQuote gas) confirmWalletUpgrade,
  }) => _guard.run(
    operation: 'self-custodial-withdrawal-execute',
    // The key reaches the server as the execution's idempotency key, so it
    // must follow the intent: reviewing again prepares a new withdrawal, and
    // reusing the previous key against it is a conflict.
    fingerprint: '${quote.intent.fingerprint}|${prepared.withdrawalId}',
    command: (key) async {
      final fingerprint = quote.intent.fingerprint;
      final pending = _pendingSubmissions[fingerprint];
      if (pending != null) return _submitPending(fingerprint, pending);

      final execution = await _createExecution(
        prepared,
        mode: GasPaymentMode.appSponsored,
        idempotencyKey: key,
      );
      // Sponsorship is not wired up for this chain or account at all, so no
      // execution was bound and the intent may still be self-broadcast.
      if (execution == null) {
        return _executeUserBroadcast(quote: quote, prepared: prepared);
      }

      if (!execution.awaitsAuthorization) {
        // The server's own words for why it will not pay, so a wallet that is
        // asked for gas anyway can be told apart from a misconfiguration.
        _ref
            .read(observabilityReporterProvider)
            .recordOperation(
              'self_custodial_withdrawal_sponsorship',
              outcome: execution.gasPayment.decision.name,
            );
        throw SponsoredGasUnavailable(
          executionId: execution.executionId,
          gasPayment: execution.gasPayment,
        );
      }
      final authorization = execution.authorization!;
      _validateAuthorization(
        execution: execution,
        authorization: authorization,
        prepared: prepared,
      );

      // The sponsored path delegates the wallet to a smart contract, which the
      // server marks as a disclosure the user must see before signing.
      if (execution.gasPayment.eip7702Required &&
          !await confirmWalletUpgrade(execution.gasPayment)) {
        throw const WalletUpgradeDeclined();
      }

      final signature = await _ref
          .read(walletAuthorizationSignerProvider)
          .signWalletAuthorization(
            expectedSigner: prepared.transaction.from,
            request: authorization,
          );
      // A relayed signature is never replayed: a failure here surfaces instead
      // of being retried with the same or a fresh signature.
      await _ref
          .read(walletActionExecutionRepositoryProvider)
          .submitAuthorization(
            executionId: execution.executionId,
            signature: signature,
            idempotencyKey: '$key-authorization',
          );
      return _reload(prepared.withdrawalId);
    },
  );

  /// User-paid fallback after sponsorship was refused pre-broadcast. The user
  /// signs and broadcasts the frozen transaction and pays gas themselves.
  Future<SelfCustodialWithdrawalSummary> executeUserPaid({
    required WithdrawalQuote quote,
    required PreparedSelfCustodialWithdrawal prepared,
  }) => _guard.run(
    operation: 'self-custodial-withdrawal-user-paid',
    fingerprint: '${quote.intent.fingerprint}|${prepared.withdrawalId}',
    command: (key) async {
      final fingerprint = quote.intent.fingerprint;
      final pending = _pendingSubmissions[fingerprint];
      if (pending != null) return _submitPending(fingerprint, pending);

      _requireGasBalance(prepared);
      final execution = await _createExecution(
        prepared,
        mode: GasPaymentMode.userPaidNative,
        idempotencyKey: key,
      );
      if (execution == null) {
        return _executeUserBroadcast(quote: quote, prepared: prepared);
      }
      _validateExecution(execution, prepared);

      final txHash = await _broadcast(prepared);
      final submission = _PendingWithdrawalSubmission(
        withdrawalId: prepared.withdrawalId,
        txHash: txHash,
        executionId: execution.executionId,
      );
      _pendingSubmissions[fingerprint] = submission;
      return _submitPending(fingerprint, submission);
    },
  );

  /// The legacy direct path, used only while no execution is bound to the
  /// intent: the server rejects it once one exists.
  Future<SelfCustodialWithdrawalSummary> _executeUserBroadcast({
    required WithdrawalQuote quote,
    required PreparedSelfCustodialWithdrawal prepared,
  }) async {
    final fingerprint = quote.intent.fingerprint;
    _requireGasBalance(prepared);
    final txHash = await _broadcast(prepared);
    final submission = _PendingWithdrawalSubmission(
      withdrawalId: prepared.withdrawalId,
      txHash: txHash,
    );
    _pendingSubmissions[fingerprint] = submission;
    return _submitPending(fingerprint, submission);
  }

  /// The wallet must be able to pay the observed gas before the user is ever
  /// asked to sign a transaction they fund themselves.
  void _requireGasBalance(PreparedSelfCustodialWithdrawal prepared) {
    final gas = prepared.gas;
    if (gas != null && !gas.canPayGas) throw InsufficientWithdrawalGas(gas);
  }

  Future<String> _broadcast(PreparedSelfCustodialWithdrawal prepared) async {
    final authGateway = _ref.read(identityAuthGatewayProvider);
    if (authGateway is! EmbeddedWalletTransactionSender) {
      throw StateError('Privy transaction sender is unavailable');
    }
    final transactionSender = authGateway as EmbeddedWalletTransactionSender;
    return transactionSender.sendTransaction(
      expectedSigner: prepared.transaction.from,
      chainId: prepared.transaction.chainId,
      to: prepared.transaction.to,
      data: prepared.transaction.data,
      value: prepared.transaction.value,
    );
  }

  Future<SelfCustodialWithdrawalSummary> _submitPending(
    String fingerprint,
    _PendingWithdrawalSubmission pending,
  ) async {
    final result = await submit(
      withdrawalId: pending.withdrawalId,
      txHash: pending.txHash,
      executionId: pending.executionId,
    );
    _pendingSubmissions.remove(fingerprint);
    return result;
  }

  /// Returns null only when the server deterministically refused to bind an
  /// execution, which leaves the legacy direct submission path usable.
  ///
  /// Every other failure keeps the error: an execution may exist despite it,
  /// and the server rejects direct submission once one is bound, so
  /// broadcasting anyway would strand a transaction it cannot accept.
  Future<WalletActionExecution?> _createExecution(
    PreparedSelfCustodialWithdrawal prepared, {
    required GasPaymentMode mode,
    required String idempotencyKey,
  }) async {
    try {
      return await _ref
          .read(walletActionExecutionRepositoryProvider)
          .createSelfCustodialWithdrawalExecution(
            withdrawalId: prepared.withdrawalId,
            mode: mode,
            idempotencyKey: idempotencyKey,
          );
    } on ServerFailure catch (failure) {
      // 404: the deployment has no execution route. 422: this intent or chain
      // is not eligible for a bound execution.
      if (failure.statusCode == 404 || failure.statusCode == 422) return null;
      rethrow;
    }
  }

  Future<SelfCustodialWithdrawalSummary> _reload(String withdrawalId) async {
    _ref.invalidate(selfCustodialWithdrawalProvider(withdrawalId));
    return _ref
        .read(fundingRepositoryProvider)
        .getSelfCustodialWithdrawal(withdrawalId);
  }

  Future<SelfCustodialWithdrawalSummary> submit({
    required String withdrawalId,
    required String txHash,
    String? executionId,
  }) async {
    const operation = 'submit_self_custodial_withdrawal';
    _ref
        .read(observabilityReporterProvider)
        .recordOperation(operation, outcome: 'started');
    try {
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
      _ref
          .read(observabilityReporterProvider)
          .recordOperation(operation, outcome: 'succeeded');
      _ref.invalidate(selfCustodialWithdrawalProvider(withdrawalId));
      return result;
    } on ApiFailure catch (failure, stackTrace) {
      _ref
          .read(observabilityReporterProvider)
          .recordApiFailure(
            operation: operation,
            failure: failure,
            stackTrace: stackTrace,
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
              quote.intent.amount.scale <= asset.decimals &&
              asset.balance.compareTo(quote.intent.amount) >= 0,
        )
        .toList(growable: false);
    if (matches.length != 1) {
      throw StateError('No unique withdrawable asset is available');
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
        transaction.chainId != _chainId(quote.intent.chain) ||
        transaction.to.toLowerCase() != asset.contractAddress!.toLowerCase() ||
        transaction.value.toLowerCase() != '0x0' ||
        prepared.transaction.payloadHash.isEmpty ||
        !RegExp(r'^0x[0-9a-fA-F]+$').hasMatch(transaction.data) ||
        !transaction.validUntil.isAfter(DateTime.now().toUtc())) {
      throw StateError('Server withdrawal transaction failed validation');
    }
  }

  /// The signature commits to the Privy request verbatim, so every field the
  /// user reviewed is re-checked against it first. Anything that disagrees
  /// with the frozen withdrawal fails closed before the wallet is asked.
  void _validateAuthorization({
    required WalletActionExecution execution,
    required WalletAuthorizationRequest authorization,
    required PreparedSelfCustodialWithdrawal prepared,
  }) {
    _validateExecution(execution, prepared);
    final transaction = prepared.transaction;
    final expiresAt = execution.authorizationExpiresAt;
    final authorized = authorization.transaction;
    if (!authorization.sponsor ||
        authorization.referenceId != execution.executionId ||
        authorization.caip2 != 'eip155:${transaction.chainId}' ||
        authorized.from.toLowerCase() != transaction.from.toLowerCase() ||
        authorized.to.toLowerCase() != transaction.to.toLowerCase() ||
        authorized.data.toLowerCase() != transaction.data.toLowerCase() ||
        authorized.value.toLowerCase() != '0x0' ||
        expiresAt == null ||
        !expiresAt.isAfter(DateTime.now().toUtc())) {
      throw StateError('Server authorization payload failed validation');
    }
  }

  void _validateExecution(
    WalletActionExecution execution,
    PreparedSelfCustodialWithdrawal prepared,
  ) {
    final transaction = prepared.transaction;
    if (execution.resourceId != prepared.withdrawalId ||
        execution.chainId != transaction.chainId ||
        execution.walletAddress.toLowerCase() !=
            transaction.from.toLowerCase() ||
        execution.transaction.to.toLowerCase() !=
            transaction.to.toLowerCase() ||
        execution.transaction.data.toLowerCase() !=
            transaction.data.toLowerCase() ||
        execution.transaction.value.toLowerCase() != '0x0' ||
        transaction.value.toLowerCase() != '0x0') {
      throw StateError('Server execution failed validation');
    }
  }

  int _chainId(String chain) => switch (normalizeChainLabel(chain)) {
    'ethereum' => 1,
    // Arbitrum testnet is used by the withdrawal contract in this app.
    'arbitrum' => 421614,
    'base' => 8453,
    'bsc' => 56,
    _ => -1,
  };
}

final _evmAddress = RegExp(r'^0x[0-9a-fA-F]{40}$');

final class _PendingWithdrawalSubmission {
  const _PendingWithdrawalSubmission({
    required this.withdrawalId,
    required this.txHash,
    this.executionId,
  });

  final String withdrawalId;
  final String txHash;

  /// Null for the legacy direct submission; set once the hash belongs to a
  /// bound user-paid execution, which the server requires it be reported to.
  final String? executionId;
}
