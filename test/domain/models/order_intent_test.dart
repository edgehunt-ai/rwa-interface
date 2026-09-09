import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/order_intent.dart';

void main() {
  DecimalValue value(String value) => DecimalValue(value, unit: 'quantity');

  test('validates product side and spot/perpetual-only fields', () {
    expect(
      () => OrderIntent(
        symbol: 'NVDA',
        kind: MarketProductKind.bstock,
        side: TradingSide.long,
        type: TradingOrderType.market,
        quantity: value('1'),
      ),
      throwsArgumentError,
    );
    expect(
      () => OrderIntent(
        symbol: 'NVDA',
        kind: MarketProductKind.bstock,
        side: TradingSide.buy,
        type: TradingOrderType.market,
        quantity: value('1'),
        leverage: DecimalValue('2', unit: 'leverage'),
      ),
      throwsArgumentError,
    );
  });

  test('limit requires quantity and price and amount is exclusive', () {
    expect(
      () => OrderIntent(
        symbol: 'NVDA',
        kind: MarketProductKind.bstock,
        side: TradingSide.buy,
        type: TradingOrderType.limit,
        amount: value('10'),
      ),
      throwsArgumentError,
    );
    expect(
      () => OrderIntent(
        symbol: 'NVDA',
        kind: MarketProductKind.bstock,
        side: TradingSide.buy,
        type: TradingOrderType.market,
        amount: value('10'),
        quantity: value('1'),
      ),
      throwsArgumentError,
    );
  });
}
