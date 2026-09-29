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

  test('mark notional is unavailable without a mark price', () {
    final position = Position(
      positionId: 'position-1',
      symbol: 'NVDA',
      kind: MarketProductKind.perp,
      quantity: DecimalValue('3'),
      valueUsd: DecimalValue('700'),
    );

    expect(position.markNotional, isNull);
  });
}
