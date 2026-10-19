import 'package:flutter_riverpod/misc.dart';

import '../../../domain/auth/authentication.dart';

import '../../../domain/models/api_failure.dart';

/// Preserve the underlying failure when Riverpod wraps a failed dependency.
String errorMessage(Object error, {required String fallback}) {
  while (error is ProviderException) {
    error = error.exception;
  }
  if (error is ApiFailure) {
    return apiFailureMessage(error, fallback: fallback);
  }
  final message = switch (error) {
    IdentityFailure() => error.reason ?? '',
    FormatException() => error.message,
    StateError() => error.message.toString(),
    _ => error.toString(),
  }.trim();
  if (message.isEmpty ||
      message == 'null' ||
      message == "Instance of '${error.runtimeType}'") {
    return fallback;
  }
  return message;
}
