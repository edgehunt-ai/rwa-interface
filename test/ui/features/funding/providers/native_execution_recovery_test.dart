import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app/providers/api_providers.dart';
import 'package:nobell/domain/models/wallet_action_execution.dart';
import 'package:nobell/domain/repositories/wallet_action_execution_repository.dart';
import 'package:nobell/ui/features/funding/providers/native_execution_recovery_providers.dart';

import '../../../../helpers/funding_execution_fixture.dart';

void main() {
  ({NativeExecutionRecoveryCommands commands, RecordingFundingSigner signer})
  harness(_Executions executions) {
    final signer = RecordingFundingSigner(executions.events);
    final container = ProviderContainer(
      overrides: [
        walletActionExecutionRepositoryProvider.overrideWithValue(executions),
        walletAuthorizationSignerProvider.overrideWithValue(signer),
      ],
    );
    addTearDown(container.dispose);
    return (
      commands: container.read(nativeExecutionRecoveryCommandsProvider),
      signer: signer,
    );
  }

  test('abort only requests backend revocation and returns fresh evidence without signing', () async {
    final repository = _Executions(fundingExecution());
    repository.prepared = _execution(delivery: 'voided', cancellation: false);
    final context = harness(repository);
    final result = await context.commands.prepare('execution-1');
    expect(repository.events, ['get', 'prepare', 'get']);
    expect(context.signer.requests, isEmpty);
    expect(result.nativeDeliveryState, 'voided');
    expect(result.status, WalletActionExecutionState.ambiguous);
  });

  test('cancellation requires second confirmation and signs only exact-nonce no-op', () async {
    final repository = _Executions(_execution());
    final context = harness(repository);
    final result = await context.commands.authorize('execution-1');
    expect(repository.events, ['get', 'sign', 'cancel-submit']);
    final request = context.signer.requests.single;
    expect(request.sponsor, isFalse);
    expect(request.transaction.nonce, '0xa');
    expect(request.transaction.value, '0x0');
    expect(request.transaction.data, '0x');
    expect(result.txHash, '0x${'a' * 64}');
    expect(result.status, WalletActionExecutionState.ambiguous);
  });

  test('lost cancellation response becomes read-only even if stale GET still offers authorization', () async {
    final repository = _Executions(_execution())..failSubmit = true;
    final context = harness(repository);
    await expectLater(
      context.commands.authorize('execution-1'),
      throwsStateError,
    );
    await context.commands.authorize('execution-1');
    expect(context.signer.requests, hasLength(1));
    expect(
      repository.events.where((value) => value == 'cancel-submit'),
      hasLength(1),
    );
  });

  test(
    'server-authorized renewal uses new request identity but never a new nonce',
    () async {
      final repository = _Executions(_execution())..failSubmit = true;
      final context = harness(repository);
      await expectLater(
        context.commands.authorize('execution-1'),
        throwsStateError,
      );
      repository.current = _execution(cancellationId: 'cancel-renewed');
      repository.failSubmit = false;
      await context.commands.authorize('execution-1');
      expect(context.signer.requests.map((request) => request.referenceId), [
        'cancel-1',
        'cancel-renewed',
      ]);
      expect(
        context.signer.requests.map((request) => request.transaction.nonce),
        ['0xa', '0xa'],
      );
    },
  );

  for (final mutation in [
    'nonce',
    'data',
    'sponsor',
    'raw',
    'voided',
    'expired',
  ]) {
    test('cancellation rejects $mutation mismatch before signing', () async {
      final repository = _Executions(_execution(mutation: mutation));
      final context = harness(repository);
      await expectLater(
        context.commands.authorize('execution-1'),
        throwsStateError,
      );
      expect(context.signer.requests, isEmpty);
      expect(repository.events, ['get']);
    });
  }

  test(
    'historical user_wallet never receives cancellation authority',
    () async {
      final repository = _Executions(fundingExecution(provider: 'user_wallet'));
      final context = harness(repository);
      await expectLater(
        context.commands.prepare('execution-1'),
        throwsStateError,
      );
      expect(repository.events, ['get']);
      expect(context.signer.requests, isEmpty);
    },
  );
}

WalletActionExecution _execution({
  String delivery = 'dispatching',
  bool cancellation = true,
  String? mutation,
  String cancellationId = 'cancel-1',
}) {
  final original = fundingExecution();
  final expiry = DateTime.now().toUtc().add(
    Duration(seconds: mutation == 'expired' ? -1 : 40),
  );
  final data = mutation == 'data' ? fundingData : '0x';
  final sponsor = mutation == 'sponsor';
  return WalletActionExecution(
    executionId: original.executionId,
    resourceId: original.resourceId,
    chainId: original.chainId,
    walletAddress: original.walletAddress,
    mode: original.mode,
    status: WalletActionExecutionState.ambiguous,
    gasPayment: original.gasPayment,
    transaction: original.transaction,
    executionProvider: 'privy_native',
    nativeNonce: '10',
    nativeDeliveryState: mutation == 'voided' ? 'voided' : delivery,
    txHash: '0x${'a' * 64}',
    nativeCancellation: !cancellation
        ? null
        : NativeCancellation(
            cancellationId: cancellationId,
            nonce: mutation == 'nonce' ? '11' : '10',
            to: fundingTarget,
            status: 'awaiting_user_authorization',
            authorizationExpiresAt: expiry,
            authorization: WalletAuthorizationRequest(
              version: 1,
              method: 'POST',
              url: 'https://api.privy.io/v1/wallets/wallet-1/rpc',
              headers: {
                'privy-app-id': 'app',
                'privy-idempotency-key':
                    'wallet-action-cancellation-$cancellationId',
                'privy-request-expiry': '${expiry.millisecondsSinceEpoch}',
              },
              body: {
                'method': 'eth_sendTransaction',
                'chain_type': 'ethereum',
                'sponsor': sponsor,
                'reference_id': cancellationId,
                'caip2': 'eip155:56',
                'params': {
                  'transaction': {
                    'from': fundingSigner,
                    'to': fundingTarget,
                    'data': mutation == 'raw' ? fundingData : data,
                    'value': '0x0',
                    'nonce': '0xa',
                  },
                },
              },
              referenceId: cancellationId,
              sponsor: sponsor,
              caip2: 'eip155:56',
              transaction: AuthorizedTransaction(
                from: fundingSigner,
                to: fundingTarget,
                data: data,
                value: '0x0',
                nonce: '0xa',
              ),
            ),
          ),
  );
}

final class _Executions implements WalletActionExecutionRepository {
  _Executions(this.current);
  WalletActionExecution current;
  WalletActionExecution? prepared;
  bool failSubmit = false;
  final events = <String>[];
  @override
  Future<WalletActionExecution> get(String executionId) async {
    events.add('get');
    return current;
  }

  @override
  Future<WalletActionExecution> prepareCancellation({
    required String executionId,
    required String idempotencyKey,
  }) async {
    events.add('prepare');
    return current = prepared ?? current;
  }

  @override
  Future<WalletActionExecution> submitCancellationAuthorization({
    required String executionId,
    required String signature,
    required String idempotencyKey,
  }) async {
    events.add('cancel-submit');
    if (failSubmit) throw StateError('Lost response');
    return current;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
