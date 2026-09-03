sealed class ApiFailure implements Exception {
  const ApiFailure({this.requestId, this.retryable = false, this.userAction});

  final String? requestId;
  final bool retryable;
  final String? userAction;

  Iterable<Object?> get _properties => [requestId, retryable, userAction];

  @override
  bool operator ==(Object other) {
    if (runtimeType != other.runtimeType || other is! ApiFailure) return false;
    final left = _properties.toList(growable: false);
    final right = other._properties.toList(growable: false);
    if (left.length != right.length) return false;
    for (var index = 0; index < left.length; index++) {
      if (left[index] != right[index]) return false;
    }
    return true;
  }

  @override
  int get hashCode => Object.hash(runtimeType, Object.hashAll(_properties));
}

final class ServerFailure extends ApiFailure {
  const ServerFailure({
    required this.statusCode,
    required this.code,
    super.requestId,
    super.retryable,
    super.userAction,
    this.details = const {},
  });
  final int statusCode;
  final String code;
  final Map<String, Object?> details;

  @override
  Iterable<Object?> get _properties => [
    ...super._properties,
    statusCode,
    code,
    Object.hashAllUnordered(
      details.entries.map((e) => Object.hash(e.key, e.value)),
    ),
  ];
}

final class AuthenticationFailure extends ApiFailure {
  const AuthenticationFailure({super.requestId, super.userAction});
}

final class NetworkFailure extends ApiFailure {
  const NetworkFailure({super.requestId, super.retryable = true});
}

final class TimeoutFailure extends ApiFailure {
  const TimeoutFailure({super.requestId, super.retryable = true});
}

final class CancelledFailure extends ApiFailure {
  const CancelledFailure({super.requestId});
}

final class DecodingFailure extends ApiFailure {
  const DecodingFailure({super.requestId});
}

final class CompatibilityFailure extends ApiFailure {
  const CompatibilityFailure({super.requestId});
}

final class UnknownFailure extends ApiFailure {
  const UnknownFailure({super.requestId});
}
