# Theme-aware illustration assets

The current illustrations come from Figma's [插图更新 · Dark mode test](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/NoBell?node-id=3414-15052).
Its dark image fills have transparent backgrounds and dark materials. Existing
light artwork is retained at the original paths; the dark variants use the same
paths with `_dark.webp`. `ThemedIllustration` selects the appropriate artwork
from `Theme.of(context).brightness`, including changes to the system appearance.
Transparency controls the surrounding surface; it does not change artwork colours.

Paths below are relative to `assets/figma/`.

| Dark variant of asset | Figma image node | Export pixels (3x) |
| --- | --- | --- |
| `account_activity/private_key_warning.webp` | `3453:62520` | 360 × 360 |
| `common/empty_state_illustration.webp` | `3453:62377` | 360 × 360 |
| `common/error_state_illustration.webp` | `3453:62420` | 360 × 360 |
| `common/sign_in_illustration.webp` | `3453:62333` | 360 × 360 |
| `funding/deposit_empty.webp` | `3453:62200` | 360 × 360 |
| `funding/deposit_received.webp` | `3453:62173` | 360 × 360 |
| `home_markets/favorites_empty_illustration.webp` | `3453:62289` | 360 × 360 |
| `trade/funding_pending.webp` | `3453:62870` | 360 × 360 |
| `trade/order_submitting.webp` | `3453:62690` | 360 × 360 |
| `trade/order_success.webp` | `3453:62797` | 360 × 360 |

The funding-pending node is named `v0.9 10-order-success` in Figma, but its
image fill depicts the transfer tray on the Preparing Trading Funds screen.
Use the image in that slot rather than inferring its purpose from the layer name.

Export each 120 × 120 image node as a 3x PNG with `contentsOnly: true`, then
convert to lossless WebP while preserving alpha. Exporting without `contentsOnly`
can include the parent screen background even when the image fill is transparent.
The read-only Figma Plugin API export is:

```js
const png = await node.exportAsync({
  format: 'PNG',
  contentsOnly: true,
  constraint: {type: 'SCALE', value: 3},
});
```

With ImageMagick, convert the exported PNG without resizing or flattening:

```sh
magick export_3x.png -strip -define webp:lossless=true illustration_dark.webp
identify -format '%f opaque=%[opaque] corner=%[pixel:p{0,0}]\n' illustration_dark.webp
```

The 3x PNG and WebP must have identical alpha values and identical RGB values
where alpha is nonzero. RGB in fully transparent pixels is not visible and may
be discarded by the WebP encoder. Several embedded Figma source images are only
200 × 200; exporting at 3x does not add detail to those sources.

Flutter display sizes are retained. The previews in
`lib/ui/core/widgets/themed_illustration_previews.dart` show both appearances.
`test/ui/core/widgets/themed_illustration_test.dart` checks live system/explicit
theme switching, stable image geometry, actual asset decoding, 3x dimensions,
transparent corners and nonempty artwork.

`home_markets/login_prompt.webp` and `trade/unified_trading_illustration.webp`
already retain transparency and do not need background removal. The account
avatar is a separate profile image, not a state illustration.
