# HIP3 order execution details

Base: `rwa-interface/main` at `f0fcb46`, independent `feat/hip3-order-fills` worktree.

## Read-only scope

- Existing `GET /v1/orders/{order_id}` → generated service → repository →
  `orderProvider` → HIP3 detail screen. No additional fill endpoint exists.
- Routes `/hip3/orders` and `/hip3/orders/:orderId`. Open-order cards link to
  detail; the HIP3 Open panel also links to all HIP3 order records so filled
  orders remain reachable after they leave the open list.
- Existing generic `/details`, bStocks views, order writes, cancellation,
  signing executor, protection state, reconciliation and migrations unchanged.
- No backend, OpenAPI or generated API client edits.

## Facts and missing fields

- `TradingOrderFill` maps fill ID, provider trade ID, optional provider hash,
  execution timestamp, exact price, quantity and fee with its actual fee asset.
- All returned fills are retained; detail renders them lazily, newest first.
  Equal timestamps use fill ID as a deterministic tie-breaker.
- Decimal strings never pass through double. Negative fees/rebates and original
  precision are retained. Execution times explicitly use UTC, preserving supplied
  fractional seconds. No order-created timestamp is substituted for a fill time.
- `fills == null` differs from `fills == []`. Both have truthful empty messages;
  neither claims the order never executed.
- Aggregate filled quantity, average price, fee and order-level realized PnL are
  shown under Order totals, not computed from a potentially partial fill array.
- Current OrderFill has **no side or per-fill realized PnL**. Those values display
  Unavailable with an explanation. Order side/PnL are never copied into each fill.
- Order and OrderFill do not expose a settlement/quote asset. New fill-price and
  realized-PnL mappings leave it absent. This view also avoids using the legacy
  aggregate mapper's assumed USDC: unknown units are explicitly unavailable.
  Base quantity uses the order symbol; each fill's fee uses `fee_asset`.
- Contract-required fields missing from malformed payloads produce a query error
  with retry (generated validation is not weakened to manufacture zero values).

## Coverage and pagination

- Detail displays the response's fill count, oldest/newest returned execution
  timestamps and optional provider observation time.
- The fills array has no cursor, hasMore, total count or completeness flag. The
  page explicitly does not promise complete history or invent a fill pagination
  endpoint. Refresh re-queries the order; it does not merge stale response copies.
- Separately, the order-record list consumes `next_cursor` / `has_more`, prevents
  duplicate loads, deduplicates order IDs, retries the failed cursor and detects
  repeated/invalid cursors. It queries HIP3 only through the existing provider.
- Existing order providers isolate by order ID and session generation; stale
  account/order responses are not shown as a newly selected order's details.

## Verification

Final run: **40 tests passed**, `flutter analyze --no-pub` reported no issues,
and `git diff --check` was clean.

- Mapping tests exercise the real generated GET decoder and repository, including
  exact decimals, UTC conversion, fee currencies, null/empty records, optional
  PnL/hash, required-field errors and more than a UI-sized page of fills.
- Widget tests cover totals vs fills, missing facts, newest-first ordering,
  refresh/retry, account/order isolation, HIP3-only guard, deep link, navigation,
  record pagination and 375px 2× text in light/dark themes.
- Regression checks include existing order-provider, routing, order/position
  acceptance and HIP3 order-panel tests. No real transactions are sent.
- Phone light/dark snapshots inspected; no full iOS compilation or device test.
