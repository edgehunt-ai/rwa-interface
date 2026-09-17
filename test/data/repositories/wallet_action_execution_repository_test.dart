import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/data/api/api_environment.dart';
import 'package:rwa_interface/data/api/rwa_api_data_source.dart';
import 'package:rwa_interface/data/repositories/wallet_action_execution_repository_impl.dart';
import 'package:rwa_interface/data/services/generated_wallet_action_execution_service.dart';
import 'package:rwa_interface/domain/models/wallet_action_execution.dart';

import '../../helpers/controlled_api_adapter.dart';
import '../../helpers/trading_provider_harness.dart';

void main() {
  ({
    WalletActionExecutionRepositoryImpl repository,
    ControlledApiAdapter adapter,
  })
  harness(List<ControlledResponse> responses) {
    final source = RwaApiDataSource.create(
      tokenProvider: FakePrivyAccessTokenProvider(),
      environment: const ApiEnvironment(baseUrl: 'https://controlled.invalid'),
    );
    final adapter = ControlledApiAdapter(responses);
    source.dio.httpClientAdapter = adapter;
    return (
      repository: WalletActionExecutionRepositoryImpl(
        GeneratedWalletActionExecutionService(
          source.client.getFundingApi(),
          source.client.getWalletsApi(),
        ),
      ),
      adapter: adapter,
    );
  }

  test('a sponsored execution exposes the request the wallet signs', () async {
    final context = harness([
      ControlledResponse.json(
        method: 'POST',
        path: '/v1/self-custodial-withdrawals/withdrawal-1/executions',
        statusCode: 201,
        body: _sponsoredExecutionJson,
      ),
    ]);

    final execution = await context.repository
        .createSelfCustodialWithdrawalExecution(
          withdrawalId: 'withdrawal-1',
          mode: GasPaymentMode.appSponsored,
          idempotencyKey: 'key-1',
        );

    expect(execution.executionId, 'execution-1');
    expect(execution.chainId, 56);
    expect(execution.mode, GasPaymentMode.appSponsored);
    expect(
      execution.status,
      WalletActionExecutionState.awaitingUserAuthorization,
    );
    expect(execution.awaitsAuthorization, isTrue);
    expect(execution.gasPayment.decision, GasSponsorshipDecision.eligible);
    expect(execution.gasPayment.platformPays, isTrue);
    expect(execution.gasPayment.eip7702Required, isTrue);
    expect(execution.gasPayment.eip7702Notice, 'Your wallet will be upgraded.');
    expect(execution.gasPayment.estimatedFeeUsd.value, '0.05');

    final authorization = execution.authorization!;
    expect(authorization.version, 1);
    expect(authorization.method, 'POST');
    expect(authorization.url, 'https://api.privy.io/v1/wallets/wallet-1/rpc');
    expect(authorization.referenceId, 'execution-1');
    expect(authorization.caip2, 'eip155:56');
    expect(authorization.sponsor, isTrue);
    expect(authorization.transaction.to, _to);
    expect(authorization.transaction.value, '0x0');
    // Signing covers the server's own bytes, so the payload must round-trip
    // field for field rather than be reassembled.
    expect(authorization.headers, {
      'privy-app-id': 'app-id',
      'privy-idempotency-key': 'privy-key-1',
      'privy-request-expiry': '1780000000000',
    });
    expect(
      authorization.body,
      _sponsoredExecutionJson['privy_authorization_payload']['body'],
    );

    final sent = context.adapter.requests.single;
    expect(sent.headers['idempotency-key'], 'key-1');
    expect(jsonDecode(utf8.decode(sent.body)), {'mode': 'app_sponsored'});
  });

  test('a refused sponsorship carries no request to sign', () async {
    final context = harness([
      ControlledResponse.json(
        method: 'POST',
        path: '/v1/self-custodial-withdrawals/withdrawal-1/executions',
        statusCode: 201,
        body: {
          ..._sponsoredExecutionJson,
          'status': 'user_gas_confirmation_required',
          'gas_payment': {
            ...(_sponsoredExecutionJson['gas_payment'] as Map<String, Object?>),
            'decision': 'user_gas_confirmation_required',
            'platform_pays': false,
          },
          'privy_authorization_payload': null,
          'authorization_expires_at': null,
        },
      ),
    ]);

    final execution = await context.repository
        .createSelfCustodialWithdrawalExecution(
          withdrawalId: 'withdrawal-1',
          mode: GasPaymentMode.appSponsored,
          idempotencyKey: 'key-1',
        );

    expect(execution.awaitsAuthorization, isFalse);
    expect(execution.requiresUserPaidFallback, isTrue);
    expect(execution.authorization, isNull);
    expect(execution.gasPayment.fallbackAllowed, isTrue);
  });

  test('each submission sends only its own variant', () async {
    final context = harness([
      ControlledResponse.json(
        method: 'POST',
        path: '/v1/wallet-action-executions/execution-1/submissions',
        statusCode: 200,
        body: _submittedExecutionJson,
      ),
      ControlledResponse.json(
        method: 'POST',
        path: '/v1/wallet-action-executions/execution-2/submissions',
        statusCode: 200,
        body: _submittedExecutionJson,
      ),
    ]);

    await context.repository.submitAuthorization(
      executionId: 'execution-1',
      signature: '0xauthorization',
      idempotencyKey: 'key-2',
    );
    await context.repository.submitTransactionHash(
      executionId: 'execution-2',
      txHash: '0x${'ab' * 32}',
      idempotencyKey: 'key-3',
    );

    expect(jsonDecode(utf8.decode(context.adapter.requests.first.body)), {
      'privy_authorization_signature': '0xauthorization',
    });
    expect(jsonDecode(utf8.decode(context.adapter.requests.last.body)), {
      'tx_hash': '0x${'ab' * 32}',
    });
  });
}

