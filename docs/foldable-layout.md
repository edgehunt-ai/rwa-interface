# Foldable layout baseline

The application builder wraps the navigator and confirmation host in
`FoldableAdaptiveShell`. This applies to screens, dialogs, bottom sheets and
foreground notification notices.

- Available width up to 720 logical pixels fills the window. Wider windows center
  a 720-pixel pane on the application background.
- Separating hinges and half-open folds use Flutter's `DisplayFeatureSubScreen`.
  Content stays in the leading pane (top pane for a horizontal fold); the other
  pane is intentionally unused in this initial single-pane implementation.
- Flat, non-obstructing folds do not split the content.
- Descendant `MediaQuery` reports the actual content viewport, with adjusted safe
  area and keyboard insets. The navigator subtree is retained on size changes.

Automated coverage includes width limits, vertical hinges, horizontal half-open
folds and preservation of text input, scroll offset and widget identity across
outer-screen, inner-screen, split-window and landscape sizes. Existing trading
and withdrawal layout tests provide additional regression coverage.

Before device acceptance, run the app on an Android foldable emulator and a target
physical device. Check markets, trading, assets and funding screens in folded,
unfolded, landscape and split-screen modes. Open a dialog and bottom sheet, show
the keyboard, and fold/unfold while editing an order. Verify that controls remain
reachable and input, selected instrument, route and scroll position survive.
These device checks are still required; synthetic widget tests do not validate
manufacturer-specific folding or activity lifecycle behavior.

Two-pane trading layouts and posture-specific controls are future work.
