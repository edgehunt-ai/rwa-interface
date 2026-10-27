# Theme tokens and dark mode

All colours in the app come from `lib/ui/core/theme/app_theme.dart`. Widgets,
screens and painters must never declare colour literals.

## Token source

`AppColorTokens.light` and `AppColorTokens.dark` mirror the design token files
`Light.tokens.json` and `Dark.tokens.json` one-to-one (30 colour tokens each).
When the tokens change, update both maps and the parity test in
`test/ui/core/theme/app_theme_test.dart`.

| Token group | Flutter field |
| --- | --- |
| `surface.canvas` / `base` / `subtle` / `warm` | `surfaceCanvas` / `surfaceBase` / `surfaceSubtle` / `surfaceWarm` |
| `text.primary` / `secondary` / `tertiary` / `inverse` | `textPrimary` / `textSecondary` / `textTertiary` / `textInverse` |
| `icon.primary` / `secondary` / `brand` / `inverse` | `iconPrimary` / `iconSecondary` / `iconBrand` / `iconInverse` |
| `border.subtle`, `divider.soft`, `overlay.scrim` | `borderSubtle`, `dividerSoft`, `overlayScrim` |
| `action.primary` / `primary-pressed` / `secondary` | `actionPrimary` / `actionPrimaryPressed` / `actionSecondary` |
| `brand.default` / `soft` | `brandDefault` / `brandSoft` |
| `illustration.lime` / `sky` / `orange` / `mint` | `illustrationLime` / `illustrationSky` / `illustrationOrange` / `illustrationMint` |
| `semantic.success` / `warning` / `danger` (+ `-soft`) | `AppSemanticColors.success` / `warning` / `danger` (+ `successSoft`, …) |

Third-party marks (network logos) are fixed across appearances and live in
`AppBrandColors`.

## Reading colours

```dart
final colors = context.appColors;        // AppRwaColors
final semantic = context.semanticColors; // AppSemanticColors
```

Both getters fall back to the brightness-matching token set when a widget is
rendered outside the app theme (for example an overlay inserted by a test
harness), so they never return `null`.

Inside `ThemeData` construction use the token object directly.

## Appearance selection

`appThemeModeProvider` (`lib/app/providers/theme_mode_provider.dart`) holds the
selected `ThemeMode` and persists it through `ThemeModeService`. It defaults to
`ThemeMode.system`; Settings → Display Mode opens a bottom sheet where the user
picks Light, Dark or System. The choice is applied immediately (the sheet pops
with the selection) and `AppRoot` watches the provider, passing the value to
`MaterialApp`.

Bootstrap reads the saved choice before creating `AppRoot`, so the first Flutter
frame uses the selected appearance. On Android 12+, `ThemeModeService` also
synchronizes the choice through `global.nobell.app/appearance` to
`UiModeManager.setApplicationNightMode`. Android persists this per-app override
and uses it for the system splash before Dart starts. Selecting System clears
the override; older Android versions retain the system-selected native splash.
An existing installation migrates its Flutter-only preference when the updated
native activity first runs, so the first system splash after updating may still
use the previous system appearance. Native code requires a full rebuild/install.

Verify native synchronization on an Android 12+ device with
`flutter test integration_test/launch_appearance_test.dart -d <device-id>`.

Native launch artwork follows the same pink (light) / white (dark) colours as
`AppLaunchMark`. Android selects `drawable-night-*`; iOS selects the dark
appearance in the `LaunchImage` asset catalog. All images are transparent so
the native launch background remains visible, including inside the mark.
Regenerate both platforms from `assets/launch/surface/first-frame.svg` with
`node scripts/generate-native-launch-assets.mjs` (requires ImageMagick with SVG
and WebP support).

## Guardrails

- `test/ui/core/theme/theme_token_usage_test.dart` fails if any file under
  `lib/` outside the theme defines a literal colour (`Color(0x…)`,
  `Color.fromARGB`, `Colors.<name>`). `Colors.transparent` is allowed.
- `test/ui/core/theme/app_theme_test.dart` verifies every token value in both
  appearances and that the ThemeData slots (scaffold, card, dialog, divider,
  color scheme) use those tokens.
- Monochrome SVG assets use `fill="currentColor"` / `stroke="currentColor"`.
  Render them with `AppSvgIcon`, which passes the enclosing `IconTheme` colour
  to `SvgTheme.currentColor`. This includes button foreground and disabled
  colours; Flutter SVGs do not automatically inherit CSS/text colours. Pass
  `color: colors.iconSecondary` (or a semantic token) for an explicit tone.
  Keep multi-colour brand marks and illustrations in `SvgPicture.asset` so
  their internal colours remain intact. Clip-path fills are geometry and do
  not need theme colours.
- Neutral bStocks/HIP-3 venue badges use `VenueIcon`. It maps the original SVG
  background, border and mark to `surfaceSubtle`, `borderSubtle` and
  `iconSecondary` separately, preserving the Figma geometry and layer contrast
  in both appearances. Do not flatten these badges with a single colour filter.
