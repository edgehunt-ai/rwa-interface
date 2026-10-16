import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app/routing/app_router.dart';
import 'package:nobell/app/routing/routes.dart';
import 'package:nobell/domain/models/activity_record.dart';
import 'package:nobell/domain/models/domain_page.dart';
import 'package:nobell/domain/auth/authentication.dart';
import 'package:nobell/ui/features/session/providers/authentication_provider.dart';
import 'package:nobell/ui/features/session/views/privy_login_screen.dart';
import 'package:nobell/ui/features/activity/providers/activity_provider.dart';
import 'package:nobell/ui/features/activity/views/activity_screen.dart';

import '../../helpers/test_app.dart';

void main() {
  testWidgets('list detail action opens a stable record route', (tester) async {
    final record = ActivityRecord(
      id: 'order/123',
      category: ActivityCategory.orders,
      type: 'market',
      status: ActivityState.success,
      title: 'TSLA',
      symbol: 'TSLA',
      createdAt: DateTime.utc(2026),
    );
    final router = AppRouter.create(initialLocation: '/activity');
    addTearDown(router.dispose);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authenticatedStateOverride,
          activityProvider.overrideWith(
            (_, _) async => DomainPage(items: [record]),
          ),
          activityDetailProvider(record.id).overrideWith((_) async => record),
        ],
        child: buildRouterTestApp(router),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('TSLA'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(ValueKey('activity-detail-link-${record.id}')));
    await tester.pumpAndSettle();
    expect(find.byType(ActivityDetailScreen), findsOneWidget);
    expect(
      router.routeInformationProvider.value.uri.toString(),
      AppRoutes.activityDetailLocation(record.id),
    );
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.byType(ActivityScreen), findsOneWidget);
  });

  testWidgets('failed detail requests can be retried', (tester) async {
    var attempts = 0;
    final router = AppRouter.create(initialLocation: '/activity/retry');
    addTearDown(router.dispose);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authenticatedStateOverride,
          activityDetailProvider('retry').overrideWith((_) async {
            if (++attempts == 1) throw StateError('temporary failure');
            return ActivityRecord(
              id: 'retry',
              category: ActivityCategory.cash,
              type: 'deposit',
              status: ActivityState.success,
              title: 'Recovered record',
              createdAt: DateTime.utc(2026),
            );
          }),
        ],
        child: buildRouterTestApp(router),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();
    expect(attempts, 2);
    expect(find.text('Recovered record'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  test('activity locations encode IDs and reject empty IDs', () {
    const id = 'order/123 ?#中文';
    expect(Uri.parse(AppRoutes.activityDetailLocation(id)).pathSegments, [
      'activity',
      id,
    ]);
    expect(() => AppRoutes.activityDetailLocation('  '), throwsArgumentError);
  });

  for (final category in [
    ActivityCategory.orders,
    ActivityCategory.cash,
    ActivityCategory.funding,
  ]) {
    testWidgets('opens activity category details directly', (tester) async {
      const id = 'record/123 ?#中文';
      final router = AppRouter.create(
        initialLocation: AppRoutes.activityDetailLocation(id),
      );
      addTearDown(router.dispose);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authenticatedStateOverride,
            activityDetailProvider(id).overrideWith(
              (_) async => ActivityRecord(
                id: id,
                category: category,
                type: 'deposit',
                status: ActivityState.success,
                title: 'Test record',
                createdAt: DateTime.utc(2026),
                fields: const [ActivityField(label: 'Record ID', value: id)],
              ),
            ),
          ],
          child: buildRouterTestApp(router),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(ActivityDetailScreen), findsOneWidget);
      expect(find.text(id), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      expect(find.byType(ActivityScreen), findsOneWidget);
      expect(router.routeInformationProvider.value.uri.path, '/activity');
    });
  }

  testWidgets('missing record displays a recoverable state', (tester) async {
    final router = AppRouter.create(initialLocation: '/activity/missing');
    addTearDown(router.dispose);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authenticatedStateOverride,
          activityDetailProvider('missing').overrideWith((_) async => null),
        ],
        child: buildRouterTestApp(router),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Page not found'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('logged out link does not load private records', (tester) async {
    final router = AppRouter.create(initialLocation: '/activity/private');
    addTearDown(router.dispose);
    var fetched = false;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authenticationProvider.overrideWithBuild(
            (_, _) => const AuthenticationUnauthenticated(),
          ),
          activityDetailProvider('private').overrideWith((_) async {
            fetched = true;
            return null;
          }),
        ],
        child: buildRouterTestApp(router),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Log in'), findsOneWidget);
    expect(fetched, isFalse);
    expect(router.routeInformationProvider.value.uri.path, '/activity/private');
    await tester.tap(find.text('Log in'));
    await tester.pumpAndSettle();
    expect(find.byType(PrivyLoginScreen), findsOneWidget);
    expect(router.routeInformationProvider.value.uri.path, '/activity/private');
  });
}
