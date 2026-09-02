# rwa_interface

Cross-platform RWA trading interface.

## Observability

Sentry error reporting and sampled performance monitoring are enabled by default. Runtime values can
be supplied without source changes:

```sh
flutter run \
  --dart-define=SENTRY_DSN=https://public-key@example.ingest.sentry.io/project \
  --dart-define=SENTRY_ENVIRONMENT=staging \
  --dart-define=SENTRY_TRACES_SAMPLE_RATE=0.10 \
  --dart-define=SENTRY_PROFILES_SAMPLE_RATE=0.10 \
  --dart-define=SENTRY_RELEASE=app@1.0.0+1
```

Set `SENTRY_DSN` to an empty value to disable telemetry. Never commit a Sentry auth token; release,
source-map, and debug-symbol upload credentials belong in CI secret storage.

GitHub Actions runs quality checks for pull requests. Pushes to `main` additionally build an Android
release APK and an unsigned iOS release app. Configure runtime values under Actions **Variables**:

```text
SENTRY_DSN
SENTRY_ENVIRONMENT
SENTRY_TRACES_SAMPLE_RATE
SENTRY_PROFILES_SAMPLE_RATE
SENTRY_ORG=dodo-k4
SENTRY_PROJECT=flutter
```

Configure `SENTRY_AUTH_TOKEN` under Actions **Secrets** to upload Dart debug symbols, Android R8
mappings, and iOS dSYM files. When the secret is absent, packaging still succeeds and only symbol
upload is skipped. Never write this token to source, variables, logs, or workflow files.

The iOS artifact is unsigned. Producing an installable or App Store IPA additionally requires Apple
distribution certificate and provisioning-profile secrets. Android release builds enable R8 code
and resource shrinking; Sentry's Android Gradle plugin uploads the generated mapping when the token
is available.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
