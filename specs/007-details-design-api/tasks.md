# Tasks: Validate Trade Detail Screens and API Coverage

**Input**: Design documents from `/specs/007-details-design-api/`

**Prerequisites**: [plan.md](plan.md), [spec.md](spec.md), [research.md](research.md), [data-model.md](data-model.md), [audit-matrix.md](audit-matrix.md), [trade screen audit contract](contracts/trade-screen-audit.md), [quickstart.md](quickstart.md)

**Tests**: Widget, provider, and acceptance tests are required for every repaired gap because this feature changes financial actions, navigation context, and data-backed outcomes.

## Phase 1: Setup and audit evidence

**Purpose**: Make the 54 fixed child links independently auditable without adding a parent-layer link.

- [X] T001 Record the authoritative type, entry trigger, return target, component, resource boundary, and existing test for inventory items 1–54 in `specs/007-details-design-api/audit-results.md` using node ID and the existing `specs/006-implement-figma-screens/screen-inventory.md` matrix.
- [X] T002 [P] Add node-ID-aware test helpers and failure messages in `test/ui/features/orders/views/trade_screen_test.dart` for parent-to-overlay route, tab, and dismissal assertions.
- [X] T003 [P] Add a feature traceability assertion for all 54 inventory node IDs in `test/acceptance/requirement_traceability_test.dart`.

**Checkpoint**: Every child item has an auditable owner and the test suite can report missing node evidence.

## Phase 2: Foundational navigation and data boundaries

**Purpose**: Establish the shared guarantees that block all journey audits.

- [X] T004 Verify `/trade`, `/funding/deposit`, and `/funding/withdraw` navigation and back/return behavior without creating routes for overlays or reference frames in `test/app/routing/app_router_test.dart` and `test/app/routing/platform_navigation_test.dart`.
- [X] T005 Document existing order, position, deposit, withdrawal, transfer, market, and chart provider-to-repository mappings and record absent capabilities as `blocked` in `specs/007-details-design-api/audit-results.md`.
- [X] T006 Add a contract-update decision test/checklist for blocked capabilities in `test/acceptance/requirement_traceability_test.dart` and `specs/007-details-design-api/contracts/trade-screen-audit.md`.

**Checkpoint**: Every future repair has a valid route/overlay ownership rule and data-boundary decision.

## Phase 3: User Story 1 — Verified bStocks and funding journeys (Priority: P1) 🎯 MVP

**Goal**: Verify and repair the bStocks order, funding-recovery, position, and open-order journeys with accurate outcomes and return context.

**Independent Test**: From `/trade`, exercise the bStocks child nodes through Buy/Sell, insufficient-funds recovery, pending/terminal outcomes, Position/Open/Details, TP/SL, and withdrawal handoff; each returns to its documented context.

- [X] T007 [P] [US1] Add `/trade`-entry widget coverage for nodes 1–4 (time sheet, chart, reference-price, and retained Details context) in `test/ui/features/orders/views/trade_screen_test.dart`, and bStocks market/limit, insufficient-funds, transfer, review, pending, and terminal states for nodes 5–16 in `test/ui/features/orders/views/bstocks_order_panel_test.dart`.
- [X] T008 [P] [US1] Add parent-to-overlay widget coverage for bStocks Position/Open/Details, TP/SL, sell/preview, and cancellation for non-shared nodes 17–24 and 26–34 in `test/ui/features/orders/views/trade_screen_test.dart`.
- [X] T009 [US1] Repair confirmed bStocks navigation, overlay return-context, or explicit outcome-state gaps in `lib/ui/features/orders/views/trade_screen.dart`, `lib/ui/features/orders/views/bstocks_order_panel.dart`, and `lib/ui/features/orders/views/bstocks_transfer_flow.dart`.
- [X] T010 [US1] Repair confirmed bStocks provider/repository mapping or failure-state gaps in `lib/ui/features/orders/providers/order_providers.dart`, `lib/ui/features/positions/providers/position_providers.dart`, and `lib/ui/features/funding/providers/withdrawal_providers.dart`.
- [X] T011 [US1] Add order/position/funding acceptance regression coverage for every US1 repair, including non-success outcome and return context, in `test/acceptance/order_position_flow_test.dart` and `test/acceptance/funding_flow_test.dart`.
- [X] T012 [US1] Update nodes 1–24 and 26–34 with concrete test paths and audit results in `specs/007-details-design-api/audit-results.md`.

**Checkpoint**: bStocks and funding recovery are independently auditable and tested from their actual parent entry points.

## Phase 4: User Story 2 — Resolve confirmed design or contract gaps (Priority: P2)

**Goal**: Resolve only evidence-backed missing behavior, data, or transitions without duplicating verified UI.

**Independent Test**: Each audit result marked `gap` has a matching correction and regression; each `blocked` result documents the required contract capability and displays an explicit unavailable state.

