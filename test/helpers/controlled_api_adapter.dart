import 'dart:convert';

import 'package:dio/dio.dart';

final class ControlledResponse {
  const ControlledResponse({
    required this.method,
    required this.path,
    required this.statusCode,
    required this.body,
    this.headers = const {},
    this.delay = Duration.zero,
  });

  factory ControlledResponse.json({
    required String method,
    required String path,
    required int statusCode,
    Object? body,
    Map<String, List<String>> headers = const {},
    Duration delay = Duration.zero,
  }) => ControlledResponse(
    method: method.toUpperCase(),
    path: path,
    statusCode: statusCode,
    body: utf8.encode(jsonEncode(body)),
    headers: {
      'content-type': const ['application/json'],
      ...headers,
    },
    delay: delay,
  );

  final String method;
  final String path;
  final int statusCode;
  final List<int> body;
  final Map<String, List<String>> headers;
  final Duration delay;
}

final class ControlledRequest {
  const ControlledRequest({
    required this.method,
    required this.path,
    required this.headers,
    required this.body,
  });

  final String method;
  final String path;
  final Map<String, Object?> headers;
  final List<int> body;
}

final class ControlledApiAdapter implements HttpClientAdapter {
  ControlledApiAdapter([Iterable<ControlledResponse> responses = const []])
    : _responses = List.of(responses);

  final List<ControlledResponse> _responses;
  final List<ControlledRequest> requests = [];
  bool _closed = false;

  void enqueue(ControlledResponse response) => _responses.add(response);

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    if (_closed) throw StateError('Controlled adapter is closed');
    final body = requestStream == null
        ? <int>[]
        : await requestStream.expand((chunk) => chunk).toList();
    requests.add(
      ControlledRequest(
        method: options.method.toUpperCase(),
        path: options.uri.path,
        headers: _sanitizeHeaders(options.headers),
        body: body,
      ),
    );
    final index = _responses.indexWhere(
      (response) =>
          response.method == options.method.toUpperCase() &&
          response.path == options.uri.path,
    );
    if (index < 0) {
      throw StateError(
        'Unexpected controlled request: ${options.method.toUpperCase()} '
        '${options.uri.path}',
      );
    }
    final response = _responses.removeAt(index);
    if (response.delay > Duration.zero) {
      await Future<void>.delayed(response.delay);
    }
    return ResponseBody.fromBytes(
      response.body,
      response.statusCode,
      headers: response.headers,
    );
  }

  Map<String, Object?> _sanitizeHeaders(Map<String, dynamic> headers) => {
    for (final entry in headers.entries)
      if (!const {
        'authorization',
        'cookie',
        'x-signature',
      }.contains(entry.key.toLowerCase()))
        entry.key.toLowerCase(): entry.value,
  };

  @override
  void close({bool force = false}) => _closed = true;
}
