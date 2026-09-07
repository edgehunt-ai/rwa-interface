import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/data/services/funding_service.dart';
import 'package:rwa_interface/data/services/wallets_service.dart';

void main() {
  test('narrow ports do not expose plans transfers or claims', () {
    final surface = '$FundingService $WalletsService'.toLowerCase();
    expect(surface, isNot(contains('plan')));
    expect(surface, isNot(contains('claim')));
  });
}
