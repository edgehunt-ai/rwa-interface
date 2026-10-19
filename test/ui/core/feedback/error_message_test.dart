import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/domain/auth/authentication.dart';
import 'package:nobell/domain/models/api_failure.dart';
import 'package:nobell/ui/core/feedback/error_message.dart';

void main() {
  test(
    'unwraps a failing Riverpod dependency to preserve the server reason',
    () {
      const failure = ServerFailure(
        statusCode: 422,
        code: 'insufficient_margin',
        failureReason: 'The account has insufficient withdrawable collateral.',
      );
      final dependency = Provider<int>((ref) => throw failure);
      final dependent = Provider<int>((ref) => ref.watch(dependency));
      final container = ProviderContainer();
      addTearDown(container.dispose);
      try {
        container.read(dependent);
        fail('The provider must throw');
      } catch (error) {
        expect(
          errorMessage(error, fallback: 'Request failed'),
          failure.failureReason,
        );
      }
    },
  );

  test('preserves SDK, parsing, state and identity failure reasons', () {
    for (final (error, expected) in <(Object, String)>[
      (
        const FormatException('Invalid response version'),
        'Invalid response version',
      ),
      (
        StateError('Transfer route is unavailable'),
        'Transfer route is unavailable',
      ),
      (
        const IdentityFailure(
          AuthenticationFailureCode.provider,
          retryable: true,
          reason: 'Passkey was rejected by the device',
        ),
        'Passkey was rejected by the device',
      ),
      (
        const NetworkFailure(userAction: 'Connection reset by peer'),
        'Connection reset by peer',
      ),
    ]) {
      expect(errorMessage(error, fallback: 'Failed'), expected);
    }
  });

  test('falls back only when the error has no readable detail', () {
    expect(
      errorMessage(Object(), fallback: 'Request failed'),
      'Request failed',
    );
    expect(
      errorMessage(const FormatException(''), fallback: 'Request failed'),
      'Request failed',
    );
  });
}
