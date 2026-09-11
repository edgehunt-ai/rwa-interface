import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/api/api_environment.dart';
import '../../data/api/privy_access_token_provider.dart';
import '../../data/api/rwa_api_data_source.dart';
import '../../data/repositories/markets_repository_impl.dart';
import '../../data/repositories/market_hours_repository_impl.dart';
import '../../data/repositories/hip3_opening_repository_impl.dart';
import '../../domain/repositories/hip3_opening_repository.dart';
import '../../data/repositories/hip3_order_execution_repository_impl.dart';
import '../../data/repositories/funding_repository_impl.dart';
import '../../data/repositories/orders_repository_impl.dart';
import '../../data/repositories/portfolio_repository_impl.dart';
import '../../data/repositories/positions_repository_impl.dart';
import '../../data/repositories/account_repository_impl.dart';
import '../../data/repositories/activity_repository_impl.dart';
import '../../data/repositories/session_repository_impl.dart';
import '../../data/repositories/app_update_repository_impl.dart';
import '../../app_review/app_review.dart';
import '../../data/repositories/wallets_repository_impl.dart';
import '../../data/repositories/realtime_repository_impl.dart';
import '../../data/repositories/trade_intent_repository_impl.dart';
import '../../data/services/generated_account_service.dart';
import '../../data/services/generated_activity_service.dart';
import '../../data/services/generated_markets_service.dart';
import '../../data/services/generated_funding_service.dart';
import '../../data/services/generated_orders_service.dart';
import '../../data/services/generated_charts_service.dart';
import '../../data/services/generated_portfolio_service.dart';
import '../../data/services/generated_positions_service.dart';
import '../../data/services/generated_session_service.dart';
import '../../data/services/generated_wallets_service.dart';
import '../../data/services/hip3_order_action_service.dart';
import '../../data/services/dio_realtime_service.dart';
import '../../data/services/generated_system_service.dart';
import '../../data/services/package_info_service.dart';
import '../../data/services/realtime_service.dart';
import '../../data/services/generated_trade_intent_service.dart';
import '../../domain/repositories/markets_repository.dart';
import '../../domain/repositories/market_hours_repository.dart';
import '../../domain/repositories/hip3_order_execution_repository.dart';
import '../../domain/repositories/funding_repository.dart';
import '../../domain/repositories/orders_repository.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../../domain/repositories/positions_repository.dart';
import '../../domain/repositories/account_repository.dart';
import '../../domain/repositories/activity_repository.dart';
import '../../domain/repositories/session_repository.dart';
import '../../domain/repositories/wallets_repository.dart';
import '../../domain/repositories/realtime_repository.dart';
import '../../domain/repositories/trade_intent_repository.dart';
import '../../domain/services/hip3_typed_data_signer.dart';
import '../../domain/repositories/app_update_repository.dart';
import 'auth_providers.dart';
import 'session_scope.dart';
import 'hip3_confirmation_provider.dart';
import '../../data/services/hip3_position_action_service.dart';
import '../../data/services/hip3_position_action_executor.dart';

