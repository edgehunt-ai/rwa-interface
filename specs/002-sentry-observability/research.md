# Research: Application Observability

## Installation method

**Decision**: Add the Flutter SDK directly and configure it in application-owned code.
**Rationale**: The runtime DSN is known; controlled edits are reviewable and avoid executing an
external wizard binary. CI symbol upload can be added independently with secret credentials.
**Alternatives considered**: The Sentry wizard automates setup but is unnecessary for runtime capture
and can make broader native and build changes.

## Sampling

**Decision**: Default to 10% traces and 10% profiles among sampled traces, overridable at build time.
**Rationale**: Bounded defaults provide production performance visibility with controlled volume.
**Alternatives considered**: 100% is costly; zero disables the requested performance monitoring.

## Privacy

**Decision**: Disable automatic PII and do not attach domain objects by default.
**Rationale**: The application handles identity, wallet, and financial data.
