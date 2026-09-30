import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/decimal_value.dart';
import '../../domain/models/domain_page.dart';
import '../../domain/models/market_product.dart';
import '../../domain/models/portfolio.dart';
import '../../domain/models/portfolio_asset.dart';
import '../../domain/models/portfolio_allocation.dart';
import '../../domain/models/portfolio_history.dart' as domain;
import '../../domain/models/position.dart';
import '../../domain/models/trading_account.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../services/portfolio_service.dart';
import '../mappers/chain_name_mapper.dart';

// The domain portfolio still exposes this optional legacy aggregate.
// ignore_for_file: deprecated_member_use

final class PortfolioRepositoryImpl
    implements
        PortfolioRepository,
        PortfolioHistoryRepository,
        PortfolioAssetsRepository,
        PortfolioAllocationRepository {
  PortfolioRepositoryImpl(this._service);
  final PortfolioService _service;

  @override
  Future<Portfolio> getSummary() async {
    final value = await _service.getSummary();
    return Portfolio(
      totalValueUsd: _usd(value.totalValueUsd),
      availableToTradeUsd: _usd(value.availableToTradeUsd),
      todayPnl: _optionalUsd(value.todayPnlUsd),
      todayPnlPercent: _optional(value.todayPnlPercent, 'percent'),
      marginInUseUsd: _optionalUsd(value.marginInUseUsd),
      stocksValueUsd: _optionalUsd(value.stocksValueUsd),
      updatedAt: value.calculatedAt.toUtc(),
    );
  }

  @override
  Future<PortfolioRailAllocation> getRailAllocation() async {
    final value = await _service.getRailAllocation();
    final asset = value.oneOf.value;
    if (asset is! api.RailPortfolioAllocation) {
      throw const FormatException('Expected rail portfolio allocation');
    }
    return mapRailPortfolioAllocation(asset);
  }

  @override
  Future<domain.PortfolioHistory> getHistory(
    domain.PortfolioHistoryRange range,
  ) async {
    final value = await _service.getHistory(
      range: range.apiValue,
      interval: range.interval,
    );
    return domain.PortfolioHistory(
      range: range,
      calculatedAt: value.calculatedAt.toUtc(),
      points: List.unmodifiable(
        value.points.map(
          (point) => domain.PortfolioHistoryPoint(
            timestamp: point.timestamp.toUtc(),
            totalValueUsd: _usd(point.totalValueUsd),
            pnlUsd: _optionalUsd(point.pnlUsd),
            pnlPercent: _optional(point.pnlPercent, 'percent'),
          ),
        ),
      ),
    );
  }

  @override
  Future<List<TradingAccount>> listAccounts() async =>
      (await _service.listAccounts()).items.map(_account).toList();

  @override
  Future<List<PortfolioAsset>> listAssets({String? cursor}) async {
    final values = <PortfolioAsset>[];
    var nextCursor = cursor;
    do {
      final page = await _service.listAssets(cursor: nextCursor);
      values.addAll(
        page.items.map(
          (asset) => PortfolioAsset(
            assetId: asset.assetId,
            network: asset.network.name,
            symbol: asset.symbol,
            decimals: asset.decimals,
            balance: DecimalValue(
              asset.balance,
              asset: asset.symbol,
              unit: 'token',
            ),
            withdrawable: asset.withdrawable ?? false,
            walletId: asset.walletId,
            contractAddress: asset.contractAddress,
            native: asset.native_,
          ),
        ),
      );
      nextCursor = page.nextCursor;
    } while (nextCursor != null);
    return values;
  }

  @override
  Future<DomainPage<HoldingGroup>> listHoldings({String? cursor}) async {
    final value = await _service.listHoldings(cursor: cursor);
    return DomainPage(
      items: value.items
          .map(
            (group) => HoldingGroup(
              symbol: group.stock.symbol,
              totalValueUsd: _usd(group.totalValueUsd),
              positions: group.positions.map(mapPosition).toList(),
            ),
          )
          .toList(),
      nextCursor: value.nextCursor,
      hasMore: value.hasMore,
    );
  }

  TradingAccount _account(api.AccountBalance value) => TradingAccount(
    kind: switch (value.account) {
      api.AccountKind.app => TradingAccountKind.app,
      api.AccountKind.bstocks => TradingAccountKind.bstocks,
      api.AccountKind.hip3 => TradingAccountKind.hip3,
      _ => TradingAccountKind.unknown,
    },
    label: value.label,
    address: value.address,
    walletId: value.walletId,
    chain: value.chain == null ? null : canonicalChainName(value.chain!.name),
    totalValueUsd: _optionalUsd(value.totalValueUsd),
    availableUsd: _optionalUsd(value.availableUsd),
    availableRequiresTransfer: value.availableRequiresTransfer,
    marginUsedUsd: _optionalUsd(value.marginUsedUsd),
    balances: value.balances
        .map(
          (balance) => TokenBalance(
            symbol: balance.symbol,
            balance: DecimalValue(
              balance.balance,
              asset: balance.symbol,
              unit: 'token',
            ),
            valueUsd: _optionalUsd(balance.valueUsd),
            decimals: balance.decimals,
            chain: balance.chain == null
                ? null
                : canonicalChainName(balance.chain!.name),
          ),
        )
        .toList(),
  );

  DecimalValue _usd(String value) =>
      DecimalValue(value, asset: 'USD', unit: 'fiat');
  DecimalValue? _optionalUsd(String? value) =>
      value == null ? null : _usd(value);
}