final apiEnvironmentProvider = Provider<ApiEnvironment>(
  (ref) => ApiEnvironment.fromEnvironment(),
);
final privyAccessTokenProvider = Provider<PrivyAccessTokenProvider>(
  (ref) => ref.watch(identityAccessTokenProvider),
);
final apiDataSourceProvider = Provider<RwaApiDataSource>(
  (ref) => RwaApiDataSource.create(
    tokenProvider: ref.watch(privyAccessTokenProvider),
    environment: ref.watch(apiEnvironmentProvider),
  ),
);
final sessionRepositoryProvider = Provider<SessionRepository>((ref) {
  final source = ref.watch(apiDataSourceProvider);
  return SessionRepositoryImpl(
    GeneratedSessionService(source.client.getAuthApi()),
  );
});
final accountRepositoryProvider = Provider<AccountRepository>((ref) {
  if (AppReviewConfiguration.buildEnabled && ref.watch(appReviewModeProvider)) {
    return AppReviewAccountRepository(ref.watch(appReviewStoreProvider));
  }
  final source = ref.watch(apiDataSourceProvider);
  return AccountRepositoryImpl(
    GeneratedAccountService(source.client.getAccountApi()),
  );
});
final appUpdateRepositoryProvider = Provider<AppUpdateRepository>((ref) {
  final source = ref.watch(apiDataSourceProvider);
  return AppUpdateRepositoryImpl(
    GeneratedSystemService(source.client.getSystemApi()),
    PackageInfoPlusService(),
  );
});
final walletsRepositoryProvider = Provider<WalletsRepository>((ref) {
  if (AppReviewConfiguration.buildEnabled && ref.watch(appReviewModeProvider)) {
    return AppReviewWalletsRepository(ref.watch(appReviewStoreProvider));
  }
  final source = ref.watch(apiDataSourceProvider);
  return WalletsRepositoryImpl(
    GeneratedWalletsService(source.client.getWalletsApi()),
  );
});
final marketsRepositoryProvider = Provider<MarketsRepository>((ref) {
  final source = ref.watch(apiDataSourceProvider);
  return MarketsRepositoryImpl(
    GeneratedMarketsService(source.client.getMarketsApi()),
    GeneratedChartsService(source.client.getChartsApi()),
  );
});
final marketHoursRepositoryProvider = Provider<MarketHoursRepository>((ref) {
  final source = ref.watch(apiDataSourceProvider);
  return MarketHoursRepositoryImpl(
    GeneratedChartsService(source.client.getChartsApi()),
  );
});
final portfolioRepositoryProvider = Provider<PortfolioRepository>((ref) {
  if (AppReviewConfiguration.buildEnabled && ref.watch(appReviewModeProvider)) {
    return AppReviewPortfolioRepository();
  }
  final source = ref.watch(apiDataSourceProvider);
  return PortfolioRepositoryImpl(
    GeneratedPortfolioService(source.client.getPortfolioApi()),
  );
});
final fundingRepositoryProvider = Provider<FundingRepository>((ref) {
  // Deposit data is read-only server configuration (wallet address, routes,
  // and QR payloads). Keep it on the real API even in App Review mode so the
  // Deposit sheet reflects the account's actual funding instructions.
  final source = ref.watch(apiDataSourceProvider);
  return FundingRepositoryImpl(
    GeneratedFundingService(source.client.getFundingApi()),
  );
});
final ordersRepositoryProvider = Provider<OrdersRepository>((ref) {
  if (AppReviewConfiguration.buildEnabled && ref.watch(appReviewModeProvider)) {
    final source = ref.watch(apiDataSourceProvider);
    return AppReviewOrdersRepository(
      ref.watch(appReviewStoreProvider),
      previewDelegate: OrdersRepositoryImpl(
        GeneratedOrdersService(source.client.getOrdersApi()),
      ),
      marketsDelegate: ref.watch(marketsRepositoryProvider),
    );
  }
  final source = ref.watch(apiDataSourceProvider);
  return OrdersRepositoryImpl(
    GeneratedOrdersService(source.client.getOrdersApi()),
  );
});
final tradeIntentRepositoryProvider = Provider<TradeIntentRepository>((ref) {
  if (AppReviewConfiguration.buildEnabled && ref.watch(appReviewModeProvider)) {
    return AppReviewTradeIntentRepository(ref.watch(appReviewStoreProvider));
  }
  final source = ref.watch(apiDataSourceProvider);
  return TradeIntentRepositoryImpl(
    GeneratedTradeIntentService(source.client.getOrdersApi()),
  );
});
final hip3TypedDataSignerProvider = Provider<Hip3TypedDataSigner>((ref) {
  final gateway = ref.watch(identityAuthGatewayProvider);
  if (gateway case final Hip3TypedDataSigner signer) return signer;
  throw const Hip3SigningFailure(
    Hip3SigningFailureCode.walletUnavailable,
    retryable: true,
  );
});
final hip3OrderExecutionRepositoryProvider =
    Provider<Hip3OrderExecutionRepository>((ref) {
      ref.watch(sessionGenerationProvider);
      if (AppReviewConfiguration.buildEnabled &&
          ref.watch(appReviewModeProvider)) {
        return AppReviewHip3OrderExecutionRepository(
          ref.watch(appReviewStoreProvider),
        );
      }
      final source = ref.watch(apiDataSourceProvider);
      return Hip3OrderExecutionRepositoryImpl(
        ref.watch(hip3TypedDataSignerProvider),
        GeneratedHip3OrderActionService(source.client.getOrdersApi()),
      );
    });
