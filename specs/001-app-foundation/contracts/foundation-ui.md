# Foundation UI Contracts

## Navigation

- Root path resolves to the foundation home screen.
- A secondary demonstration path validates forward and backward navigation.
- Unknown paths resolve to a localized not-found screen with root recovery.
- Route paths and names are centralized; screens receive typed inputs rather than parse URLs.

## Page Shell

- Accepts content, optional top content, and optional bottom action content.
- Owns safe-area and keyboard avoidance exactly once per page.
- Allows edge-to-edge background without placing interactive content under system areas.
- Supports scrollable long content and keeps the focused input reachable.

## Adaptive Interactions

- Progress exposes a semantic label and optional value.
- Switch exposes value, change callback, and semantic label.
- Alert returns confirmation, cancellation, or dismissal.
- Action sheet returns a selected action or dismissal.
- Date selection returns a selected date or cancellation and enforces allowed bounds.

## Feedback States

- Loading communicates ongoing work without announcing completion.
- Empty communicates absence and may expose one relevant next action.
- Error presents a safe localized summary and may expose retry and copyable reference actions.
- Actions are absent, not disabled, when no callback exists.

## Copyable Reference

- Displays a readable value and exposes a clearly labeled copy action.
- Copies the complete safe source value even when display is shortened.
- Announces success or failure accessibly.
- Rejects prohibited sensitive values and never renders raw runtime diagnostics.

## Text and Appearance

- Every component declares wrap, truncate, scroll, or expand behavior for dynamic text.
- Important truncated values provide full-view access.
- Monetary values remain unambiguous.
- Components support light/dark appearance and 200% text scaling without hiding primary actions.
