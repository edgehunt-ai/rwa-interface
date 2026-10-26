import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nobell/app.dart';
import 'package:nobell/app/providers/api_providers.dart';
import 'package:nobell/app/providers/auth_providers.dart';
import 'package:nobell/app/config/privy_configuration.dart';
import 'package:nobell/app/routing/app_router.dart';
import 'package:nobell/domain/auth/authentication.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/domain_page.dart';
import 'package:nobell/domain/models/market_product.dart';
import 'package:nobell/domain/models/portfolio.dart';
import 'package:nobell/domain/models/product_session.dart';
import 'package:nobell/domain/models/registered_device.dart';
import 'package:nobell/domain/models/stock.dart';
import 'package:nobell/domain/models/user_account.dart';
import 'package:nobell/domain/models/wallet.dart';
import 'package:nobell/domain/repositories/account_repository.dart';
import 'package:nobell/domain/repositories/markets_repository.dart';
import 'package:nobell/domain/repositories/portfolio_repository.dart';
import 'package:nobell/domain/repositories/session_repository.dart';
import 'package:nobell/domain/repositories/wallets_repository.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';
import 'package:nobell/ui/features/home/views/home_screen.dart';
import 'package:nobell/ui/features/account/providers/account_providers.dart';
import 'package:nobell/ui/features/account/views/settings_screen.dart';
import 'package:nobell/ui/features/markets/providers/market_providers.dart';
import 'package:nobell/ui/features/markets/views/market_product_widgets.dart';
import 'package:nobell/ui/features/markets/views/market_screen.dart';
import 'package:nobell/ui/features/orders/views/trade_screen.dart';
import 'package:nobell/ui/features/session/providers/authentication_provider.dart';
import 'package:nobell/ui/features/session/views/privy_login_screen.dart';

import '../../../helpers/display_config.dart';
import '../../../helpers/fake_identity_auth_gateway.dart';
import '../../../helpers/test_app.dart';

