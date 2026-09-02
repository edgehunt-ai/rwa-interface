# iOS Manual Acceptance Checklist

**Purpose**: Repeatable native iOS validation excluded from automated integration testing
**Environment**: iOS simulator or physical device on macOS
**Current execution**: Pending; the implementation environment is not macOS

| Scenario | Procedure | Expected Result | Result |
|----------|-----------|-----------------|--------|
| Edge back | Open Details and drag from the left edge | Transition follows the gesture and returns Home | Pending |
| Top inset | Run on a notched or Dynamic Island device | Interactive content clears the top system area | Pending |
| Bottom inset | Show a page with a bottom action | Action clears the Home Indicator and remains tappable | Pending |
| Landscape | Rotate on a device with lateral insets | Essential content remains reachable | Pending |
| Keyboard | Focus a bottom input in a scrollable page | Field, validation, and action remain reachable | Pending |
| Controls | Open progress, switch, alert, sheet, and date controls | Interaction follows iOS conventions | Pending |
| Appearance | Switch between light and dark appearance | Semantic meaning and contrast remain consistent | Pending |
| Large text | Set text size to 200% and repeat the flow | Content remains understandable and operable | Pending |

Record `Pass` or `Fail` plus the device and OS version for every row during native validation.
