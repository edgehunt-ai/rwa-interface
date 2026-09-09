# Data Model: Trade Detail Screen Audit

## DesignInventoryItem

| Field | Meaning | Validation |
|---|---|---|
| inventoryNumber | Stable child-screen order, 1–54 | Required and unique |
| nodeId | Stable Figma child identifier | Required; authoritative over title |
| type | Route, overlay, state, or component reference | Must match prior matrix |
| entry/return | Parent trigger and expected return context | Required before completion |
| auditResult | verified, gap, blocked, or not-applicable | Evidence required |

## AuditEvidence

| Field | Meaning |
|---|---|
| trigger | User action or parent state that exposes the item |
| assertion | Visible outcome and allowed action |
| component | Owning screen/panel/sheet |
| resource | Order, position, funding, market, or chart state |
| regressionTest | Node-tagged test covering the finding |

## Resource state rules

| Resource | Allowed visible states |
|---|---|
| Order | loading, preview, pending, filled/confirmed, failed, cancelled, unavailable |
| Position | loading, populated, empty, unavailable, TP/SL update pending/confirmed/failed |
| Funding | route selection, review, submitted/pending, confirmed, failed, unavailable |
| Market/chart | loading, populated, partial-data, unavailable |

All financial values retain their asset, unit, decimals, and approved display semantics. Missing contract data remains unavailable rather than synthesized.
