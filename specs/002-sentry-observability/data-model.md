# Data Model: Application Observability

## Observability Configuration

- DSN: overridable endpoint; empty disables monitoring
- environment: deployment label
- release: optional build release identifier
- traces sample rate: decimal from 0 through 1
- profiles sample rate: decimal from 0 through 1, relative to sampled traces

Invalid numeric values fall back to bounded defaults. No configuration contains an auth token.
