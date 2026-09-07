import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/data/services/orders_service.dart';
import 'package:rwa_interface/data/services/positions_service.dart';

void main() {
  test('service ports intentionally expose no wallet action operation', () {
    expect(OrdersService, isNotNull);
    expect(PositionsService, isNotNull);
    expect('$OrdersService $PositionsService', isNot(contains('WalletAction')));
  });
}
