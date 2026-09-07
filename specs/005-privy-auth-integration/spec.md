# Feature Specification: Privy Authentication Integration

**Feature Branch**: `feat/005-privy-auth-integration`

**Created**: 2026-09-04

**Status**: Draft

**Input**: User description: "接入 Privy SDK 的实际登录集成；本阶段不实现最终 UI，不修改 OpenAPI。"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Restore an Existing Login (Priority: P1)

As a returning mobile user, I want the application to restore my existing identity and product session so that I can continue without signing in again.

**Why this priority**: Every authenticated request depends on a reliable identity bootstrap and a valid product session.

**Independent Test**: Start the application with either a valid, expired, or absent identity session and verify the resulting authentication state and product-session exchange.

**Acceptance Scenarios**:

1. **Given** a supported mobile platform and a valid persisted identity session, **When** authentication initializes, **Then** the application obtains an access token, establishes the product session, and exposes the authenticated account.
2. **Given** no persisted identity session, **When** authentication initializes, **Then** the application exposes an unauthenticated state without treating it as an error.
3. **Given** identity initialization or product-session establishment fails, **When** bootstrap completes, **Then** the application exposes a recoverable domain failure without leaking SDK exceptions or credentials.

---

### User Story 2 - Sign In with Email Code (Priority: P1)

As a signed-out user, I want to request and verify a one-time code sent to my email so that I can authenticate without a password.

**Why this priority**: Email code login is the initial supported interactive sign-in method and makes the authentication integration usable.

**Independent Test**: Request a code for a valid email, submit both a valid and invalid code, and verify state transitions and product-session creation.

**Acceptance Scenarios**:

1. **Given** authentication is ready and the code-defined login methods allow email, **When** a user submits a valid email address, **Then** a one-time code is requested and the application enters a code-required state retaining the normalized email.
2. **Given** a code has been requested, **When** the user submits a valid code, **Then** identity authentication succeeds, a product session is established, the authoritative wallet is synchronized, and only then is the authenticated account exposed.
3. **Given** an invalid email, unsupported login method, invalid code, expired code, cancellation, or network failure, **When** the operation completes, **Then** the application exposes a safe, actionable failure and permits retry without retaining the code.

---

### User Story 3 - Authorize API Requests and Recover from Expiry (Priority: P1)

As an authenticated user, I want API requests to use my current identity access token and recover once from token expiry so that normal application operations remain authorized.

**Why this priority**: A login that is not connected to the existing API boundary does not create a functional product session.

**Independent Test**: Execute authenticated requests with valid and expired tokens and verify token injection, one refresh attempt, request replay, and fail-closed logout behavior.

**Acceptance Scenarios**:

1. **Given** an authenticated identity, **When** an API request is made, **Then** the current access token is supplied through the existing authorization boundary.
2. **Given** an authenticated request receives an unauthorized response, **When** token recovery succeeds, **Then** concurrent failures share one recovery operation and each request is retried at most once.
3. **Given** token recovery fails or the retried request is unauthorized, **When** recovery completes, **Then** local authenticated state and account-scoped state are cleared and the application requires a fresh login.

---

### User Story 4 - Log Out Safely (Priority: P2)

As an authenticated user, I want to log out so that identity credentials, the product session, and account-scoped application state are no longer usable on the device.

**Why this priority**: Explicit logout is a required security and shared-device control.

**Independent Test**: Log out from an authenticated state under both successful and failed remote conditions and verify the local identity and account state are cleared.

**Acceptance Scenarios**:

1. **Given** an authenticated user, **When** logout is requested, **Then** the identity session and all account-scoped application state are cleared and subsequent API requests carry no prior token.
2. **Given** remote logout reports a failure, **When** logout completes, **Then** the application still fails closed locally and exposes a safe recoverable failure if user action is needed.

### Edge Cases

