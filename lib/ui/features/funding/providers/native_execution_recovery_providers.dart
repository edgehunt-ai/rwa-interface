import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../app/providers/auth_providers.dart';
import '../../../../app/providers/idempotent_command_guard.dart';
import '../../../../app/providers/session_scope.dart';
import '../../../../data/api/idempotency_key.dart';
import '../../../../domain/models/wallet_action_execution.dart';

final walletExecutionEvidenceProvider = FutureProvider.autoDispose
    .family<WalletActionExecution, String>((ref, executionId) {
      ref.watch(sessionGenerationProvider);
      return ref.watch(walletActionExecutionRepositoryProvider).get(executionId);
    }, retry: (_, _) => null);

final nativeExecutionRecoveryCommandsProvider = Provider((ref) {
  ref.watch(sessionGenerationProvider);
  return NativeExecutionRecoveryCommands(ref);
});

final class NativeExecutionRecoveryCommands {
  NativeExecutionRecoveryCommands(this._ref);
  final Ref _ref;
  final _guard = IdempotentCommandGuard();
  final _submitted = <String>{};

  /// This explicit command may revoke undispatched authority, but never signs.
  Future<WalletActionExecution> prepare(String executionId) => _guard.run(
    operation: 'native-execution-cancellation-prepare',
    fingerprint: executionId,
    command: (_) async {
      final repository = _ref.read(walletActionExecutionRepositoryProvider);
      final current = await repository.get(executionId);
      _requireNative(current, executionId);
      final cancellation = current.nativeCancellation;
      await repository.prepareCancellation(
        executionId: executionId,
        idempotencyKey: scopedIdempotencyKey('native-cancellation-$executionId-${cancellation?.cancellationId ?? 'initial'}-${cancellation?.authorizationExpiresAt?.millisecondsSinceEpoch ?? 'none'}'),
      );
      _ref.invalidate(walletExecutionEvidenceProvider(executionId));
      return repository.get(executionId);
    },
  );

  /// Only an explicit second confirmation authorizes native cancellation gas.
  Future<WalletActionExecution> authorize(String executionId) => _guard.run(
    operation: 'native-execution-cancellation-authorize',
    fingerprint: executionId,
    command: (_) async {
      final repository = _ref.read(walletActionExecutionRepositoryProvider);
      final current = await repository.get(executionId);
      _requireNative(current, executionId);
      final cancellation = current.nativeCancellation;
      if (cancellation == null) {
        throw StateError('No server-owned cancellation is available');
      }
      final authorization = cancellation.authorization;
      final requestId = authorization?.headers['privy-idempotency-key'];
      final submissionIdentity = '${cancellation.cancellationId}|$requestId';
      if (_submitted.contains(submissionIdentity) ||
          cancellation.status != 'awaiting_user_authorization') {
        return current;
      }
      final expiry = cancellation.authorizationExpiresAt;
      final transaction = authorization?.transaction;
      final nonce = authorization?.transaction.nonce;
      final params = authorization?.body['params'];
      final raw = params is Map ? params['transaction'] : null;
      final requestExpiry = int.tryParse(
        authorization?.headers['privy-request-expiry'] ?? '',
      );
      if (authorization == null || transaction == null || requestId == null || requestId.isEmpty ||
          expiry == null || !expiry.isAfter(DateTime.now().toUtc()) ||
          requestExpiry == null || requestExpiry <= DateTime.now().millisecondsSinceEpoch ||
          authorization.version != 1 || authorization.method != 'POST' ||
          !RegExp(r'^https://api\.privy\.io/v1/wallets/[^/]+/rpc$').hasMatch(authorization.url) ||
          authorization.sponsor || current.gasPayment.platformPays ||
          current.nativeDeliveryState != 'dispatching' ||
          const {WalletActionExecutionState.chainConfirmed, WalletActionExecutionState.completed}.contains(current.status) ||
          authorization.referenceId != cancellation.cancellationId ||
          authorization.caip2 != 'eip155:${current.chainId}' ||
          cancellation.nonce != current.nativeNonce ||
          current.transaction.nonce != current.nativeNonce ||
          !RegExp(r'^(0|[1-9][0-9]*)$').hasMatch(cancellation.nonce) ||
          nonce == null || !RegExp(r'^0x(0|[1-9a-f][0-9a-f]*)$').hasMatch(nonce) ||
          BigInt.parse(cancellation.nonce) != BigInt.parse(nonce.substring(2), radix: 16) ||
          transaction.from.toLowerCase() != current.walletAddress.toLowerCase() ||
          transaction.to.toLowerCase() != cancellation.to.toLowerCase() ||
          transaction.value != '0x0' || transaction.data != '0x' ||
          authorization.body['method'] != 'eth_sendTransaction' ||
          authorization.body['chain_type'] != 'ethereum' ||
          authorization.body['sponsor'] != false ||
          authorization.body['reference_id'] != cancellation.cancellationId ||
          authorization.body['caip2'] != authorization.caip2 ||
          raw is! Map || raw['from'] != transaction.from ||
          raw['to'] != transaction.to || raw['data'] != '0x' ||
          raw['value'] != '0x0' || raw['nonce'] != nonce) {
        throw StateError('Cancellation authorization does not match the original native nonce');
      }
      final signature = await _ref.read(walletAuthorizationSignerProvider)
          .signWalletAuthorization(expectedSigner: current.walletAddress, request: authorization);
      _submitted.add(submissionIdentity);
      try {
        return await repository.submitCancellationAuthorization(
          executionId: executionId,
          signature: signature,
          idempotencyKey: scopedIdempotencyKey('native-cancellation-submit-$submissionIdentity'),
        );
      } finally {
        // A lost response never authorizes a second send or claims no spend.
        _ref.invalidate(walletExecutionEvidenceProvider(executionId));
      }
    },
  );

  void _requireNative(WalletActionExecution execution, String expectedId) {
    if (execution.executionId != expectedId ||
        execution.executionProvider != 'privy_native' ||
        execution.mode != GasPaymentMode.userPaidNative ||
        execution.nativeNonce == null) {
      throw StateError('Historical or non-native execution is observation-only');
    }
  }
}
