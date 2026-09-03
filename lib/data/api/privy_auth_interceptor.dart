import 'package:dio/dio.dart';

import 'privy_access_token_provider.dart';

class PrivyAuthInterceptor extends Interceptor {
  PrivyAuthInterceptor(this._dio, this._tokenProvider);

  static const _retriedKey = 'rwa_privy_auth_retried';

  final Dio _dio;
  final PrivyAccessTokenProvider _tokenProvider;
  Future<String?>? _refreshInFlight;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _tokenProvider.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (!_shouldRetry(err.requestOptions, err.response?.statusCode)) {
      handler.next(err);
      return;
    }

    final token = await _refreshOnce();
    if (token == null || token.isEmpty) {
      await _tokenProvider.onAuthenticationExpired();
      handler.next(err);
      return;
    }

    final request = err.requestOptions;
    request.extra[_retriedKey] = true;
    request.headers['Authorization'] = 'Bearer $token';
    try {
      handler.resolve(await _dio.fetch<Object?>(request));
    } on DioException catch (retryError) {
      handler.next(retryError);
    }
  }

  bool _shouldRetry(RequestOptions request, int? statusCode) {
    return statusCode == 401 && request.extra[_retriedKey] != true;
  }

  Future<String?> _refreshOnce() async {
    final current = _refreshInFlight;
    if (current != null) {
      return current;
    }

    final refresh = _tokenProvider.refreshAccessToken();
    _refreshInFlight = refresh;
    try {
      return await refresh;
    } finally {
      if (identical(_refreshInFlight, refresh)) {
        _refreshInFlight = null;
      }
    }
  }
}