Position mapPosition(api.Position value) => Position(
  positionId: value.positionId,
  symbol: value.symbol,
  kind: value.kind == api.ProductKind.bstock
      ? MarketProductKind.bstock
      : MarketProductKind.perp,
  side: switch (value.side) {
    api.PositionSideEnum.long => PositionSide.long,
    api.PositionSideEnum.short => PositionSide.short,
    _ => PositionSide.none,
  },
  productId: value.productId,
  positionVersion: value.positionVersion,
  hip3ActionId: value.hip3ActionId,
  protectionOrderIds: List.unmodifiable(
    value.protectionOrderIds?.toList() ?? const [],
  ),
  marginMode: switch (value.marginMode) {
    api.MarginMode.isolated => PositionMarginMode.isolated,
    api.MarginMode.cross => PositionMarginMode.cross,
    null => null,
    _ => PositionMarginMode.unknown,
  },
  quantity: DecimalValue(
    value.quantity,
    unit: value.quantityUnit ?? 'quantity',
  ),
  valueUsd: DecimalValue(value.valueUsd ?? '0', asset: 'USD', unit: 'fiat'),
  entryPrice: _optional(value.entryPrice, 'price'),
  markPrice: _optional(value.markPrice, 'price'),
  unrealizedPnl: _optional(value.unrealizedPnl, 'pnl'),
  unrealizedPnlPercent: _optional(value.unrealizedPnlPercent, 'percent'),
  realizedPnl: _optional(value.realizedPnl, 'pnl'),
  fundingPaid: _optional(value.fundingPaid, 'funding'),
  leverage: _optional(value.leverage, 'leverage'),
  margin: _optional(value.margin, 'margin'),
  liquidationPrice: _optional(value.liquidationPrice, 'price'),
  takeProfitPrice: _optional(value.takeProfitPrice, 'price'),
  stopLossPrice: _optional(value.stopLossPrice, 'price'),
  stopLimitPrice: _optional(value.stopLimitPrice, 'price'),
  updatedAt: value.updatedAt?.toUtc(),
);

DecimalValue? _optional(String? value, String unit) =>
    value == null ? null : DecimalValue(value, unit: unit);

