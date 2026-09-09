# Implementation Plan: Validate Trade Detail Screens and API Coverage

**Branch**: `feat/007-details-design-api` | **Date**: 2026-09-08 | **Spec**: [spec.md](spec.md)

## Summary

Audit the 54 fixed Trade/Foundation child screens using their direct links and node IDs, then repair only proven navigation, state, accessibility, test, or approved-contract gaps. Keep the existing `/trade` composition and its funding-route handoffs; do not recreate the already verified screens or turn overlays into routes.

## Technical Context

**Language/Version**: Dart 3.13 / Flutter

**Primary Dependencies**: Flutter, Riverpod, GoRouter, generated OpenAPI client

**Storage**: N/A; data comes from authenticated account services

**Testing**: `flutter test`, widget/provider tests, acceptance tests

**Target Platform**: Android API 28+, iOS 17+, web not in scope

**Project Type**: Mobile application

**Performance Goals**: Preserve selected trade context while overlays open and data refreshes; no user-visible blocking work beyond normal request loading states

**Constraints**: Direct child links only; semantic theme and shared financial formatter; Riverpod → repository → service → generated client; no fabricated financial state; no manual generated-client edits

**Scale/Scope**: 54 design nodes across `/trade`, `/funding/deposit`, and `/funding/withdraw`; only confirmed gaps are changed

## Constitution Check

| Gate | Plan response | Status |
|---|---|---|
| Traceability | Every audit/test records its inventory number and node ID. | Pass |
| Layering | UI observes Riverpod state; repositories/services own generated-client calls and map domain failures. | Pass |
| Financial correctness | Shared formatters and contract-provided decimals remain mandatory. | Pass |
| Safety and recovery | Pending/failure/unavailable states remain explicit; safe references only are copyable. | Pass |
| UX/accessibility | Verify return context, semantic labels, long text, and enlarged text for changed flows. | Pass |
| Reuse/rendering | Retain TradeScreen, order panels, TP/SL sheet, and transfer-flow ownership; no speculative shared abstraction. | Pass |

## Phase 0: Research

See [research.md](research.md). No unresolved clarification remains. Existing contracts already expose orders, positions, deposits, withdrawals, transfers, markets, and charts; any newly proven data omission follows the approved contract-update workflow.

## Phase 1: Design

- [Data model](data-model.md): audit evidence and resource-to-screen state rules.
- [UI and integration contract](contracts/trade-screen-audit.md): per-node evidence, route/overlay rules, API boundary, and outcome requirements.
- [Audit results](audit-results.md): mandatory 54-node completion evidence.
- [Validation guide](quickstart.md): reproducible audit batches and commands.

## Project Structure

```text
lib/
├── app/routing/                 # `/trade` and funding-route declarations
├── ui/features/orders/          # TradeScreen, bStocks/HIP-3 panels, TP/SL and transfer flows
├── ui/features/funding/         # deposit and withdrawal handoffs
├── ui/features/*/providers/     # Riverpod presentation state and commands
├── domain/repositories/         # resource ports
└── data/{repositories,services}/ # domain mapping and generated-client boundary

test/
├── ui/features/orders/          # node-tagged widget journeys
└── acceptance/                  # order/position/funding end-to-end behavior
```

**Structure Decision**: Keep the existing feature ownership. Each correction belongs to the owning screen/panel and its existing provider/repository boundary.

## Complexity Tracking

No constitution violations or new structural complexity are required.
