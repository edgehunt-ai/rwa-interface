# Tasks: Implement Figma Screens

**Input**: Design documents from `/specs/006-implement-figma-screens/`

**Prerequisites**: [plan.md](plan.md), [spec.md](spec.md), [research.md](research.md), [data-model.md](data-model.md), [UI state contract](contracts/ui-state-contract.md), [quickstart.md](quickstart.md)

**Tests**: Provider, widget, and acceptance tests are required because this feature changes financial actions, critical UI states, navigation, and formatting-sensitive displays.

## Requirement traceability

| Requirement | Covered by tasks |
|---|---|
| FR-001, FR-011, SC-001 | T001, T009, T021–T024, T036–T038, T046–T047 |
| FR-002, SC-002 | T007, T010–T015, T025–T029, T039–T040 |
| FR-003, FR-006, SC-003 | T006, T011–T015, T018–T020, T025–T030, T033–T035, T040, T043–T045 |
| FR-004 | T004, T010–T015, T025–T029, T039–T041 |
| FR-005 | T005, T010–T015, T019–T020, T025–T030, T033–T035, T040 |
| FR-007 | T006, T010–T015, T018, T025–T030, T033, T040, T043 |
| FR-008 | T006, T020, T040, T044–T045 |
| FR-009, SC-005 | T002, T006, T008, T019, T034, T044, T049–T050 |
| FR-010 | T003, T016, T031, T041, T047, T049 |
| SC-004 | T020, T035, T045, T049–T050 |

## Phase 1: Setup and traceability

**Purpose**: Make the 86-item design inventory executable without confusing routes, overlays, and component references.

- [X] T001 Verify the 86-item traceability matrix (node ID, canvas order, type, initial parent context, and `listed` status) in `specs/006-implement-figma-screens/screen-inventory.md`
- [X] T002 [P] Add the iOS 17+/Android API 28+/web-N/A support matrix and enlarged-text/localization validation cases to `specs/006-implement-figma-screens/quickstart.md`
- [X] T003 [P] Populate Figma asset provenance, durable asset paths, container size, and leaf size fields in `specs/006-implement-figma-screens/screen-inventory.md`

## Phase 2: Foundational presentation shell

**Purpose**: Establish shared, testable primitives before any journey screen is implemented.

- [X] T004 Define semantic RWA surface, text, border, action, selected, success, warning, and loss theme roles in `lib/ui/core/theme/app_theme.dart`
- [X] T005 [P] Implement shared financial value/price/change presentation wrappers backed by `TokenAmountFormatter` in `lib/ui/core/formatters/token_amount_formatter.dart`
- [X] T006 [P] Implement reusable state feedback in `lib/ui/core/feedback/design_state_feedback.dart`, extending `lib/ui/core/feedback/app_feedback_state.dart` and `lib/ui/core/feedback/copyable_text.dart`
- [X] T007 Implement the mobile navigation shell and named route contract in `lib/app/routing/routes.dart` and `lib/app/routing/app_router.dart`
- [X] T008 Add core widget tests in `test/ui/core/feedback/design_state_feedback_test.dart` and `test/ui/core/layout/app_page_scaffold_test.dart`

**Checkpoint**: Shared shell preserves existing Riverpod/repository boundaries and is ready for feature composition.

## Phase 3: User Story 1 — Home, Markets, Assets, and Funding (Priority: P1) 🎯 MVP

**Goal**: Deliver the Home/Market/Asset/Funding journeys and every matching route, overlay, or component state from the 22-item region.

**Independent Test**: With representative provider fixtures, a user can enter Home, Market, Assets, Deposit, and Withdraw flows; operate navigation/search/filter/asset selection; and see clear loading, empty, unavailable, pending, success, and failure outcomes.

### Design reading and traceability

- [X] T009 [US1] Read and classify the 22 Home/Markets nodes in exact inventory order (`59:122` through `458:3017`), record concrete parent/return paths and asset provenance in `specs/006-implement-figma-screens/screen-inventory.md`

### Implementation

