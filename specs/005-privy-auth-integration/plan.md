# Implementation Plan: Privy Authentication Integration

**Branch**: `feat/005-privy-auth-integration` | **Date**: 2026-09-04 | **Spec**: [spec.md](spec.md)

**Input**: Feature specification from `/specs/005-privy-auth-integration/spec.md`

**Note**: This template is filled in by the `$speckit-plan` command; its definition describes the execution workflow.

## Summary

Add the official Privy Flutter SDK behind a narrow identity gateway, expose an
application-owned Riverpod authentication state machine for startup restoration
and email OTP login, and adapt the authenticated Privy user to the existing API
token and product-session boundaries. Native platform channels remain confined to
Android/iOS; test doubles and an unsupported adapter keep tests and other targets
deterministic. No final login UI or HTTP contract changes are included.

## Technical Context

<!--
  ACTION REQUIRED: Replace the content in this section with the technical details
  for the project. The structure here is presented in advisory capacity to guide
  the iteration process.
-->

**Language/Version**: Dart ^3.13.0, Flutter 3.24+

**Primary Dependencies**: Flutter, Riverpod 3, Dio 5, generated `rwa_api_client`, `privy_flutter` 0.10.1

**Storage**: Provider-owned secure identity persistence; no application token storage

**Testing**: `flutter_test`, focused gateway/provider unit tests, existing API interceptor tests

**Target Platform**: Android API 28+, iOS 17+; explicit unavailable state on web/macOS/Windows/Linux

**Project Type**: Cross-platform Flutter application with mobile-only authentication capability

**Performance Goals**: One SDK initialization and product-session exchange per bootstrap; one refresh for a concurrent 401 burst

**Constraints**: Android compiles app/library modules with API 36 and installs on API 28+; no raw SDK types above integration boundary; no credential logging/storage; fail closed; no OpenAPI or final UI changes

**Scale/Scope**: One identity provider, email OTP only, one authentication state machine, existing product-session and HTTP token paths

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- **Specification and traceability**: PASS. `spec.md` defines prioritized, testable flows; tasks and tests will cite story/requirement identifiers.
- **Layering**: PASS. SDK calls stay in `data/auth`; domain contracts and application state contain no SDK types; Riverpod coordinates use cases.
- **Correctness and tests**: PASS. Gateway result mapping, state transitions, stale completions, unsupported targets, logout, and token refresh receive focused tests.
- **Security and privacy**: PASS. Privy owns refresh persistence; code/token values are transient and never logged; failure paths clear user scope.
- **UX states**: PASS for this non-UI feature. Explicit states and recovery semantics are delivered for the future design-led UI.
- **Modularity/rendering**: PASS. No widget changes; consumers can select minimal authentication state fields later.
- **Dependency**: PASS. `privy_flutter` is the provider-supported native implementation required for real authentication and is isolated behind an owned gateway.
- **Contract discipline**: PASS. Existing HTTP endpoints and generated client remain unchanged.

Post-design re-check: PASS. Contracts preserve the Riverpod → repository/session and gateway → SDK boundaries; no constitutional exception is required.

## Project Structure

### Documentation (this feature)

```text
specs/005-privy-auth-integration/
├── plan.md              # This file ($speckit-plan command output)
├── research.md          # Phase 0 output ($speckit-plan command)
├── data-model.md        # Phase 1 output ($speckit-plan command)
├── quickstart.md        # Phase 1 output ($speckit-plan command)
├── contracts/           # Phase 1 output ($speckit-plan command)
└── tasks.md             # Phase 2 output ($speckit-tasks command - NOT created by $speckit-plan)
```

### Source Code (repository root)
<!--
  ACTION REQUIRED: Replace the placeholder tree below with the concrete layout
  for this feature. Delete unused options and expand the chosen structure with
  real paths (e.g., apps/admin, packages/something). The delivered plan must
  not include Option labels.
-->

```text
lib/
├── app/providers/             # SDK/gateway injection and existing API wiring
├── data/auth/                 # Privy adapter and unsupported implementation
├── data/api/                  # Existing access-token interceptor boundary
├── domain/auth/               # SDK-independent contracts, state, failures
└── ui/features/session/providers/ # Riverpod authentication orchestration

test/
├── data/auth/                 # Adapter result mapping tests
└── ui/features/session/       # State-machine and session exchange tests
```

**Structure Decision**: Extend the existing layered Flutter project. Provider SDK
types are restricted to `lib/data/auth`; authentication behavior exposed to the
application is expressed by owned domain contracts. Existing session repository
and API interceptor boundaries are reused rather than duplicated.

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
No constitution violations require tracking.
