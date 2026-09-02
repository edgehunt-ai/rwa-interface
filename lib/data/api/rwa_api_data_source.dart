import 'package:dio/dio.dart';
import 'package:rwa_api_client/rwa_api_client.dart';

import 'privy_access_token_provider.dart';
import 'privy_auth_interceptor.dart';

/// Data-layer owner of the generated wire client.
///
/// Repositories must map generated models to app domain models before returning
/// data to UI code.
class RwaApiDataSource {
  RwaApiDataSource._({required this.client, required this.dio});

  factory RwaApiDataSource.create({
    required PrivyAccessTokenProvider tokenProvider,
    String baseUrl = RwaApiClient.basePath,
  }) {
    final dio = Dio(BaseOptions(baseUrl: baseUrl));
    final interceptor = PrivyAuthInterceptor(dio, tokenProvider);
    final client = RwaApiClient(dio: dio, interceptors: [interceptor]);
    return RwaApiDataSource._(client: client, dio: dio);
  }

  final RwaApiClient client;
  final Dio dio;
}
