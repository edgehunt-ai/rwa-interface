# Privy Android Activity context compatibility

Privy Flutter 0.10.2 passes `applicationContext` to Privy Android 0.15.0.
The SDK retains that context in its passkey handler and supplies it to AndroidX
Credential Manager. Launching the credential UI then fails with
`ensure the context parameter is an activity-based context`.

`../privy-activity-context.gradle` builds a patched copy of the plugin sources in
the build directory. It makes the plugin ActivityAware and preserves a shared
`PrivyActivityContext` during initialization. The wrapper delegates to the current
Activity and returns to the Application on detach, including configuration and
engine changes. UI launches without a live Activity fail with an actionable
message. Authentication requests continue through the existing Riverpod gateway;
this patch only repairs native SDK initialization and UI context ownership.

The Pub cache and Dart/iOS plugin code are unchanged. Exact replacement checks
fail the build when relevant upstream source changes. Review and remove this
workaround once the upstream plugin and SDK support Activity lifecycle handling.
Privy Flutter 0.11.0 still contains the same Application-context initialization.

Run the native regression tests with:

```sh
flutter pub get
flutter build apk --debug --config-only --no-pub --target-platform android-arm64
cd android
./gradlew :app:testDebugUnitTest -Ptarget-platform=android-arm64 --console=plain
```

The config-only build generates the ignored Gradle wrapper and local SDK
properties needed by a clean checkout without packaging an APK.
