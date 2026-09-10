# HIP3 Testnet acceptance

## Scope

Two small Testnet Limit/GTC orders, each 12–15 USDC notional, using an account
already configured for Cross 1x. One must rest and then be cancelled; the other
must fill and be queryable. Never substitute a mock result or a direct exchange
submission for the app → API → worker flow.

## Prerequisites

- Deploy the matching frontend and backend. The backend must include the
  retryable `hip3_action_not_ready` response and schema migration 0031.
- Confirm the API environment is Testnet, preflight and reconciliation workers
  run, and the authenticated app wallet matches the trading account.
- Confirm the target client supports EIP-712 signing. The native Privy gateway
  implements it; the current web gateway still needs its signing integration.
- Confirm Unified Account spot USDC collateral after holds and the app's actual
  funding ledger. Per-DEX withdrawable is not the Unified Account collateral
  source. No manual fake ledger credit.
- Do not put keys, login tokens or signatures in source, fixtures, screenshots,
  logs or this report.

## Corrected client behavior

- HIP3 lists send `kind=perp`; the unscoped/bStocks request is unchanged.
- Resting HIP3 cancellations create an independent `cancel_order` action and
  sign its step. Unsubmitted local orders keep the existing cancellation path.
- Only `hip3_action_not_ready` is retried as preparation latency, using the same
  creation key. Permanent execution and idempotency errors are not hidden.
- Ambiguous/submitting actions are polled, not signed again. Lost submission
  responses are queried before any same-key/same-signature retry.
- Bounded unresolved recovery retains the original order/action identity and
  displays confirmation pending rather than success or invalid signature.

## Evidence to record

For each scenario record environment, backend/frontend revisions, account
address, product, quantity, limit price, order/action IDs, provider order ID,
observed transitions and final reservation/ledger outcome. Record no secrets.

1. Resting/cancel: observe `open`, submit a signed cancel action, then verify
   original order `cancelled`, zero fills (or truthful partial fills if raced),
   and matching release/settlement. An accepted cancel action alone is not proof
   of zero fills.
2. Fill/query: submit a bounded marketable limit, observe provider fill facts,
   query order/detail/list, and verify exact filled quantity, average price,
   fees and one terminal settlement. The resulting position is not automatically
   closed by this acceptance task; any cleanup trade needs an explicit plan.
3. Retry: resend the identical callback key/signature and verify no second order,
   broadcast claim or ledger settlement is created.

## Current live status

Real API/client-signing/worker acceptance passed on 2026-09-10 (Asia/Shanghai).
This used a standalone client-signing driver and an isolated, locally issued test
identity, not the Flutter/Privy UI. Native App login/signing acceptance is still
outstanding. Trading, risk, broadcast, fills and settlement were real Testnet.

- Rest/cancel: App order `04393e97-d0f5-4c43-89de-c37f4bc362ce`, venue
  `59716126380`, 0.05 TSLA at 260; confirmed cancelled, no fills, 13.0351 USDC
  reservation fully released.
- Fill/query: App order `70ea3b52-fea9-4a11-b61f-f73138678247`, venue
  `59716206315`, 0.033 TSLA filled at 390.5. Detail/list both contain trade
  `303149827625949`, actual fee 0.001159 USDC, reconciliation matched.
- Identical callback retries returned identical results, with one placement/fill
  and one terminal settlement per order. No open xyz orders remained. Account 2
  retains the resulting 0.033 TSLA long position; it was not automatically closed.
- Live verification uncovered/fixed Testnet preview time ordering and separate
  confirmation/signing lifetimes. Context/quote confirmation is bounded at 60s;
  signed actions expire two minutes after order creation. Fresh risk is still
  required transactionally at order creation and broadcast.
- The isolated ledger's opening adjustment was backed by an actual observed
  balance. This is not deposit-ingestion acceptance. No staging deployment or
  production account database was changed.

Full evidence: sibling backend repository
`docs/hip3-testnet-acceptance-2026-09-10.md`.

Current preflight findings (snapshots, not order authorization evidence):

- The repository's example staging API, `https://rwa-api-staging.dxd.ink`, returns
  200 for health/readiness and serves OpenAPI 1.8.0 with the new HIP3 context and
  step-submission paths. `/v1/me` returns 401 `access_token_required`; authenticated
  account binding, deployed code revision and worker configuration are unverified.
- `xyz:CL` is `onlyIsolated=true`, `marginMode=noCross`, and its book was empty.
  Do not try to convert CL to Cross 1x; it is unsuitable for this acceptance slice.
- `xyz:TSLA` supports Cross. Account 2 was changed to Cross 1x and queried to
  confirm before acceptance. XYZ100 was not used or reconfigured.
- Select prices/quantity from a new book immediately before each order; recorded
  book snapshots must not be reused as executable prices.
- A real authenticated frontend runtime remains unverified. Wallet private keys
  do not substitute for Privy authentication; the user allowed the isolated test
  identity for the backend acceptance described above.

Local tests use the existing SDK engine explicitly because this machine's
untracked Flutter SDK checkout cannot infer its correct engine revision:

```sh
FLUTTER_PREBUILT_ENGINE_VERSION=a804b261645ef8c13eb3d5c44a5c2fb0340c5539 \
  /private/tmp/hip3-flutter-sdk/bin/flutter test --no-pub
```