- Authentication is requested on web or desktop, where the selected identity SDK is unavailable.
- Build-time public Privy configuration is absent or malformed.
- Multiple initialization, code request, code verification, logout, or expiry callbacks overlap.
- The user changes identity while an earlier product-session request is still in flight.
- A token is unavailable despite an authenticated SDK state, or a token becomes invalid during request replay.
- The application is resumed after the identity session expires while suspended.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The system MUST obtain the public Privy App ID and mobile Client ID from compile-time environment variables, MUST validate both before SDK initialization, and MUST NOT store provider secrets in source code or build parameters.
- **FR-002**: The system MUST initialize identity authentication only on supported mobile platforms and MUST expose a deterministic unsupported-capability failure elsewhere without crashing application startup.
- **FR-003**: The system MUST expose authentication readiness as explicit initializing, unauthenticated, awaiting-code, authenticating, authenticated, and failure states.
- **FR-004**: The system MUST restore a valid persisted identity session during startup and exchange it for the existing product session.
- **FR-005**: The system MUST support requesting an email one-time code when email is enabled by the centralized code-defined login-method configuration.
- **FR-006**: The system MUST normalize and validate an email address before requesting a code and MUST reject empty or structurally invalid input locally.
- **FR-007**: The system MUST support verifying the one-time code against the same email for which it was requested and MUST discard code values after submission.
- **FR-008**: After successful identity authentication, the system MUST establish the existing product session and synchronize the authoritative wallet before exposing the user as fully authenticated.
- **FR-009**: The identity integration MUST implement the existing access-token boundary so API infrastructure can retrieve a current token, refresh identity state, and react to terminal authentication expiry.
- **FR-010**: Token recovery MUST be single-flight for concurrent unauthorized responses, MUST retry each request no more than once, and MUST fail closed when recovery cannot restore authorization.
- **FR-011**: Logout and terminal authentication expiry MUST clear identity credentials, product-session state, and account-scoped state.
- **FR-012**: Repeated or overlapping authentication commands MUST not publish stale results or establish a session for a superseded identity.
- **FR-013**: SDK errors, provider error details, access tokens, one-time codes, email addresses, and stack traces MUST NOT be exposed to users or written to ordinary logs, analytics, or crash metadata.
- **FR-014**: All identity SDK results and exceptions MUST be mapped at the integration boundary into stable domain outcomes with retry guidance where applicable.
- **FR-015**: The system MUST allow authentication behavior to be replaced with deterministic test doubles without invoking native platform channels.
- **FR-016**: This feature MUST NOT add final login screens, social/passkey/wallet login, wallet signing, or HTTP/OpenAPI contract changes.

### Key Entities

- **Authentication Configuration**: Public environment-specific identity application identifiers supplied at build time and enabled login methods centralized in code.
- **Identity Session**: The provider-owned authenticated identity and its short-lived access-token capability; refresh credentials remain owned by the provider SDK.
- **Authentication State**: The application-visible lifecycle of initialization, email challenge, verification, authenticated product session, logout, and safe failure.
- **Product Session**: The backend-issued application session and account created from a successfully authenticated identity token.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Automated tests demonstrate all authentication states and every acceptance scenario without requiring native platform channels.
- **SC-002**: With a valid persisted identity, startup reaches an authenticated product session through one identity restoration and one product-session exchange.
- **SC-003**: Valid email-code login reaches an authenticated product session; invalid and expired codes preserve retry capability while never retaining or exposing the submitted code.
- **SC-004**: A burst of concurrent unauthorized responses triggers exactly one token recovery, retries each affected request at most once, and clears authentication if recovery fails.
- **SC-005**: Unsupported platforms start normally and report authentication as unavailable rather than throwing an unhandled platform exception.
- **SC-006**: Static analysis, formatting, dependency resolution, and all relevant automated tests pass on the implementation branch.

## Assumptions

- The first interactive login method is email one-time code; other methods are separate future features.
- The current identity SDK release requires Android API 28+ and iOS 17+; web and desktop retain the rest of the application but do not offer authentication in this feature.
- The existing product-session and wallet-sync endpoints are sufficient and remain unchanged; Flutter no longer depends on the authentication-configuration endpoint at startup.
- The final authentication UI will consume the application state and commands delivered here in a later design-led feature.
- Provider application and client identifiers are public configuration values supplied through `--dart-define`; no provider secret is stored in the client.
