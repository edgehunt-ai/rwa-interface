# Quickstart: Application Observability

```sh
flutter pub get
dart format --output=none --set-exit-if-changed lib test
dart analyze --fatal-infos
flutter test
```

Override configuration with `--dart-define=SENTRY_DSN=`, `SENTRY_ENVIRONMENT`,
`SENTRY_TRACES_SAMPLE_RATE`, `SENTRY_PROFILES_SAMPLE_RATE`, and `SENTRY_RELEASE`.

GitHub Actions runs formatting, analysis, and tests for pull requests. Pushes to the primary branch
and manual runs additionally package an Android release APK and an unsigned iOS release app. When
the `SENTRY_AUTH_TOKEN` secret is configured, those jobs upload available debug symbols to Sentry;
the token is optional for packaging.
