# Research: Privy Authentication Integration

## Official SDK and version

- **Decision**: Use `privy_flutter` 0.10.1, the current stable release reviewed for this plan.
- **Rationale**: It is the provider-published Flutter bridge and exposes authentication, current user, access-token refresh, and logout needed by the existing boundaries.
- **Alternatives considered**: Direct REST integration was rejected because it would duplicate provider session security and refresh-token ownership; a mock-only gateway would not satisfy actual login.

## Supported platforms

- **Decision**: Enable actual authentication on Android API 28+ and iOS 17+ and return an owned unsupported-capability result elsewhere.
- **Rationale**: These are enforced by the SDK package metadata (`minSdk = 28` and iOS 17). Selecting the adapter before constructing the SDK prevents missing-plugin failures on other Flutter targets. The package README currently states Android API 27, but a real Gradle link check confirms the stricter manifest requirement.
- **Alternatives considered**: Dropping desktop/web builds was rejected because the existing application is cross-platform; pretending authentication is available was rejected as unsafe.

## Configuration

- **Decision**: Read App ID and mobile Client ID from `PRIVY_APP_ID` and `PRIVY_CLIENT_ID` compile-time defines before SDK construction; require both non-empty values. Keep enabled login methods in one code constant, currently `email`.
- **Rationale**: The Web demo also receives its public Privy identifier from deployment configuration. Compile-time values allow Flutter to initialize even when the backend configuration service is unavailable, while one constants file makes supported UI flows explicit.
- **Alternatives considered**: `/v1/auth/config` was removed from the Flutter startup dependency because a service configuration failure otherwise prevents Privy initialization.

## Authentication method and SDK calls

- **Decision**: Implement email OTP with `email.sendCode(email)` and `email.loginWithCode(code:, email:)`; restore with `getAuthState()`; use `getUser()` plus `getAccessToken()` and `refresh()`; clear with `logout()`.
- **Rationale**: This is the smallest complete interactive flow supported by both the feature request and SDK. Every SDK `Result<T>` is folded into owned outcomes at the adapter boundary.
- **Alternatives considered**: OAuth requires redirect platform configuration and product decisions; phone, passkey, SIWE/SIWS, and wallet functions are deferred.

## Embedded wallet and backend synchronization

- **Decision**: After creating/restoring `/v1/auth/session`, call the idempotent `/v1/me/wallets/sync` operation before publishing authenticated state.
- **Rationale**: This matches the Web demo and keeps the backend wallet record authoritative. `privy_flutter` 0.10.1 does not expose React's `PrivyProvider.config.embeddedWallets.ethereum.createOnLogin`; its whitelabel OTP flow exposes explicit wallet creation methods instead.
- **Alternatives considered**: Creating a wallet directly in Flutter was rejected because it would duplicate backend wallet policy and diverge from the demo's authoritative sync flow.

## State and concurrency

- **Decision**: A single Riverpod notifier owns bootstrap, challenge, verification, product-session exchange, and logout. Monotonic operation epochs discard stale completions, while the existing interceptor retains single-flight refresh responsibility.
- **Rationale**: Identity and product session become authenticated atomically from the application's perspective and identity switching cannot publish earlier results.
- **Alternatives considered**: Independent SDK and product-session providers risk transient authenticated states without a usable backend session.

## Security and observability

- **Decision**: Never persist or log email OTP/access tokens in application code; keep provider log level disabled; map SDK errors to coarse domain failure codes.
- **Rationale**: Privy remains the sole credential persistence owner and sensitive provider detail cannot enter UI or telemetry.
- **Alternatives considered**: Logging raw exceptions was rejected because SDK messages may contain identity context.

## Android build metadata compatibility

- **Decision**: Compile the Android application and Android library subprojects against API 36 while keeping target behavior unchanged and minimum install API at 28.
- **Rationale**: `privy_flutter` 0.10.1 fixes its own library compile SDK at 34, while its resolved Privy Core AndroidX dependencies require compile SDK 35. Other existing native plugins require compile SDK 36, so the host uses the highest installed requirement. Host-level library compile metadata makes the published dependency graphs link without bypassing minimum-runtime checks.
- **Alternatives considered**: `tools:overrideLibrary` was rejected because it bypasses a real minimum-API safety check; forcing older transitive AndroidX packages was rejected because it changes the provider-tested dependency graph.