- [X] T013 [US2] Classify every unresolved audit row as `gap`, `blocked`, or `verified`, with a concrete reason and owner, in `specs/007-details-design-api/audit-results.md`.
- [X] T014 [US2] Convert each `gap` row from `specs/007-details-design-api/audit-results.md` into a dedicated node-ID task in `specs/007-details-design-api/tasks.md` that names the owning source file, regression-test file, assertion, and return context before changing implementation code.
- [X] T015 [US2] For each blocked API capability, update the contract submodule and run `npm run api:update`, then map the capability through `lib/data/services/`, `lib/data/repositories/`, `lib/domain/repositories/`, and `lib/ui/features/*/providers/`; record the generated client refresh in `specs/007-details-design-api/audit-results.md`.
- [X] T016 [US2] Verify unavailable, partial-data, retry, safe-reference copy, and long-text behavior for each repaired or newly unblocked node in `test/ui/features/orders/views/trade_screen_test.dart`, `test/ui/features/orders/views/hip3_order_panel_test.dart`, `test/ui/features/funding/figma_screen_states_test.dart`, and `test/acceptance/requirement_traceability_test.dart`.

**Checkpoint**: No confirmed gap lacks a correction or explicit approved-contract dependency.

## Phase 5: User Story 3 — Verify HIP-3 and live data safely (Priority: P3)

**Goal**: Verify HIP-3 trade/position details, close flows, and shared references use authoritative data while preserving valid context.

**Independent Test**: From `/trade` with HIP-3 selected, exercise Position/Open/Details, Long/Short/Close, market/limit, leverage, review, pending/failure, and return-context paths.

- [X] T017 [P] [US3] Add full TradeScreen-entry widget coverage for HIP-3 nodes 35–44, 46, 48–51, and 53 in `test/ui/features/orders/views/hip3_order_panel_test.dart`.
- [X] T018 [P] [US3] Add widget coverage for shared/reference nodes 25, 45, 47, 52, and 54, verifying delegation rather than standalone routes, in `test/ui/features/orders/views/trade_screen_test.dart`.
- [X] T019 [US3] Repair confirmed HIP-3 side/type/leverage/margin preservation, close-flow, or outcome-state gaps in `lib/ui/features/orders/views/trade_screen.dart` and `lib/ui/features/orders/views/hip3_order_panel.dart`.
- [X] T020 [US3] Add provider and acceptance regressions for each HIP-3 repair, including pending, failed, cancelled, or unavailable behavior, in `test/ui/features/orders/providers/order_providers_test.dart` and `test/acceptance/order_position_flow_test.dart`.
- [X] T021 [US3] Update HIP-3 and shared/reference rows with concrete evidence in `specs/007-details-design-api/audit-results.md`.

**Checkpoint**: HIP-3 and shared flows retain authoritative state and documented return context.

## Phase 6: Polish and cross-cutting validation

**Purpose**: Complete evidence, accessibility, and quality gates.

- [X] T022 [P] Verify changed bStocks, HIP-3, deposit, and withdrawal flows at enlarged text and with long safe references in `test/ui/features/orders/views/trade_screen_test.dart`, `test/ui/features/orders/views/hip3_order_panel_test.dart`, and `test/ui/features/funding/figma_screen_states_test.dart`; record results in `specs/007-details-design-api/audit-results.md`.
- [X] T023 Run `dart format --set-exit-if-changed .`, `dart analyze`, and the quickstart test commands; record all 54 final results in `specs/007-details-design-api/audit-results.md`.
- [X] T024 Reconcile completion status, blocked contract dependencies, and test evidence across `specs/007-details-design-api/spec.md`, `specs/007-details-design-api/audit-results.md`, and `specs/007-details-design-api/quickstart.md`.

## Phase 7: Transfer-complete order continuation

- [X] T025 [US1] [Node 543:16937] On an authoritative completed funding transfer, restore the immutable bStocks `OrderPreview` in `lib/ui/features/orders/views/bstocks_transfer_flow.dart`; add `test/ui/features/orders/views/bstocks_order_panel_test.dart` coverage that Back restores the funded order review and its return context is the invoking `/trade` order sheet.
- [X] T026 [US1] [Node 543:17110] Submit only the completed transfer's immutable bStocks preview through `orderCommandProvider` in `lib/ui/features/orders/views/bstocks_transfer_flow.dart`; add an assertion for the preview ID/idempotent submit and `Close & View Later` pending state in `test/ui/features/orders/views/bstocks_order_panel_test.dart`.

## Dependencies & Execution Order

- Phase 1 → Phase 2 → User Stories 1–3 → Phase 6.
- US1 is the MVP. US2 starts after foundational classification and may proceed alongside US1 for independent findings. US3 starts after Phase 2 and should not modify bStocks-owned files without coordination.
- T015 is conditional: execute only for audit rows proven blocked by an approved missing capability; it depends on contract-source access and must precede any dependent UI work.

## Parallel Opportunities

- T002 and T003 can run in parallel.
- T007 and T008 can run in parallel; T017 and T018 can run in parallel.
- T022 can run alongside non-conflicting final test work after the relevant repairs.

## Implementation Strategy

1. Establish item-level evidence and real route/overlay constraints.
2. Deliver and validate bStocks/funding entry-to-outcome journeys as the MVP.
3. Repair only findings supported by audit evidence; isolate any contract upgrade.
4. Complete HIP-3 and shared-reference journeys, then run quality gates and reconcile all 54 nodes.
