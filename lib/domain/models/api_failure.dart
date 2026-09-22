enum FailureKind {
  unauthorized,
  forbidden,
  validation,
  conflict,
  rateLimited,
  unavailable,
  network,
  unknown,
  cancelled,
  decoding,
  compatibility,
}

sealed class ApiFailure implements Exception {
  const ApiFailure({this.requestId, this.retryable = false, this.userAction});

  final String? requestId;
  final bool retryable;
  final String? userAction;

  FailureKind get kind;

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

String apiFailureMessage(ApiFailure failure, {required String fallback}) {
  if (failure is ServerFailure) {
    if (failure.failureReason case final reason?
        when reason.trim().isNotEmpty) {
      return reason.trim();
    }
    final detail = failure.details.entries
        .map((entry) => '${entry.key}: ${entry.value}')
        .join(', ');
    final suffix = detail.isEmpty ? '' : ' ($detail)';
    return 'HTTP ${failure.statusCode} ${failure.code}$suffix';
  }
  if (failure.userAction case final action?
      when action.trim().isNotEmpty && action != 'reauthenticate') {
    return action;
  }
  return '${failure.kind.name}: $fallback';
}

final class ServerFailure extends ApiFailure {
  const ServerFailure({
    required this.statusCode,
    required this.code,
    super.requestId,
    super.retryable,
    super.userAction,
    this.failureReason,
    this.details = const {},
  });
  final int statusCode;
  final String code;
  final String? failureReason;
  final Map<String, Object?> details;

  @override
  FailureKind get kind => switch (statusCode) {
    403 => FailureKind.forbidden,
    409 => FailureKind.conflict,
    422 => FailureKind.validation,
    429 => FailureKind.rateLimited,
    503 => FailureKind.unavailable,
    _ => FailureKind.unknown,
  };

  @override
  Iterable<Object?> get _properties => [
    ...super._properties,
    statusCode,
    code,
    failureReason,
    Object.hashAllUnordered(
      details.entries.map((e) => Object.hash(e.key, e.value)),
    ),
  ];
}

final class AuthenticationFailure extends ApiFailure {
  const AuthenticationFailure({super.requestId, super.userAction});
  @override
  FailureKind get kind => FailureKind.unauthorized;
}

final class NetworkFailure extends ApiFailure {
  const NetworkFailure({
    super.requestId,
    super.retryable = true,
    super.userAction,
  });
  @override
  FailureKind get kind => FailureKind.network;
}

final class TimeoutFailure extends ApiFailure {
  const TimeoutFailure({super.requestId, super.retryable = true});
  @override
  FailureKind get kind => FailureKind.network;
}

final class CancelledFailure extends ApiFailure {
  const CancelledFailure({super.requestId});
  @override
  FailureKind get kind => FailureKind.cancelled;
}

final class DecodingFailure extends ApiFailure {
  const DecodingFailure({super.requestId, super.userAction});
  @override
  FailureKind get kind => FailureKind.decoding;
}

final class CompatibilityFailure extends ApiFailure {
  const CompatibilityFailure({super.requestId, super.userAction});
  @override
  FailureKind get kind => FailureKind.compatibility;
}

final class UnknownFailure extends ApiFailure {
  const UnknownFailure({super.requestId, super.retryable, super.userAction});
  @override
  FailureKind get kind => FailureKind.unknown;
}
