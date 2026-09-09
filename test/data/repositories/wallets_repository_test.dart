import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/domain/models/withdrawal.dart';

void main() {
  test('expired withdrawal authorization is not usable', () {
    final value = WalletAuthorization(
      authorizationId: 'auth-1',
      walletId: 'wallet-1',
      status: WalletAuthorizationState.authorized,
      expiresAt: DateTime.utc(2020),
    );
    expect(value.isUsable, isFalse);
  });
}
