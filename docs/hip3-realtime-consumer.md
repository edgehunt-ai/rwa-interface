# HIP3 realtime consumer — locally verified, rollout pending

The contract submodule and generated SDK now resolve local commit
`309211050b02510fef5bb0df0f802a11420f5554` (OpenAPI SHA-256
`221776abef15f3d9a74b4f31b120cdd4f28da5352b5f62f51c7e44db39c6252e`).
The official updater regenerated the SDK. Remote configuration was not changed;
the local commit is not yet published. The updater's whole-project quality stage
still encounters eight existing funding deprecation infos outside this task.

## Explicit rollout configuration

Order snapshots cover all active/unresolved orders and the latest 100 terminal
orders, not complete order history. History remains REST-paginated. The same
connection may deliver another `hip3_snapshot` with a new cursor when membership
changes. The accumulator atomically replaces its cache; disappearance alone is
not cancellation or closure. Consumers must not reconnect or submit a signature
because a replacement snapshot arrived. Existing REST refresh/fallback remains.

`--dart-define=HIP3_REALTIME_ENABLED=true` now enables the client path; omission
keeps it disabled. `HIP3_ACCOUNT_ENVIRONMENT` remains `testnet` by default and is
not inferred from a public market's network. The server separately requires
`RWA_HIP3_REALTIME_ENABLED=true` and validated matching sources. Neither setting
changes signing/trading permissions or disables REST recovery. The enabled build
flag regression passed, and the default flag/controller/scope/detail integration
passed 17 tests. No build/deployment environment has been changed. Large-account
window regression now passes on the backend; inactive-subscription cleanup,
omitted-DEX completeness and prolonged-load acceptance remain before rollout.
The latest six-file consumer regression passed 36 tests, including replacement
snapshots, replay, identity scope and order-detail refresh. This batch is ready for
a local checkpoint, not a claim of deployment. GitHub access was restored using
the user's authorized account switch; publication proceeds contract-first.

## Transport guarantees implemented locally

- Stream parsing preserves CRLF across byte/chunk boundaries and discards a
  partial frame at EOF. A linear frame buffer is limited to 12 Mi UTF-16 code
  units; this includes room for the server's bounded snapshot envelope.
- SSE header identity must agree with the validated JSON envelope. HIP3 cursors
  must have a canonical stream ID and a nonnegative signed-64-bit sequence.
- A subscription freezes its channel set. Caller mutation cannot reuse a cursor
  against different channels on reconnect.
- HIP3 replay uses one `BigInt` watermark, rejects stream changes, and drops older
  or repeated sequences. Generic reserved channels retain only 256 recent IDs.
- Recovery instructions bypass business-event deduplication. The consumer sees
  `resync_required` even if its ID was seen; it must then resubscribe without the
  old cursor. Transport does not silently replace the application's snapshot.
- Duplicate events do not regress `Last-Event-ID`. It advances after delivery;
  this is not a durable database acknowledgement protocol.
- Authentication/permission/validation failures do not retry the invalid session.
  Existing bounded reconnect behavior remains for transient failures. Prior Dio
  requests are cancelled before waiting for reconnect backoff.
- A successful response must be HTTP 200 with a `text/event-stream` media type.
  HTTP 204 reports `realtime_disabled` without reconnecting; wrong or missing
  content types report a decoding failure instead of silently ending the stream.
- New delivered events restore the retry budget. Duplicates and heartbeat-only
  connections do not; exhausted EOF retries report a retryable network failure so
  state consumers can fall back instead of mistaking disconnection for success.
- Cancelling a subscription interrupts both a request awaiting headers and its
  reconnect delay. The production delay timer is cancelled; pause/resume is
  forwarded to the underlying stream. Per-wait cancellation signals do not retain
  a listener for every historical reconnect on one long-lived future.
- Nested HIP3 resource identities are mapped from the payload, not outer aliases.
  HIP3 stream sequence numbers are not interpreted as entity business versions.
  Raw and entity providers rebuild on session-generation changes.

## Still required before enablement

`data/api/hip3_realtime_state.dart` now implements the data-boundary accumulator:
it validates the exact snapshot subscription, signer and account environment,
while public market updates match their own fully qualified subscribed environment.
It replaces snapshots atomically, applies nested updates without mutating previous
states, preserves explicit zero-position and cancelled-order facts, rejects
cross-stream changes and resets on `resync_required`. A delta cannot initialize
state after that reset. Large cursor comparisons use `BigInt`.

The live candle cache keeps three recent windows per product/environment/interval,
allows corrections, and does not replace REST chart history. Oversized initial
candle snapshots are rejected, not truncated. Account entries are not silently
evicted: the accumulator fails at its 1,000-resource/8 MiB bounds. Every resource
also has a 512 KiB payload bound. Those safeguards do not resolve the server's
large-account collection strategy. Missing snapshot members are not fabricated
cancellations or closed positions.

