import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/data/repositories/positions_repository_impl.dart';
import 'package:rwa_interface/data/services/positions_service.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/position.dart';

void main() {
  final service = _Positions();
  final repository = PositionsRepositoryImpl(service);
  final position = Position(
    positionId: 'position-1',
    symbol: 'XYZ',
    kind: MarketProductKind.perp,
    side: PositionSide.long,
    quantity: DecimalValue('1', unit: 'quantity'),
    valueUsd: DecimalValue('100', asset: 'USD', unit: 'fiat'),
    entryPrice: DecimalValue(
      '100.000000000000000001',
      asset: 'USDC',
      unit: 'price',
    ),
  );

  test('TP/SL direction uses decimal comparisons without precision loss', () {
    expect(
      () => repository.updateTpSl(
        position,
        takeProfit: '100.000000000000000000',
        idempotencyKey: 'key',
      ),
      throwsArgumentError,
    );
  });

  test('leverage range and mutually exclusive close inputs are validated', () {
    expect(
      () => repository.updateLeverage(
        position,
        leverage: '50.000000000000000001',
        idempotencyKey: 'key',
      ),
      throwsArgumentError,
    );
    expect(
      () => repository.close(
        position.positionId,
        quantity: '1',
        percent: '100',
        idempotencyKey: 'key',
      ),
      throwsArgumentError,
    );
  });
}

final class _Positions implements PositionsService {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
