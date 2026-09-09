# Data Model: Privy Authentication Integration

## IdentityConfiguration

- `appId`: required non-empty provider application identifier
- `clientId`: required non-empty mobile client identifier

Derived from the compile-time `PRIVY_APP_ID` and `PRIVY_CLIENT_ID` values; not persisted by the feature. Enabled login methods are held separately in the centralized `PrivyConfiguration.loginMethods` constant.

## IdentityPrincipal

- `id`: opaque provider identity identifier

Owns no token value. It represents the provider user needed by the gateway to retrieve or refresh a token.

## EmailChallenge

- `email`: trimmed, normalized email associated with the active challenge
- `requestedAt`: optional diagnostic timestamp without the submitted code

The OTP itself is never placed in application state and is discarded after the SDK call.

## AuthenticationState

Variants:

1. `initializing`
2. `unauthenticated`
3. `awaitingCode(email)`
4. `authenticating(email?)`
5. `authenticated(ProductSession)`
6. `failure(AuthenticationFailure, recoverableState)`
7. `unsupported(AuthenticationFailure)`

Transitions:

```text
initializing -> unauthenticated | authenticating -> authenticated | failure | unsupported
unauthenticated -> awaitingCode | failure
awaitingCode -> authenticating -> authenticated | awaitingCode-with-failure
authenticated -> unauthenticated (logout/expiry) | failure
any supported state -> initializing (retry/bootstrap)
```

Only the latest operation epoch may publish a transition.

## AuthenticationFailure

- `code`: stable category (`invalidInput`, `methodUnavailable`, `invalidCode`, `network`, `configuration`, `expired`, `provider`, `unsupportedPlatform`)
- `retryable`: whether repeating the user operation can recover
- `safeMessageKey`: localizable presentation key, never a raw SDK message

## Relationship to ProductSession

An identity login is necessary but not sufficient for application authentication.
`authenticated` contains the existing `ProductSession` only after the backend
session exchange succeeds for the current session generation.
