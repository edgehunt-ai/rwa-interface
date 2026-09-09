import 'controlled_api_adapter.dart';

final class TradingScenarioFixture {
  const TradingScenarioFixture._();

  static ControlledResponse json({
    required String method,
    required String path,
    required int statusCode,
    Object? body,
    Map<String, List<String>> headers = const {},
  }) => ControlledResponse.json(
    method: method,
    path: path,
    statusCode: statusCode,
    body: body,
    headers: headers,
  );

  static ControlledResponse success(
    String path, {
    Object? body = const <String, Object?>{},
  }) => json(method: 'GET', path: path, statusCode: 200, body: body);

  static ControlledResponse empty(String path) =>
      success(path, body: const {'items': <Object?>[]});

  static ControlledResponse page(
    String path,
    List<Object?> items, {
    String? nextCursor,
  }) => success(path, body: {'items': items, 'next_cursor': nextCursor});

  static ControlledResponse failure(String path, int statusCode) => json(
    method: 'GET',
    path: path,
    statusCode: statusCode,
    body: {
      'code': 'fixture_$statusCode',
      'retryable': statusCode == 429 || statusCode == 503,
    },
  );

  static ControlledResponse malformed(String path) => ControlledResponse(
    method: 'GET',
    path: path,
    statusCode: 200,
    body: const [0xff, 0xfe],
    headers: const {
      'content-type': ['application/json'],
    },
  );
}
