import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app/providers/api_providers.dart';
import 'package:nobell/app_review/app_review.dart';
import 'package:nobell/domain/repositories/funding_repository.dart';
import 'package:nobell/domain/repositories/wallets_repository.dart';
import 'package:nobell/domain/models/funding_catalog_summary.dart';
import 'package:nobell/ui/features/funding/views/transfer_screen.dart';

import '../helpers/test_app.dart';

void main() {
  testWidgets('review transfer quotes and executes with simulated balances', (
    tester,
  ) async {
    final live = _UnexpectedFunding();
    final container = ProviderContainer(
      overrides: [
        walletsRepositoryProvider.overrideWith(
          (ref) => AppReviewWalletsRepository(
            watchAppReviewStore(ref),
            readDelegate: _UnexpectedWallets(),
          ),
        ),
        fundingRepositoryProvider.overrideWith(
          (ref) => AppReviewFundingRepository(
            watchAppReviewStore(ref),
            readDelegate: live,
          ),
        ),
      ],
    );
    addTearDown(container.dispose);
    container.read(appReviewModeProvider.notifier).setEnabled(true);
    final store = container.read(appReviewStoreProvider);
    final total = store.total;
    final revision = container.read(appReviewRevisionProvider);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: buildTestApp(const TransferScreen(), locale: const Locale('en')),
      ),
    );
    await tester.pumpAndSettle();
    for (final invalidAmount in ['0', '999999']) {
      await tester.enterText(find.byType(TextField).first, invalidAmount);
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pumpAndSettle();
      expect(
        tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
        isNull,
      );
    }
    await tester.enterText(find.byType(TextField).first, '1');
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pumpAndSettle();
    expect(
      find.text(
        'The quote changed and cannot be confirmed. Adjust the send amount and try again.',
      ),
      findsNothing,
    );
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNotNull,
    );
    await tester.pump(const Duration(seconds: 6));
    await tester.pumpAndSettle();
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNotNull,
    );
    expect(container.read(appReviewRevisionProvider), revision);
    expect(store.cash, 4375);
    expect(store.perpsCash, 2400);
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();
    expect(store.cash, 4374);
    expect(store.perpsCash, 2401);
    expect(store.total, total);
    expect(store.fundingTransfers, hasLength(1));
    expect(store.activities.where((a) => a.type == 'transfer'), hasLength(1));
    expect(container.read(appReviewRevisionProvider), greaterThan(revision));
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  }, skip: !AppReviewConfiguration.buildEnabled);
}

final class _UnexpectedFunding implements FundingRepository {
  @override
  Future<FundingCatalogSummary> getFundingCatalog() async =>
      throw Exception('Catalog unavailable');

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw StateError('Live funding is unavailable: real wallet has no funds');
}

final class _UnexpectedWallets implements WalletsRepository {
  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw StateError('Real wallet signing must not be called');
}
