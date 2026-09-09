# Data Model: Implement Figma Screens

## Existing domain entities to present

### DesignScreen

| Field | Meaning | Validation |
|---|---|---|
| `nodeId` | Stable Figma node identity | Must be unique within the 86-frame inventory. |
| `name` | Design-frame label | May be duplicated; pair with `nodeId` in logs, tasks, and tests. |
| `region` | Parent design area | One of Home/Markets, Trade/Foundation, Settings, or Activity. |
| `canvasOrder` | Deterministic order within its region | Must preserve ascending canvas position. |
| `status` | Listed, reading, implemented, verified, or blocked | Every item begins `listed`; it cannot be verified before its node has been read and implementation tests pass. |
| `inventoryType` | Route/state candidate, overlay, or component reference | A direct Figma frame is not automatically an independently navigable route. |
| `parentContext` | Figma region initially, then concrete in-app entry/dismiss path | Must be present before an item is marked implemented. |

### MarketProduct and MarketSnapshot

Existing market identity and live price state displayed in Home, Markets, product discovery, and trade frames.

| Requirement | Rule |
|---|---|
| Product venue | Use `MarketProductKind`, network, and product metadata; do not infer venue from the symbol. |
| Price/change/volume | Preserve `DecimalValue` precision and use centralized formatting. |
| Availability | `tradable == false` disables or explains financial action; it must not be represented as executable. |
| Favorites | Changes go through `FavoritesCommand`; refresh affected provider state after success. |

### Portfolio, HoldingGroup, Position, and TradingAccount

Existing account value, allocation, cash, stock, and position data used in Home/Assets views.

| Requirement | Rule |
|---|---|
| Totals and change | Render with shared financial formatting and semantic movement/status treatment. |
| Empty/partial account data | Render an explicit state; do not manufacture a portfolio amount. |
| Asset grouping | Keep cash, bStocks, and perpetual equity categories distinct where the design distinguishes them. |

### FundingCatalog, Deposit, Withdrawal, WithdrawalIntent, WithdrawalQuote, and WalletAuthorization

Existing funding data and command state used by deposit routes, asset pickers, withdrawal entry, and withdrawal review.

| Transition | Guard |
|---|---|
| Select asset/network → enter amount/address | Route must be supported by `FundingCatalog`; invalid fields remain recoverable. |
| Enter input → quote/review | Quote carries the values, fee, and route shown for user review. |
| Review → wallet authorization → create | Authorization must be usable; commands preserve the existing idempotency protections. |
| Create → activity/history | Pending, success, and failure remain distinct; invalidate the relevant provider after a successful command. |

### OrderIntent, OrderPreview, Order, and Position

Existing trade input and lifecycle data used by bStocks, HIP-3, chart, order, close, and market-status variations.

| Requirement | Rule |
|---|---|
| Product kind and side | Retain `OrderIntent` validation: bStocks use buy/sell; perpetuals use long/short. |
| Limit orders | Require quantity and limit price. |
| Amount vs. quantity | Accept exactly one input form. |
| Perpetual-only order fields | Leverage, margin mode, reduce-only, and order-intent TP/SL must not be sent for bStocks. Existing bStocks positions may use the separate TP/SL position-management command when the product supports it. |
| Confirmation | Present preview/fee/impact prior to irreversible or signed action where applicable. |

### ActivityRecord

Existing history identity and status data used by Activity frames.

| Requirement | Rule |
|---|---|
| Status | Display pending, success, failed, cancelled, and unknown with text and non-color cues. |
| Reference | Show a copyable full reference when a record has an account or transaction identifier. |
| Pagination | Preserve cursor/page state when the user returns from a detail or filter selection. |

## Presentation state model

Every data-backed screen maps a domain/provider result to one of: `loading`, `success`, `empty`, `partial`, `unavailable`, `failure`, or `commandPending`. A sheet, selected tab, search query, filter, expanded section, or review step is represented as explicit feature state with a deterministic back/dismiss transition.
