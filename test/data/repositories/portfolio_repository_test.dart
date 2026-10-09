import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:rwa_interface/data/repositories/portfolio_repository_impl.dart';
import 'package:rwa_interface/data/services/portfolio_service.dart';
import 'package:rwa_interface/domain/models/trading_account.dart';
import 'package:rwa_interface/domain/models/portfolio_history.dart';
import 'package:rwa_interface/domain/models/position.dart';

void main() {
  test(
    'preserves HIP3 return and signed funding without deriving missing data',
    () {
      final wire = api.Position(
        (b) => b
          ..positionId = 'p1'
          ..symbol = 'TSLA'
          ..kind = api.ProductKind.perp
          ..quantity = '1'
          ..valueUsd = '100'
          ..unrealizedPnlPercent = '-12.3456'
          ..fundingPaid = '-0.000123',
      );
      final value = mapPosition(wire);
      expect(value.unrealizedPnlPercent?.value, '-12.3456');
      expect(value.fundingPaid?.value, '-0.000123');
      final missing = mapPosition(
        wire.rebuild(
          (b) => b
            ..unrealizedPnlPercent = null
            ..fundingPaid = null
            ..realizedPnl = '7',
        ),
      );
      expect(missing.unrealizedPnlPercent, isNull);
      expect(missing.fundingPaid, isNull);
      expect(missing.unrealizedPnl, isNull);
    },
  );
  test(
    'preserves HIP3 action binding and confirmed protection identifiers',
    () {
      final position = mapPosition(
        api.Position(
          (b) => b
            ..positionId = 'position-1'
            ..productId = 'xyz:TSLA'
            ..positionVersion = 'version-2'
            ..hip3ActionId = 'action-3'
            ..protectionOrderIds.addAll(['tp-1', 'sl-2'])
            ..marginMode = api.MarginMode.cross
            ..symbol = 'TSLA'
            ..kind = api.ProductKind.perp
            ..quantity = '0.099'
            ..valueUsd = '36.357',
        ),
      );
      expect(position.productId, 'xyz:TSLA');
      expect(position.positionVersion, 'version-2');
      expect(position.hip3ActionId, 'action-3');
      expect(position.protectionOrderIds, ['tp-1', 'sl-2']);
      expect(position.marginMode, PositionMarginMode.cross);
      expect(
        () => position.protectionOrderIds.add('fake'),
        throwsUnsupportedError,
      );
    },
  );

  test('does not invent HIP3 metadata for non-HIP3 holdings', () {
    final position = mapPosition(
      api.Position(
        (b) => b
          ..positionId = 'holding-1'
          ..symbol = 'TSLA'
          ..kind = api.ProductKind.bstock
          ..quantity = '1'
          ..valueUsd = '367',
      ),
    );
    expect(position.productId, isNull);
    expect(position.positionVersion, isNull);
    expect(position.hip3ActionId, isNull);
    expect(position.marginMode, isNull);
    expect(position.protectionOrderIds, isEmpty);
  });

  test('maps the bStocks reference return for spot holdings', () {
    final position = mapPosition(
      api.Position(
        (b) => b
          ..positionId = 'holding-return-1'
          ..symbol = 'NVDA'
          ..kind = api.ProductKind.bstock
          ..quantity = '2'
          ..valueUsd = '240'
          ..unrealizedPnlReferenceUsd = '16.25'
          ..unrealizedPnlPercent = '7.261744',
      ),
    );

    expect(position.unrealizedPnl?.value, '16.25');
    expect(position.unrealizedPnlPercent?.value, '7.261744');
  });

  test('maps account kind and preserves token precision', () async {
    final accounts = await PortfolioRepositoryImpl(_Portfolio()).listAccounts();
    expect(accounts.single.kind, TradingAccountKind.hip3);
    expect(
      accounts.single.balances.single.balance.value,
      '0.123456789012345678',
    );
  });

  test('maps portfolio history without losing decimal precision', () async {
    final history = await PortfolioRepositoryImpl(_Portfolio())
        .getHistory(PortfolioHistoryRange.oneWeek);
    expect(history.range, PortfolioHistoryRange.oneWeek);
    expect(history.points.single.totalValueUsd.value, '12345.678901');
    expect(history.points.single.pnlPercent?.value, '1.234567');
    expect(history.points.single.timestamp, DateTime.utc(2026, 1, 1));
  });

  test('requests and maps product-scoped bStocks sell availability', () async {
    final service = _ProductPortfolio();
    final assets = await PortfolioRepositoryImpl(service)
        .listAssets(productId: 'bstocks:nvdab');

    expect(service.productId, 'bstocks:nvdab');
    expect(assets.single.productId, 'bstocks:nvdab');
    expect(assets.single.walletId, 'wallet-1');
    expect(assets.single.bstocksAvailableQuantity?.value, '1.25');
    expect(assets.single.bstocksAvailabilityStatus, 'complete');
    expect(assets.single.freshness, 'live');
  });

  test('maps account allocation and expands known spot breakdowns', () {
    final allocation = mapRailPortfolioAllocation(
      _allocation(
        spot: _accountAllocation(
          account: api.PortfolioAccountAllocationItemAccountEnum.spot,
          valueUsd: '750',
          percent: '75',
          cash: _allocationValue('250'),
          bstocks: _allocationValue('500'),
        ),
        perps: _accountAllocation(
          account: api.PortfolioAccountAllocationItemAccountEnum.perps,
          valueUsd: '250',
          percent: '25',
        ),
      ),
    );

    expect(
      allocation.items.map(
        (item) => (item.rail, item.valueUsd.value, item.percent.value),
      ),
      const [
        ('cash', '250', '25'),
        ('bstock', '500', '50'),
        ('perp', '250', '25'),
      ],
    );
  });

  test('does not convert unavailable allocation values to zero', () {
    final allocation = mapRailPortfolioAllocation(
      _allocation(
        spot: _accountAllocation(
          account: api.PortfolioAccountAllocationItemAccountEnum.spot,
          cash: _allocationValue(null),
        ),
        perps: _accountAllocation(
          account: api.PortfolioAccountAllocationItemAccountEnum.perps,
          valueUsd: '250',
          percent: '25',
        ),
      ),
    );

    expect(allocation.items, hasLength(1));
    expect(allocation.items.single.rail, 'perp');
    expect(allocation.items.single.valueUsd.value, '250');
  });
}

