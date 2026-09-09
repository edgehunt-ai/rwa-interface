# Trade/Foundation Audit Matrix

Use `screen-inventory.md` for the direct child-screen link and node ID. This matrix supplies the audit path and prevents frame titles from being treated as product behavior. It deliberately contains no parent-layer link.

| Batch | Inventory items | Entry and audit objective | Expected return/context | Resource boundary |
|---|---:|---|---|---|
| Base trade states | 1–4 | Open `/trade` in bStocks; audit market-hours sheet, chart style, and reference-price controls. | Dismiss/switch retains selected product and Details context. | Market, chart, and session data. |
| bStocks order and funding recovery | 5–16 | Audit Buy/Sell, market/limit, insufficient funds, external deposit, in-app transfer, review, pending, and terminal outcomes. | Sheets return to the originating order context; deposit returns to funding choice. | Orders, funding plans, deposits, transfers, wallet actions. |
| bStocks position and open orders | 17–34 | Audit Position/Open/Details, withdrawal transfer, TP/SL, sell, preview, cancel, and shared transfer-reference behavior. | Preserve selected tab and order/position context. Reference frames delegate to the existing transfer flow. | Positions, orders, withdrawals, transfers. |
| HIP-3 and close | 35–44, 46, 48–51, 53 | Audit HIP-3 product selection, Position/Open/Details, Long/Short/Close, market/limit, leverage, margin, TP/SL, review, and outcomes. | Preserve product, side, order type, leverage, margin, and valid inputs across sheet transitions. | Positions, orders, market, and chart data. |
| Shared and reference frames | 25, 45, 47, 52, 54 | Audit shared TP/SL, bStocks limit-price behavior, and transfer-reference delegation. | Return to the invoking position/order context. | Position command state, order preview, transfer flow. |

## Node-ID corrections

The child-frame title is retained verbatim in `screen-inventory.md`; use the following node-ID meanings for implementation and tests.

| Inventory item | Node ID | Verified meaning |
|---:|---|---|
| 25 | 543:13079 | Shared bStocks TP/SL editor; not a market-status screen. |
| 39 | 513:21826 | bStocks Buy order review; not a HIP-3 journey. |
| 45 | 543:11376 | bStocks TP/SL entry state. |
| 46 | 543:13208 | HIP-3 Long order review/confirmation state; not a market-status sheet. |
| 47 | 513:23345 | Transfer reference frame; delegate to the established transfer flow. |
| 52 | 543:11158 | bStocks limit-price sheet; not a HIP-3 state. |
| 54 | 513:23347 | Transfer reference frame; delegate to the established transfer flow. |

## Required evidence per item

For each of the 54 rows, record the child node ID, type, trigger, assertion, return target, responsible component, provider/repository resource, regression test, and audit result. A frame is complete only after this evidence exists. Component-reference frames are verified by delegation and return-context behavior, not by a fabricated standalone route or geometry.
