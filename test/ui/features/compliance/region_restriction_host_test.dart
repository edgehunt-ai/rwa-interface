import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nobell/app.dart';
import 'package:nobell/app/providers/auth_providers.dart';
import 'package:nobell/app/providers/api_providers.dart';
import 'package:nobell/domain/models/access_region.dart';
import 'package:nobell/domain/models/api_failure.dart';
import 'package:nobell/domain/repositories/access_region_repository.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';
import 'package:nobell/ui/features/compliance/views/region_restriction_dialog.dart';
import 'package:nobell/ui/features/compliance/views/region_restriction_host.dart';

import '../../../helpers/test_app.dart';
import '../../../helpers/fake_identity_auth_gateway.dart';

AccessRegion decision({
  bool restricted = true,
  String? country = 'US',
  List<String> countries = const ['CA', 'US'],
  List<RestrictedRegion>? regions,
}) => AccessRegion(
  countryCode: country,
  source: country == null ? 'unknown' : 'edge',
  restricted: restricted,
  restrictedCountries: countries,
  restrictedRegions:
      regions ??
      countries.map(
        (code) => RestrictedRegion(
          countryCode: code,
          name: switch (code) {
            'CA' => 'Canada',
            'US' => 'United States',
            'JP' => 'Japan',
            'SG' => 'Singapore',
            _ => code,
          },
        ),
      ),
);

final class RegionRepository implements AccessRegionRepository {
  Future<AccessRegion> Function() next = () async => decision();
  int requests = 0;
  @override
  Future<AccessRegion> getAccessRegion() {
    requests++;
    return next();
  }
}

