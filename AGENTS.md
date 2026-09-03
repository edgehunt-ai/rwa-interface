# Agent implementation guidance

## API request boundary

- Prefer `Riverpod` providers/notifiers for all application-facing API requests.
- Keep the normal dependency direction as `Widget/screen → Riverpod → repository/use case → service → generated client`.
- Do not construct `Dio` or call generated API operations directly from widgets, screens, or ordinary business classes.
- Use direct lower-layer calls only for narrowly scoped bootstrap code, non-Flutter isolates, transport infrastructure, or focused tests. Document the exception and cover it with tests.
- Keep generated client types and transport exceptions inside the data boundary; expose domain models and stable failures to presentation/state code.

## Generated client

- Treat `openapi/main.yaml` as the contract source of truth.
- Do not hand-edit generated files under `packages/rwa_api_client`.
- After contract changes, run `npm run client:regenerate`; use `npm run quality:check` for validation without replacing the checked-in client.
