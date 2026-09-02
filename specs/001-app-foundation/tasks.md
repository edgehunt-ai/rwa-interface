# Tasks: Cross-Platform App Foundation

**Input**: Design documents from `/specs/001-app-foundation/`

**Prerequisites**: plan.md, spec.md, research.md, data-model.md, contracts/, quickstart.md

**Tests**: Automated widget tests and a manual iOS checklist are required by the specification.

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Complete project configuration and dependency setup.

- [x] T001 Add `go_router`, localization, and internationalization dependencies in pubspec.yaml
- [x] T002 Configure generated localization in pubspec.yaml and l10n.yaml
- [x] T003 [P] Add initial English application strings in lib/l10n/app_en.arb
- [x] T004 [P] Retain strict analyzer settings and add generated localization exclusions in analysis_options.yaml

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Establish shared theme, test helpers, and application wiring required by every story.

- [x] T005 Create semantic light and dark theme definitions in lib/ui/core/theme/app_theme.dart
- [x] T006 Wire localization, themes, and router into lib/app.dart
- [x] T007 [P] Create configurable widget-test app harness in test/helpers/test_app.dart
- [x] T008 [P] Create viewport and text-scale test helpers in test/helpers/display_config.dart

**Checkpoint**: Theme, localization, application wiring, and test harness are available.

---

## Phase 3: User Story 1 - Navigate Predictably Across Platforms (Priority: P1) 🎯 MVP

**Goal**: Provide centralized URL routing, recovery, history, and platform-standard back behavior.

**Independent Test**: Open root, secondary, direct, and unknown locations; exercise back and web
history behavior and verify the resulting destination.

### Tests for User Story 1

- [x] T009 [P] [US1] Add route parsing, direct-link, not-found, and recovery tests in test/app/routing/app_router_test.dart
- [x] T010 [P] [US1] Add platform page transition and back-contract tests in test/app/routing/platform_navigation_test.dart

### Implementation for User Story 1

- [x] T011 [P] [US1] Define centralized route names and paths in lib/app/routing/routes.dart
- [x] T012 [P] [US1] Create localized not-found view in lib/ui/features/not_found/views/not_found_screen.dart
- [x] T013 [P] [US1] Create a minimal secondary route fixture in lib/ui/features/home/views/details_screen.dart
- [x] T014 [US1] Implement the application router and route recovery in lib/app/routing/app_router.dart
- [x] T015 [US1] Connect root navigation affordances in lib/ui/features/home/views/home_screen.dart

**Checkpoint**: Navigation scenarios work independently on the shared application shell.

---

## Phase 4: User Story 2 - Use Safe, Platform-Appropriate Interfaces (Priority: P1)

**Goal**: Keep interactions familiar and essential content reachable around system UI and keyboards.

**Independent Test**: Render page layouts and each adaptive interaction for target platforms with
representative insets, orientation, and keyboard conditions.

### Tests for User Story 2

- [x] T016 [P] [US2] Add safe-area, landscape, and keyboard layout tests in test/ui/core/layout/app_page_scaffold_test.dart
- [x] T017 [P] [US2] Add platform-variant tests for adaptive controls in test/ui/core/adaptive/adaptive_controls_test.dart

### Implementation for User Story 2

- [x] T018 [P] [US2] Implement the page-level safe and keyboard-aware shell in lib/ui/core/layout/app_page_scaffold.dart
- [x] T019 [P] [US2] Implement adaptive progress and switch controls in lib/ui/core/adaptive/app_adaptive_controls.dart
- [x] T020 [P] [US2] Implement adaptive alert and action-sheet contracts in lib/ui/core/adaptive/app_adaptive_dialogs.dart
- [x] T021 [P] [US2] Implement adaptive bounded date selection in lib/ui/core/adaptive/app_adaptive_date_picker.dart

**Checkpoint**: Layout and system-sensitive controls can be tested without business screens.

---

## Phase 5: User Story 3 - Understand and Recover from Common States (Priority: P2)

**Goal**: Provide consistent loading, empty, error, recovery, and safe-copy experiences.