PortfolioRailAllocation mapRailPortfolioAllocation(
  api.RailPortfolioAllocation value,
) {
  final items = <PortfolioRailAllocationItem>[];
  for (final item in value.items) {
    switch (item.account) {
      case api.PortfolioAccountAllocationItemAccountEnum.spot:
        final breakdown = item.breakdown;
        if (breakdown == null) {
          _addAllocationItem(
            items,
            rail: 'spot',
            valueUsd: item.valueUsd,
            percent: item.percent,
          );
          continue;
        }
        _addAllocationValue(
          items,
          rail: 'cash',
          value: breakdown.cash,
          valuedTotalUsd: value.valuedTotalUsd,
          parentPercent: item.percent,
        );
        _addAllocationValue(
          items,
          rail: 'bstock',
          value: breakdown.bstocks,
          valuedTotalUsd: value.valuedTotalUsd,
          parentPercent: item.percent,
        );
      case api.PortfolioAccountAllocationItemAccountEnum.perps:
        _addAllocationItem(
          items,
          rail: 'perp',
          valueUsd: item.valueUsd,
          percent: item.percent,
        );
    }
  }
  return PortfolioRailAllocation(
    items: List.unmodifiable(items),
    valuedTotalUsd: _usdValue(value.valuedTotalUsd),
    unvaluedAssetCount: value.unvaluedAssetCount,
  );
}

void _addAllocationValue(
  List<PortfolioRailAllocationItem> items, {
  required String rail,
  required api.PortfolioAllocationValue? value,
  required String valuedTotalUsd,
  required String? parentPercent,
}) {
  final valueUsd = value?.valueUsd;
  if (valueUsd == null || parentPercent == null) return;
  _addAllocationItem(
    items,
    rail: rail,
    valueUsd: valueUsd,
    percent: _percentageOf(valueUsd, valuedTotalUsd),
  );
}

void _addAllocationItem(
  List<PortfolioRailAllocationItem> items, {
  required String rail,
  required String? valueUsd,
  required String? percent,
}) {
  if (valueUsd == null || percent == null) return;
  items.add(
    PortfolioRailAllocationItem(
      rail: rail,
      valueUsd: _usdValue(valueUsd),
      percent: DecimalValue(percent, unit: 'percent'),
    ),
  );
}

String _percentageOf(String value, String total, {int scale = 18}) {
  final amount = _decimalParts(value);
  final denominatorValue = _decimalParts(total);
  if (denominatorValue.units == BigInt.zero) return '0';
  final numerator =
      amount.units.abs() *
      BigInt.from(100) *
      _powerOfTen(denominatorValue.scale + scale);
  final denominator = denominatorValue.units.abs() * _powerOfTen(amount.scale);
  var quotient = numerator ~/ denominator;
  final remainder = numerator.remainder(denominator);
  if (remainder * BigInt.from(2) >= denominator) quotient += BigInt.one;
  return _decimalFromScaled(quotient, scale);
}

({BigInt units, int scale}) _decimalParts(String value) {
  final parts = value.split('.');
  final scale = parts.length == 1 ? 0 : parts.last.length;
  return (
    units: BigInt.parse('${parts.first}${parts.length == 1 ? '' : parts.last}'),
    scale: scale,
  );
}

BigInt _powerOfTen(int exponent) => BigInt.from(10).pow(exponent);

DecimalValue _usdValue(String value) =>
    DecimalValue(value, asset: 'USD', unit: 'fiat');

String _decimalFromScaled(BigInt units, int scale) {
  if (scale == 0) return units.toString();
  final digits = units.toString().padLeft(scale + 1, '0');
  final split = digits.length - scale;
  final value = '${digits.substring(0, split)}.${digits.substring(split)}';
  final withoutZeros = value.replaceFirst(RegExp(r'0+$'), '');
  return withoutZeros.endsWith('.')
      ? withoutZeros.substring(0, withoutZeros.length - 1)
      : withoutZeros;
}
