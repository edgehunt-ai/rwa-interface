# Research: Cross-Platform App Foundation

## Declarative routing

**Decision**: Use `go_router` with a single application-owned router and named route definitions.

**Rationale**: The application targets web, future deep links, nested business areas, and eventual
authentication redirects. Central ownership prevents platform checks from leaking into screens.

**Alternatives considered**: Raw `Navigator` is adequate for a few mobile pages but makes URL parsing,
refresh restoration, and future guards manual. A custom Router implementation adds complexity without
product value.

## Platform navigation behavior

**Decision**: Use the platform transition behavior supplied through the app theme and router page
construction. Add custom page transitions only when a measured platform mismatch is demonstrated.

**Rationale**: Flutter's platform transition builders preserve Android/iOS conventions and iOS back
gestures while minimizing custom navigation code.

**Alternatives considered**: Forcing Cupertino pages everywhere would weaken Android/Web conventions;
custom transitions risk breaking interactive back gestures.

## Adaptive system interactions

**Decision**: Expose small application-owned wrappers for progress, switch, alert, action sheet, and
date selection. Platform selection occurs only inside these wrappers.

**Rationale**: These interactions carry strong platform expectations, while business components such
as market cards should retain one product design.

**Alternatives considered**: Platform checks in each feature duplicate behavior. A second complete
Cupertino application tree would double maintenance.

## Safe layout and keyboard behavior

**Decision**: Provide one page shell that owns safe-area policy and keyboard-aware scrolling. Permit
edge-to-edge backgrounds while keeping interactive content within usable insets.

**Rationale**: Page-level ownership prevents nested safe-area padding and inconsistent keyboard fixes.

**Alternatives considered**: Adding `SafeArea` in every component creates duplicated padding; relying
only on default scaffold behavior does not cover long forms and bottom actions.

## Theme and localization

**Decision**: Keep Material 3 as the behavior/theme base, define semantic light/dark theme values in
the design-system layer, and use Flutter's generated localization pipeline from the first user-facing
foundation strings.

**Rationale**: This retains accessible platform behavior, keeps brand values centralized, and avoids
hard-coded production strings.

**Alternatives considered**: Material defaults do not express product semantics; a custom widget stack
would recreate accessibility behavior; deferred localization causes costly string migration.

## Test scope

**Decision**: Use widget tests for routes, theme, adaptive selection, safe layout, states, copy
feedback, long content, and 200% text. Record iOS-native checks in a manual acceptance checklist.

**Rationale**: The user explicitly excluded iOS integration tests. Widget tests provide deterministic
coverage while native gesture fidelity remains a documented manual gate.

**Alternatives considered**: iOS integration automation is out of scope; screenshot-only tests would
not verify semantics or interactions.
