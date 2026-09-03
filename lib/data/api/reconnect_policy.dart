final class ReconnectPolicy {
  const ReconnectPolicy({
    this.maxAttempts = 5,
    this.baseDelay = const Duration(milliseconds: 250),
    this.maxDelay = const Duration(seconds: 8),
  });
  final int maxAttempts;
  final Duration baseDelay;
  final Duration maxDelay;

  Duration delayFor(int attempt) {
    final factor = 1 << attempt.clamp(0, 20);
    final candidate = baseDelay * factor;
    return candidate > maxDelay ? maxDelay : candidate;
  }
}
