final class IdempotentCommandGuard {
  final Map<String, String> _keys = {};
  final Map<String, Future<Object?>> _inFlight = {};
  int _sequence = 0;

  Future<T> run<T>({
    required String operation,
    required String fingerprint,
    required Future<T> Function(String idempotencyKey) command,
  }) {
    final identity = '$operation|$fingerprint';
    final active = _inFlight[identity];
    if (active != null) return active.then((value) => value as T);

    final key = _keys.putIfAbsent(
      identity,
      () =>
          '$operation-${DateTime.now().microsecondsSinceEpoch}-${_sequence++}',
    );
    late final Future<T> request;
    request = () async {
      try {
        return await command(key);
      } finally {
        if (identical(_inFlight[identity], request)) {
          _inFlight.remove(identity);
        }
      }
    }();
    _inFlight[identity] = request;
    return request;
  }
}
