# HIP3 wallet history UI

This is a local extension for reading exact account history. It preserves the incumbent `AppTheme`, `AppPageScaffold`, and order-history implementation; it does not establish a new visual system or new global tokens. The history entry has three scrollable tabs: Orders, Funding fees, and Liquidations. Funding and liquidation panels read through Riverpod controllers and repositories.

## Sources and windows

Each wallet-history panel starts with the live provider source and a UTC window from now minus 30 days to now. The model normalizes bounds to milliseconds. The panel has no product filter or arbitrary date picker.

- Switching between “Read from provider” and “Saved archive” preserves both window bounds.
- “Previous 30 days” sets the end to one millisecond before the current start and subtracts 30 days for the new start, clamped at the Unix epoch. It is disabled at the epoch.
- “Latest 30 days” recalculates the window relative to now while retaining the selected source.
- Refresh and pull-to-refresh reload the current query. They do not move the window to now.
- Both bounds are displayed in UTC. Loaded results also show the trading environment and snapshot time.

Coverage is explicit. The retention notice says the provider does not guarantee permanent history retention. Partial coverage warns that missing records must not be interpreted as zero activity. An archive response with partial coverage displays the number of missing intervals, including when no records were returned. An empty result describes only the selected window, not the absence of account activity.

When partial coverage supplies `resumeFrom`, “Read missing history” switches to the live source with that value as the start and the existing query end as the end. It does not merge live and archive histories or individually navigate every missing range. Detailed covered/missing range bounds, warning arrays, and the `retentionGuaranteed` field are not individually rendered. In the model, only `sourceExhausted` and `archiveComplete` count as non-partial coverage; that classification does not establish permanent retention.

## Record presentation

The panel inherits theme text styles and standard Flutter controls. It uses a vertically scrolling list with 20 logical pixels of padding, wrapping window controls, and dividers between records. Monetary and position values are selectable text without ellipsis or display rounding. Transaction hashes are also selectable. There are no synthetic totals or inferred currency conversions.

Funding rows show the product ID, event time, exact settled amount, signed position size, funding rate, and transaction hash. A settlement asset is appended only when supplied. If it is absent, a visible notice says the amount is not a USD valuation. The collateral-token model field is not used to invent a display currency.

Liquidation rows retain the complete returned event group: event time, provider account value, account-value scope, every returned HIP3 position and its signed size, excluded native-position count, and transaction hash. Cross-account and isolated-account scope values have localized labels; other scope strings are displayed as supplied. The value caveat states that this is account value at the event, not the loss on an individual product, and assumes no settlement currency. Native positions are represented by the returned count, not fabricated position details. The separate `marginMode` model field is not independently displayed.

## Loading, recovery, and account changes

Initial loading uses a linear progress indicator. During loading or a top-level error, prior records are hidden. A top-level failure shows a localized error and retry action that invalidates the current provider. Pull-to-refresh failures reach this same visible recovery state.

A session-generation change resets the panel to the latest window for its selected source. The controller also watches session generation and repository changes. Pagination responses are ignored after disposal or a generation change, preventing an older request from appending into the replacement state.

“Load more records” follows the current page cursor using the same immutable query. While appending, existing records stay visible, a progress indicator appears, and repeated load actions are disabled. A pagination error preserves existing rows and shows a retry action. Successful append validates snapshot ID, environment, source, and observation time; rejects missing or reused cursors and conflicting records with the same ID; deduplicates identical records; and rejects a merged list exceeding 10,000 items. Pagination ends when `hasMore` is false.

## Targeted verification

The implementation was checked with targeted analysis (no issues reported), a six-test widget/capture run recorded in `/private/tmp/hip3-history-render-confirm.log`, and a four-file integration run reporting 38 passed in `/private/tmp/hip3-history-consumer-integration.log`. Two optional capture tests return early in standard runs, so that integration count is not a claim of 38 behavioral tests. Temporary logs are session evidence and may not persist.

The latest UI pagination run in `/private/tmp/hip3-history-ui-pagination.log` reports nine passed: eight behavioral tests plus the optional capture test returning early without capture configuration. The widget coverage checks the three-tab entry, precise funding values and unknown settlement asset, empty archive gaps and live gap queries with preserved bounds, immediate hiding of the previous account's facts, complete liquidation groups and caveats at enlarged text size, error retry and refresh preserving the query window, the previous window ending one millisecond before the old start, and a failed next page retaining earlier records and retrying the identical cursor. These added checks did not change the UI implementation or invalidate the reviewed captures.

An independent finish review inspected all six images in `.impeccable/review/hip3-history/`: funding and liquidation captures for phone light (375 × 812), phone dark with 1.6× text (375 × 812), and tablet light (834 × 1112). The reviewer returned ship within the deterministic Flutter scope, with no material findings. These images are synthetic Flutter widget rasterizations. They do not establish iOS simulator or hardware behavior, real-wallet/API correctness, or deployment status. No full iOS compile was performed, as explicitly requested.

## Implementation references

- `lib/ui/features/orders/views/hip3_order_history_screen.dart`
- `lib/ui/features/orders/views/hip3_wallet_history_panel.dart`
- `lib/app/providers/hip3_wallet_history_controller.dart`
- `lib/domain/models/hip3_wallet_history.dart`
- `lib/l10n/app_en.arb` and `lib/l10n/app_zh.arb`
- `test/ui/features/orders/views/hip3_wallet_history_panel_test.dart`

Documentation follows the scoped Impeccable document guidance: record observed component behavior and constraints without inventing tokens or promoting a local history extension into global brand rules.