- [X] T010 [US1] Implement node `59:122` Home portfolio summary, quick actions, favorites ranking, product filter, and bottom navigation in `lib/ui/features/home/views/home_screen.dart`
- [X] T011 [P] [US1] Implement nodes `202:2490`, `224:1576`, `202:2574`, and `322:1385` Market overview/filter/status states in `lib/ui/features/markets/views/market_screen.dart`
- [X] T012 [P] [US1] Implement nodes `202:2546`, `206:717`, `206:728`, and `215:1014` stock browse/search states in `lib/ui/features/markets/views/market_search_screen.dart`
- [X] T013 [P] [US1] Implement nodes `345:1501`, `381:1730`, `408:4409`, `408:4210`, `388:2941`, and `396:1917` asset overview variants in `lib/ui/features/portfolio/views/assets_screen.dart`
- [X] T014 [US1] Implement nodes `256:1110`, `285:2040`, and `286:1786` deposit route/details states in `lib/ui/features/funding/views/deposit_screen.dart`
- [X] T015 [US1] Implement nodes `458:2963`, `458:3017`, `458:2889`, and `458:2921` withdrawal picker, entry, and review states in `lib/ui/features/funding/views/withdrawal_screen.dart`
- [X] T016 [US1] Persist Home/Markets/Assets/Funding assets and their rendered geometry in `assets/figma/home_markets/`, `pubspec.yaml`, and `specs/006-implement-figma-screens/screen-inventory.md`
- [X] T017 [US1] Add Home/Markets/Assets/Funding ARB keys in `lib/l10n/app_en.arb`

### Tests

- [X] T018 [P] [US1] Add market/funding provider tests in `test/ui/features/markets/providers/market_providers_test.dart`, `test/ui/features/funding/providers/deposit_providers_test.dart`, and `test/ui/features/funding/providers/withdrawal_providers_test.dart`
- [X] T019 [P] [US1] Add Home, Market, Assets, and Funding widget tests in `test/ui/features/home/figma_screen_states_test.dart`, `test/ui/features/markets/figma_screen_states_test.dart`, `test/ui/features/portfolio/figma_screen_states_test.dart`, and `test/ui/features/funding/figma_screen_states_test.dart`
- [X] T020 [US1] Add funding acceptance coverage in `test/acceptance/funding_flow_test.dart`
- [X] T021 [US1] Mark all 22 Home/Markets items implemented and verified only after the node-specific tests pass in `specs/006-implement-figma-screens/screen-inventory.md`

**Checkpoint**: The P1 mobile shell and account/discovery/funding journey is independently demonstrable.

## Phase 4: User Story 2 — Trade and Foundation Cleanup (Priority: P2)

**Goal**: Deliver all 54 Trade/Foundation design variants while keeping bStocks, HIP-3, order validation, and financial confirmation semantics explicit.

**Independent Test**: With representative bStocks and perpetual fixtures, the user can visit each trade variation, select chart/order/price/time state, and is prevented from submitting invalid or unsupported actions.

### Design reading and traceability

- [X] T022 [US2] Read and classify Trade inventory rows 1–18 in exact matrix order and record parent/return paths in `specs/006-implement-figma-screens/screen-inventory.md`
- [X] T023 [US2] Read and classify Trade inventory rows 19–36 in exact matrix order and record parent/return paths in `specs/006-implement-figma-screens/screen-inventory.md`
- [X] T024 [US2] Read and classify Trade inventory rows 37–54 in exact matrix order and record parent/return paths in `specs/006-implement-figma-screens/screen-inventory.md`

### Implementation

- [X] T025 [US2] Implement trade nodes `513:17082`, `513:17402`, `513:17285`, and `513:17185` for default/time/chart/reference-price states in `lib/ui/features/orders/views/trade_screen.dart`
- [X] T026 [US2] Implement bStocks nodes `513:16964`, `513:18066`, `513:19064`, `543:16239`, `543:16418`, `543:16591`, `543:16764`, `543:16937`, `543:17110`, and `543:17283` in `lib/ui/features/orders/views/bstocks_order_panel.dart`
- [X] T027 [US2] Implement bStocks nodes `543:20394`, `513:16723`, `513:20368`, `513:18951`, `543:18062`, `543:18216`, `543:18370`, `577:23970`, `513:22190`, `513:20553`, `543:19583`, `513:22446`, `543:19785`, `513:16809`, `513:22318`, and `543:20139` in `lib/ui/features/orders/views/bstocks_order_panel.dart`
- [X] T028 [US2] Implement HIP-3/close nodes `513:21271`, `513:17694`, `513:17796`, `513:18650`, `513:21826`, `579:24502`, `579:25070`, `513:17594`, `543:11041`, `543:11270`, `543:11376`, `513:18439`, `513:17919`, `513:21641`, `513:21456`, `543:11158`, and `543:12636` in `lib/ui/features/orders/views/hip3_order_panel.dart`
- [X] T029 [US2] Implement overlay/component-reference nodes `543:13079`, `513:23349`, `543:13208`, `513:23345`, and `513:23347` in `lib/ui/features/orders/widgets/trade_overlays.dart`
- [X] T030 [US2] Map `OrderIntent`, order preview, position, and API/domain failure conditions to explicit trade state without direct client calls in `lib/ui/features/orders/providers/order_providers.dart`
- [X] T031 [US2] Persist trade assets and geometry in `assets/figma/trade/`, `pubspec.yaml`, and `specs/006-implement-figma-screens/screen-inventory.md`
- [X] T032 [US2] Add trade labels, validation, status, confirmation, and recoverable-error copy in `lib/l10n/app_en.arb`

