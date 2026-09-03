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

## OpenAPI contract

`openapi/main.yaml` is the single public product contract shared by the backend and clients. It
uses OpenAPI 3.0.3 and exposes explicit `/v1` paths. Runtime availability still requires a mounted
backend route; a declared path is not evidence that an asset operation is enabled.

Install and run the contract gate with Node.js 22:

```sh
npm ci --ignore-scripts
npm run contract:check
```

The gate runs custom semantic rules, Redocly CLI 2.50.0 lint, and OpenAPI Generator 7.24.0
validation through wrapper 2.40.1. Generator validation is configured with `useDocker: true` so it
does not depend on the host Java version; Docker must be available locally and in CI.


### Generated Dart API client

The formal Flutter app consumes the same `openapi/main.yaml` contract through a generated `dart-dio` package:

```sh
npm run client:generate
npm run client:check
```

Before analyzing or building Flutter, generate the `built_value` parts:

```sh
(cd packages/rwa_api_client && dart pub get && dart run build_runner build)
```

Generated files live under `packages/rwa_api_client` and must not be edited by hand. The app wraps the package in `lib/data/api`; repositories must map generated wire DTOs to domain models before exposing them to UI code. The Privy adapter supplies the current access token to the Dio interceptor. A 401 triggers at most one Privy refresh and replay, then returns the app to its login state if refresh fails. Privy remains the only owner of refresh tokens. The generator uses OpenAPI Generator 7.24.0 with `dart-dio`, `enumUnknownDefaultCase=true`, and `legacyDiscriminatorBehavior=false`.

The custom rules reject duplicate or missing `operationId` values, unresolved references,
incomplete path parameters, orphan schemas, financial commands without a required
`Idempotency-Key`, `409`, and `422`, missing protected/public error response sets,
server-owned request fields, non-Decimal financial wire values, and responses that omit
`X-Request-ID`.

`.github/CODEOWNERS` requests review from the verified backend platform and frontend owners.
The `Contract approvals` workflow additionally requires both owners to approve the exact PR head
commit whenever contract governance files change. Configure the repository ruleset to require the
`Require frontend and backend contract approvals` status check before merging to `main`.
