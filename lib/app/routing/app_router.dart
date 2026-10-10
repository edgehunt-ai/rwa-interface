import 'package:go_router/go_router.dart';
import 'package:nobell/app/routing/routes.dart';
import 'package:nobell/ui/features/home/views/details_screen.dart';
import 'package:nobell/ui/features/home/views/home_screen.dart';
import 'package:nobell/ui/features/funding/views/deposit_screen.dart';
import 'package:nobell/ui/features/funding/views/withdrawal_screen.dart';
import 'package:nobell/ui/features/funding/views/transfer_screen.dart';
import 'package:nobell/ui/features/markets/views/market_screen.dart';
import 'package:nobell/ui/features/markets/views/market_search_screen.dart';
import 'package:nobell/ui/features/not_found/views/not_found_screen.dart';
import 'package:nobell/ui/features/portfolio/views/assets_screen.dart';
import 'package:nobell/ui/features/orders/views/trade_screen.dart';
import 'package:nobell/ui/features/account/views/settings_screen.dart';
import 'package:nobell/ui/features/activity/views/activity_screen.dart';
import 'package:nobell/domain/models/activity_record.dart';
import 'package:nobell/ui/features/session/providers/authentication_provider.dart';
import 'package:nobell/ui/features/session/views/privy_login_screen.dart';
import 'package:nobell/domain/models/market_product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

abstract final class AppRouter {
  static GoRouter create({String initialLocation = AppRoutes.homePath}) {
    return GoRouter(
      initialLocation: initialLocation,
      observers: [SentryNavigatorObserver()],
      routes: [
        GoRoute(
          name: AppRoutes.homeName,
          path: AppRoutes.homePath,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          name: AppRoutes.transferName,
          path: AppRoutes.transferPath,
          builder: (context, state) => const TransferScreen(),
        ),
        GoRoute(
          name: AppRoutes.loginName,
          path: AppRoutes.loginPath,
          builder: (context, state) => Consumer(
            builder: (context, ref, _) => PrivyLoginScreen(
              authentication: ref.watch(authenticationProvider),
              returnToHomeOnSuccess: true,
            ),
          ),
        ),
        GoRoute(
          name: AppRoutes.marketSearchName,
          path: AppRoutes.marketSearchPath,
          builder: (context, state) => const MarketDiscoverySearchScreen(),
        ),
        GoRoute(
          name: AppRoutes.allStocksName,
          path: AppRoutes.allStocksPath,
          builder: (context, state) => const MarketSearchScreen(),
        ),
        GoRoute(
          name: AppRoutes.marketsName,
          path: AppRoutes.marketsPath,
          builder: (context, state) => const MarketScreen(),
        ),
        GoRoute(
          name: AppRoutes.assetsName,
          path: AppRoutes.assetsPath,
          builder: (context, state) => const AssetsScreen(),
        ),
        GoRoute(
          name: AppRoutes.depositName,
          path: AppRoutes.depositPath,
          builder: (context, state) => DepositScreen(
            chain: state.uri.queryParameters['chain'],
            token: state.uri.queryParameters['token'],
          ),
        ),
        GoRoute(
          name: AppRoutes.depositSelectName,
          path: AppRoutes.depositSelectPath,
          redirect: (_, _) => AppRoutes.depositPath,
        ),
        GoRoute(
          name: AppRoutes.withdrawalName,
          path: AppRoutes.withdrawalPath,
          builder: (context, state) => WithdrawalScreen(
            token: state.uri.queryParameters['token'] ?? 'USDC',
            chain: state.uri.queryParameters['chain'] ?? 'Arbitrum',
          ),
        ),
        GoRoute(
          name: AppRoutes.withdrawalSelectName,
          path: AppRoutes.withdrawalSelectPath,
          builder: (context, state) =>
              const WithdrawalScreen(showSelector: true),
        ),
        GoRoute(
          name: AppRoutes.tradeName,
          path: AppRoutes.tradePath,
          builder: (context, state) {
            final kind = switch (state.uri.queryParameters['kind']) {
              'perp' => MarketProductKind.perp,
              _ => MarketProductKind.bstock,
            };
            return TradeScreen(
              symbol: state.uri.queryParameters['symbol'],
              initialKind: kind,
            );
          },
        ),
        GoRoute(
          name: AppRoutes.settingsName,
          path: AppRoutes.settingsPath,
          builder: (context, state) => const SettingsScreen(),
        ),
        GoRoute(
          name: AppRoutes.activityName,
          path: AppRoutes.activityPath,
          builder: (context, state) => ActivityScreen(
            initialCategory: state.uri.queryParameters['tab'] == 'cash'
                ? ActivityCategory.cash
                : null,
          ),
        ),
        GoRoute(
          name: AppRoutes.detailsName,
          path: AppRoutes.detailsPath,
          builder: (context, state) => const DetailsScreen(),
        ),
      ],
      errorBuilder: (context, state) =>
          NotFoundScreen(location: state.uri.toString()),
    );
  }
}
