import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/data/services/orders_service.dart';
import 'package:nobell/data/services/positions_service.dart';

void main() {
  test('service ports intentionally expose no wallet action operation', () {
    expect(OrdersService, isNotNull);
    expect(PositionsService, isNotNull);
    expect('$OrdersService $PositionsService', isNot(contains('WalletAction')));
  });
}
