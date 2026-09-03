import 'package:dio/dio.dart';

final class RequestReplayPolicy {
  const RequestReplayPolicy();

  bool canReplay(RequestOptions request) {
    final method = request.method.toUpperCase();
    if (const {'GET', 'HEAD', 'OPTIONS'}.contains(method)) return true;
    final key = request.headers['Idempotency-Key']?.toString();
    if (key == null || key.isEmpty) return false;
    return request.data is! Stream;
  }
}
