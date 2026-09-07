# Quickstart: Validate Privy Authentication Integration

## Prerequisites

- Flutter compatible with Dart ^3.13.0
- Android API 28+ device/emulator or iOS 17+ simulator/device for native validation
- Non-empty staging `PRIVY_APP_ID` and `PRIVY_CLIENT_ID` public values
- The mobile application identifiers are registered in the Privy dashboard

## Automated validation

```bash
flutter pub get
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test
```

Expected: dependency resolution, formatting, analysis, gateway tests, provider
state tests, and existing API interceptor/session tests all pass without native
platform channels.

## Native staging smoke test

1. Start the app on a supported mobile target with `API_BASE_URL`, `PRIVY_APP_ID`, and `PRIVY_CLIENT_ID` supplied through `--dart-define`.
2. Bootstrap authentication. With no persisted identity, expect `unauthenticated`.
3. Request a code for a staging email. Expect `awaitingCode` with the normalized email.
4. Enter the received code. Expect identity verification, product-session exchange,
   authoritative wallet synchronization, and then `authenticated` with the backend account.
5. Restart the app. Expect restoration to the same account without a new code.
6. Trigger logout. Expect `unauthenticated`, cleared account state, and no token on
   subsequent requests.
7. On web or desktop, bootstrap authentication and expect `unsupportedPlatform`
   without an unhandled exception.

Do not record screenshots, logs, or test artifacts containing OTPs or access tokens.

## Validation record (2026-09-04)

- `dart format --output=none --set-exit-if-changed lib test`: passed (199 files)
- `flutter analyze`: passed with no issues
- `flutter test`: passed (133 tests)
- `flutter build apk --debug`: passed; generated `build/app/outputs/flutter-apk/app-debug.apk`
- Native staging OTP smoke test: pending registered staging client and controlled email inbox
