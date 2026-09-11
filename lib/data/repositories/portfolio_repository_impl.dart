import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/decimal_value.dart';
import '../../domain/models/domain_page.dart';
import '../../domain/models/market_product.dart';
import '../../domain/models/portfolio.dart';
import '../../domain/models/position.dart';
import '../../domain/models/trading_account.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../services/portfolio_service.dart';

// The domain portfolio still exposes this optional legacy aggregate.
// ignore_for_file: deprecated_member_use

final class PortfolioRepositoryImpl implements PortfolioRepository {
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
  Future<List<TradingAccount>> listAccounts() async =>
      (await _service.listAccounts()).items.map(_account).toList();

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
    chain: value.chain?.name,
    totalValueUsd: _optionalUsd(value.totalValueUsd),
    availableUsd: _optionalUsd(value.availableUsd),
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
            chain: balance.chain?.name,
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
  productId: value.productId,
  positionVersion: value.positionVersion,
  hip3ActionId: value.hip3ActionId,
  protectionOrderIds: List.unmodifiable(value.protectionOrderIds ?? []),
  marginMode: switch (value.marginMode) {
    api.MarginMode.cross => PositionMarginMode.cross,
    api.MarginMode.isolated => PositionMarginMode.isolated,
    null => null,
    _ => PositionMarginMode.unknown,
  },
  symbol: value.symbol,
  kind: value.kind == api.ProductKind.bstock
      ? MarketProductKind.bstock
      : MarketProductKind.perp,
  side: switch (value.side) {
    api.PositionSideEnum.long => PositionSide.long,
    api.PositionSideEnum.short => PositionSide.short,
    _ => PositionSide.none,
  },
  quantity: DecimalValue(
    value.quantity,
    unit: value.quantityUnit ?? 'quantity',
  ),
  valueUsd: DecimalValue(value.valueUsd, asset: 'USD', unit: 'fiat'),
  entryPrice: _optional(value.entryPrice, 'price'),
  markPrice: _optional(value.markPrice, 'price'),
  unrealizedPnl: _optional(value.unrealizedPnl, 'pnl'),
  unrealizedPnlPercent: _optional(value.unrealizedPnlPercent, 'percent'),
  fundingPaid: _optional(value.fundingPaid, 'funding'),
  realizedPnl: _optional(value.realizedPnl, 'pnl'),
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
