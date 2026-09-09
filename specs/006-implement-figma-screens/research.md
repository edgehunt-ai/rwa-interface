# Research: Implement Figma Screens

## Decision: Implement from Figma one direct-child frame at a time

**Rationale**: The feature has 86 direct child frames, including duplicate labels that represent distinct visual states. The stable node link and documented canvas ordering avoid lost variants and allow each implemented screen to be traced back to its design context.

**Alternatives considered**:

- Treat duplicate labels as a single screen: rejected because overlays, selected states, and different product modes have different visible requirements.
- Recreate the visual design from the parent screenshot alone: rejected because it loses component descriptions, exportable assets, and state-specific layout information.

## Decision: Extend the existing Flutter presentation architecture

**Rationale**: The repository already has GoRouter destinations, a centralized theme, Riverpod providers, repository ports, `DecimalValue` domain values, and test structure. New UI should compose these boundaries rather than introduce a parallel app or transport path.

**Alternatives considered**:

- Call generated API clients from the screens: rejected by the application API boundary and would leak transport types/errors into presentation.
- Use feature-local theme colors and number formatting: rejected by the constitution's semantic-token and financial-precision requirements.

## Decision: Model design variations as explicit UI states

**Rationale**: Filter, search, selected-tab, chart, order, sheet, review, empty, unavailable, and failure states should be observable and testable. Existing `AsyncValue`, domain status enums, and command/provider state provide the basis for this mapping.

**Alternatives considered**:

- Implement only the happy-path frames: rejected because users need recoverable feedback and the design inventory contains explicit variant states.
- Drive state from untyped widget-local flags: rejected because it would make data-backed states hard to restore, test, and keep consistent across entry points.

## Decision: Preserve authentic design assets with explicit geometry

**Rationale**: The design context includes company marks, venue icons, navigation icons, and account artwork. Each asset must be downloaded into a durable project location or mapped to an equivalent existing asset, then displayed with the Figma-specified container and leaf dimensions.

**Alternatives considered**:

- Substitute Material icons or text symbols: rejected when the glyph does not clearly match the supplied asset.
- Embed expiring Figma URLs in application code: rejected because those source URLs are temporary.

## Decision: Build by shared journey, while preserving design inventory order

**Rationale**: The Home/Markets/Assets/Funding frames share navigation and financial-list primitives. Implementing them first establishes reusable, testable components; subsequent trade, settings, and activity work can use the same shell. The inventory remains the source order for reading and completion tracking.

**Alternatives considered**:

- Build 86 isolated pages: rejected because it duplicates state logic and visual controls.
- Start with the most visually complex trade variation: rejected because foundational shell, market, and funding primitives are prerequisites.
