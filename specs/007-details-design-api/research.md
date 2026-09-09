# Research: Trade Detail Screen Audit

## Decision: Audit by node ID and journey batch

**Rationale**: Several Figma frame titles do not describe their implemented behavior. The fixed inventory plus `audit-matrix.md` provides stable node IDs, while batches expose parent/return context without creating 54 independent routes.

**Alternatives considered**:

- Audit from frame titles alone: rejected because known title-to-behavior mismatches would misclassify bStocks and HIP-3 states.
- Add a route for every frame: rejected because most frames are tabs, sheets, visual states, or component references.

## Decision: Retain existing data boundaries

**Rationale**: Orders, positions, deposits, withdrawals, transfers, markets, and charts already have repository/service mappings. Riverpod command/provider state keeps data and failures outside widgets.

**Alternatives considered**:

- Call generated APIs from a trade widget: rejected by the project API boundary and failure-mapping requirements.
- Treat all screens as Activity records: rejected because the design spans different authoritative resources.

## Decision: Repair only evidence-backed gaps

**Rationale**: The prior traceability matrix marks all 54 items verified, but current evidence has gaps in full entry-to-overlay journeys, HIP-3 journey coverage, route return behavior, and node-level test traceability.

**Alternatives considered**:

- Reimplement all screens: rejected as duplicate risk.
- Trust prior verification without retesting: rejected because tests and documented task paths are inconsistent.

## Decision: Contract changes follow the submodule update path

**Rationale**: If audit reveals a required absent field or operation, the OpenAPI contract is the source of truth and the generated client must be refreshed through the repository command.

**Alternatives considered**:

- Hand-edit generated code or synthesize missing values: rejected as unsafe and against repository policy.
