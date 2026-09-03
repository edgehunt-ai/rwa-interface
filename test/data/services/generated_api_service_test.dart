import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart';
import 'package:rwa_interface/data/services/generated_session_service.dart';

void main() {
  test('204 空成功不尝试解码 body', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://fixture.example'))
      ..httpClientAdapter = _EmptyAdapter();
    final client = RwaApiClient(dio: dio, interceptors: const []);
    await expectLater(
      GeneratedSessionService(client.getAuthApi()).deleteSession(),
      completes,
    );
  });
}

final class _EmptyAdapter implements HttpClientAdapter {
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    expect(options.method, 'DELETE');
    return ResponseBody.fromString('', 204);
  }

  @override
  void close({bool force = false}) {}
}
