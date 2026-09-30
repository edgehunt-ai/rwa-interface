import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/position.dart';

void main() {
  test('HIP-3 mark notional is quantity multiplied by mark price', () {
    final position = Position(
      positionId: 'position-1',
      symbol: 'NVDA',
      kind: MarketProductKind.perp,
      side: PositionSide.long,
      quantity: DecimalValue('3.0154'),
      valueUsd: DecimalValue('700'),
      markPrice: DecimalValue('182.4'),
    );

    expect(position.markNotional?.value, '550.00896');
  });

  test('bStocks mark value is quantity multiplied by mark price', () {
    final position = Position(
      positionId: 'position-1',
      symbol: 'NVDA',
      kind: MarketProductKind.bstock,
      side: PositionSide.long,
      quantity: DecimalValue('12.5'),
      valueUsd: DecimalValue('1'),
      markPrice: DecimalValue('100.25'),
    );

    expect(position.markValue?.value, '1253.125');
    expect(position.markValue?.asset, 'USD');
    expect(position.markNotional, isNull);
  });

  test('mark value preserves sub-cent decimal precision', () {
    final position = Position(
      positionId: 'position-1',
      symbol: 'NVDA',
      kind: MarketProductKind.bstock,
      quantity: DecimalValue('0.00000001'),
      valueUsd: DecimalValue('0'),
      markPrice: DecimalValue('0.00000002'),
    );

    expect(position.markValue?.value, '0.0000000000000002');
  });

  test('mark notional is unavailable without a mark price', () {
    final position = Position(
      positionId: 'position-1',
      symbol: 'NVDA',
      kind: MarketProductKind.perp,
      quantity: DecimalValue('3'),
      valueUsd: DecimalValue('700'),
    );

    expect(position.markValue, isNull);
    expect(position.markNotional, isNull);
  });
}
