# Data Model: Cross-Platform App Foundation

This feature has no persisted business data. The following immutable UI concepts define contracts.

## Navigation Destination

- `name`: stable internal identifier
- `path`: stable URL path
- `builder`: destination content factory
- `parent`: optional back-navigation relationship

Validation: paths are unique and begin with `/`; root and not-found recovery always resolve.

## Semantic Style

- `role`: purpose-based name such as surface, muted text, success, warning, or loss
- `lightValue`: value for light appearance
- `darkValue`: value for dark appearance
- `foregroundRole`: paired content role where required

Validation: roles are unique, retain meaning across appearances, and meet applicable contrast rules.

## Feedback State

- `kind`: loading, empty, or error
- `title`: localized primary message
- `message`: optional localized detail
- `actionLabel`: optional localized recovery label
- `onAction`: optional recovery command

Validation: action label and callback occur together; error content never contains raw exceptions.

## Copyable Reference

- `displayValue`: potentially shortened presentation
- `sourceValue`: complete value copied to the clipboard
- `semanticLabel`: localized accessibility description
- `sensitivity`: safe or prohibited

State transition: idle -> copy requested -> succeeded or failed -> idle after feedback.

Validation: prohibited values cannot invoke copy; safe copy never uses the shortened display value.

## Platform Interaction

- `kind`: progress, switch, alert, action sheet, or date selection
- `platformStyle`: resolved Android, iOS, or web behavior
- `result`: typed user selection or dismissal

Validation: business callers use one contract and cannot select a platform-specific implementation.
