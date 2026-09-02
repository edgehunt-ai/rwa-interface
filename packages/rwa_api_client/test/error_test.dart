import 'package:test/test.dart';
import 'package:rwa_api_client/rwa_api_client.dart';

// tests for Error
void main() {
  final instance = ErrorBuilder();
  // TODO add properties to the builder and call build()

  group(Error, () {
    // Stable machine-readable error code
    // String code
    test('to test the property `code`', () async {
      // TODO
    });

    // Localized user-facing message
    // String message
    test('to test the property `message`', () async {
      // TODO
    });

    // Whether retrying the same request can succeed
    // bool retryable
    test('to test the property `retryable`', () async {
      // TODO
    });

    // Stable client action hint, or null
    // String userAction
    test('to test the property `userAction`', () async {
      // TODO
    });

    // BuiltMap<String, JsonObject> details
    test('to test the property `details`', () async {
      // TODO
    });

    // Matches the X-Request-ID response header
    // String requestId
    test('to test the property `requestId`', () async {
      // TODO
    });

  });
}
