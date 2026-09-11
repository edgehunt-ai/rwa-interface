import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/app/providers/auth_providers.dart';
import 'package:rwa_interface/app/config/privy_configuration.dart';
import 'package:rwa_interface/app/routing/app_router.dart';
import 'package:rwa_interface/domain/auth/authentication.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/portfolio.dart';
import 'package:rwa_interface/domain/models/product_session.dart';
import 'package:rwa_interface/domain/models/registered_device.dart';
import 'package:rwa_interface/domain/models/user_account.dart';
import 'package:rwa_interface/domain/models/wallet.dart';
import 'package:rwa_interface/domain/repositories/account_repository.dart';
import 'package:rwa_interface/domain/repositories/markets_repository.dart';
import 'package:rwa_interface/domain/repositories/portfolio_repository.dart';
import 'package:rwa_interface/domain/repositories/session_repository.dart';
import 'package:rwa_interface/domain/repositories/wallets_repository.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/features/home/views/home_screen.dart';
import 'package:rwa_interface/ui/features/session/providers/authentication_provider.dart';

import '../../../helpers/fake_identity_auth_gateway.dart';
import '../../../helpers/test_app.dart';

void main() {
  testWidgets('Home shows portfolio, quick actions, and market ranking', (
    tester,
  ) async {
    final container = await _authenticatedContainer();
    addTearDown(container.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(theme: AppTheme.light, home: const HomeScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Portfolio'), findsOneWidget);
    expect(find.text(r'$12,580.42'), findsOneWidget);
    expect(find.text(r'+$248.32 today'), findsOneWidget);
    expect(find.text('Deposit'), findsOneWidget);
    expect(find.text('Withdraw'), findsOneWidget);
    expect(find.text('Markets'), findsOneWidget);
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
        child: MaterialApp(theme: AppTheme.light, home: const HomeScreen()),
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
        child: MaterialApp(theme: AppTheme.light, home: const HomeScreen()),
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
  @override
  Future<Portfolio> getSummary() async => Portfolio(
    totalValueUsd: DecimalValue('12580.42', asset: 'USD', unit: 'fiat'),
    availableToTradeUsd: DecimalValue('0', asset: 'USD', unit: 'fiat'),
    todayPnl: DecimalValue('248.32', asset: 'USD', unit: 'fiat'),
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _Markets implements MarketsRepository {
  @override
  Future<DomainPage<MarketProduct>> listProducts({
    String? query,
    String? cursor,
  }) async => DomainPage(
    items: [
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
    dynamic kind,
    dynamic group,
    int? limit,
  }) async => DomainPage(
    items: [
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
