# Implementation Plan: Cross-Platform App Foundation

**Branch**: `001-app-foundation` | **Date**: 2026-09-02 | **Spec**: [spec.md](spec.md)

**Input**: Feature specification from `/specs/001-app-foundation/spec.md`

## Summary

Build the reusable Orbit application shell for Android, iOS, and web. Use declarative URL routing,
Material 3 theming with centralized semantic styles, localized strings, platform-adaptive system
interactions, safe page layout, shared feedback/copy components, and focused widget tests. Native iOS
automation and all business features remain out of scope.

## Technical Context

**Language/Version**: Dart 3.13.0, Flutter 3.47.0

**Primary Dependencies**: Flutter Material/Cupertino SDKs, `go_router`, `flutter_localizations`, `intl`

**Storage**: N/A; the foundation stores no user or business data

**Testing**: `flutter_test` widget and unit tests; manual iOS acceptance checklist

**Target Platform**: Android, iOS, and modern web browsers

**Project Type**: Cross-platform Flutter application

**Performance Goals**: Smooth platform transitions and interactions at target refresh rate; state
changes rebuild only their smallest reasonable consumer

**Constraints**: Material 3 foundation; centralized platform branching; light/dark appearance; 200%
text scale; no overflow at supported widths; no iOS integration-test target in this feature

**Scale/Scope**: One application shell, root/detail/not-found routes, five adaptive interaction
families, four shared feedback/copy components, English localization seed, and foundation tests

## Constitution Check

*GATE: Passed before research and re-checked after design.*

- **Specification and traceability**: PASS. FR-001 through FR-020 map to tasks and tests.
- **Layer boundaries**: PASS. Routing and core UI live outside feature business logic; no data layer
  is invented because this feature has no external data.
- **Correctness and tests**: PASS. Component and routing contracts receive widget tests; iOS-native
  behavior has a repeatable manual checklist per the explicit scope decision.
- **Security and integrity**: PASS. Copy behavior excludes secrets and raw diagnostics; no financial
  state is introduced.
- **Accessible, recoverable UX**: PASS. Safe layout, semantics, feedback, long text, text scaling, and
  not-found recovery are first-class requirements.
- **Modularity and rendering**: PASS. Platform differences are centralized; stateful behavior is
  isolated; shared components have bounded contracts.
- **Technical constraints**: PASS. Semantic theme, localization, file-size guidance, strict analysis,
  and dependency justification are included.

Post-design re-check: PASS. The contracts and model preserve these boundaries with no exceptions.

## Project Structure

### Documentation (this feature)

```text
specs/001-app-foundation/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/
│   └── foundation-ui.md
├── checklists/
│   └── requirements.md
└── tasks.md
```

### Source Code (repository root)

```text
lib/
├── main.dart
├── app.dart
├── app/
│   └── routing/
│       ├── app_router.dart
│       └── routes.dart
├── l10n/
│   ├── app_en.arb
│   └── generated/
└── ui/
    ├── core/
    │   ├── adaptive/
    │   ├── feedback/
    │   ├── layout/
    │   └── theme/
    └── features/
        └── home/views/

test/
├── app/
│   └── routing/
├── helpers/
└── ui/core/
    ├── adaptive/
    ├── feedback/
    ├── layout/
    └── theme/
```

**Structure Decision**: Retain the constitution's hybrid layered structure. App-wide routing and UI
primitives are core infrastructure; no repository, service, domain model, or use case is created
until a business feature requires one.

## Complexity Tracking

No constitution violations require justification.