`Hip3LiveRepositoryImpl` now consumes the accumulator and maps all five resource
kinds to domain models. Orders/positions use the existing REST mappers; the
portfolio summary mapper is shared with REST. Market amounts retain settlement
asset and unit metadata, candles use wire intervals such as `1m` rather than
generated enum identifiers, and balance assets retain exact amounts, absent
valuations, source and freshness. Raw projections and generated types remain
inside the data boundary. Unexpected EOF reports a network failure.

`hip3LiveConnectionProvider` now manages these repository subscriptions with an
explicit query plus session-generation key. Background, disabled configuration,
old-generation requests and unobserved providers release their connections.
Resync immediately clears the live overlay and creates a fresh subscription after
bounded backoff. Two consecutive resync retries without incremental recovery are
allowed; further recovery instructions fall back. Initial snapshot waiting is
bounded to 45 seconds. Errors clear the overlay and leave REST available; they do
not automatically retry authentication or validation failures. The provider's
enabled flag still defaults to false.

`hip3LiveIdentityProvider` now resolves the authenticated App wallet list across
bounded pages, requiring exactly one active Hyperliquid wallet. It rejects duplicate
wallet IDs, cursor loops, excessive results and ambiguous/missing signers. Late
responses cannot restore an old session. `HIP3_ACCOUNT_ENVIRONMENT` defaults to
the existing `testnet` execution deployment; it is distinct from public market
environment. Disabled/background identity reads issue no wallet request.

The shared `hip3AccountLiveProvider` now feeds the actual HIP3 orders, open-orders,
position lists, active-position actions, holdings and portfolio-summary queries.
These account views use push-driven REST refresh: a one-second coalescing timer
retains server filtering and pagination rather than splicing a whole live snapshot
into a cursor page. Changes during an in-flight read schedule one follow-up after
completion. Disposed, unobserved and background queries do not issue that read.
Internal-ledger account queries are unchanged. Existing ten-second polling remains
available whether push is disabled, unavailable or recovering.

The actual HIP3 order-detail screen now owns a page-lifetime refresh listener.
Only a successfully loaded, matching HIP3 order enables its shared account stream;
bStocks/mismatched details do not. HTTP loading/errors retain the listener, so
refreshes cannot recreate the only stream and cause a snapshot-refresh loop.
Cursor changes and live loss coalesce into a one-second REST refresh; in-flight
pushes schedule a follow-up after completion. Background/disposal cancel timers,
and a session-generation change discards the old listener. Five new lifecycle
tests plus existing detail/account-refresh tests passed 34 cases; targeted
analysis passed. The actual position panels already consume the push-refreshed
`positionsProvider`; the generic `positionProvider` has no current page consumers.
No unused generic coordinator or detail overlay is required for these pages.
Full runtime/network acceptance still needs completion. SSE remains
disabled by default; the account-page connection does not establish runtime or
real-network delivery.

## Direct price updates

The actual market snapshot provider now watches a separate REST baseline and the
scoped market live provider. A price tick updates the displayed Mark price and its
24-hour change only when full product/venue/environment/settlement identity matches,
its source observation is strictly newer than the baseline and it remains fresh.
Future-dated observations and source-time regression are rejected. Source-time
regression in a stream fails the accumulator without advancing its cursor.

Book levels, other statistics, independent reference fields and their observation
time remain from REST. Price-only provenance is retained separately. The aggregate
freshness deadline is the earlier of REST and price deadlines, so neither a fresh
tick nor a short-lived tick can misrepresent the combined snapshot as fresh.
Ticks do not restart HTTP polling or refetch the book. Live loss while foreground
invalidates the REST baseline; the trade-screen retry also refreshes that baseline.

## Direct candle updates

`CandleSeries.hip3_provenance` now carries exact product/network/source plus the
source observation and freshness deadline. The generated consumer maps this into
the chart and each REST bar. Missing metadata leaves REST usable without guessing
an observation from `fetchedAt`. Product, network, source and requested interval
mismatches fail at the repository boundary.

The real chart provider now keeps its 15-second REST query independent from its
scoped live subscription. Newer, fresh, matching observations correct/extend only
recent bars; REST history/reference fields and their receipt time remain intact.
Losing live delivery or selecting retry invalidates the actual REST baseline.
History merging compares per-bar source observations so a delayed REST fallback
cannot undo a newer streamed bar. Source observations are not exchange-global
revision numbers; equal or incomparable observations are not guessed to be newer.
History retains at most the newest 5,000 bars, including during long-lived live
rollover; this is a display cache, not an archival completeness promise.

The latest seven-file frontend integration passed 53 tests (including the existing
optional capture test without a capture request). This is not real-network or
runtime enablement. Backend source/precision regression remains separately tracked.
The generic repository now maps nested HIP3 entity IDs,
but that does not apply snapshots or maintain page-level HIP3 state.
The generic coordinator is not yet wired to HIP3 and has additional state-retention
work. Page lifecycle, session isolation and polling fallback need end-to-end
verification. Do not enable runtime SSE or disable polling merely because the SDK
and transport tests pass. No trading command is replayed by this transport.
