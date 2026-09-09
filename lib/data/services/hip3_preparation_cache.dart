/// Session-scoped preparation snapshots. A retry must not replace a context or
/// close preview already used to create a client-signed action.
final class Hip3PreparationCache {
  final Map<String, ({String command, Future<Object> value})> _entries = {};

  Future<T> get<T extends Object>(
    String key,
    String command,
    Future<T> Function() prepare,
  ) async {
    final existing = _entries[key];
    if (existing != null) {
      if (existing.command != command) {
        throw ArgumentError('Idempotency key reused for another HIP3 command');
      }
      return await existing.value as T;
    }
    final future = Future<T>.sync(prepare);
    _entries[key] = (command: command, value: future);
    try {
      return await future;
    } catch (_) {
      // No preparation was obtained. Safe to retry preparation; the caller
      // retains the same idempotency key for any preview request.
      if (identical(_entries[key]?.value, future)) _entries.remove(key);
      rethrow;
    }
  }
}
