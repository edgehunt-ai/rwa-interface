# Implementation Plan: Implement Figma Screens

**Branch**: `feat/006-implement-figma-screens` | **Date**: 2026-09-07 | **Spec**: [spec.md](spec.md)

**Input**: Feature specification from `/specs/006-implement-figma-screens/spec.md`

## Summary

Implement the 86 direct-child mobile design frames enumerated in the specification, in their Figma canvas order. Reuse the existing Flutter theme, GoRouter navigation, Riverpod providers, repositories, domain models, shared feedback controls, and financial formatter. Organize the work by reusable app shell and feature journeys: Home/Markets/Assets/Funding first, then trade variations, Settings, and Activity. Each implementation slice reads its specific Figma node context before code changes and validates both the normal and applicable exceptional states.

## Technical Context

**Language/Version**: Dart 3.13 with Flutter

**Primary Dependencies**: Flutter Material, flutter_riverpod, go_router, intl, Dio only within the data layer, generated `rwa_api_client`

**Storage**: Remote account, market, wallet, funding, order, portfolio, and activity data through existing repositories; no new local persistence planned

**Testing**: `flutter test`, targeted provider/unit tests, widget tests for interaction/state rendering, and existing acceptance tests

**Target Platform**: Native Flutter release: iOS 17.0+ and Android API 28+; browser coverage is N/A because web is not a supported release target for this feature

**Project Type**: Mobile application

**Performance Goals**: Preserve responsive navigation and scrolling with representative market/activity lists; subscriptions remain scoped to the smallest consuming widgets

**Constraints**: Design fidelity at 393 px reference width; semantic themed colors only; accessible large text/long text; financial precision via `TokenAmountFormatter`; no direct generated-client/Dio calls from widgets or business classes

**Scale/Scope**: 86 direct Figma child frames across Home/Markets/Assets/Funding (22), Trade/Foundation cleanup (54), Settings (6), and Activity (4); duplicates are unique visual states identified by node ID

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

**Pre-Phase 0: PASS**

- Specification and direct links exist for all 86 design items; each is tracked as a route/state, overlay, or component-reference candidate rather than assumed to be a standalone screen.
- Presentation will call Riverpod state only. Existing repositories/services/generated clients maintain the required dependency direction.
- Financial values retain `DecimalValue` and token-decimal semantics, using the shared formatter rather than feature-local number formatting.
- UI must include loading, empty, partial-data, success, unavailable, and failure states where the existing domain state can produce them.
- New visual primitives are allowed only after checking and reusing existing theme/layout/feedback components. New dependencies are not planned.
- The implementation tasks will include suitable unit/provider, widget, and acceptance validation; they must update each item from `listed` to `reading`, `implemented`, and `verified`. Material financial actions retain explicit confirmation and idempotency flows already provided by the funding/order boundary.
- New visible copy is added through the existing ARB localization flow and validated with representative long/localized labels.

**Post-Phase 1: PASS**

The model and UI contracts preserve the current domain/data boundary and identify the screen-state, formatting, accessibility, and asset-fidelity obligations. No constitution exception or complexity justification is required.

## Project Structure

### Documentation (this feature)

```text
specs/006-implement-figma-screens/
├── plan.md              # This file ($speckit-plan command output)
├── research.md          # Phase 0 output ($speckit-plan command)
├── data-model.md        # Phase 1 output ($speckit-plan command)
├── quickstart.md        # Phase 1 output ($speckit-plan command)
├── contracts/           # Phase 1 output ($speckit-plan command)
└── tasks.md             # Phase 2 output ($speckit-tasks command - NOT created by $speckit-plan)
```

### Source Code (repository root)
```text
lib/
├── app/
│   ├── providers/              # composition-root providers and session scope
│   └── routing/                # named navigation destinations
├── data/
│   ├── repositories/           # domain-port implementations
│   └── services/               # generated-client adaptation and transport
├── domain/
│   ├── models/                 # DecimalValue-backed domain entities
│   └── repositories/           # presentation-safe ports
├── l10n/                       # ARB source and generated localizations
└── ui/
    ├── core/                   # theme, layout, formatting, feedback primitives
    └── features/               # screen composition, feature widgets, providers

test/
├── acceptance/                 # user-flow and governance checks
├── ui/features/                # provider and widget tests by feature
└── ui/core/                    # shared visual/formatting behavior tests
```

**Structure Decision**: Use the existing Flutter mobile-app structure. Feature UI composes `ui/core` primitives and only consumes feature/app Riverpod state. Existing domain models and repository ports are extended only when a design state needs a missing, stable domain concept; generated transport types remain in `data/`.

## Complexity Tracking

No constitution violations or complexity exceptions are anticipated.
