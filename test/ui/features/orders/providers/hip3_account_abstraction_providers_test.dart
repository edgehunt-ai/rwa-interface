import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:nobell/app/providers/api_providers.dart';
import 'package:nobell/domain/models/hip3_account_abstraction.dart';
import 'package:nobell/domain/models/user_account.dart';
import 'package:nobell/domain/repositories/hip3_account_abstraction_repository.dart';
import 'package:nobell/ui/features/account/providers/account_providers.dart';
import 'package:nobell/ui/features/orders/providers/hip3_account_abstraction_providers.dart';

void main() {
  test(
    'successful conversion invalidates the cached status provider',
    () async {
      SharedPreferences.setMockInitialValues({});
      var statusBuilds = 0;
      final container = ProviderContainer(
        overrides: [
          accountProvider.overrideWith(
            (_) async => const UserAccount(
              userId: 'user-1',
              settings: UserPreferences(
                language: 'en',
                pushEnabled: true,
                notifyOrderFilled: true,
                notifyOrderFailed: true,
                notifyLiquidationWarning: true,
              ),
            ),
          ),
          hip3AccountAbstractionRepositoryProvider.overrideWithValue(
            _ConvertingRepository(),
          ),
          hip3AccountAbstractionProvider.overrideWith((_) async {
            statusBuilds++;
            return Hip3AccountAbstractionStatus(
              ownerAddress: '0xowner',
              currentMode: statusBuilds == 1
                  ? Hip3AccountAbstractionMode.defaultMode
                  : Hip3AccountAbstractionMode.unifiedAccount,
              switchAvailable: statusBuilds == 1,
            );
          }),
        ],
      );
      addTearDown(container.dispose);

      expect(
        (await container.read(hip3AccountAbstractionProvider.future))
            .isUnifiedAccount,
        isFalse,
      );

      await container
          .read(hip3AccountAbstractionCommandProvider)
          .convertToUnifiedAccount();

      expect(
        (await container.read(hip3AccountAbstractionProvider.future))
            .isUnifiedAccount,
        isTrue,
      );
      expect(statusBuilds, 2);
    },
  );
}

final class _ConvertingRepository implements Hip3AccountAbstractionRepository {
  @override
  Future<Hip3AccountAbstractionStatus> getStatus() async =>
      throw UnimplementedError();

  @override
  Future<Hip3AccountAbstractionStatus> switchToUnifiedAccount({
    required String prepareIdempotencyKey,
    required String executeIdempotencyKey,
  }) async => const Hip3AccountAbstractionStatus(
    ownerAddress: '0xowner',
    currentMode: Hip3AccountAbstractionMode.unifiedAccount,
    switchAvailable: false,
  );
}
