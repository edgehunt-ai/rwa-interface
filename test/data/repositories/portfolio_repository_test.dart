import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:nobell/data/repositories/portfolio_repository_impl.dart';
import 'package:nobell/data/services/portfolio_service.dart';
import 'package:nobell/domain/models/trading_account.dart';
import 'package:nobell/domain/models/portfolio_allocation.dart';
import 'package:nobell/domain/models/portfolio_history.dart';
import 'package:nobell/domain/models/position.dart';

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

  test('requests and maps scoped bStocks sell availability', () async {
    final service = _ProductPortfolio();
    final assets = await PortfolioRepositoryImpl(service)
        .listAssets(productId: 'bstocks:nvdab', account: 'spot');

    expect(service.productId, 'bstocks:nvdab');
    expect(service.account, 'spot');
    expect(assets.single.productId, 'bstocks:nvdab');
    expect(assets.single.walletId, 'wallet-1');
    expect(assets.single.holdingReturnAmountUsd?.value, '16');
    expect(assets.single.holdingReturnPercent?.value, '3');
    expect(assets.single.bstocksAvailableQuantity?.value, '1.25');
    expect(assets.single.bstocksAvailabilityStatus, 'complete');
    expect(assets.single.freshness, 'live');
    expect(assets.single.withdrawalAvailableBalance, isNull);
  });

  test(
    'decodes top-level quote and stock withdrawal availability exactly',
    () async {
      for (final symbol in ['USDC', 'NVDAB', 'OTHER']) {
        final assets = await PortfolioRepositoryImpl(
          _ProductPortfolio(
            wireOverrides: {
              'symbol': symbol,
              'balance': '100',
              'value_usd': '100',
              'available_quantity': '20.000000000000000001',
              'availability_status': 'complete',
              if (symbol != 'NVDAB') 'bstocks': null,
            },
          ),
        ).listAssets();
        final asset = assets.single;
        expect(asset.availableQuantity?.value, '20.000000000000000001');
        expect(asset.availabilityStatus, 'complete');
        expect(
          asset.withdrawalAvailableBalance?.value,
          '20.000000000000000001',
        );
        expect(asset.balance.value, '100');
        expect(asset.valueUsd?.value, '100');
        expect(
          asset.bstocksAvailableQuantity?.value,
          symbol == 'NVDAB' ? '1.25' : null,
        );
      }
    },
  );

  test(
    'decodes zero, null and stale without falling back to nested stock funds',
    () async {
      for (final scenario in [
        (quantity: '0', status: 'complete', freshness: 'live', expected: '0'),
        (quantity: null, status: 'partial', freshness: 'live', expected: null),
        (
          quantity: '20',
          status: 'unavailable',
          freshness: 'live',
          expected: null,
        ),
        (
          quantity: '20',
          status: 'complete',
          freshness: 'stale',
          expected: null,
        ),
      ]) {
        final asset = (await PortfolioRepositoryImpl(
          _ProductPortfolio(
            wireOverrides: {
              'balance': '100',
              'available_quantity': scenario.quantity,
              'availability_status': scenario.status,
              'freshness': scenario.freshness,
            },
          ),
        ).listAssets()).single;
        expect(asset.bstocksAvailableQuantity?.value, '1.25');
        expect(asset.withdrawalAvailableBalance?.value, scenario.expected);
        expect(asset.balance.value, '100');
      }
    },
  );

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

  for (final status in [
    api.PortfolioCrossMarginPoolStatusEnum.available,
    api.PortfolioCrossMarginPoolStatusEnum.unavailable,
  ]) {
    for (final total in ['10', '0']) {
      test('cross pool uses its own snapshot, status=$status total=$total', () {
        final wire = _allocation(
          spot: _accountAllocation(
            account: api.PortfolioAccountAllocationItemAccountEnum.spot,
            valueUsd: '0',
            percent: '0',
          ),
          perps: _accountAllocation(
            account: api.PortfolioAccountAllocationItemAccountEnum.perps,
            valueUsd: '10',
            percent: '100',
            crossMarginUsedUsd: '4.47',
            estimatedWithdrawableUsd: '3.52',
            crossMarginPool: api.PortfolioCrossMarginPool(
              (b) => b
                ..status = status
                ..asset = api.PortfolioCrossMarginPoolAssetEnum.USDC
                ..valueUsd = '9.09'
                ..quantity = '9.08',
            ),
          ),
        ).rebuild((b) => b.valuedTotalUsd = total);
        final result = mapRailPortfolioAllocation(wire);
        final details = result.perps!.perpsBreakdown!;
        final incomplete = mapRailPortfolioAllocation(
          wire.rebuild((b) {
            b.dataStatus = api.PortfolioDataStatus.partial;
            b.items[1] = b.items[1].rebuild((item) => item.percent = null);
          }),
        );
        expect(incomplete.perps, isNotNull);
        expect(incomplete.perps!.percent, isNull);
        expect(incomplete.hasCompleteValuation, isFalse);
        if (status == api.PortfolioCrossMarginPoolStatusEnum.available) {
          expect(
            incomplete.perps!.perpsBreakdown!.crossMarginPool!.valueUsd.value,
            '9.09',
          );
        }
        expect(details.crossMargin!.valueUsd.value, '4.47');
        expect(details.estimatedWithdrawable!.valueUsd.value, '3.52');
        if (status == api.PortfolioCrossMarginPoolStatusEnum.available) {
          expect(details.crossMarginPool!.valueUsd.value, '9.09');
          expect(
            details.crossMarginPool!.percent.value,
            total == '0' ? '0' : '90.9',
          );
          expect(details.crossMarginPoolQuantity!.value, '9.08');
          expect(details.crossMarginPoolQuantity!.asset, 'USDC');
        } else {
          expect(details.crossMarginPool, isNull);
          expect(details.crossMarginPoolQuantity, isNull);
        }
        expect(
          mapRailPortfolioAllocation(
            wire.rebuild(
              (b) => b
                ..dataStatus = api.PortfolioDataStatus.partial
                ..unvaluedAssetCount = 1,
            ),
          ).hasCompleteValuation,
          isFalse,
        );
      });
    }
  }

  test('missing pool never falls back to used margin', () {
    final result = mapRailPortfolioAllocation(
      _allocation(
        spot: _accountAllocation(
          account: api.PortfolioAccountAllocationItemAccountEnum.spot,
          valueUsd: '0',
          percent: '0',
        ),
        perps: _accountAllocation(
          account: api.PortfolioAccountAllocationItemAccountEnum.perps,
          valueUsd: '10',
          percent: '100',
          crossMarginUsedUsd: '4.47',
        ),
      ),
    );
    expect(result.perps!.perpsBreakdown!.crossMarginPool, isNull);
    expect(result.perps!.perpsBreakdown!.crossMarginPoolQuantity, isNull);
  });

  test('maps perps allocation details and liquidation risk', () {
    final allocation = mapRailPortfolioAllocation(
      _allocation(
        spot: _accountAllocation(
          account: api.PortfolioAccountAllocationItemAccountEnum.spot,
          valueUsd: '600',
          percent: '60',
        ),
        perps: _accountAllocation(
          account: api.PortfolioAccountAllocationItemAccountEnum.perps,
          valueUsd: '400',
          percent: '40',
          crossMarginUsedUsd: '180',
          isolatedMarginUsedUsd: '110',
          openOrderMarginEstimate: api.PortfolioOpenOrderMarginEstimate(
            (builder) => builder
              ..status =
                  api.PortfolioOpenOrderMarginEstimateStatusEnum.available
              ..amountUsd = '110'
              ..orderCount = 2,
          ),
          estimatedWithdrawableUsd: '100',
          crossLiquidationRisk: api.PortfolioCrossLiquidationRisk(
            (builder) => builder
              ..status = api.PortfolioCrossLiquidationRiskStatusEnum.safe
              ..closestDistancePercent = '12.5'
              ..crossPositionCount = 3,
          ),
        ),
      ),
    );

    expect(allocation.spot?.valueUsd.value, '600');
    expect(allocation.perps?.percent?.value, '40');
    final details = allocation.perps?.perpsBreakdown;
    expect(details?.crossMargin?.valueUsd.value, '180');
    expect(details?.crossMargin?.percent.value, '18');
    expect(details?.isolatedMargin?.valueUsd.value, '110');
    expect(details?.openOrderMargin?.valueUsd.value, '110');
    expect(details?.estimatedWithdrawable?.valueUsd.value, '100');
    expect(
      details?.crossLiquidationRisk?.level,
      PortfolioLiquidationRiskLevel.safe,
    );
    expect(
      details?.crossLiquidationRisk?.closestDistancePercent?.value,
      '12.5',
    );
    expect(details?.crossLiquidationRisk?.crossPositionCount, 3);
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
  String? crossMarginUsedUsd,
  api.PortfolioCrossMarginPool? crossMarginPool,
  String? isolatedMarginUsedUsd,
  api.PortfolioOpenOrderMarginEstimate? openOrderMarginEstimate,
  String? estimatedWithdrawableUsd,
  api.PortfolioCrossLiquidationRisk? crossLiquidationRisk,
}) => api.PortfolioAccountAllocationItem((builder) {
  builder
    ..account = account
    ..status = api.PortfolioAvailabilityStatus.available
    ..valueUsd = valueUsd
    ..percent = percent
    ..unvaluedAssetCount = 0;
  if (cash != null ||
      bstocks != null ||
      crossMarginUsedUsd != null ||
      crossMarginPool != null ||
      isolatedMarginUsedUsd != null ||
      openOrderMarginEstimate != null ||
      estimatedWithdrawableUsd != null ||
      crossLiquidationRisk != null) {
    builder.breakdown.update((breakdown) {
      if (cash != null) breakdown.cash.replace(cash);
      if (bstocks != null) breakdown.bstocks.replace(bstocks);
      breakdown.crossMarginUsedUsd = crossMarginUsedUsd;
      if (crossMarginPool != null) {
        breakdown.crossMarginPool.replace(crossMarginPool);
      }
      breakdown.isolatedMarginUsedUsd = isolatedMarginUsedUsd;
      if (openOrderMarginEstimate != null) {
        breakdown.openOrderMarginEstimate.replace(openOrderMarginEstimate);
      }
      breakdown.estimatedWithdrawableUsd = estimatedWithdrawableUsd;
      if (crossLiquidationRisk != null) {
        breakdown.crossLiquidationRisk.replace(crossLiquidationRisk);
      }
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
  _ProductPortfolio({this.wireOverrides});

  final Map<String, Object?>? wireOverrides;
  String? productId;
  String? account;

  @override
  Future<api.PortfolioAssetPage> listAssets({
    String? cursor,
    String? productId,
    String? account,
  }) async {
    this.productId = productId;
    this.account = account;
    final page = api.PortfolioAssetPage(
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
              ..holdingReturn.replace(
                api.PortfolioHoldingReturn(
                  (value) => value
                    ..amountUsd = '16'
                    ..percent = '3',
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
    if (wireOverrides == null) return page;
    final wire = Map<String, Object?>.from(
      api.standardSerializers.serializeWith(
            api.PortfolioAsset.serializer,
            page.items.single,
          )!
          as Map,
    )..addAll(wireOverrides!);
    final decoded = api.standardSerializers.deserializeWith(
      api.PortfolioAsset.serializer,
      wire,
    )!;
    return page.rebuild((builder) => builder.items.replace([decoded]));
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
