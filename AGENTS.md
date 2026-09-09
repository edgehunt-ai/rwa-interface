# Agent implementation guidance

## API request boundary

- Prefer `Riverpod` providers/notifiers for all application-facing API requests.
- Keep the normal dependency direction as `Widget/screen → Riverpod → repository/use case → service → generated client`.
- Do not construct `Dio` or call generated API operations directly from widgets, screens, or ordinary business classes.
- Use direct lower-layer calls only for narrowly scoped bootstrap code, non-Flutter isolates, transport infrastructure, or focused tests. Document the exception and cover it with tests.
- Keep generated client types and transport exceptions inside the data boundary; expose domain models and stable failures to presentation/state code.

## Generated client

- Treat `contracts/rwa-api-contract/openapi/main.yaml` as a read-only submodule input.
- `git@github.com:edgehunt-ai/rwa-api-contract.git` is the contract source of truth; do not modify its contents from this repository.
- Do not hand-edit generated files under `packages/rwa_api_client`.
- Use `npm run api:update` or `npm run api:update:branch -- <branch>` to update the submodule and refresh the checked-in client.
