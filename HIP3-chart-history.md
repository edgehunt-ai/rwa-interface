# HIP3 candle inspection and historical windows

Base: `rwa-interface/main` at `22f1751`. Frontend-only; no contract, backend,
bStocks chart, order, position or signing changes.

## Existing functionality preserved

- `hip3ChartProvider` still refreshes the current window 15 seconds after each
  request completes and cancels polling on disposal.
- Existing loading, error, empty and stale states remain. Retrying the latest
  chart does not discard loaded history.
- Repository → charts service → generated API client already supports explicit
  `from`, `to`, `interval` and decimal OHLCV. No duplicate HTTP implementation.

## Inspection

- Tap, long-press/drag or horizontal drag selects the nearest candle using its
  actual timestamp, including sparse intervals. Crosshair is at candle close.
- Readout defaults to the latest candle and uses UTC date/time through seconds;
  prices and base volume use the original decimal strings, including trailing
  scale. Missing O/H/L/V remain unavailable (`—`), never replaced by close/zero.
- Price unit is USDC; volume unit is the HIP3 product symbol, not USD turnover.
- Screen-reader increase/decrease actions step through candles.
- Product/window changes clear the selected candle. Line/candle mode is preserved.

## History

- “Load earlier candles” requests one earlier time window using the selected
  window's duration and interval. There is only one in-flight history request.
- Request inclusive `to=before`, filter locally to `[from,before)`; no 1ms
  subtraction because the API currently serializes timestamps at second precision.
- First history boundary rounds the live `from` up to an interval boundary so
  the straddling candle cannot fall into a gap. Subsequent windows are contiguous.
- Merge by timestamp, sort ascending; duplicate live timestamps update in place.
  Live snapshots win over historical overlap, including refresh during history I/O.
- A failed page keeps candles and the same boundary for retry. Successful empty
  windows advance the boundary but allow an explicit further request.
- Product/window family instances and disposal generations isolate late results.

### Deliberate API limitation

The current OpenAPI response has **no cursor, hasMore or earliest-available time**.
An empty window is therefore not proof that all earlier history is exhausted.
The UI explicitly says that window is empty and allows continued lookup; it does
not fabricate a terminal page based on a short/empty response.

Pagination stops once 5000 distinct candles are loaded or the Unix epoch is
reached. Hyperliquid documents availability of only the most recent 5000 candles:
[official candleSnapshot documentation](https://hyperliquid.gitbook.io/hyperliquid-docs/for-developers/api/info-endpoint#candle-snapshot).
This is **not** a cutoff of 5000 elapsed intervals (sparse markets can span longer).
An authoritative earlier end for sparse/new markets requires future backend
metadata; this task does not expand the API merely to guess such a boundary.

## Verification

- 26 targeted Flutter tests pass: provider pagination, UI inspection and state
  handling, plus existing generated transport/repository chart tests.
- Includes non-aligned boundaries, duplicate/out-of-window candles, retry,
  concurrent live updates, empty windows, terminal limits, late results across
  product/interval changes and dispose/recreate of the same key.
- Includes exact tiny/large decimal values, UTC date rollover, missing fields,
  375px portrait and 812px landscape with 2× text and dark theme.
- `flutter analyze --no-pub`: no issues. `git diff --check`: clean.
- Rendered/inspected phone crosshair screenshot with loaded font and icons;
  mechanical UI detector returned no findings. No full iOS build or device test.