void main() {
  late RegionRepository repository;
  late ProviderContainer container;

  setUp(() {
    repository = RegionRepository();
    container = ProviderContainer(
      overrides: [accessRegionRepositoryProvider.overrideWithValue(repository)],
    );
  });
  tearDown(() => container.dispose());

  Future<void> mount(
    WidgetTester tester, {
    ThemeMode mode = ThemeMode.light,
    Locale locale = const Locale('en'),
    Widget? child,
  }) async {
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: buildTestApp(
          RegionRestrictionHost(child: child ?? const Text('App content')),
          themeMode: mode,
          locale: locale,
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  for (final mode in [ThemeMode.light, ThemeMode.dark]) {
    testWidgets('server restriction renders the Figma dialog in $mode', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(393, 852));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await mount(tester, mode: mode);
      expect(find.text('Access Restricted'), findsOneWidget);
      expect(
        find.text(
          'This service is not available in certain regions.\nCanada and United States.',
        ),
        findsOneWidget,
      );
      final dialog = tester.widget<Dialog>(find.byType(Dialog));
      final colors = (mode == ThemeMode.dark ? AppTheme.dark : AppTheme.light)
          .extension<AppRwaColors>()!;
      expect(dialog.backgroundColor, colors.surfaceBase);
      expect(
        tester
            .getSize(
              find.descendant(
                of: find.byType(Dialog),
                matching: find.byType(Material),
              ),
            )
            .width,
        350,
      );
      final image = tester.widget<Image>(find.byType(Image));
      expect(
        image.image,
        AssetImage(
          mode == ThemeMode.dark
              ? 'assets/figma/common/region_restriction_dark.png'
              : 'assets/figma/common/region_restriction.png',
        ),
      );
      expect(tester.getSize(find.byType(Image)), const Size(120, 120));
      expect(
        tester
            .widget<ModalBarrier>(
              find.byKey(const ValueKey('region-restriction-barrier')),
            )
            .color,
        colors.overlayScrim.withValues(alpha: 0.7),
      );
      final title = tester.widget<Text>(find.text('Access Restricted'));
      expect(title.style!.fontSize, 17);
      expect(title.style!.height, 22 / 17);
      final caption = tester.widget<Text>(find.textContaining('This service'));
      expect(caption.style!.fontSize, 12);
      expect(caption.style!.height, 16 / 12);
      expect(
        find.descendant(
          of: find.byType(Dialog),
          matching: find.byType(ButtonStyleButton),
        ),
        findsNothing,
      );
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('waits for the API and ignores country blacklist and UI locale', (
    tester,
  ) async {
    final pending = Completer<AccessRegion>();
    repository.next = () => pending.future;
    await mount(tester, locale: const Locale('zh'));
    expect(find.byType(RegionRestrictionDialog), findsNothing);
    pending.complete(decision(restricted: false, countries: ['US']));
    await tester.pumpAndSettle();
    expect(find.byType(RegionRestrictionDialog), findsNothing);
  });

  testWidgets('renders only current server countries including new codes', (
    tester,
  ) async {
    repository.next = () async => decision(country: 'SG', countries: ['SG']);
    await mount(tester);
    expect(
      find.text(
        'This service is not available in certain regions.\nSingapore.',
      ),
      findsOneWidget,
    );
    expect(find.textContaining('United States'), findsNothing);
  });

  testWidgets(
    'server display names and order override country code order in either locale',
    (tester) async {
      repository.next = () async => decision(
        countries: ['CN', 'US'],
        regions: const [
          RestrictedRegion(countryCode: 'US', name: 'United States of America'),
          RestrictedRegion(countryCode: 'CN', name: 'Mainland China (server)'),
        ],
      );
      await mount(tester);
      expect(
        find.text(
          'This service is not available in certain regions.\nUnited States of America and Mainland China (server).',
        ),
        findsOneWidget,
      );
      await mount(tester, locale: const Locale('zh'));
      expect(
        find.textContaining(
          'United States of America、Mainland China (server)。',
        ),
        findsOneWidget,
      );
    },
  );

  testWidgets('unknown location does not fabricate a restriction', (
    tester,
  ) async {
    repository.next = () async =>
        decision(restricted: false, country: null, countries: []);
    await mount(tester);
    expect(find.byType(RegionRestrictionDialog), findsNothing);
  });

  testWidgets('foreground checks refresh and remove an obsolete restriction', (
    tester,
  ) async {
    await mount(tester);
    final firstRequests = repository.requests;
    repository.next = () async => decision(restricted: false);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pumpAndSettle();
    expect(repository.requests, firstRequests + 1);
    expect(find.byType(RegionRestrictionDialog), findsNothing);
  });

  testWidgets('failure shows its actual reason and retry checks again', (
    tester,
  ) async {
    repository.next = () async => throw const ServerFailure(
      statusCode: 503,
      code: 'geoip_unavailable',
      message: 'Country lookup is temporarily unavailable',
    );
    await mount(tester);
    expect(
      find.text('Country lookup is temporarily unavailable'),
      findsOneWidget,
    );
    expect(find.byType(RegionRestrictionDialog), findsNothing);
    repository.next = () async => decision(countries: ['JP']);
    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Japan.'), findsOneWidget);
    expect(
      find.text('Country lookup is temporarily unavailable'),
      findsNothing,
    );
  });

  testWidgets('failed refresh keeps a confirmed restriction visible', (
    tester,
  ) async {
    await mount(tester);
    repository.next = () async =>
        throw const TimeoutFailure(userAction: 'Country lookup timed out');
    container.invalidate(accessRegionProvider);
    await tester.pumpAndSettle();
    expect(find.byType(RegionRestrictionDialog), findsOneWidget);
    expect(find.text('Country lookup timed out'), findsOneWidget);
  });

  testWidgets('barrier and background navigation cannot dismiss restriction', (
    tester,
  ) async {
    var backgroundTaps = 0;
    await mount(
      tester,
      child: TextButton(
        onPressed: () => backgroundTaps++,
        child: const Text('Background'),
      ),
    );
    await tester.tapAt(const Offset(5, 5));
    await tester.pumpAndSettle();
    expect(backgroundTaps, 0);
    expect(find.byType(RegionRestrictionDialog), findsOneWidget);
  });

  testWidgets(
    'app root blocks system back and keeps the notice above navigation',
    (tester) async {
      SharedPreferences.setMockInitialValues({});
      final rootContainer = ProviderContainer(
        overrides: [
          accessRegionRepositoryProvider.overrideWithValue(repository),
          identityAuthGatewayProvider.overrideWithValue(
            FakeIdentityAuthGateway(),
          ),
        ],
      );
      addTearDown(rootContainer.dispose);
      final router = GoRouter(
        initialLocation: '/details',
        routes: [
          GoRoute(
            path: '/',
            builder: (_, _) => const Scaffold(body: Text('Home')),
          ),
          GoRoute(
            path: '/details',
            builder: (_, _) => const Scaffold(body: Text('Details')),
          ),
        ],
      );
      addTearDown(router.dispose);
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: rootContainer,
          child: AppRoot(router: router),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(RegionRestrictionDialog), findsOneWidget);
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(router.routeInformationProvider.value.uri.path, '/details');
      expect(find.byType(RegionRestrictionDialog), findsOneWidget);
      router.go('/');
      await tester.pumpAndSettle();
      expect(find.byType(RegionRestrictionDialog), findsOneWidget);
      repository.next = () async => decision(restricted: false);
      rootContainer.invalidate(accessRegionProvider);
      await tester.pumpAndSettle();
      expect(find.byType(RegionRestrictionDialog), findsNothing);
      expect(tester.takeException(), isNull);
    },
  );
}