### Tests

- [X] T033 [P] [US2] Add trade state-provider tests in `test/ui/features/orders/providers/order_providers_test.dart`
- [X] T034 [P] [US2] Add bStocks/HIP-3 widget-state tests in `test/ui/features/orders/views/bstocks_order_panel_test.dart`, `test/ui/features/orders/views/hip3_order_panel_test.dart`, and `test/ui/features/orders/views/trade_overlays_test.dart`
- [X] T035 [US2] Add trade acceptance coverage in `test/acceptance/order_position_flow_test.dart`
- [X] T036 [US2] Mark all 54 Trade/Foundation items implemented and verified only after the node-specific tests pass in `specs/006-implement-figma-screens/screen-inventory.md`

**Checkpoint**: Trade states preserve product constraints, confirmation semantics, and financially safe failure behavior.

## Phase 5: User Story 3 — Settings and Activity (Priority: P3)

**Goal**: Deliver six Settings variations and four Activity states with safe navigation, detailed status, and copyable references.

**Independent Test**: A user can reach Settings and Activity, switch the available variants, and receive clear empty/loading/partial/failure outcomes without losing context.

### Design reading and traceability

- [X] T037 [US3] Read and classify the six Settings nodes (`527:9559`, `461:6587`, `461:6678`, `461:6764`, `461:6858`, `540:10746`) in canvas order in `specs/006-implement-figma-screens/screen-inventory.md`
- [X] T038 [US3] Read and classify the four Activity nodes (`560:20700`, `560:22713`, `560:23164`, `560:23454`) in canvas order in `specs/006-implement-figma-screens/screen-inventory.md`

### Implementation

- [X] T039 [US3] Implement Settings nodes in `lib/ui/features/account/views/settings_screen.dart`
- [X] T040 [US3] Implement Activity nodes in `lib/ui/features/activity/views/activity_screen.dart`
- [X] T041 [US3] Persist Settings/Activity assets and geometry in `assets/figma/account_activity/`, `pubspec.yaml`, and `specs/006-implement-figma-screens/screen-inventory.md`
- [X] T042 [US3] Add Settings and Activity visible copy in `lib/l10n/app_en.arb`

### Tests

- [X] T043 [P] [US3] Add activity provider tests in `test/ui/features/activity/providers/activity_provider_test.dart`
- [X] T044 [P] [US3] Add Settings/Activity widget tests in `test/ui/features/account/figma_screen_states_test.dart` and `test/ui/features/activity/figma_screen_states_test.dart`
- [X] T045 [US3] Add Activity acceptance coverage in `test/acceptance/activity_flow_test.dart`
- [X] T046 [US3] Mark all six Settings and four Activity items implemented and verified only after the node-specific tests pass in `specs/006-implement-figma-screens/screen-inventory.md`

**Checkpoint**: Settings and Activity work independently and preserve return context and data-state clarity.

## Phase 6: Polish and cross-cutting validation

- [X] T047 Validate every traceability-matrix entry has link, type, concrete parent/return context, durable asset provenance, and final status in `specs/006-implement-figma-screens/screen-inventory.md`
- [X] T048 [P] Run and repair formatting/static analysis with `dart format lib test`, `flutter analyze`, and the relevant targeted test files under `test/`
- [X] T049 [P] Run the manual Figma-to-app, enlarged-text, localization, and asset-geometry checks in `specs/006-implement-figma-screens/quickstart.md`
- [X] T050 Perform a final constitution/API-boundary/financial-precision/accessibility review in `specs/006-implement-figma-screens/quickstart.md`

## Dependencies and execution order

- T001–T003 establish traceability and validation targets.
- T004–T008 are blocking foundations.
- US1 begins with T009 and is the MVP.
- US2 requires the shared shell and follows the 54 items’ exact reading order through T022–T024.
- US3 requires the shared shell and follows its Settings then Activity reading order through T037–T038.
- T047–T050 run after all desired stories are complete.

## Parallel opportunities

- T002/T003 can run in parallel after T001 starts.
- T005/T006 can run in parallel after T004’s token decisions are available.
- In US1, T011/T012/T013 can proceed in parallel after T009; T018/T019 can run together after their implementation targets exist.
- In US2, T033/T034 can run in parallel after T025–T032.
- In US3, T043/T044 can run in parallel after T039–T042.

## Implementation strategy

1. Complete traceability and foundation tasks.
2. Build and validate US1 as the MVP.
3. Read every Trade node in order before implementing its mapped state, then validate US2.
4. Read every Settings and Activity node in order, implement and validate US3.
5. Do not mark a design item verified until its route/state/overlay behavior, assets, accessibility, and tests are complete.
