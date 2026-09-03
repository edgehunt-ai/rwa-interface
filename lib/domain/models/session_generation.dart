final class SessionGeneration {
  const SessionGeneration(this.value);

  final int value;

  SessionGeneration next() => SessionGeneration(value + 1);
}
