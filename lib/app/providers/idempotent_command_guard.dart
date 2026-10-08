import '../../data/api/idempotency_key.dart';

final class IdempotentCommandGuard {
  final Map<String, String> _keys = {};
  final Map<String, Future<Object?>> _inFlight = {};

  Future<T> run<T>({
    required String operation,
    required String fingerprint,
    required Future<T> Function(String idempotencyKey) command,
  }) {
    final identity = '$operation|$fingerprint';
    final active = _inFlight[identity];
    if (active != null) return active.then((value) => value as T);

    // Keep retries stable within this command scope. A replacement scope must
    // receive a fresh key so a later session cannot replay an earlier command.
    final key = _keys.putIfAbsent(identity, newIdempotencyKey);
    // Start the request before registering its cleanup.  An immediately
    // completed future can otherwise run `finally` while a self-referential
    // local future is still uninitialized.
    final request = command(key);
    final tracked = request.whenComplete(() {
      _inFlight.remove(identity);
    });
    _inFlight[identity] = tracked;
    return tracked;
  }
}
