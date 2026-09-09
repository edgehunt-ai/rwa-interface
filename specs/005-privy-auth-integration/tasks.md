# Tasks: Privy Authentication Integration

**Input**: Design documents from `/specs/005-privy-auth-integration/`

**Prerequisites**: plan.md, spec.md, research.md, data-model.md, contracts/, quickstart.md

**Tests**: Required by SC-001 and constitution principle III; write focused tests before each implementation slice.

## Phase 1: Setup (Shared Infrastructure)

- [X] T001 Add the pinned Privy Flutter dependency and resolve the lockfile in pubspec.yaml and pubspec.lock
- [X] T002 [P] Raise Android minimum SDK to API 28 in android/app/build.gradle.kts
- [X] T003 [P] Raise iOS deployment target to 17.0 consistently in ios/Runner.xcodeproj/project.pbxproj

---

## Phase 2: Foundational (Blocking Prerequisites)

- [X] T004 [P] Define SDK-independent authentication state, failure, configuration, and principal models in lib/domain/auth/authentication.dart
- [X] T005 [P] Define the identity authentication gateway contract in lib/domain/auth/identity_auth_gateway.dart
- [X] T006 Add deterministic fake gateway coverage for all owned result types in test/helpers/fake_identity_auth_gateway.dart and test/domain/auth/authentication_test.dart
- [X] T007 Implement supported-platform selection and unsupported gateway behavior in lib/data/auth/identity_auth_gateway_factory.dart and lib/data/auth/unsupported_identity_auth_gateway.dart
- [X] T008 Wire gateway and authentication controller dependencies through Riverpod in lib/app/providers/auth_providers.dart and lib/app/providers/api_providers.dart

**Checkpoint**: SDK-independent authentication foundation can be exercised without native channels.

---

## Phase 3: User Story 1 - Restore an Existing Login (Priority: P1) 🎯 MVP

**Goal**: Restore provider identity and exchange it for the existing product session.

**Independent Test**: Bootstrap with valid, absent, failed, and stale restored identities and verify application states.

- [X] T009 [P] [US1] Add Privy adapter tests for initialization, restored identity, absent identity, and safe failures in test/data/auth/privy_identity_auth_gateway_test.dart
- [X] T010 [P] [US1] Add authentication controller bootstrap and stale-completion tests in test/ui/features/session/providers/authentication_provider_test.dart
- [X] T011 [US1] Implement Privy initialization, auth-state inspection, result mapping, and current-user ownership in lib/data/auth/privy_identity_auth_gateway.dart
- [X] T012 [US1] Implement bootstrap, build-time configuration validation, product-session exchange, and authoritative wallet sync in lib/ui/features/session/providers/authentication_provider.dart
- [X] T013 [US1] Connect the production platform factory to the Privy adapter in lib/data/auth/identity_auth_gateway_factory.dart

**Checkpoint**: A persisted Privy identity restores to a usable backend product session.

---

## Phase 4: User Story 2 - Sign In with Email Code (Priority: P1)

**Goal**: Request and verify an email OTP and establish the product session.

**Independent Test**: Exercise valid/invalid emails, disabled email method, send failures, valid/invalid OTPs, and repeated submissions.

- [X] T014 [P] [US2] Extend Privy adapter tests for email send and verification result mapping in test/data/auth/privy_identity_auth_gateway_test.dart
- [X] T015 [P] [US2] Extend controller tests for validation, awaiting-code state, verification, retry, and OTP non-retention in test/ui/features/session/providers/authentication_provider_test.dart
- [X] T016 [US2] Implement email code request and verification in lib/data/auth/privy_identity_auth_gateway.dart
- [X] T017 [US2] Implement email normalization, code-defined method gating, challenge state, verification, backend session exchange, and wallet sync in lib/ui/features/session/providers/authentication_provider.dart

**Checkpoint**: Email OTP login produces an authenticated product session without a final UI.

---

## Phase 5: User Story 3 - Authorize API Requests and Recover from Expiry (Priority: P1)

**Goal**: Supply real Privy tokens to the existing API interceptor and fail closed after terminal expiry.

**Independent Test**: Verify token retrieval, refresh ordering, concurrent 401 single-flight behavior, retry limit, and authentication cleanup.

- [X] T018 [P] [US3] Add adapter token retrieval, refresh, and expiry cleanup tests in test/data/auth/privy_identity_auth_gateway_test.dart
- [X] T019 [P] [US3] Verify concrete gateway delegation, null-token expiry cleanup, and existing interceptor retry semantics in test/app/providers/api_providers_test.dart and test/data/api/privy_auth_interceptor_test.dart
- [X] T020 [US3] Implement PrivyAccessTokenProvider token, refresh, and terminal expiry behavior in lib/data/auth/privy_identity_auth_gateway.dart
- [X] T021 [US3] Connect expiry cleanup to authentication and session-generation state in lib/app/providers/auth_providers.dart and lib/ui/features/session/providers/authentication_provider.dart

**Checkpoint**: Existing repositories are authorized by the real provider session and fail closed on expiry.

---

## Phase 6: User Story 4 - Log Out Safely (Priority: P2)

**Goal**: Clear provider identity, backend session, and all account-scoped application state.

**Independent Test**: Log out under successful, expired-backend, and provider-failure conditions and verify local state is unauthenticated.

- [X] T022 [P] [US4] Add controller logout ordering and fail-closed tests in test/ui/features/session/providers/authentication_provider_test.dart
- [X] T023 [US4] Implement provider logout and safe failure mapping in lib/data/auth/privy_identity_auth_gateway.dart
- [X] T024 [US4] Implement coordinated backend/provider logout and unconditional user-scope clearing in lib/ui/features/session/providers/authentication_provider.dart

**Checkpoint**: Logout leaves no prior token or account-scoped state usable.

---

## Phase 7: Polish & Cross-Cutting Concerns

- [X] T025 [P] Document real-device staging prerequisites and unsupported targets in README.md and specs/005-privy-auth-integration/quickstart.md
- [X] T026 Audit changed files for raw SDK exceptions, credential logging, TODOs, and architectural boundary leaks
- [X] T027 Run Dart formatting, Flutter analysis, focused authentication tests, and the full Flutter test suite from specs/005-privy-auth-integration/quickstart.md
- [ ] T028 Perform the supported-device staging smoke test when registered Privy staging credentials and an OTP inbox are available, recording only non-sensitive outcomes in specs/005-privy-auth-integration/quickstart.md

---

## Dependencies & Execution Order

- Phase 1 precedes Phase 2; Phase 2 blocks all stories.
- US1 establishes SDK/bootstrap ownership and precedes US2 and US3 integration.
- US2 and US3 can proceed independently after US1; US4 depends on shared gateway/controller ownership from US1.
- Polish follows all selected stories. T028 is environment-dependent and does not block deterministic automated validation.

## Parallel Opportunities

- T002 and T003 are independent platform configuration changes.
- T004 and T005 define separate model and behavior contracts.
- Within each story, adapter tests and controller/interceptor tests touch separate files and can be authored in parallel.
- Documentation T025 can proceed while implementation is audited.

## Implementation Strategy

1. Deliver setup and the SDK-independent gateway boundary.
2. Implement US1 as the MVP: restored identity to product session.
3. Add US2 interactive email OTP and US3 real API authorization.
4. Add US4 fail-closed logout.
5. Run automated gates, then execute the staging smoke test when external prerequisites are available.

Every task follows the required checkbox, sequential ID, optional parallel marker,
story label, concrete action, and file-path format.
