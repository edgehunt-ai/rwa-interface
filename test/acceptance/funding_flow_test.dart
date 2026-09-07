import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/data/api/api_environment.dart';
import 'package:rwa_interface/data/api/rwa_api_data_source.dart';
import 'package:rwa_interface/data/repositories/funding_repository_impl.dart';
import 'package:rwa_interface/data/repositories/wallets_repository_impl.dart';
import 'package:rwa_interface/data/services/generated_funding_service.dart';
import 'package:rwa_interface/data/services/generated_wallets_service.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/deposit.dart';
import 'package:rwa_interface/domain/models/withdrawal.dart';
import 'package:rwa_interface/ui/features/funding/providers/deposit_providers.dart';
import 'package:rwa_interface/ui/features/funding/providers/withdrawal_providers.dart';

import '../helpers/controlled_api_adapter.dart';
import '../helpers/trading_provider_harness.dart';

void main() {
  test('funding commands traverse the complete controlled boundary', () async {
    final adapter = ControlledApiAdapter([
      _json('GET', '/v1/funding/catalog', 200, _catalogJson),
      _json('POST', '/v1/deposits', 201, _depositJson()),
      _json(
        'GET',
        '/v1/deposits/deposit-1',
        200,
        _depositJson(status: 'ambiguous'),
      ),
      _json('POST', '/v1/withdrawal-quotes', 201, _quoteJson),
      _json(
        'POST',
        '/v1/me/wallets/wallet-1/authorizations',
        201,
        _authorizationJson,
      ),
      _json('POST', '/v1/withdrawals', 201, _withdrawalJson()),
      _json(
        'GET',
        '/v1/withdrawals/withdrawal-1',
        200,
        _withdrawalJson(status: 'manual_review'),
      ),
    ]);
    final source = _source(adapter);
    final container = ProviderContainer(
      overrides: [
        fundingRepositoryProvider.overrideWithValue(
          FundingRepositoryImpl(
            GeneratedFundingService(source.client.getFundingApi()),
          ),
        ),
        walletsRepositoryProvider.overrideWithValue(
          WalletsRepositoryImpl(
            GeneratedWalletsService(source.client.getWalletsApi()),
          ),
        ),
      ],
    );
    addTearDown(container.dispose);
    final deposits = container.listen(depositCommandsProvider, (_, _) {});
    final withdrawals = container.listen(withdrawalCommandsProvider, (_, _) {});
    addTearDown(deposits.close);
    addTearDown(withdrawals.close);

    final catalog = await container.read(fundingCatalogProvider.future);
    expect(catalog.rails.map((rail) => rail.network), ['BSC', 'arbitrum']);

    final createdDeposit = await container
        .read(depositCommandsProvider)
        .create(chain: 'BSC', amount: '10');
    expect(createdDeposit.capability?.code, 'funding_transfer_not_supported');
    expect(createdDeposit.capability?.retryable, isFalse);
    final deposit = await container.read(depositProvider('deposit-1').future);
    expect(deposit.resource.status, DepositState.ambiguous);

    final intent = WithdrawalIntent(
      chain: 'BSC',
      amount: DecimalValue('5', asset: 'USDC', unit: 'token'),
      address: '0x456',
    );
    final commands = container.read(withdrawalCommandsProvider);
    final quote = await commands.quote(intent);
    expect(quote.estimatedReceive.value, '4.9');
    final authorization = await commands.authorize(
      walletId: 'wallet-1',
      quote: quote,
    );
    expect(authorization.isUsable, isTrue);
    final createdWithdrawal = await commands.create(
      quote: quote,
      authorization: authorization,
    );
    expect(createdWithdrawal.status, WithdrawalState.processing);
    final withdrawal = await container.read(
      withdrawalProvider('withdrawal-1').future,
    );
    expect(withdrawal.status, WithdrawalState.manualReview);

    final paths = adapter.requests.map((request) => request.path).toList();
    expect(paths, isNot(contains(contains('/funding/plans'))));
    expect(paths, isNot(contains(contains('/transfers'))));
    expect(paths, isNot(contains(contains('/claims'))));
    for (final request in adapter.requests.where(
      (request) => request.method == 'POST',
    )) {
      expect(request.headers['idempotency-key'], isNotNull);
    }
  });
}

RwaApiDataSource _source(ControlledApiAdapter adapter) {
  final source = RwaApiDataSource.create(
    tokenProvider: FakePrivyAccessTokenProvider(),
    environment: const ApiEnvironment(baseUrl: 'https://controlled.invalid'),
  );
  source.dio.httpClientAdapter = adapter;
  return source;
}

ControlledResponse _json(String method, String path, int status, Object body) =>
    ControlledResponse.json(
      method: method,
      path: path,
      statusCode: status,
      body: body,
    );

const _catalogJson = {
  'rails': [
    {
      'rail': 'bstock',
      'network': 'BSC',
      'settlement_asset': 'USDC',
      'minimum_amount': '1',
    },
    {
      'rail': 'perp',
      'network': 'Arbitrum',
      'settlement_asset': 'USDC',
      'minimum_amount': '1',
    },
  ],
  'updated_at': '2026-01-01T00:00:00Z',
};

Map<String, Object?> _depositJson({String status = 'awaiting'}) => {
  'deposit_id': 'deposit-1',
  'chain': 'BSC',
  'token': 'USDC',
  'amount': '10',
  'status': status,
  'requires_transfer': true,
  'instructions': {'chain': 'BSC', 'token': 'USDC', 'address': '0x123'},
  'created_at': '2026-01-01T00:00:00Z',
};

const _quoteJson = {
  'quote_id': 'quote-1',
  'asset': 'USDC',
  'chain': 'BSC',
  'amount': '5',
  'total_fee': '0.1',
  'estimated_receive': '4.9',
  'sufficient': true,
};

const _authorizationJson = {
  'authorization_id': 'authorization-1',
  'wallet_id': 'wallet-1',
  'purpose': 'withdrawal',
  'status': 'authorized',
  'created_at': '2026-01-01T00:00:00Z',
  'expires_at': '2030-01-01T00:00:00Z',
};

Map<String, Object?> _withdrawalJson({String status = 'processing'}) => {
  'withdrawal_id': 'withdrawal-1',
  'asset': 'USDC',
  'chain': 'BSC',
  'amount': '5',
  'received_amount': '4.9',
  'total_fee': '0.1',
  'address': '0x456',
  'status': status,
  'created_at': '2026-01-01T00:00:00Z',
};
