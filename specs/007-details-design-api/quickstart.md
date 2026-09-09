# Quickstart: Validate Trade Detail Screen Audit

## Prerequisites

- Use branch `feat/007-details-design-api` with authenticated/representative provider fixtures.
- Read `screen-inventory.md` and select the corresponding journey from `audit-matrix.md`.

## Run validation

```sh
flutter test test/ui/features/orders
flutter test test/acceptance/order_position_flow_test.dart
flutter test test/acceptance/funding_flow_test.dart
flutter test test/ui/features/funding/providers/funding_transfer_providers_test.dart
flutter test test/acceptance/requirement_traceability_test.dart
dart format --set-exit-if-changed .
dart analyze
```

## Audit scenarios

1. Run items 1–4 from `/trade`; verify sheet dismissal and chart/reference selections preserve context.
2. Run items 5–16 through bStocks order, insufficient-funds, transfer, pending, and outcome paths.
3. Run items 17–34 through Position/Open/Details, withdrawal, TP/SL, previews, cancellation, and transfer references.
4. Run HIP-3 items in the audit matrix through Long/Short/Close, market/limit, leverage, review, and outcome states.
5. For every correction, record node ID, provider resource, test name, entry trigger, result, and return context in `audit-results.md`; expand all grouped rows before declaring the feature complete.
6. For In-App Transfer, assert the server plan → transfer-purpose authorization → transfer lifecycle; only a completed transfer can submit its immutable order preview.
7. If an approved capability is missing, record it as blocked, update the contract source, run `npm run api:update`, then add its domain, provider, and regression coverage before retrying the audit.

Expected result: no added standalone route for an overlay/reference frame; financial outcomes remain explicit; all changed flows pass static analysis and their relevant tests. The audit's final classification section is authoritative, including the completed transfer-preview and pending-state regressions for nodes 13 and 14.
