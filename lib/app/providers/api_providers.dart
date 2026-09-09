import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/api/api_environment.dart';
import '../../data/api/privy_access_token_provider.dart';
import '../../data/api/rwa_api_data_source.dart';
import '../../data/repositories/markets_repository_impl.dart';
import '../../data/repositories/funding_repository_impl.dart';
import '../../data/repositories/orders_repository_impl.dart';
import '../../data/repositories/portfolio_repository_impl.dart';
import '../../data/repositories/positions_repository_impl.dart';
import '../../data/repositories/account_repository_impl.dart';
import '../../data/repositories/activity_repository_impl.dart';
import '../../data/repositories/session_repository_impl.dart';
import '../../data/repositories/wallets_repository_impl.dart';
import '../../data/repositories/realtime_repository_impl.dart';
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
import '../../data/services/dio_realtime_service.dart';
import '../../data/services/realtime_service.dart';
import '../../domain/repositories/markets_repository.dart';
import '../../domain/repositories/funding_repository.dart';
import '../../domain/repositories/orders_repository.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../../domain/repositories/positions_repository.dart';
import '../../domain/repositories/account_repository.dart';
import '../../domain/repositories/activity_repository.dart';
import '../../domain/repositories/session_repository.dart';
import '../../domain/repositories/wallets_repository.dart';
import '../../domain/repositories/realtime_repository.dart';
import 'auth_providers.dart';

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
  final source = ref.watch(apiDataSourceProvider);
  return AccountRepositoryImpl(
    GeneratedAccountService(source.client.getAccountApi()),
  );
});
final walletsRepositoryProvider = Provider<WalletsRepository>((ref) {
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
final portfolioRepositoryProvider = Provider<PortfolioRepository>((ref) {
  final source = ref.watch(apiDataSourceProvider);
  return PortfolioRepositoryImpl(
    GeneratedPortfolioService(source.client.getPortfolioApi()),
  );
});
final fundingRepositoryProvider = Provider<FundingRepository>((ref) {
  final source = ref.watch(apiDataSourceProvider);
  return FundingRepositoryImpl(
    GeneratedFundingService(source.client.getFundingApi()),
  );
});
final ordersRepositoryProvider = Provider<OrdersRepository>((ref) {
  final source = ref.watch(apiDataSourceProvider);
  return OrdersRepositoryImpl(
    GeneratedOrdersService(source.client.getOrdersApi()),
  );
});
final positionsRepositoryProvider = Provider<PositionsRepository>((ref) {
  final source = ref.watch(apiDataSourceProvider);
  return PositionsRepositoryImpl(
    GeneratedPositionsService(source.client.getPositionsApi()),
  );
});
final activityRepositoryProvider = Provider<ActivityRepository>((ref) {
  final source = ref.watch(apiDataSourceProvider);
  return ActivityRepositoryImpl(
    GeneratedActivityService(source.client.getActivityApi()),
  );
});
final realtimeServiceProvider = Provider<RealtimeService>((ref) {
  return DioRealtimeService(ref.watch(apiDataSourceProvider).dio);
});
final realtimeRepositoryProvider = Provider<RealtimeRepository>((ref) {
  return RealtimeRepositoryImpl(ref.watch(realtimeServiceProvider));
});
