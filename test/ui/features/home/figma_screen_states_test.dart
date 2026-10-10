import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
import 'package:nobell/ui/features/session/providers/authentication_provider.dart';
import 'package:nobell/ui/features/session/views/privy_login_screen.dart';

import '../../../helpers/display_config.dart';
import '../../../helpers/fake_identity_auth_gateway.dart';
import '../../../helpers/test_app.dart';

void main() {
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
          scenario.loss ? semantic.loss : semantic.success,
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
    addTearDown(container.dispose);
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
    expect(find.text('Markets'), findsWidgets);
    expect(find.text('NVDA'), findsWidgets);
    await tester.tap(find.text('Gainers'));
    await tester.pump();
    expect(find.text('Gainers'), findsOneWidget);
  });

  testWidgets('account avatar opens settings', (tester) async {
    final router = AppRouter.create();
    addTearDown(router.dispose);
    final container = await _authenticatedContainer(account: _Account());
    addTearDown(container.dispose);
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
  });

  testWidgets('market row opens its product trade detail', (tester) async {
    final router = AppRouter.create();
    addTearDown(router.dispose);
    final container = await _authenticatedContainer();
    addTearDown(container.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: buildRouterTestApp(router),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('NVDA').last);
    await tester.pumpAndSettle();

    expect(find.text('NVDA'), findsWidgets);
  });

  testWidgets('home switches to Popular when initial favorites are empty', (
    tester,
  ) async {
    final container = await _authenticatedContainer(
      markets: _EmptyFavoritesMarkets(),
    );
    addTearDown(container.dispose);
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
  });

  testWidgets('home keeps the favorites empty state after user selects it', (
    tester,
  ) async {
    final container = await _authenticatedContainer(
      markets: _EmptyFavoritesMarkets(),
    );
    addTearDown(container.dispose);
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
  });
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
  @override
  Future<DomainPage<MarketProduct>> listProducts({
    String? query,
    String? cursor,
    String? group,
    MarketProductKind? productType,
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
              isFavorite: true,
            ),
          ],
  );

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

final class _Account implements AccountRepository {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
  @override
  Future<UserAccount> getAccount() async => const UserAccount(
    userId: 'user-1',
    displayName: 'Ada',
    settings: UserPreferences(
      language: 'en',
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
    account: const UserAccount(
      userId: 'home-user',
      displayName: 'Ada',
      settings: UserPreferences(
        language: 'en',
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
