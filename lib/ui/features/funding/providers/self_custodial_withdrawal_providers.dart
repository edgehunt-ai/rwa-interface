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
      final prepared = await _ref
          .read(fundingRepositoryProvider)
          .createSelfCustodialWithdrawal(
            walletId: wallet.walletId,
            assetId: asset.assetId,
            chain: wallet.chain,
            amount: quote.intent.amount.value,
            destinationAddress: quote.intent.address,
            idempotencyKey: createKey,
          );
      _validatePrepared(prepared, asset: asset, wallet: wallet, quote: quote);
      return prepared;
    },
  );

  Future<SelfCustodialWithdrawalSummary> execute({
    required WithdrawalQuote quote,
    required PreparedSelfCustodialWithdrawal prepared,
  }) => _guard.run(
    operation: 'self-custodial-withdrawal-execute',
    fingerprint: quote.intent.fingerprint,
    command: (_) async {
      final fingerprint = quote.intent.fingerprint;
      final pending = _pendingSubmissions[fingerprint];
      if (pending != null) {
        final result = await submit(
          withdrawalId: pending.withdrawalId,
          txHash: pending.txHash,
        );
        _pendingSubmissions.remove(fingerprint);
        return result;
      }
      // The wallet must be able to pay the observed gas before the user is
      // ever asked to sign.
      final gas = prepared.gas;
      if (gas != null && !gas.canPayGas) {
        throw InsufficientWithdrawalGas(gas);
      }

      final authGateway = _ref.read(identityAuthGatewayProvider);
      if (authGateway is! EmbeddedWalletTransactionSender) {
        throw StateError('Privy transaction sender is unavailable');
      }
      final transactionSender = authGateway as EmbeddedWalletTransactionSender;
      final txHash = await transactionSender.sendTransaction(
        expectedSigner: prepared.transaction.from,
        chainId: prepared.transaction.chainId,
        to: prepared.transaction.to,
        data: prepared.transaction.data,
        value: prepared.transaction.value,
      );
      _pendingSubmissions[fingerprint] = _PendingWithdrawalSubmission(
        withdrawalId: prepared.withdrawalId,
        txHash: txHash,
      );
      final result = await submit(
        withdrawalId: prepared.withdrawalId,
        txHash: txHash,
      );
      _pendingSubmissions.remove(fingerprint);
      return result;
    },
  );

  Future<SelfCustodialWithdrawalSummary> submit({
    required String withdrawalId,
    required String txHash,
  }) async {
    const operation = 'submit_self_custodial_withdrawal';
    _ref
        .read(observabilityReporterProvider)
        .recordOperation(operation, outcome: 'started');
    try {
      final result = await _guard.run(
        operation: 'self-custodial-withdrawal-submit',
        fingerprint: '$withdrawalId|$txHash',
        command: (key) => _ref
            .read(fundingRepositoryProvider)
            .submitSelfCustodialWithdrawal(
              id: withdrawalId,
              txHash: txHash,
              idempotencyKey: key,
            ),
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
              asset.network.toLowerCase() == wallet.chain.toLowerCase() &&
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
              wallet.chain.toLowerCase() == chain.toLowerCase(),
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
        prepared.assetId != asset.assetId ||
        prepared.chain.toLowerCase() != quote.intent.chain.toLowerCase() ||
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

  int _chainId(String chain) => switch (chain.toLowerCase()) {
    'ethereum' => 1,
    'arbitrum' => 42161,
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
  });

  final String withdrawalId;
  final String txHash;
}
