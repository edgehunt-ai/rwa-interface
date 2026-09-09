# UI State Contract: Figma Screen Implementation

## Purpose

This contract defines the stable boundaries between Flutter screen composition and existing feature state. It is internal to the application; it does not expose new HTTP endpoints.

## Presentation dependency rule

```text
Screen/widget → Riverpod provider/notifier → repository port → data service → generated client
```

Screens and ordinary business classes must not construct Dio or call generated operations. Generated types and transport exceptions stay inside the data boundary; presentation receives domain models and stable failure state.

## Required screen-state mapping

| Source condition | Required presentation outcome |
|---|---|
| Provider loading | Designed loading treatment; do not show stale values as current without an explicit stale/partial cue. |
| Provider success with data | Render the matching design state from domain entities. |
| Provider success with no data | Render the applicable designed empty state. |
| Provider partial data | Render usable data plus a clear partial/retry cue. |
| Provider/domain failure | Render a recoverable user-facing failure without a raw exception or stack trace. |
| Unsupported product/route | Render unavailable state; financial command is disabled. |
| Command in flight | Render pending state and prevent accidental duplicate submission. |
| Command success/failure | Invalidate or refresh the documented state, retain valid inputs where safe, and communicate outcome clearly. |

## Navigation and overlay contract

- Each inventory entry has one direct Figma link, an initial parent context, and an explicit type: route/state candidate, overlay, or component reference. A task replaces the initial parent context with the concrete in-app entry/dismiss path once the node has been read.
- Bottom navigation preserves the active destination context for Home, Market, Assets, and Activity.
- Search, filter, expanded content, sheets, pickers, review screens, and status explanations have a clear back/dismiss path.
- Returning from an overlay restores safe input and selection state.

## Financial display contract

- Use domain `DecimalValue` and the shared `TokenAmountFormatter` path for all customer-visible amounts, quantities, prices, fees, PnL, and token values.
- Use token decimals supplied by the domain contract; never use binary floating-point or feature-local rounding for presentation.
- Very small non-zero values cannot silently render as zero.
- Status and movement always communicate meaning in text or iconography as well as color.

## Asset and accessibility contract

- A design asset is either stored durably in the application or matched to an existing project asset with the same glyph.
- The asset container and leaf dimensions preserve the Figma design's geometry.
- Interactive controls expose semantic labels and usable tap targets.
- Account/transaction references support copying the full value even when the displayed form is truncated.
- Long localized strings and enlarged text must retain primary actions, amounts, and statuses without clipping.
