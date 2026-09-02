# Implementation Plan: Application Observability

**Branch**: `main` | **Date**: 2026-09-02 | **Spec**: [spec.md](spec.md)

## Summary

Integrate `sentry_flutter` behind an application-owned bootstrap and build-time configuration. Attach
its navigation observer to `go_router`, enable bounded tracing and profiling, disable automatic PII,
and preserve normal startup when monitoring is disabled or initialization fails.

## Technical Context

**Language/Version**: Dart 3.13.0, Flutter 3.47.0
**Primary Dependencies**: `sentry_flutter`, `sentry_dart_plugin`, `go_router`, GitHub Actions
**Storage**: N/A
**Testing**: Unit/widget tests with injected bootstrap behavior
**Target Platform**: Android and iOS

**CI Packaging**: Android release APK and unsigned iOS release app; web packaging excluded

## Constitution Check

- Specification traceability: PASS
- Layered architecture: PASS; monitoring stays in `lib/app/observability/`
- Tests and regression protection: PASS
- Security/privacy: PASS; PII disabled and secrets prohibited
- UX resilience: PASS; failed initialization falls back to normal startup
- Modularity: PASS; one reusable bootstrap and one router observer

## Project Structure

```text
lib/app/observability/
├── observability_config.dart
└── sentry_bootstrap.dart
test/app/observability/
├── observability_config_test.dart
└── sentry_bootstrap_test.dart
.github/workflows/
└── ci.yml
```

## Complexity Tracking

No constitution violations.