void main() {
  for (final language in ['en', 'zh-CN']) {
    testWidgets('app startup applies account $language on the home screen', (
      tester,
    ) async {
      await configureDisplay(tester, size: const Size(393, 852));
      SharedPreferences.setMockInitialValues({});
      tester.platformDispatcher.accessibilityFeaturesTestValue =
          const FakeAccessibilityFeatures(disableAnimations: true);
      addTearDown(
        tester.platformDispatcher.clearAccessibilityFeaturesTestValue,
      );
      final account = _Account(language: language);
      final router = AppRouter.create();
      addTearDown(router.dispose);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            identityAuthGatewayProvider.overrideWithValue(
              FakeIdentityAuthGateway(
                restoredPrincipal: const IdentityPrincipal('home-user'),
              ),
            ),
            privyConfigurationProvider.overrideWithValue(
              const PrivyConfiguration(appId: 'app-id', clientId: 'client-id'),
            ),
            sessionRepositoryProvider.overrideWithValue(
              _Session(language: language == 'en' ? 'zh-CN' : 'en'),
            ),
            walletsRepositoryProvider.overrideWithValue(_Wallets()),
            accountRepositoryProvider.overrideWithValue(account),
            portfolioRepositoryProvider.overrideWithValue(_Portfolio()),
            marketsRepositoryProvider.overrideWithValue(_Markets()),
          ],
          child: AppRoot(router: router),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(SettingsScreen), findsNothing);
      final homeContext = tester.element(find.byType(HomeScreen));
      expect(
        Localizations.localeOf(homeContext).languageCode,
        language == 'en' ? 'en' : 'zh',
      );
      expect(
        find.text(AppLocalizations.of(homeContext).deposit),
        findsOneWidget,
      );

      account.language = language == 'en' ? 'zh-CN' : 'en';
      ProviderScope.containerOf(homeContext).invalidate(accountProvider);
      await tester.pumpAndSettle();
      expect(
        Localizations.localeOf(homeContext).languageCode,
        language == 'en' ? 'zh' : 'en',
      );
      expect(find.byType(SettingsScreen), findsNothing);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
    });
  }

  for (final mode in [ThemeMode.light, ThemeMode.dark]) {
    testWidgets('quick action icons match their labels in ${mode.name} mode', (
      tester,
    ) async {
      await configureDisplay(tester, size: const Size(393, 852));
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authenticatedStateOverride,
            portfolioRepositoryProvider.overrideWithValue(_Portfolio()),
            marketsRepositoryProvider.overrideWithValue(_Markets()),
          ],
          child: buildTestApp(const HomeScreen(), themeMode: mode),
        ),
      );
      await tester.pumpAndSettle();

      for (final label in ['Deposit', 'Withdraw']) {
        final button = label == 'Deposit'
            ? find.widgetWithText(FilledButton, label)
            : find.widgetWithText(OutlinedButton, label);
        final svg = tester.widget<SvgPicture>(
          find.descendant(of: button, matching: find.byType(SvgPicture)),
        );
        final textColor = DefaultTextStyle.of(tester.element(find.text(label)))
            .style
            .color;
        expect(
          (svg.bytesLoader as SvgAssetLoader).theme!.currentColor,
          textColor,
        );
      }
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets(
    'failed restore offers retry and recovers without opening login',
    (tester) async {
      await configureDisplay(tester, size: const Size(393, 852));
      final container = ProviderContainer(
        overrides: [
          authenticationProvider.overrideWithBuild(
            (_, _) => const AuthenticationFailed(
              IdentityFailure(
                AuthenticationFailureCode.backendSession,
                retryable: true,
                requestId: 'restore-request',
              ),
            ),
          ),
          identityAuthGatewayProvider.overrideWithValue(
            FakeIdentityAuthGateway(
              restoredPrincipal: const IdentityPrincipal('home-user'),
            ),
          ),
          privyConfigurationProvider.overrideWithValue(
            const PrivyConfiguration(appId: 'app-id', clientId: 'client-id'),
          ),
          sessionRepositoryProvider.overrideWithValue(_Session()),
          walletsRepositoryProvider.overrideWithValue(_Wallets()),
          portfolioRepositoryProvider.overrideWithValue(_Portfolio()),
          marketsRepositoryProvider.overrideWithValue(_Markets()),
        ],
      );
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: buildTestApp(const HomeScreen()),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Ready when you are'), findsNothing);
      expect(find.text('Log in'), findsNothing);
      expect(find.textContaining('restore-request'), findsOneWidget);
      await tester.tap(find.text('Retry'));
      await tester.pumpAndSettle();

      expect(
        container.read(authenticationProvider),
        isA<AuthenticationAuthenticated>(),
      );
      expect(find.text(r'$12,580.42'), findsOneWidget);
      expect(find.byType(PrivyLoginScreen), findsNothing);
      expect(tester.takeException(), isNull);
      await _disposeContainerAfterWidgets(tester, container);
    },
  );

  testWidgets('terminal restoration failure keeps login available', (
    tester,
  ) async {
    await configureDisplay(tester, size: const Size(393, 852));
    final container = ProviderContainer(
      overrides: [
        authenticationProvider.overrideWithBuild(
          (_, _) => const AuthenticationFailed(
            IdentityFailure(
              AuthenticationFailureCode.provider,
              retryable: false,
            ),
          ),
        ),
        marketsRepositoryProvider.overrideWithValue(_Markets()),
      ],
    );
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: buildTestApp(const HomeScreen()),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Ready when you are'), findsOneWidget);
    expect(find.text('Log in'), findsWidgets);
    expect(find.text('Retry'), findsNothing);
    expect(tester.takeException(), isNull);
    await _disposeContainerAfterWidgets(tester, container);
  });

  for (final scenario in [
    (
      name: 'whole amounts',
      total: '10',
      pnl: '1',
      percent: '1.2',
      valueText: r'$10.00',
      performanceText: r'+$1.00 (+1.20%) Today',
      loss: false,
    ),
    (
      name: 'sub-dollar rounding',
      total: '0.12345',
      pnl: '0.125',
      percent: '1.235',
      valueText: r'$0.12',
      performanceText: r'+$0.13 (+1.24%) Today',
      loss: false,
    ),
    (
      name: 'losses',
      total: '12580.4',
      pnl: '-248.325',
      percent: '-2.015',
      valueText: r'$12,580.40',
      performanceText: r'$-248.33 (-2.02%) Today',
      loss: true,
    ),
    (
      name: 'percentage only',
      total: '10',
      pnl: null,
      percent: '-1.2',
      valueText: r'$10.00',
      performanceText: '(-1.20%) Today',
      loss: true,
    ),
    (
      name: 'amount only',
      total: '10',
      pnl: '1.2',
      percent: null,
      valueText: r'$10.00',
      performanceText: r'+$1.20 Today',
      loss: false,
    ),
    (
      name: 'zero performance',
      total: '10',
      pnl: '0',
      percent: null,
      valueText: r'$10.00',
      performanceText: r'$0.00 Today',
      loss: false,
    ),
    (
      name: 'empty portfolio',
      total: '0',
      pnl: '0',
      percent: '0',
      valueText: r'$0.00',
      performanceText: null,
      loss: false,
    ),
    (
      name: 'missing performance',
      total: '10',
      pnl: null,
      percent: null,
      valueText: r'$10.00',
      performanceText: null,
      loss: false,
    ),
  ]) {
    testWidgets('Home matches asset summary for ${scenario.name}', (
      tester,
    ) async {
      await configureDisplay(tester, size: const Size(320, 852));
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authenticatedStateOverride,
            portfolioRepositoryProvider.overrideWithValue(
              _Portfolio(
                summary: Portfolio(
                  totalValueUsd: DecimalValue(
                    scenario.total,
                    asset: 'USD',
                    unit: 'fiat',
                  ),
                  availableToTradeUsd: DecimalValue('0'),
                  todayPnl: scenario.pnl == null
                      ? null
                      : DecimalValue(scenario.pnl!, asset: 'USD', unit: 'fiat'),
                  todayPnlPercent: scenario.percent == null
                      ? null
                      : DecimalValue(scenario.percent!, unit: 'percent'),
                ),
              ),
            ),
            marketsRepositoryProvider.overrideWithValue(_Markets()),
          ],
          child: buildTestApp(const HomeScreen()),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(scenario.valueText), findsOneWidget);
      if (scenario.performanceText case final text?) {
        final performance = find.text(text);
        expect(performance, findsOneWidget);
        final semantic = AppTheme.light.extension<AppSemanticColors>()!;
        expect(
          tester.widget<Text>(performance).style?.color,
          scenario.loss ? semantic.danger : semantic.success,
        );
      } else {
        expect(find.textContaining('Today'), findsNothing);
        expect(
          find.text('—'),
          scenario.total == '0' ? findsOneWidget : findsNothing,
        );
        expect(
          find.text('No performance yet'),
          scenario.total == '0' ? findsNothing : findsOneWidget,
        );
      }
      expect(tester.takeException(), isNull);
    });
  }

  for (final width in [320.0, 393.0]) {
    testWidgets('portfolio preview fits ${width.toInt()}px', (tester) async {
      await configureDisplay(tester, size: Size(width, 182));
      await tester.pumpWidget(homePortfolioPerformancePreview());
      await tester.pumpAndSettle();

      expect(find.text(r'$12,580.40'), findsOneWidget);
      expect(find.text(r'+$248.30 (+2.01%) Today'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  for (final width in [320.0, 393.0]) {
    testWidgets('logged-out banner fits ${width.toInt()}px and opens login', (
      tester,
    ) async {
      SharedPreferences.setMockInitialValues({});
      await configureDisplay(tester, size: Size(width, 852));
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authenticationProvider.overrideWithBuild(
              (_, _) => const AuthenticationUnauthenticated(),
            ),
            identityAuthGatewayProvider.overrideWithValue(
              FakeIdentityAuthGateway(),
            ),
            privyConfigurationProvider.overrideWithValue(
              const PrivyConfiguration(appId: 'app-id', clientId: 'client-id'),
            ),
            marketsRepositoryProvider.overrideWithValue(_Markets()),
          ],
          child: buildTestApp(const HomeScreen()),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('home-wordmark')), findsOneWidget);
      expect(find.text('Logo'), findsNothing);
      final illustration = find.image(
        const AssetImage('assets/figma/home_markets/login_prompt.webp'),
      );
      expect(illustration, findsOneWidget);
      expect(tester.getSize(illustration), const Size(126, 126));
      final banner = find.ancestor(
        of: illustration,
        matching: find.byType(Ink),
      );
      final bannerRect = tester.getRect(banner);
      final imageRect = tester.getRect(illustration);
      expect(imageRect.top - bannerRect.top, 26);
      expect(imageRect.right - bannerRect.right, 11);
      final material = find
          .ancestor(of: illustration, matching: find.byType(Material))
          .first;
      expect(tester.widget<Material>(material).clipBehavior, Clip.antiAlias);
      expect(tester.takeException(), isNull);

      await tester.tap(find.text('Ready when you are'));
      await tester.pumpAndSettle();

      expect(find.byType(PrivyLoginScreen), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('Home shows portfolio, quick actions, and market ranking', (
    tester,
  ) async {
    final container = await _authenticatedContainer();
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: AppTheme.light,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const HomeScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Portfolio'), findsOneWidget);
    expect(find.text(r'$12,580.42'), findsOneWidget);
    expect(find.text(r'+$248.32 (+2.01%) Today'), findsOneWidget);
    expect(find.text('Deposit'), findsOneWidget);
    expect(find.text('Withdraw'), findsOneWidget);
    // The only Markets label belongs to bottom navigation, not this preview.
    expect(find.text('Markets'), findsOneWidget);
    final depositButton = find.widgetWithText(FilledButton, 'Deposit');
    final productFilter = find.byType(MarketProductFilter);
    expect(
      tester.getRect(productFilter).top - tester.getRect(depositButton).bottom,
      28,
    );
    expect(find.text('NVDA'), findsWidgets);
    await tester.tap(find.text('Gainers'));
    await tester.pump();
    expect(find.text('Gainers'), findsOneWidget);
    await _disposeContainerAfterWidgets(tester, container);
  });

  for (final mode in [ThemeMode.light, ThemeMode.dark]) {
    testWidgets('guest opens settings from home in ${mode.name} mode', (
      tester,
    ) async {
      SharedPreferences.setMockInitialValues({});
      await configureDisplay(tester, size: const Size(393, 852));
      final router = AppRouter.create();
      addTearDown(router.dispose);
      var personalRequests = 0;
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authenticationProvider.overrideWithBuild(
              (_, _) => const AuthenticationUnauthenticated(),
            ),
            identityAuthGatewayProvider.overrideWithValue(
              FakeIdentityAuthGateway(),
            ),
            privyConfigurationProvider.overrideWithValue(
              const PrivyConfiguration(appId: 'app-id', clientId: 'client-id'),
            ),
            marketsRepositoryProvider.overrideWithValue(_Markets()),
            accountProvider.overrideWith((_) async {
              personalRequests++;
              throw StateError('Guest must not load an account');
            }),
            passkeyProvider.overrideWithBuild((_, _) async {
              personalRequests++;
              throw StateError('Guest must not load a Passkey');
            }),
          ],
          child: MaterialApp.router(
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: mode,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: router,
          ),
        ),
      );
      await tester.pumpAndSettle();
      final settings = find.byTooltip('Open settings');
      final search = find.byTooltip('Search markets');
      expect(tester.getSize(settings), const Size(44, 44));
      expect(tester.getSize(search), const Size(44, 44));
      expect(
        tester.getCenter(find.byKey(const Key('home-wordmark'))).dx,
        393 / 2,
      );
      final icon = tester.widget<SvgPicture>(
        find.byWidgetPredicate(
          (widget) =>
              widget is SvgPicture &&
              widget.bytesLoader is SvgAssetLoader &&
              (widget.bytesLoader as SvgAssetLoader).assetName ==
                  'assets/figma/home_markets/settings.svg',
        ),
      );
      expect(icon.width, 20);
      expect(icon.height, 20);
      expect(
        (icon.bytesLoader as SvgAssetLoader).theme!.currentColor,
        (mode == ThemeMode.dark ? AppTheme.dark : AppTheme.light)
            .extension<AppRwaColors>()!
            .iconPrimary,
      );
      await tester.tap(settings);
      await tester.pumpAndSettle();
      expect(find.byType(SettingsScreen), findsOneWidget);
      expect(find.byType(PrivyLoginScreen), findsNothing);
      expect(find.text('Your account'), findsOneWidget);
      for (final label in [
        'Language',
        'Display Mode',
        'Terms Of Use',
        'Privacy Policy',
        'Check for Updates',
        'App Version',
        'Cache Size',
      ]) {
        expect(find.text(label), findsOneWidget);
      }
      for (final label in [
        'Passkey',
        'Export Private Key',
        'Log Out',
        'Delete Account',
      ]) {
        expect(find.text(label), findsNothing);
      }
      expect(personalRequests, 0);
      await tester.tap(find.text('Terms Of Use'));
      await tester.pumpAndSettle();
      expect(find.text('Term of Use'), findsOneWidget);
      router.pop();
      await tester.pumpAndSettle();
      await tester.tap(find.text('Log in'));
      await tester.pumpAndSettle();
      expect(find.byType(PrivyLoginScreen), findsOneWidget);
      expect(personalRequests, 0);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('settings icon opens account settings', (tester) async {
    final router = AppRouter.create();
    addTearDown(router.dispose);
    final container = await _authenticatedContainer(account: _Account());
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: buildRouterTestApp(router),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Open settings'));
    await tester.pumpAndSettle();

    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Ada'), findsOneWidget);
    await _disposeContainerAfterWidgets(tester, container);
  });

  testWidgets('market row opens its product trade detail', (tester) async {
    final router = AppRouter.create();
    addTearDown(router.dispose);
    final container = await _authenticatedContainer();
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: buildRouterTestApp(router),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('NVDA').last);
    await tester.pumpAndSettle();

    final screen = tester.widget<TradeScreen>(find.byType(TradeScreen));
    expect(screen.symbol, 'NVDA');
    expect(screen.initialKind, MarketProductKind.bstock);
    expect(
      tester.widget<Text>(find.byKey(const Key('trade-product-symbol'))).data,
      'NVDA',
    );
    await _disposeContainerAfterWidgets(tester, container);
  });

  testWidgets('home limits markets to five without a redundant view more', (
    tester,
  ) async {
    final container = await _authenticatedContainer(
      markets: const _ManyMarkets(count: 5),
    );
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: buildTestApp(const HomeScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(MarketProductRow), findsNWidgets(5));
    expect(find.byKey(const Key('home-markets-view-more')), findsNothing);
    await _disposeContainerAfterWidgets(tester, container);
  });

  testWidgets('home view more opens markets on the selected ranking tab', (
    tester,
  ) async {
    await configureDisplay(tester, size: const Size(393, 852));
    final router = AppRouter.create();
    addTearDown(router.dispose);
    final container = await _authenticatedContainer(
      markets: const _ManyMarkets(count: 6),
    );
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: buildRouterTestApp(router),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Gainers'));
    await tester.pumpAndSettle();
    expect(find.byType(MarketProductRow), findsNWidgets(5));
    expect(find.text('STOCK6'), findsNothing);

    final viewMore = find.byKey(const Key('home-markets-view-more'));
    expect(viewMore, findsOneWidget);
    await tester.ensureVisible(viewMore);
    await tester.pumpAndSettle();
    await tester.tap(viewMore);
    await tester.pumpAndSettle();

    expect(find.byType(MarketScreen), findsOneWidget);
    expect(
      tester.widget<MarketRankingTabs>(find.byType(MarketRankingTabs)).active,
      'Gainers',
    );
    expect(container.read(marketRankingTabProvider).value, 'Gainers');
    await _disposeContainerAfterWidgets(tester, container);
  });

  testWidgets('home switches to Popular when initial favorites are empty', (
    tester,
  ) async {
    final container = await _authenticatedContainer(
      markets: _EmptyFavoritesMarkets(),
    );
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: AppTheme.light,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const HomeScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Popular'), findsOneWidget);
    expect(find.text('NVDA'), findsWidgets);
    expect(find.text('No favorites yet'), findsNothing);
    await _disposeContainerAfterWidgets(tester, container);
  });

  testWidgets('home keeps the favorites empty state after user selects it', (
    tester,
  ) async {
    final container = await _authenticatedContainer(
      markets: _EmptyFavoritesMarkets(),
    );
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: AppTheme.light,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const HomeScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Favorites'));
    await tester.pumpAndSettle();

    expect(find.text('No favorites yet'), findsOneWidget);
    expect(
      find.text('Tap the star on any market to save it here.'),
      findsOneWidget,
    );
    await _disposeContainerAfterWidgets(tester, container);
  });

  testWidgets('home empty favorites explores the Popular markets tab', (
    tester,
  ) async {
    final router = AppRouter.create();
    addTearDown(router.dispose);
    final container = await _authenticatedContainer(
      markets: _EmptyFavoritesMarkets(),
    );
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: buildRouterTestApp(router),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Favorites'));
    await tester.pumpAndSettle();
    expect(find.text('No favorites yet'), findsOneWidget);

    final explore = find.text('Explore markets');
    await tester.ensureVisible(explore);
    await tester.drag(find.byType(ListView).first, const Offset(0, -80));
    await tester.pumpAndSettle();
    await tester.tap(explore);
    await tester.pumpAndSettle();

    expect(find.byType(MarketScreen), findsOneWidget);
    expect(
      tester.widget<MarketRankingTabs>(find.byType(MarketRankingTabs)).active,
      'Popular',
    );
    expect(container.read(marketRankingTabProvider).value, 'Popular');
    await _disposeContainerAfterWidgets(tester, container);
  });
}

Future<void> _disposeContainerAfterWidgets(
  WidgetTester tester,
  ProviderContainer container,
) async {
  await tester.pumpWidget(const SizedBox.shrink());
  container.dispose();
}

Future<ProviderContainer> _authenticatedContainer({
  AccountRepository? account,
  MarketsRepository? markets,
}) async {
  final container = ProviderContainer(
    overrides: [
      identityAuthGatewayProvider.overrideWithValue(
        FakeIdentityAuthGateway(
          restoredPrincipal: const IdentityPrincipal('home-user'),
        ),
      ),
      privyConfigurationProvider.overrideWithValue(
        const PrivyConfiguration(appId: 'app-id', clientId: 'client-id'),
      ),
      sessionRepositoryProvider.overrideWithValue(_Session()),
      walletsRepositoryProvider.overrideWithValue(_Wallets()),
      portfolioRepositoryProvider.overrideWithValue(_Portfolio()),
      marketsRepositoryProvider.overrideWithValue(markets ?? _Markets()),
      if (account != null) accountRepositoryProvider.overrideWithValue(account),
    ],
  );
  container.listen(authenticationProvider, (_, _) {});
  await container.read(authenticationProvider.notifier).bootstrap();
  expect(
    container.read(authenticationProvider),
    isA<AuthenticationAuthenticated>(),
  );
  return container;
}

final class _Portfolio implements PortfolioRepository {
  _Portfolio({this.summary});
  final Portfolio? summary;

  @override
  Future<Portfolio> getSummary() async =>
      summary ??
      Portfolio(
        totalValueUsd: DecimalValue('12580.42', asset: 'USD', unit: 'fiat'),
        availableToTradeUsd: DecimalValue('0', asset: 'USD', unit: 'fiat'),
        todayPnl: DecimalValue('248.32', asset: 'USD', unit: 'fiat'),
        todayPnlPercent: DecimalValue('2.01', unit: 'percent'),
      );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _Markets implements MarketsRepository {
  static final _product = MarketProduct(
    symbol: 'NVDA',
    name: 'NVIDIA',
    kind: MarketProductKind.bstock,
    price: DecimalValue('120', asset: 'USD', unit: 'fiat'),
    settlementAsset: 'USDC',
    network: 'Arbitrum',
    tradable: true,
    isFavorite: true,
  );

  @override
  Future<DomainPage<Stock>> listStocks() async => const DomainPage(
    items: [
      Stock(
        symbol: 'NVDA',
        name: 'NVIDIA',
        referencePrice: '120',
        products: [
          MarketProductRef(symbol: 'NVDA', kind: MarketProductKind.bstock),
        ],
      ),
    ],
  );

  @override
  Future<MarketProduct> getProduct(MarketProductRef ref) async {
    if (ref.symbol != _product.symbol || ref.kind != _product.kind) {
      throw StateError('Unexpected market product: ${ref.symbol}/${ref.kind}');
    }
    return _product;
  }

  @override
  Future<DomainPage<MarketProduct>> listProducts({
    String? query,
    String? cursor,
    String? group,
    MarketProductKind? productType,
  }) async => DomainPage(items: group == 'favorites' ? const [] : [_product]);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _EmptyFavoritesMarkets implements MarketsRepository {
  @override
  Future<DomainPage<MarketProduct>> listProducts({
    String? query,
    String? cursor,
    String? group,
    MarketProductKind? productType,
    dynamic kind,
    int? limit,
  }) async => DomainPage(
    items: group == 'favorites'
        ? const []
        : [
            MarketProduct(
              symbol: 'NVDA',
              name: 'NVIDIA',
              kind: MarketProductKind.bstock,
              price: DecimalValue('120', asset: 'USD', unit: 'fiat'),
              settlementAsset: 'USDC',
              network: 'Arbitrum',
              tradable: true,
              isFavorite: false,
            ),
          ],
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _ManyMarkets implements MarketsRepository {
  const _ManyMarkets({required this.count});

  final int count;

  @override
  Future<DomainPage<MarketProduct>> listProducts({
    String? query,
    String? cursor,
    String? group,
    MarketProductKind? productType,
  }) async => DomainPage(
    items: [
      for (var index = 1; index <= count; index++)
        MarketProduct(
          symbol: 'STOCK$index',
          name: 'Stock $index',
          kind: MarketProductKind.bstock,
          price: DecimalValue('$index', asset: 'USD', unit: 'fiat'),
          settlementAsset: 'USDC',
          network: 'Arbitrum',
          tradable: true,
          isFavorite: true,
        ),
    ],
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _Account implements AccountRepository {
  _Account({this.language = 'en'});

  String language;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
  @override
  Future<UserAccount> getAccount() async => UserAccount(
    userId: 'user-1',
    displayName: 'Ada',
    settings: UserPreferences(
      language: language,
      pushEnabled: true,
      notifyOrderFilled: true,
      notifyOrderFailed: true,
      notifyLiquidationWarning: true,
    ),
  );

  @override
  Future<void> deleteDevice(String deviceId) async {}

  @override
  Future<DomainPage<RegisteredDevice>> listDevices({String? cursor}) async =>
      const DomainPage(items: []);

  @override
  Future<RegisteredDevice> registerDevice(DeviceRegistration registration) =>
      throw UnimplementedError();

  @override
  Future<UserPreferences> updateSettings(UserPreferencesPatch patch) async =>
      (await getAccount()).settings;
}

final class _Session implements SessionRepository {
  _Session({this.language = 'en'});

  final String language;

  @override
  Future<ProductSession> createOrRestore({
    String? language,
    required int generation,
  }) async => ProductSession(
    sessionId: 'home-session',
    createdAt: DateTime.utc(2026),
    expiresAt: DateTime.utc(2027),
    generation: generation,
    accountCreated: true,
    account: UserAccount(
      userId: 'home-user',
      displayName: 'Ada',
      settings: UserPreferences(
        language: this.language,
        pushEnabled: false,
        notifyOrderFilled: true,
        notifyOrderFailed: true,
        notifyLiquidationWarning: true,
      ),
    ),
  );

  @override
  Future<void> endSession() async {}
}

final class _Wallets implements WalletsRepository {
  @override
  Future<Wallet> syncWallet({required String idempotencyKey}) async => Wallet(
    walletId: 'home-wallet',
    address: '0xhome',
    chain: 'arbitrum',
    status: WalletState.active,
    createdAt: DateTime.utc(2026),
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
