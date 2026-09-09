# Quickstart Validation: Implement Figma Screens

## Prerequisites

1. Use the `feat/006-implement-figma-screens` branch.
2. Fetch dependencies with `flutter pub get`.
3. Use representative authenticated and unauthenticated fixtures or the configured API environment. Do not use production account data for manual validation.
4. Refer to [the screen inventory](spec.md#design-screen-inventory), [the presentation-state contract](contracts/ui-state-contract.md), and [the domain model](data-model.md).

## Supported release environments

| Platform | Minimum | Coverage |
|---|---|---|
| iOS | 17.0 | Native Flutter smoke and accessibility validation |
| Android | API 28 | Native Flutter smoke and accessibility validation |
| Web | N/A | Not a supported release target for this feature |

## Run the baseline checks

```sh
flutter analyze
flutter test
```

Expected result: formatting/static analysis and the existing relevant tests pass before adding a screen slice.

## Validate each design-frame slice

1. Open the inventory item in its Figma link and retrieve the node's design context before editing its Flutter implementation.
2. Run the app at the mobile reference width and reach the screen from its documented parent flow.
3. Compare hierarchy, typography, spacing, semantic colors, selected state, icon/brand assets, and overlay placement against the node.
4. Exercise the applicable loading, success, empty/partial, unavailable, failure, and command-pending outcomes.
5. Verify financial values use expected token decimals and formatting; verify copy controls return the full relevant reference.
6. Verify an enlarged-text/long-label scenario and keyboard/focus/back/dismiss behavior.
7. Add or update the proportional provider/widget/acceptance test, then rerun the targeted test and `flutter analyze`.

## Journey smoke checks

### Home, Markets, Assets, and Funding

- Home opens with portfolio, quick actions, market tabs, and active navigation.
- Market search/filter, all-stock, and market-status paths return safely to the previous state.
- Asset allocation/tabs/expanded variants preserve selection state.
- Deposit and withdrawal route selection, input, review, authorization, and resulting activity remain clear and recoverable.

### Trade

- bStocks and HIP-3 variations preserve product kind, side/order validation, chart/time/reference-price states, and explicit unavailable/market-status treatment.
- An invalid trade input cannot submit; a confirmation view shows the appropriate price, amount, fee, and outcome semantics.

### Settings and Activity

- Each settings variation and activity screen has a reachable route/overlay and safe return behavior.
- Activity distinguishes pending/success/failed/cancelled/unknown records and supports copies of user-relevant references.

## Implementation validation record (2026-09-07)

### Automated evidence

- The targeted provider, widget, and acceptance suites cover the Settings warning/logout flows, Activity tabs/status-filtered copyable references, bStocks/HIP-3 order states, invalid HIP-3 limit-price rejection, and order/position confirmation flows. `test/ui/features/activity/figma_screen_states_test.dart` and `test/ui/features/account/figma_screen_states_test.dart` also exercise their Figma layouts at 320px wide with 200% text scale and assert that no layout exception occurs.
- All committed Figma assets have a durable path in the inventory. The inventory records the 393px canvas, 353px content width, and the relevant fixed leaf/container geometry for each asset rule or exception.
- The Activity view uses generated localizations for visible category/filter/status labels, and row titles use ellipsis while full user-relevant references remain copyable.
- The bStocks limit-price selector retains its price as integer cents and delegates every rendered price/percentage and editable fixed-scale value to `TokenAmountFormatter`; it does not format financial output through `double` or `toStringAsFixed`.

### Manual device validation

An Android API 35 emulator was run at an overridden 393×852 display size with system font scale `2.0`. The Home/Markets initial state, horizontal Markets ranking tabs, Activity filters, and horizontally scrollable Activity tabs were inspected from device screenshots. The original enlarged-text inspection exposed Markets and Activity tab overflows; those controls were converted to dynamic-height/scrollable layouts, then the app was rebuilt and rerun. The final device log contained no new `RenderFlex overflowed` entry, and the Activity tab strip was manually scrolled through to the Approvals tab.

The automated suite additionally covers Settings’ private-key warning, Activity, and Markets at 200% text scale. Before release, a maintainer should still perform the seven-step “Validate each design-frame slice” checklist for authenticated account data and every financial action at the 393px reference width. No production account or private key is needed for that review.

## Final architecture and safety review (2026-09-07)

- Presentation code uses Riverpod providers/notifiers and does not instantiate Dio or generated OpenAPI clients under `lib/ui`.
- Order preview/submission and activity/settings commands remain behind repositories/providers. The UI renders domain values through the shared formatter.
- The private-key reveal/copy node (`461:6764`) is intentionally **blocked**, not implemented: the current authenticated account contract provides no safe export capability. The warning remains reachable and confirmation dismisses safely; no key, placeholder secret, or export control is fabricated. This is the sole non-verified inventory item and requires a reviewed domain/API security design before implementation.
- Asset geometry, semantic colors, copyable activity identifiers, limit-price validation, and recoverable failure feedback are covered by the targeted tests. Manual enlarged-text/device validation remains the release follow-up documented above.