api.RailPortfolioAllocation _allocation({
  required api.PortfolioAccountAllocationItem spot,
  required api.PortfolioAccountAllocationItem perps,
}) => api.RailPortfolioAllocation(
  (builder) => builder
    ..dimension = api.RailPortfolioAllocationDimensionEnum.rail
    ..items.addAll([spot, perps])
    ..valuedTotalUsd = '1000'
    ..unvaluedAssetCount = 0
    ..dataStatus = api.PortfolioDataStatus.complete
    ..freshness = api.PortfolioFreshness.live
    ..calculatedAt = DateTime.utc(2026, 1, 1),
);

api.PortfolioAccountAllocationItem _accountAllocation({
  required api.PortfolioAccountAllocationItemAccountEnum account,
  String? valueUsd,
  String? percent,
  api.PortfolioAllocationValue? cash,
  api.PortfolioAllocationValue? bstocks,
}) => api.PortfolioAccountAllocationItem((builder) {
  builder
    ..account = account
    ..status = api.PortfolioAvailabilityStatus.available
    ..valueUsd = valueUsd
    ..percent = percent
    ..unvaluedAssetCount = 0;
  if (cash != null || bstocks != null) {
    builder.breakdown.update((breakdown) {
      if (cash != null) breakdown.cash.replace(cash);
      if (bstocks != null) breakdown.bstocks.replace(bstocks);
    });
  }
});

api.PortfolioAllocationValue _allocationValue(String? valueUsd) =>
    api.PortfolioAllocationValue(
      (builder) => builder
        ..status = api.PortfolioAvailabilityStatus.available
        ..valueUsd = valueUsd
        ..unvaluedAssetCount = valueUsd == null ? 1 : 0,
    );

final class _Portfolio implements PortfolioService {
  @override
  Future<api.PortfolioHistory> getHistory({
    required String range,
    required String interval,
  }) async => api.PortfolioHistory(
    (history) => history
      ..range = api.PortfolioHistoryRangeEnum.n1w
      ..interval = api.PortfolioHistoryIntervalEnum.n1h
      ..dataStatus = api.PortfolioDataStatus.complete
      ..freshness = api.PortfolioFreshness.live
      ..calculatedAt = DateTime.utc(2026, 1, 1)
      ..points.add(
        api.PortfolioHistoryPoint(
          (point) => point
            ..timestamp = DateTime.utc(2026, 1, 1)
            ..totalValueUsd = '12345.678901'
            ..netExternalCashFlowUsd = '0'
            ..pnlUsd = '123.456789'
            ..pnlPercent = '1.234567',
        ),
      ),
  );

  @override
  Future<api.PortfolioAccountPage> listAccounts() async =>
      api.PortfolioAccountPage((response) {
        response
          ..scope = api.PortfolioAccountPageScopeEnum.portfolio
          ..dataStatus = api.PortfolioDataStatus.complete
          ..freshness = api.PortfolioFreshness.live;
        response.calculatedAt = DateTime.utc(2026, 1, 1);
        response.items.add(
          api.AccountBalance(
            (account) => account
              ..account = api.AccountKind.hip3
              ..availableRequiresTransfer = false
              ..balances.add(
                api.TokenBalance(
                  (balance) => balance
                    ..symbol = 'USDC'
                    ..balance = '0.123456789012345678',
                ),
              ),
          ),
        );
      });
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _ProductPortfolio implements PortfolioService {
  String? productId;

  @override
  Future<api.PortfolioAssetPage> listAssets({
    String? cursor,
    String? productId,
  }) async {
    this.productId = productId;
    return api.PortfolioAssetPage(
      (page) => page
        ..unvaluedAssetCount = 0
        ..dataStatus = api.PortfolioDataStatus.complete
        ..valuedTotalUsd = '100'
        ..totalCount = 1
        ..freshness = api.PortfolioFreshness.live
        ..calculatedAt = DateTime.utc(2026)
        ..hasMore = false
        ..items.add(
          api.PortfolioAsset(
            (asset) => asset
              ..bstocks.replace(
                api.BstocksPortfolioAvailability(
                  (availability) => availability
                    ..rail = api.BstocksPortfolioAvailabilityRailEnum.bstocks
                    ..productId = 'bstocks:nvdab'
                    ..availableQuantity = '1.25'
                    ..availabilityStatus = api
                        .BstocksPortfolioAvailabilityAvailabilityStatusEnum
                        .complete,
                ),
              )
              ..assetId = 'asset-1'
              ..source_ = api.PortfolioAssetSourceKind.evmRpc
              ..network = api.PortfolioAssetNetwork.BSC
              ..walletId = 'wallet-1'
              ..native_ = false
              ..withdrawable = true
              ..symbol = 'NVDAB'
              ..decimals = 18
              ..balanceRaw = '2000000000000000000'
              ..balance = '2'
              ..pricingSource = api.PortfolioPriceSource.bstocksMarketData
              ..observedAt = DateTime.utc(2026)
              ..freshness = api.PortfolioFreshness.live,
          ),
        ),
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
