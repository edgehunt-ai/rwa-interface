import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/data/api/privy_access_token_provider.dart';
import 'package:rwa_interface/data/api/privy_auth_interceptor.dart';

void main() {
  test('public operation 不附加 bearer token', () async {
    final provider = _TokenProvider('must-not-leak', null);
    final adapter = _SequenceAdapter([200]);
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'))
      ..httpClientAdapter = adapter;
    dio.interceptors.add(PrivyAuthInterceptor(dio, provider));
    await dio.get<Object?>(
      '/v1/public',
      options: Options(extra: {'secure': <Map<String, String>>[]}),
    );
    expect(adapter.authorizationHeaders, [null]);
  });

  test('adds bearer token and retries one 401 after Privy refresh', () async {
    final provider = _TokenProvider('expired-token', 'fresh-token');
    final adapter = _SequenceAdapter([401, 200]);
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'))
      ..httpClientAdapter = adapter;
    dio.interceptors.add(PrivyAuthInterceptor(dio, provider));

    final response = await dio.get<Object?>('/v1/me');

    expect(response.statusCode, 200);
    expect(provider.refreshCalls, 1);
    expect(adapter.authorizationHeaders, [
      'Bearer expired-token',
      'Bearer fresh-token',
    ]);
  });

  test('returns 401 and expires session when Privy cannot refresh', () async {
    final provider = _TokenProvider('expired-token', null);
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'))
      ..httpClientAdapter = _SequenceAdapter([401]);
    dio.interceptors.add(PrivyAuthInterceptor(dio, provider));

    await expectLater(dio.get<Object?>('/v1/me'), throwsA(isA<DioException>()));
    expect(provider.refreshCalls, 1);
    expect(provider.expiredCalls, 1);
  });

  test('20 个并发 401 共享一次 refresh 且每个最多重试一次', () async {
    final provider = _TokenProvider(
      'expired-token',
      'fresh-token',
      refreshDelay: const Duration(milliseconds: 20),
    );
    final adapter = _ConcurrentExpiryAdapter();
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'))
      ..httpClientAdapter = adapter;
    dio.interceptors.add(PrivyAuthInterceptor(dio, provider));

    final responses = await Future.wait(
      List.generate(20, (index) => dio.get<Object?>('/v1/me/$index')),
    );
    expect(responses.every((response) => response.statusCode == 200), isTrue);
    expect(provider.refreshCalls, 1);
    expect(adapter.calls, 40);
  });
}

class _TokenProvider implements PrivyAccessTokenProvider {
  _TokenProvider(
    this._token,
    this._refreshedToken, {
    this.refreshDelay = Duration.zero,
  });

  String? _token;
  final String? _refreshedToken;
  final Duration refreshDelay;
  int refreshCalls = 0;
  int expiredCalls = 0;

  @override
  Future<String?> getAccessToken() async => _token;

  @override
  Future<String?> refreshAccessToken() async {
    refreshCalls += 1;
    await Future<void>.delayed(refreshDelay);
    _token = _refreshedToken;
    return _token;
  }

  @override
  Future<void> onAuthenticationExpired() async {
    expiredCalls += 1;
  }
}

class _ConcurrentExpiryAdapter implements HttpClientAdapter {
  var calls = 0;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    calls++;
    final fresh = options.headers['Authorization'] == 'Bearer fresh-token';
    return ResponseBody.fromString(
      '{}',
      fresh ? 200 : 401,
      headers: {
        Headers.contentTypeHeader: ['application/json'],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

class _SequenceAdapter implements HttpClientAdapter {
  _SequenceAdapter(this._statuses);

  final List<int> _statuses;
  final List<String?> authorizationHeaders = [];
  var _index = 0;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    authorizationHeaders.add(options.headers['Authorization'] as String?);
    final status = _statuses[_index++];
    return ResponseBody.fromString(
      '{}',
      status,
      headers: {
        Headers.contentTypeHeader: ['application/json'],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}
