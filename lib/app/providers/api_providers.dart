import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/api/api_environment.dart';
import '../../data/api/privy_access_token_provider.dart';
import '../../data/api/rwa_api_data_source.dart';
import '../../data/repositories/markets_repository_impl.dart';
import '../../data/services/generated_markets_service.dart';
import '../../data/services/dio_realtime_service.dart';
import '../../data/services/realtime_service.dart';
import '../../domain/repositories/markets_repository.dart';
import '../../domain/repositories/hip3_order_execution_repository.dart';
import '../../domain/services/hip3_typed_data_signer.dart';
import '../../data/repositories/hip3_order_execution_repository_impl.dart';
import '../../data/services/hip3_order_action_service.dart';

final apiEnvironmentProvider = Provider<ApiEnvironment>(
  (ref) => ApiEnvironment.fromEnvironment(),
);
final privyAccessTokenProvider = Provider<PrivyAccessTokenProvider>(
  (ref) =>
      throw UnimplementedError('PrivyAccessTokenProvider must be overridden'),
);
final apiDataSourceProvider = Provider<RwaApiDataSource>(
  (ref) => RwaApiDataSource.create(
    tokenProvider: ref.watch(privyAccessTokenProvider),
    environment: ref.watch(apiEnvironmentProvider),
  ),
);
final marketsRepositoryProvider = Provider<MarketsRepository>((ref) {
  final source = ref.watch(apiDataSourceProvider);
  return MarketsRepositoryImpl(
    GeneratedMarketsService(source.client.getMarketsApi()),
  );
});
final realtimeServiceProvider = Provider<RealtimeService>((ref) {
  return DioRealtimeService(ref.watch(apiDataSourceProvider).dio);
});

final hip3TypedDataSignerProvider = Provider<Hip3TypedDataSigner>(
  (ref) => throw UnimplementedError(
    'Hip3TypedDataSigner must be provided by the wallet integration',
  ),
);

final hip3OrderExecutionRepositoryProvider =
    Provider<Hip3OrderExecutionRepository>((ref) {
      final source = ref.watch(apiDataSourceProvider);
      return Hip3OrderExecutionRepositoryImpl(
        ref.watch(hip3TypedDataSignerProvider),
        DioHip3OrderActionService(source.dio),
      );
    });
