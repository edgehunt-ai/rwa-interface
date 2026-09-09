import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/domain/models/user_account.dart';

void main() {
  const preferences = UserPreferences(
    language: 'en',
    pushEnabled: true,
    notifyOrderFilled: true,
    notifyOrderFailed: true,
    notifyLiquidationWarning: true,
  );

  test('prefers the API display name over the Privy display name', () {
    const account = UserAccount(
      userId: 'user-1',
      displayName: 'API user',
      settings: preferences,
    );

    expect(
      accountDisplayName(account, identityDisplayName: 'Privy user'),
      'API user',
    );
  });

  test('uses the Privy display name before the account id', () {
    const account = UserAccount(userId: 'user-1', settings: preferences);

    expect(
      accountDisplayName(account, identityDisplayName: 'Privy user'),
      'Privy user',
    );
    expect(accountDisplayName(account), 'user-1');
  });
}
