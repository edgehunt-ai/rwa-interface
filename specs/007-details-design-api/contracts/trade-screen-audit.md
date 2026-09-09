# UI and Integration Contract: Trade Screen Audit

## Design reference contract

- Use `screen-inventory.md` as the sole design-link source.
- Every audit record must name its inventory number and node ID.
- Use `audit-matrix.md` for correct behavior when a frame title is ambiguous.
- Do not place a parent-layer link in planning, tasks, tests, or implementation documentation.

## Navigation contract

| Item type | Required behavior |
|---|---|
| Route | Use the existing route only when documented: `/trade`, `/funding/deposit`, or `/funding/withdraw`. |
| Tab/state | Remain within the selected TradeScreen context. |
| Overlay | Open from and dismiss back to its invoking trade context. |
| Component reference | Delegate to the documented reusable flow; no standalone route or fabricated geometry. |

## Data contract

Widgets consume Riverpod state only. Providers call repository ports; repositories map generated-client responses and transport failures to domain values/failures. The audit may use existing order, position, deposit, withdrawal, transfer, market, chart, and funding-plan capabilities. Any missing contract capability is recorded as blocked, then updated through the approved OpenAPI submodule/client refresh workflow before it is displayed.

## Current provider-to-repository map

| Journey | UI provider | Domain repository | Service/client boundary | Audit decision |
|---|---|---|---|---|
| Order list, preview, create, cancel | `order_providers.dart` | `OrdersRepository` | `GeneratedOrdersService` → `OrdersApi` | Available. |
| Position list, TP/SL, close | `position_providers.dart` | `PositionsRepository` | `GeneratedPositionsService` → `PositionsApi` | Available. |
| Deposit and withdrawal | `deposit_providers.dart`, `withdrawal_providers.dart` | `FundingRepository` | `GeneratedFundingService` → `FundingApi` | Available. |
| Market and chart data | Trade-screen market providers | `MarketsRepository` | `GeneratedMarketsService` / `GeneratedChartsService` | Available. |
| bStocks funding transfer | No provider | No domain port | Client exposes `FundingApi.createTransfer`, but requires a server-issued `plan_id` and one-time `authorization_id`. | **Blocked**: create a plan/authorization domain flow before wiring the UI. Owner: funding API/domain boundary. |

The transfer sheet may only present an explicit pending/unavailable state until that capability is mapped. It must not manufacture a plan ID, authorization ID, transfer status, or terminal result.

## Evidence contract

Each repaired finding includes an automated test for the node ID, entry trigger, expected state, and return context. Record it in `audit-results.md`; expand its grouped rows to all 54 individual nodes before completion. Financial command tests also include a suitable pending, failure, cancellation, or unavailable outcome.

The historical `trade_overlays_test.dart` path is absent. Do not cite it as evidence unless it is created. Until then, map each overlay to an actual relevant `trade_screen_test.dart`, `bstocks_order_panel_test.dart`, or `hip3_order_panel_test.dart` test; create a dedicated overlay journey test only when those files cannot cover the full parent-to-overlay path.

## Contract-update contract

When audit proves an approved API capability is missing, record the node ID and capability as `blocked` in `audit-results.md`. Update `contracts/rwa-api-contract` from its source branch, run `npm run api:update`, and then add the required domain mapping, Riverpod provider/notifier coverage, and regression test. Generated files under `packages/rwa_api_client` are never edited manually.

For the current bStocks funding-transfer blocker, the prerequisite is a server-approved funding plan and wallet authorization. The required sequence is: obtain the plan, obtain the authorization, call `createTransfer(plan_id, authorization_id)`, then poll or subscribe to the returned transfer. No UI-only implementation satisfies this contract.
