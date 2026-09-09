# Feature Specification: Validate Trade Detail Screens and API Coverage

**Feature Branch**: `feat/007-details-design-api`

**Created**: 2026-09-08

**Status**: Complete — all 54 inventory items have audit evidence; transfer-complete nodes 13 and 14 are covered by the immutable-preview and pending-state regressions.

**Input**: User description: "Use the enumerated child design screens to implement their pages and actions and connect their APIs."

**Fixed design input**: [screen-inventory.md](screen-inventory.md) contains the 54 child-screen titles and direct links in canvas order. Planning MUST use those child links only, and MUST NOT record a parent-layer link.

**Existing traceability**: [the Trade/Foundation matrix](../006-implement-figma-screens/screen-inventory.md) is the current source for item type, entry/return path, prior implementation mapping, and verified status. This feature audits that evidence and repairs only confirmed gaps.

**Audit mapping**: [audit-matrix.md](audit-matrix.md) groups the 54 items by journey and resolves title-to-behavior ambiguities by node ID. It is the required starting point for planning and testing.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Use verified bStocks and funding journeys (Priority: P1)

An authenticated user can complete each supported bStocks trade, position, funding, review, and outcome journey represented by the fixed child-screen inventory, using current account data and receiving an accurate result.

**Why this priority**: These are financial journeys; a visual match alone is insufficient if an action does not reach the authoritative account state.

**Independent Test**: Starting from each documented route or overlay entry point, run representative supported success, pending, unavailable, and failure paths and verify the outcome and return context.

**Acceptance Scenarios**:

1. **Given** an inventoried screen is marked verified, **When** its documented journey is exercised against representative account data, **Then** its visible state, available actions, and return behavior match the child-screen design and current authoritative state.
2. **Given** a user submits, cancels, edits, closes, deposits, withdraws, or transfers through a supported inventoried journey, **When** the request succeeds, remains pending, or fails, **Then** the product shows that exact outcome without inferring final success.

---

### User Story 2 - Resolve confirmed design or data gaps (Priority: P2)

An authenticated user receives a complete and recoverable experience when an audit finds that an inventoried child screen, action, transition, or data-backed value is missing, stale, or unsupported.

**Why this priority**: The feature must improve real gaps rather than recreate the 54 screens already represented by the existing verified matrix.

**Independent Test**: For every gap found during the item-by-item audit, execute its regression test against the affected child-screen link and verify the correction and its loading, unavailable, and failure behavior.

**Acceptance Scenarios**:

1. **Given** an inventory item has no reachable implementation or an incorrect transition, **When** the user follows its documented entry point, **Then** the missing route, overlay, action, or return behavior is corrected.
2. **Given** a design requires data not supplied by the approved account contract, **When** that data is unavailable, **Then** the product presents an explicit unavailable state and does not fabricate a value or final status.

---

### User Story 3 - Verify live data safely (Priority: P3)

An authenticated user sees trade, position, order, deposit, withdrawal, transfer, and market information from the appropriate approved record, and can retry recoverable failures without losing safe context.

**Why this priority**: The inventory spans multiple financial resources, not a single activity-detail resource.

**Independent Test**: For each resource type exercised by an inventory item, test populated, pending, unavailable, and failure records and confirm that only authorized current data is shown.

**Acceptance Scenarios**:

1. **Given** a data-backed inventory item, **When** its resource is available, **Then** the screen uses the matching approved record and preserves amounts, precision, state, and safe references.
2. **Given** a recoverable request failure, **When** the user retries, **Then** the same resource context reloads without exposing transport details.

### Edge Cases

- A child item is a component reference or a duplicate-titled state; it remains a separately auditable item but does not become a new route when the design does not define one.
- An order, position, deposit, withdrawal, or transfer changes state while open; refresh must show the new authoritative state without inventing a transition.
- A contract lacks data needed by a design; the dependent UI remains explicitly unavailable until an approved contract update provides it.
- An identifier or reference is too long, absent, or not safe to disclose; the UI retains meaning, copies only safe complete values, and never exposes secrets.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The product MUST use all 54 fixed child-screen links in the inventory as the audit and implementation scope, in their recorded canvas order.
- **FR-002**: The product MUST use the existing Trade/Foundation matrix and this feature's audit matrix to verify every item's type, entry point, return path, implementation mapping, resource boundary, and status before declaring it complete.
- **FR-003**: The product MUST repair only confirmed gaps in the existing implementation; it MUST NOT duplicate a verified route, overlay, component, or API request solely because it appears in the inventory.
- **FR-004**: The product MUST map each data-backed item to the appropriate approved order, position, funding, market, or account resource; it MUST NOT treat the entire inventory as an Activity-detail feature.
- **FR-005**: The product MUST distinguish pending, confirmed, failed, cancelled, unavailable, and unknown outcomes where supplied by the approved resource, and MUST NOT infer success.
- **FR-006**: The product MUST provide loading, unavailable, partial-data, and recoverable failure behavior for every corrected data-backed gap.
- **FR-007**: The product MUST preserve financial amount, asset, unit, precision, and rounding semantics, and MUST make only safe identifiers and references copyable.
- **FR-008**: When a required capability is absent from the approved contract, the product MUST record the missing capability, obtain an approved contract update, and then map it through the established data boundary before presenting live data.
- **FR-009**: The product MUST preserve documented parent context through navigation, overlay dismissal, refresh, and safe retry.
- **FR-010**: The product MUST add or update automated regression coverage for every repaired gap, including a non-success state appropriate to the financial action.
- **FR-011**: The product MUST NOT create a separate route for a child item unless its documented type is Route; tabs, visual states, overlays, and component-reference frames MUST retain their documented composition or delegation behavior.
- **FR-012**: The product MUST treat node ID as authoritative when an inventory title conflicts with its verified behavior in the audit matrix.

### Key Entities

- **Design inventory item**: One of the fixed child screens, overlays, states, or component references in the inventory.
- **Trade resource**: An authoritative order, position, market, or chart record used by trade screens.
- **Funding resource**: An authoritative deposit, withdrawal, transfer, route, or funding-plan record used by funding screens.
- **Audit finding**: A verified mismatch between a design inventory item and its implemented behavior, data, navigation, accessibility, or supported contract capability.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: 100% of the 54 inventory items have their existing matrix entry audited against the direct child-screen link before the feature is declared complete.
- **SC-002**: 100% of confirmed gaps have a documented correction or an explicit approved-contract dependency; no gap is hidden by a fabricated value or status.
- **SC-003**: 100% of corrected financial actions visibly distinguish pending, confirmed, failed, cancelled, and unavailable outcomes when applicable.
- **SC-004**: A reviewer can exercise every corrected route or overlay from its documented parent context and return to the expected context.
- **SC-005**: All corrected screens remain usable at the supported enlarged-text setting, with no clipped primary action, status, financial value, or copy affordance.
- **SC-006**: 100% of new or updated regression tests identify their audited inventory node ID and verify the documented entry and return context.

## Assumptions

- The 54 child links in the fixed inventory are the intended scope; their authoritative type and journey metadata are retained in the existing Trade/Foundation matrix.
- Existing `verified` entries are candidates for audit, not automatic reimplementation tasks.
- Approved contracts already provide several resource-specific detail capabilities, while new fields or operations require the normal contract-update and generated-client process.
- Existing Riverpod, repository, domain-model, formatting, localization, feedback, and navigation boundaries will be extended rather than bypassed.
