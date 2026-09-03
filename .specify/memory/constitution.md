<!--
Sync Impact Report
- Version change: 1.0.0 -> 1.1.0
- Modified principles:
  - Template Principle 1 -> I. Specification-First and Traceability
  - Template Principle 2 -> II. Layered Architecture and Dependency Direction
  - Template Principle 3 -> III. Correctness, Testing, and Regression Protection
  - Template Principle 4 -> IV. Security, Privacy, and Financial Data Integrity
  - Template Principle 5 -> V. Explicit, Accessible, and Recoverable UX
- Added principles:
  - VI. Modularity, Component Reuse, and Rendering Isolation
- Added sections:
  - Technical and Product Constraints
  - Development Workflow and Quality Gates
- Initial constraints cover semantic theming, copyable content, long text, and component reuse checks.
- Expanded Principle II with a default Riverpod request boundary and documented exception policy.
- Removed sections: None; template placeholders were replaced.
- Follow-up TODOs: None.
- Amendment rationale: keep API request lifecycle, dependency injection, and state observation at
  the Riverpod/application boundary so generated transport details do not leak into presentation.
- Compatibility/migration: existing direct infrastructure calls remain valid when they are explicitly
  scoped as bootstrap, isolate, or test infrastructure; new feature code follows the Riverpod path.
-->
# RWA Interface Constitution

## Core Principles

### I. Specification-First and Traceability

Every non-trivial feature or behavior change MUST begin with a verifiable specification defining
user goals, flows, edge cases, scope, and measurable acceptance criteria. Plans, tasks, tests, and
implementation MUST trace to approved requirements. Requirement changes MUST update affected
artifacts before completion. Non-behavioral mechanical changes MAY use a reduced workflow.

Rationale: RWA products deal with assets, amounts, permissions, and potentially irreversible
operations; the team needs an agreed definition of correct behavior before choosing an implementation.

### II. Layered Architecture and Dependency Direction

The application MUST separate presentation, business logic, and data access. UI code MUST only
present state, collect input, and express user intent. Business rules MUST NOT depend on widgets,
screen lifecycle, or concrete transport and storage libraries. External API models MUST be mapped at
the data boundary rather than used as domain models. Dependencies MUST point toward the business
core. Exceptions MUST document scope, rationale, and containment in the feature plan.

Rationale: Stable boundaries limit the blast radius of UI, API, and business-rule changes and make
core behavior independently testable.

### III. Correctness, Testing, and Regression Protection

Behavior MUST receive automated verification proportional to risk: unit tests for business logic,
widget tests for material UI states and interactions, and integration tests for critical identity or
financial journeys. Defect fixes MUST include regression tests. Applicable tests MUST cover success,
failure, empty data, boundaries, and asynchronous races. Financial calculations MUST define precision
and rounding and MUST NOT use unreviewed binary floating-point arithmetic. Formatting, analysis, and
relevant tests MUST pass before completion.

Rationale: Visually plausible financial interfaces do not prove that their behavior or arithmetic is
correct.

### IV. Security, Privacy, and Financial Data Integrity

Secrets MUST NOT appear in source, logs, analytics, crash messages, or ordinary local storage.
Diagnostics MUST redact identity, account, and transaction data. External data MUST be validated.
Money MUST retain currency, unit, precision, and rounding semantics without implicit conversion. The
UI MUST distinguish pending, confirmed, and failed operations and MUST NOT infer final transaction
success. Authentication, authorization, and signing failures MUST fail closed. Security exceptions
MUST document threat, mitigation, residual risk, and approval.

Rationale: Disclosure or corruption of financial data can cause loss that is difficult or impossible
to reverse.

### V. Explicit, Accessible, and Recoverable UX

Screens MUST handle applicable loading, empty, success, partial-data, and failure states. Consequential
actions MUST disclose effects and require confirmation. Errors MUST explain recovery without exposing
internals, and recoverable failures MUST preserve valid input. Supported screens and text scales MUST
keep content and actions accessible without overflow. Core flows MUST provide semantic labels,
logical focus, sufficient contrast, and non-color status cues. User-relevant reference text MUST be
copyable. Dynamic text MUST have an explicit long-content strategy that preserves important meaning.

Rationale: Clear, accessible, and recoverable interactions reduce confusion and costly mistakes.

### VI. Modularity, Component Reuse, and Rendering Isolation

Code MUST follow single responsibilities and explicit change boundaries. Pages MUST compose flows,
not own independently testable business logic. Before creating a component, existing feature,
shared, and design-system components MUST be checked and reused, composed, or reasonably extended
when their semantics match. Cross-domain promotion requires proven reuse; forced reuse and
over-configured universal components are prohibited. Repeated patterns MUST be evaluated on their
second occurrence and extracted or justified before their third. Frequently changing state MUST be
observed by the smallest reasonable consumer; static regions MUST NOT subscribe to unrelated state.
Rendering optimizations MUST target measured bottlenecks. Splitting MUST preserve cohesive ownership.

Rationale: Intentional boundaries improve navigation, reuse, testing, and Flutter rebuild behavior
without replacing architecture with arbitrary file splitting or speculative abstraction.

