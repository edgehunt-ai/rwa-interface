# Contract: Authentication Boundary

## Identity gateway

The application-facing gateway provides:

- initialize from trusted App ID and Client ID;
- inspect restored identity state;
- request an email code;
- verify an email code;
- retrieve the current access token;
- refresh the current identity and retrieve a replacement token;
- logout and clear provider persistence.

Every operation returns owned success/failure outcomes. SDK users, results,
exceptions, channels, and token-refresh credentials do not cross this boundary.

## Riverpod authentication controller

Commands:

- `bootstrap(language?)`
- `requestEmailCode(email)`
- `verifyEmailCode(code, language?)`
- `logout()`

Observers receive the explicit states in `data-model.md`. Commands are idempotent
while the same operation is active, and stale completions cannot replace newer
state. The controller establishes a product session before publishing authenticated.

## Existing API token adapter

The concrete identity gateway implements `PrivyAccessTokenProvider`:

- `getAccessToken()` returns null when unauthenticated;
- `refreshAccessToken()` refreshes the current provider user then returns its token;
- `onAuthenticationExpired()` clears provider identity and application user scope.

The existing HTTP interceptor remains responsible for header attachment,
single-flight recovery, and one replay maximum.