**Independent Test**: Render every state, invoke optional recovery, copy safe references, and verify
clipboard value, prohibited handling, and accessible feedback.

### Tests for User Story 3

- [x] T022 [P] [US3] Add loading, empty, error, and recovery tests in test/ui/core/feedback/app_feedback_state_test.dart
- [x] T023 [P] [US3] Add full-value copy, feedback, and prohibited-value tests in test/ui/core/feedback/copyable_text_test.dart

### Implementation for User Story 3

- [x] T024 [P] [US3] Implement loading, empty, and error state components in lib/ui/core/feedback/app_feedback_state.dart
- [x] T025 [P] [US3] Implement safe full-value copy behavior in lib/ui/core/feedback/copyable_text.dart

**Checkpoint**: Feedback and copy contracts operate independently with localized content.

---

## Phase 6: User Story 4 - Read Content Under Real-World Display Conditions (Priority: P2)

**Goal**: Preserve meaning and operability across appearance, width, long content, and text scaling.

**Independent Test**: Run the foundation component matrix in light/dark appearance, narrow/wide
viewports, long strings, unbroken identifiers, and 200% text scaling.

### Tests for User Story 4

- [x] T026 [P] [US4] Add light/dark semantic-theme tests in test/ui/core/theme/app_theme_test.dart
- [x] T027 [P] [US4] Add long-text and 200% scale matrix tests in test/ui/core/foundation_accessibility_test.dart

### Implementation for User Story 4

- [x] T028 [US4] Refine long-text and accessibility contracts across lib/ui/core/feedback/ and lib/ui/core/adaptive/
- [x] T029 [US4] Add semantic long-identifier display behavior to lib/ui/core/feedback/copyable_text.dart

**Checkpoint**: Foundation components remain readable and operable across the specified matrix.

---

## Phase 7: Polish & Cross-Cutting Concerns

**Purpose**: Complete cross-platform review and final quality gates.

- [x] T030 [P] Create the repeatable iOS manual checklist and record current environment status in specs/001-app-foundation/checklists/ios-manual.md
- [x] T031 Verify component ownership, reuse checks, and file-size thresholds across lib/ and test/
- [x] T032 Run every command and scenario in specs/001-app-foundation/quickstart.md
- [x] T033 Reconcile completed behavior and evidence with specs/001-app-foundation/spec.md and specs/001-app-foundation/tasks.md

---

## Dependencies & Execution Order

### Phase Dependencies

- Setup has no dependency.
- Foundational depends on Setup and blocks all user stories.
- US1 and US2 can proceed independently after Foundational.
- US3 can proceed after Foundational and does not require navigation.
- US4 depends on the shared components delivered by US2 and US3.
- Polish depends on all selected stories.

### Parallel Opportunities

- T003 and T004 can run in parallel after dependency selection.
- T007 and T008 can run in parallel with theme implementation.
- US1 route tests and view fixtures can be prepared in parallel.
- US2 layout, control, dialog, and picker files are independently implementable.
- US3 feedback state and copy behavior are independently implementable.
- US1, US2, and US3 can run in parallel after Phase 2 when staffed.

## Parallel Example: User Story 2

```text
Task T016: Test safe-area and keyboard page shell.
Task T017: Test adaptive platform variants.
Task T019: Implement adaptive progress and switch.
Task T020: Implement adaptive alert and action sheet.
Task T021: Implement adaptive date selection.
```

## Implementation Strategy

### MVP First

1. Complete Setup and Foundational phases.
2. Complete US1 centralized navigation.
3. Validate root, secondary, direct, unknown, and back routes.

### Incremental Delivery

1. Add safe layout and adaptive interactions through US2.
2. Add common feedback and copy behavior through US3.
3. Validate appearance and text resilience through US4.
4. Complete manual iOS and automated quality gates.

## Notes

- Tests are written before their corresponding implementation and must initially fail.
- `[P]` marks work in separate files without incomplete dependencies.
- No task adds authentication, markets, portfolio, positions, trading, or iOS integration tests.