final hip3OpeningRepositoryProvider = Provider<Hip3OpeningRepository>((ref) {
  final generation = ref.watch(sessionGenerationProvider);
  final service = GeneratedHip3PositionActionService(
    ref.watch(apiDataSourceProvider).client.getOrdersApi(),
  );
  return Hip3OpeningRepositoryImpl(
    service,
    Hip3PositionActionExecutor(
      service,
      _PositionSessionSigner(ref, generation),
      isActive: () =>
          ref.mounted && ref.read(sessionGenerationProvider) == generation,
    ),
    (summary) => ref.read(hip3ConfirmationProvider.notifier).request(summary),
  );
});

final positionsRepositoryProvider = Provider<PositionsRepository>((ref) {
  if (AppReviewConfiguration.buildEnabled && ref.watch(appReviewModeProvider)) {
    return AppReviewPositionsRepository();
  }
  final generation = ref.watch(sessionGenerationProvider);
  final source = ref.watch(apiDataSourceProvider);
  final actions = GeneratedHip3PositionActionService(
    source.client.getOrdersApi(),
  );
  return PositionsRepositoryImpl(
    GeneratedPositionsService(source.client.getPositionsApi()),
    actions: actions,
    executor: Hip3PositionActionExecutor(
      actions,
      _PositionSessionSigner(ref, generation),
      isActive: () =>
          ref.mounted && ref.read(sessionGenerationProvider) == generation,
    ),
    confirm: (summary) =>
        ref.read(hip3ConfirmationProvider.notifier).request(summary),
  );
});

/// Reading positions must not require a connected signing wallet. Resolve it
/// only after consent, and reject work from a previous authenticated session.
final class _PositionSessionSigner implements Hip3TypedDataSigner {
  _PositionSessionSigner(this.ref, this.generation);
  final Ref ref;
  final Object generation;

  @override
  Future<String> signTypedDataV4({
    required String expectedSigner,
    required Map<String, Object?> typedData,
  }) {
    if (!ref.mounted || ref.read(sessionGenerationProvider) != generation) {
      throw const Hip3SigningFailure(Hip3SigningFailureCode.rejected);
    }
    return ref
        .read(hip3TypedDataSignerProvider)
        .signTypedDataV4(expectedSigner: expectedSigner, typedData: typedData);
  }
}

final activityRepositoryProvider = Provider<ActivityRepository>((ref) {
  if (AppReviewConfiguration.buildEnabled && ref.watch(appReviewModeProvider)) {
    return AppReviewActivityRepository(ref.watch(appReviewStoreProvider));
  }
  final source = ref.watch(apiDataSourceProvider);
  return ActivityRepositoryImpl(
    GeneratedActivityService(source.client.getActivityApi()),
  );
});
final realtimeServiceProvider = Provider<RealtimeService>((ref) {
  final source = ref.watch(apiDataSourceProvider);
  return DioRealtimeService(
    source.dio,
    systemApi: source.client.getSystemApi(),
  );
});
final realtimeRepositoryProvider = Provider<RealtimeRepository>((ref) {
  if (AppReviewConfiguration.buildEnabled && ref.watch(appReviewModeProvider)) {
    return AppReviewRealtimeRepository();
  }
  return RealtimeRepositoryImpl(ref.watch(realtimeServiceProvider));
});
