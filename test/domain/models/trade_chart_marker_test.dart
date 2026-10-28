import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/hip3_protection.dart';
import 'package:nobell/domain/models/market_product.dart';
import 'package:nobell/domain/models/order.dart';
import 'package:nobell/domain/models/order_intent.dart';
import 'package:nobell/domain/models/position.dart';
import 'package:nobell/domain/models/trade_chart_marker.dart';

void main() {
  test('spot markers use individual executions, including fills of cancelled orders', () {
    final markers = tradeChartExecutions([
      _order('buy', kind: MarketProductKind.bstock, side: TradingSide.buy),
      _order(
        'sell',
        kind: MarketProductKind.bstock,
        side: TradingSide.sell,
        status: TradingOrderStatus.cancelled,
      ),
    ]);
    expect(markers.map((e) => e.kind), [
      TradeChartMarkerKind.buy,
      TradeChartMarkerKind.sell,
    ]);
    expect(markers.map((e) => e.price!.value), everyElement('101.25'));
    expect(markers.map((e) => e.at), everyElement(_at));
  });

  test('perpetual markers follow execution direction for opens, closes and reversals', () {
    final markers = tradeChartExecutions([
      for (final effect in [
        'open_long',
        'close_long',
        'short_to_long',
        'open_short',
        'close_short',
        'long_to_short',
      ])
        _order(effect, effect: effect),
    ]);
    expect(markers.map((e) => e.kind), [
      TradeChartMarkerKind.long,
      TradeChartMarkerKind.short,
      TradeChartMarkerKind.long,
      TradeChartMarkerKind.short,
      TradeChartMarkerKind.long,
      TradeChartMarkerKind.short,
    ]);
  });

  test('TP and SL fill history is independent of current positions', () {
    expect(
      tradeChartExecutions([
        _order('tp', role: 'takeProfit'),
        _order('sl', role: 'stopLoss'),
      ]).map((e) => e.kind),
      [TradeChartMarkerKind.takeProfit, TradeChartMarkerKind.stopLoss],
    );
    expect(tradeChartPriceLevels([]), isEmpty);
  });

  test(
    'missing fill direction never fabricates a perpetual trade direction',
    () {
      expect(tradeChartExecutions([_order('unknown')]), isEmpty);
      final order = TradingOrder(
        orderId: 'unfilled',
        symbol: 'NVDA',
        kind: MarketProductKind.perp,
        side: TradingSide.long,
        type: TradingOrderType.limit,
        status: TradingOrderStatus.open,
        limitPrice: DecimalValue('999'),
        createdAt: _at,
      );
      expect(tradeChartExecutions([order]), isEmpty);
    },
  );

  test(
    'each active protection leg and liquidation price has its own level',
    () {
      final levels = tradeChartPriceLevels([_position()]);
      expect(levels.map((e) => e.kind), [
        TradeChartMarkerKind.takeProfit,
        TradeChartMarkerKind.stopLoss,
        TradeChartMarkerKind.liquidation,
      ]);
      expect(levels.map((e) => e.price.value), ['110', '90', '60']);
      expect(tradeChartPriceLevels([_position(quantity: '0')]), isEmpty);
    },
  );

  test('typed fractional quantities retain precision when checking active positions', () {
    expect(
      tradeChartPriceLevels([_position(quantity: '0.000000000000000001')]),
      hasLength(3),
    );
    expect(
      tradeChartPriceLevels([
        _position(quantity: '-0.000000000000000001', side: PositionSide.short),
      ]),
      hasLength(3),
    );
    expect(tradeChartPriceLevels([_position(quantity: '-0.000')]), isEmpty);
  });

  test('signed short quantities are active while zero prices are omitted', () {
    expect(
      tradeChartPriceLevels([
        _position(quantity: '-2', side: PositionSide.short),
      ]),
      hasLength(3),
    );
    final position = Position(
      positionId: 'legacy',
      symbol: 'NVDA',
      kind: MarketProductKind.perp,
      side: PositionSide.long,
      quantity: DecimalValue('1'),
      valueUsd: DecimalValue('100'),
      takeProfitPrice: DecimalValue('110', asset: 'USDC', unit: 'price'),
      stopLossPrice: DecimalValue('0', asset: 'USDC', unit: 'price'),
    );
    expect(
      tradeChartPriceLevels([position]).single.kind,
      TradeChartMarkerKind.takeProfit,
    );
  });
}

final _at = DateTime.utc(2026, 10, 20, 12);

TradingOrder _order(
  String id, {
  MarketProductKind kind = MarketProductKind.perp,
  TradingSide side = TradingSide.long,
  String? effect,
  String? role,
  TradingOrderStatus status = TradingOrderStatus.filled,
}) => TradingOrder(
  orderId: id,
  symbol: 'NVDA',
  kind: kind,
  side: side,
  type: TradingOrderType.limit,
  status: status,
  createdAt: _at.subtract(const Duration(days: 1)),
  updatedAt: _at.add(const Duration(hours: 1)),
  limitPrice: DecimalValue('999'),
  conditional: role == null
      ? null
      : ConditionalOrder(
          role: role,
          triggerPrice: DecimalValue('100'),
          triggerStatus: 'triggered',
          executionType: 'market',
          sizeMode: 'quantity',
          quantity: '1',
          triggerReference: 'mark',
        ),
  fills: [
    TradingOrderFill(
      id: 'fill',
      price: DecimalValue('101.25', unit: 'price'),
      quantity: DecimalValue('1', unit: 'quantity'),
      executedAt: _at,
      positionEffect: effect,
    ),
  ],
);

Position _position({
  String quantity = '1',
  PositionSide side = PositionSide.long,
}) => Position(
  positionId: 'position',
  symbol: 'NVDA',
  kind: MarketProductKind.perp,
  side: side,
  quantity: DecimalValue(quantity, asset: 'NVDA', unit: 'quantity'),
  valueUsd: DecimalValue('100'),
  liquidationPrice: DecimalValue('60', asset: 'USDC', unit: 'price'),
  protectionOrders: [
    Hip3PositionProtectionOrder(
      orderId: 'tp',
      protection: Hip3ProtectionParameters(
        role: 'takeProfit',
        triggerPrice: DecimalValue('110', asset: 'USDC', unit: 'price'),
      ),
    ),
    Hip3PositionProtectionOrder(
      orderId: 'sl',
      protection: Hip3ProtectionParameters(
        role: 'stopLoss',
        triggerPrice: DecimalValue('90', asset: 'USDC', unit: 'price'),
      ),
    ),
  ],
);
