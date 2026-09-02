# Quickstart: Validate the App Foundation

## Prerequisites

- Flutter 3.47.0 or a compatible stable release
- Android emulator/device, iOS simulator/device on macOS, or a supported web browser

## Automated validation

```sh
flutter pub get
dart format --output=none --set-exit-if-changed lib test
dart analyze --fatal-infos
flutter test
flutter build web --debug
```

Expected: dependency resolution, formatting, analysis, tests, and web build all succeed.

## Route validation

1. Launch the root URL and confirm the foundation screen appears.
2. Open the secondary route and navigate back using the platform-standard action.
3. On web, refresh the secondary URL and use browser back/forward.
4. Open an unknown path and recover to root from the not-found state.

## Component validation

1. Exercise loading, empty, and error variants, including retry with and without a callback.
2. Copy a shortened safe identifier; verify the complete value and accessible feedback.
3. Render adaptive progress, switch, alert, action sheet, and date selection per target platform.
4. Repeat in light/dark appearance, narrow/wide viewport, long localized content, and 200% text.

## Manual iOS acceptance

- Edge-back follows the gesture and restores the previous destination.
- Top content clears the notch or Dynamic Island; bottom actions clear the Home Indicator.
- Landscape insets keep essential content reachable.
- Keyboard does not hide the focused field, validation, or primary action.
- Progress, switch, alert, action sheet, and date selection follow iOS interaction conventions.
- Large text, dark appearance, and long content preserve meaning and operability.

Automated iOS integration testing is intentionally outside this feature.