## Technical and Product Constraints

- OpenAPI is the source of truth for HTTP contracts. Client code MUST NOT assume undeclared fields,
  states, or guarantees. Contract changes MUST trigger review of specifications, model mappings,
  compatibility behavior, and contract tests.
- Application API requests MUST normally flow through Riverpod providers/notifiers and their
  injected repository or use-case dependencies. Widgets, screens, and ordinary business classes
  MUST NOT construct Dio clients or call generated API operations directly. Bootstrap code, non-
  Flutter isolates, transport infrastructure, and focused tests MAY call lower layers directly only
  when the exception is explicit, narrowly scoped, and covered by tests.
- Shared UI MUST be layered as design-system primitives, cross-feature shared compositions, and
  feature-local components. Promotion to a broader layer requires proven consumers and compatible
  semantics; a generic `common/widgets` dumping ground is prohibited.
- Brand and semantic colors, text styles, and application-wide component styling MUST come from the
  Flutter theme or centralized semantic design tokens. Feature and page code MUST NOT declare
  unapproved `Color(...)` values, hexadecimal colors, or `Colors.*` values. Transparent colors,
  diagnostics, third-party adaptation boundaries, and design-system implementation MAY be exempt.
  Tokens MUST be named by purpose, such as surface, muted text, or warning status, rather than by a
  concrete color. Light, dark, and interactive states MUST remain semantically consistent.
- Spacing, dimensions, and local layout values MAY remain local. They MUST become shared tokens only
  when they represent an established design scale, have genuine cross-screen reuse, or require
  coordinated global adjustment.
- User-relevant identifiers and diagnostic references MUST use the project's consistent copyable-text
  pattern or expose an explicit copy action. Brief headings, button labels, navigation labels, and
  ordinary explanatory text do not require copying when no reasonable copy use case exists.
- Dynamic-text components MUST be verified with representative long content, localization expansion,
  and increased text scaling. Addresses and identifiers MAY use middle truncation for display, but
  their copy action MUST return the complete value. Error details MUST support wrapping or expansion
  and copying when safe; compact controls MUST preserve an identifiable action when truncating text.
- A hand-written Dart file over 400 lines or a widget `build` method over 80 lines MUST trigger a
  responsibility and extraction review. Generated files are exempt. Exceeding a threshold is allowed
  only when the review records why splitting would reduce cohesion, clarity, or testability.
- State subscriptions MUST be placed as close as practical to the widgets that consume the state.
  `const` constructors and immutable values MUST be used where applicable. Neither widget extraction,
  `const`, nor `RepaintBoundary` may be claimed as a performance fix without identifying the affected
  rebuild, layout, paint, or compositing cost.
- Performance work MUST begin with a reproducible scenario and measurement. The feature specification
  MUST define user-perceivable targets when data volume or interaction latency is material.
- New dependencies MUST have a clear owner and purpose. A dependency that duplicates the standard
  library or an existing project capability MUST NOT be added without documented justification.
- User-visible text MUST be localizable and MUST NOT be scattered as unmanaged literals.
- Runtime failures MUST be converted into understandable domain failure states; raw exceptions and
  stack traces MUST NOT be shown to users.
- Supported platforms, minimum system versions, and browser coverage MUST be recorded before the
  first production client feature is approved.

## Development Workflow and Quality Gates

Non-trivial features MUST follow `specify -> clarify (when needed) -> plan -> tasks -> analyze ->
implement`. Before implementation, the specification MUST have no unresolved critical clarification;
the plan MUST address architecture boundaries, data flow, errors, security impact, rendering impact,
and testing; and tasks MUST be independently verifiable and traceable to requirements.

Before completion:

- Every acceptance scenario MUST be verified.
- Formatting, static analysis, and relevant automated tests MUST pass.
- OpenAPI changes MUST receive a compatibility review.
- New dependencies and architectural complexity MUST be justified.
- Undocumented TODOs, temporary code, secrets, and debug logging MUST be absent.
- Documentation and generated Spec Kit artifacts MUST describe the final behavior.

Code review MUST check specification compliance, layer boundaries, test coverage, security and
privacy, numeric precision, state and error handling, accessibility, component ownership, and
rendering scope. Review of a new component MUST confirm that existing components were checked, its
ownership layer is correct, and it neither duplicates existing capability nor creates an
over-configured universal component. A failed mandatory gate blocks completion.

## Governance

This constitution supersedes informal development practices, feature plans, and task descriptions.
An amendment MUST include its rationale, affected principles or workflows, compatibility impact, and
any required migration plan. Approval requires explicit review by the project maintainers before the
new rules govern subsequent work.

Constitution versions follow semantic versioning: MAJOR for removal or incompatible redefinition of
a principle or governance rule, MINOR for a new principle or material expansion, and PATCH for
non-semantic clarification. Every feature plan and code review MUST include a constitution compliance
check. An exception MUST be recorded in the plan with its precise scope, risk, alternatives, expiry or
containment strategy, and approving maintainer; schedule pressure alone is not sufficient.

**Version**: 1.1.0 | **Ratified**: 2026-09-02 | **Last Amended**: 2026-09-03
