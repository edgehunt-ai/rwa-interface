# Agent implementation guidance

## API request boundary

- Prefer `Riverpod` providers/notifiers for all application-facing API requests.
- Keep the normal dependency direction as `Widget/screen → Riverpod → repository/use case → service → generated client`.
- Do not construct `Dio` or call generated API operations directly from widgets, screens, or ordinary business classes.
- Use direct lower-layer calls only for narrowly scoped bootstrap code, non-Flutter isolates, transport infrastructure, or focused tests. Document the exception and cover it with tests.
- Keep generated client types and transport exceptions inside the data boundary; expose domain models and stable failures to presentation/state code.

## User-visible errors

- Preserve concrete failure reasons from APIs, domain failures, signing flows, and SDKs through every layer. Prefer the actual readable reason over a generic failure message.
- If a command returns `null` or `false` after recording a failure in provider/notifier state, read and display that failure. Do not interpret an empty result alone as a missing server response.
- Unwrap provider/dependency exceptions before choosing the message. Preserve API messages, failure reasons, and useful validation details; when no readable reason is supplied, retain available status/code information.
- Use a generic localized fallback only when no meaningful failure detail is available. A shared error formatter must standardize extraction and presentation, not replace distinct errors with the same text.
- Apply this rule to submissions, quotes, refreshes, recovery actions, and loading failures. Preserve valid inputs and retry/recovery behavior when displaying an error.
- Do not display secrets, credentials, raw payloads, or stack traces. Remove sensitive content while retaining the specific cause; "do not expose internal details" does not mean hiding actionable business errors or safe SDK failure reasons.
- Add regression coverage when fixing lost error details, verifying the visible reason rather than only the presence of an error widget.

## Generated client

- Treat `contracts/rwa-api-contract/openapi/main.yaml` as a read-only submodule input.
- `git@github.com:edgehunt-ai/rwa-api-contract.git` is the contract source of truth; do not modify its contents from this repository.
- Do not hand-edit generated files under `packages/rwa_api_client`.
- Use `npm run api:update` or `npm run api:update:branch -- <branch>` to update the submodule and refresh the checked-in client.