const _from = '0x2222222222222222222222222222222222222222';
const _to = '0x3333333333333333333333333333333333333333';

const _sponsoredExecutionJson = <String, dynamic>{
  'execution_id': 'execution-1',
  'resource_type': 'self_custodial_withdrawal',
  'resource_id': 'withdrawal-1',
  'action_id': 'withdrawal-1',
  'action_kind': 'erc20_transfer',
  'chain_id': 56,
  'wallet_address': _from,
  'payload_hash':
      'aa11bb22cc33dd44ee55ff6677889900aa11bb22cc33dd44ee55ff6677889900',
  'business_expires_at': '2030-01-01T00:00:00Z',
  'mode': 'app_sponsored',
  'execution_provider': 'privy',
  'status': 'awaiting_user_authorization',
  'provider_status': 'not_submitted',
  'gas_payment': {
    'mode': 'app_sponsored',
    'decision': 'eligible',
    'platform_pays': true,
    'native_asset': 'BNB',
    'estimated_native_fee': '0.000065',
    'estimated_fee_usd': '0.05',
    'wallet_native_balance': '0',
    'fallback_allowed': true,
    'eip_7702_required': true,
    'eip_7702_notice': 'Your wallet will be upgraded.',
  },
  'frozen_transaction': {'to': _to, 'data': '0xa9059cbb', 'value': '0x0'},
  'fallback_from_execution_id': null,
  'privy_authorization_payload': {
    'version': 1,
    'method': 'POST',
    'url': 'https://api.privy.io/v1/wallets/wallet-1/rpc',
    'headers': {
      'privy-app-id': 'app-id',
      'privy-idempotency-key': 'privy-key-1',
      'privy-request-expiry': '1780000000000',
    },
    'body': {
      'method': 'eth_sendTransaction',
      'caip2': 'eip155:56',
      'chain_type': 'ethereum',
      'sponsor': true,
      'reference_id': 'execution-1',
      'params': {
        'transaction': {
          'from': _from,
          'to': _to,
          'data': '0xa9059cbb',
          'value': '0x0',
        },
      },
    },
  },
  'authorization_expires_at': '2030-01-01T00:00:00Z',
  'privy_transaction_id': null,
  'user_operation_hash': null,
  'tx_hash': null,
  'chain_observation': null,
  'activity_id': null,
  'failure_reason': null,
  'manual_review_reason': null,
  'created_at': '2026-01-01T00:00:00Z',
  'updated_at': '2026-01-01T00:00:00Z',
};

final _submittedExecutionJson = <String, dynamic>{
  ..._sponsoredExecutionJson,
  'status': 'submitting',
  'privy_authorization_payload': null,
  'authorization_expires_at': null,
};
