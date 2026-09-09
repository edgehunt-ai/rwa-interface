# Feature Specification: Implement Figma Screens

**Feature Branch**: `feat/006-implement-figma-screens`

**Created**: 2026-09-07

**Status**: Draft

**Input**: User description: "Read every child screen from the four supplied RWA Figma regions in canvas order, retain a direct link for each screen, and implement the screens in that sequence."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Use the home and market experience (Priority: P1)

An authenticated user can view the portfolio overview, browse market products, search and filter products, and move into deposit, withdrawal, and asset views with a clear, consistent mobile experience.

**Why this priority**: This is the primary discovery and account-entry path and includes the navigation shell shared by the highest-frequency journeys.

**Independent Test**: A user can open the application, reach the Home, Market, Assets, and Activity destinations, and complete the designed navigation actions without encountering an incomplete state.

**Acceptance Scenarios**:

1. **Given** the user opens the app, **When** the home destination has available portfolio and market data, **Then** the portfolio summary, quick actions, market ranking, and active navigation state match the approved home design.
2. **Given** the user is viewing Market, **When** they search, browse stocks, change ranking/filter state, or open a market-status explanation, **Then** the matching designed state is shown and the user can return to the preceding state.
3. **Given** a user chooses Deposit, Withdraw, or Assets, **When** the destination is supported by the available account data, **Then** the corresponding route and any designed selection/review state are reachable.

---

### User Story 2 - Place and manage a trade (Priority: P2)

An eligible user can inspect the market view, change between designed order and chart states, place or close a supported position, and understand order timing and price information.

**Why this priority**: Trading is financially sensitive and must preserve the design's state clarity across product venues and order modes.

**Independent Test**: With representative product and account fixtures, a user can transition through every designed trade state and see pending, successful, unavailable, and validation outcomes distinctly.

**Acceptance Scenarios**:

1. **Given** a supported product, **When** the user changes the selected trade mode, chart, order type, or market source, **Then** the corresponding designed variation is shown without losing the product context.
2. **Given** invalid, unavailable, or incomplete trade input, **When** the user attempts an action, **Then** the action remains safely blocked and the user receives a recoverable explanation.
3. **Given** a valid close or order action, **When** the user reaches a confirmation state, **Then** the displayed financial values, fees, and resulting status are clear and use the project-wide financial display rules.

---

### User Story 3 - Review settings and activity (Priority: P3)

An authenticated user can reach the designed settings variations and review activity records with understandable filters, empty states, and history details.

**Why this priority**: These journeys support account control and post-action verification after the primary home, market, and trade flows are available.

**Independent Test**: A user can open Settings and Activity from the relevant entry points, switch through each designed state, and identify loading, empty, error, and populated results.

**Acceptance Scenarios**:

1. **Given** a user opens Settings, **When** they choose each available account option, **Then** the matching designed screen or overlay is displayed and its back/dismiss action is clear.
2. **Given** activity data is loading, empty, partially available, or unavailable, **When** the user opens Activity, **Then** the state is explicit and any recovery action preserves the user context.

### Edge Cases

- A screen references data or a financial capability that the account does not support; the user sees an explicit unavailable state rather than misleading values or actions.
- A user returns from a sheet, detail, review, or selector; selected context and valid entered values are retained where safe.
- Long localized labels, full addresses, and enlarged text do not conceal an important amount, status, action, or copy affordance.
- Network or session failure occurs during a data-backed view; the UI presents a recoverable domain failure without exposing transport details.
- Financial values have missing token decimals or extremely small non-zero values; the display retains the approved precision semantics and never silently presents a non-zero value as zero.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The product MUST read and implement the approved design inventory from the four supplied regions in documented canvas order, retaining a direct design link, inventory type, parent context, and implementation status for every item.
- **FR-002**: The product MUST provide a coherent mobile navigation model across Home, Market, Assets, Activity, trade, funding, settings, and history journeys.
- **FR-003**: The product MUST reproduce each applicable designed state, including normal, filtered, searched, expanded, selected, sheet, review, empty, unavailable, and error states.
- **FR-004**: The product MUST use the same semantic visual roles across screens for surfaces, text hierarchy, borders, actions, positive/negative financial movement, selected navigation, and disabled/unavailable states.
- **FR-005**: The product MUST source user-facing financial information from the approved domain state and present it through the project-approved shared financial formatting rules.
- **FR-006**: The product MUST distinguish incomplete, pending, confirmed, failed, unavailable, and invalid financial actions without inferring success.
- **FR-007**: The product MUST keep application-facing requests outside widgets and expose stable user-facing state for loading, success, empty, partial-data, and failure outcomes.
- **FR-008**: The product MUST make user-related identifiers and addresses copyable where they are displayed as account or transaction references; truncated display MUST not alter copied content.
- **FR-009**: The product MUST provide accessible labels, adequate non-color state cues, usable focus/tap targets, and a long-text strategy for all implemented interactive elements.
- **FR-010**: The product MUST use the authentic design asset or an already-matching project asset for each displayed icon or brand mark; no placeholder or redrawn substitute may be used.
- **FR-011**: The product MUST keep the design inventory current when a design node is renamed, added, removed, or reordered before that node is implemented.

### Key Entities

- **Design screen**: A direct child frame in a supplied design region, identified by a stable design-node link, canvas ordering, screen name, and implementation status.
- **Market product**: A tradable or browsable product identity, venue/source, market data, availability, and presentation metadata.
- **Portfolio holding**: An account-owned balance or position including asset identity, valuation, decimals, and change information.
- **Funding route**: A supported deposit or withdrawal asset/network combination and its validation, fee, and review state.
- **Trade intent**: A user-proposed order or close action, with product context, input validity, confirmation state, and result.
- **Activity record**: A user-visible record of a financial or account event, status, time, reference, and detail state.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: 100% of the 86 documented direct-child design items have a stable direct link, recorded inventory type, parent context, and implementation status before the feature is declared complete.
- **SC-002**: A reviewer can reach every implemented route or overlay from its documented parent context, and can verify every non-route design state through its mapped widget or journey test.
- **SC-003**: 100% of critical funding and trade states visibly distinguish unavailable, invalid, pending, confirmed, and failed outcomes where applicable.
- **SC-004**: At least 95% of representative Home, Market, Asset, Activity, funding, and trade journeys complete on first attempt in acceptance testing with representative data.
- **SC-005**: Representative screens remain usable at the supported enlarged text setting, with no clipped primary action, amount, or status.

## Assumptions

- The supplied Figma frames are the source of visual and interaction intent; duplicate-named frames remain distinct because their node links and canvas positions differ.
- Existing domain models, repositories, providers, localization infrastructure, navigation, theme, and shared financial formatter will be extended rather than bypassed.
- Screens that depict unavailable or simulated inventory are implemented as explicit product states and do not imply that a financial operation is executable.
- Design assets retrieved from the design file are persisted or mapped to verified existing application assets before their temporary design URLs expire.
- The 86 direct child frames are the complete initial design inventory. They include routes, overlays, visual states, and component references; they are not assumed to be 86 independently navigable routes.

## Design Screen Inventory

Base file: `https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA`

**Tracking rule for every entry below**: initial status is `listed`; it advances only as `reading → implemented → verified` (or `blocked`). `Screen / …` frames are route/state candidates, `Bottom sheet …` frames are overlays, `Frame 117–119` are component references, and duplicate venue-named frames are variant state candidates. The direct Figma-region link is the parent context until the item is read; then its implementation task records the concrete in-app entry/dismiss path. This preserves canvas order without incorrectly treating every frame as a standalone route.

### 首页 & Markets (22)

1. [Screen / Home / Product-defined](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=59-122&m=dev)
2. [Screen / Market / Overview](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=202-2490&m=dev)
3. [Screen / Market / Product filter open](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=224-1576&m=dev)
4. [Screen / All stocks](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=202-2546&m=dev)
5. [Screen / Market / Status sheet](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=202-2574&m=dev)
6. [Screen / Market / Status sheet (variant)](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=322-1385&m=dev)
7. [Screen / Search markets / Empty](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=206-717&m=dev)
8. [Screen / Search markets / Results](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=206-728&m=dev)
9. [Screen / All stocks / Search TSLA](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=215-1014&m=dev)
10. [Screen / Home / Deposit routes](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=256-1110&m=dev)
11. [Screen / Deposit / USDC Arbitrum](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=285-2040&m=dev)
12. [Screen / Deposit / Other supported assets](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=286-1786&m=dev)
13. [Screen / Assets / Overview](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=345-1501&m=dev)
14. [Screen / Assets / Overview / Type tabs / Cash](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=381-1730&m=dev)
15. [Screen / Assets / Overview / Portfolio Allocation / Expanded](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=408-4409&m=dev)
16. [Screen / Assets / Overview / Type tabs / bStocks](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=408-4210&m=dev)
17. [Screen / Assets / Overview / Portfolio Trend / Expanded](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=388-2941&m=dev)
18. [Screen / Assets / Cash actions / USDC](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=396-1917&m=dev)
19. [Screen / Withdraw / USDC Arbitrum](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=458-2889&m=dev)
20. [Screen / Withdraw / Review USDC](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=458-2921&m=dev)
21. [Screen / Assets / Withdraw asset picker](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=458-2963&m=dev)
22. [Screen / Withdraw / Select asset](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=458-3017&m=dev)

### Trade / Foundation cleanup (54)

1. [默认](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=513-17082&m=dev)
2. [时间说明](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=513-17402&m=dev)
3. [K线](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=513-17285&m=dev)
4. [美股参考价](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=513-17185&m=dev)
5. [bstocks · 513:16964](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=513-16964&m=dev)
6. [bstocks-market · 513:18066](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=513-18066&m=dev)
7. [bstocks-market · 513:19064](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=513-19064&m=dev)
8. [bstocks-market · 543:16239](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=543-16239&m=dev)
9. [Screen / Deposit / USDC Arbitrum](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=513-22617&m=dev)
10. [bstocks-market · 543:16418](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=543-16418&m=dev)
11. [bstocks-market · 543:16591](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=543-16591&m=dev)
12. [bstocks-market · 543:16764](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=543-16764&m=dev)
13. [bstocks-market · 543:16937](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=543-16937&m=dev)
14. [bstocks-market · 543:17110](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=543-17110&m=dev)
15. [bstocks-market · 543:17283](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=543-17283&m=dev)
16. [bstocks · 543:20394](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=543-20394&m=dev)
17. [bstocks · 513:16723](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=513-16723&m=dev)
18. [Screen / Withdraw / USDC Arbitrum](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=577-24377&m=dev)
19. [bstocks-market · 513:20368](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=513-20368&m=dev)
20. [bstocks-market · 513:18951](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=513-18951&m=dev)
21. [bstocks-market · 543:18062](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=543-18062&m=dev)
22. [bstocks-market · 543:18216](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=543-18216&m=dev)
23. [bstocks-market · 543:18370](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=543-18370&m=dev)
24. [bstocks · 577:23970](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=577-23970&m=dev)
25. [Bottom sheet / US market status · 543:13079](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=543-13079&m=dev)
26. [bstocks-limit · 513:22190](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=513-22190&m=dev)
27. [bstocks-market · 513:20553](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=513-20553&m=dev)
28. [bstocks-limit · 543:19583](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=543-19583&m=dev)
29. [bstocks-limit · 513:22446](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=513-22446&m=dev)
30. [bstocks-market · 543:19785](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=543-19785&m=dev)
31. [bstocks · 513:16809](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=513-16809&m=dev)
32. [bstocks-limit · 513:22318](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=513-22318&m=dev)
33. [bstocks-market · 543:20139](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=543-20139&m=dev)
34. [Frame 118](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=513-23349&m=dev)
35. [hip3-market · 513:21271](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=513-21271&m=dev)
36. [hip3 · 513:17694](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=513-17694&m=dev)
37. [hip3 · 513:17796](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=513-17796&m=dev)
38. [hip3-market · 513:18650](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=513-18650&m=dev)
39. [hip3-market · 513:21826](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=513-21826&m=dev)
40. [close · 579:24502](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=579-24502&m=dev)
41. [close · 579:25070](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=579-25070&m=dev)
42. [hip3 · 513:17594](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=513-17594&m=dev)
43. [hip3-market · 543:11041](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=543-11041&m=dev)
44. [hip3-market · 543:11270](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=543-11270&m=dev)
45. [bstocks-market · 543:11376](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=543-11376&m=dev)
46. [Bottom sheet / US market status · 543:13208](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=543-13208&m=dev)
47. [Frame 117](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=513-23345&m=dev)
48. [hip3-market · 513:18439](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=513-18439&m=dev)
49. [hip3 · 513:17919](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=513-17919&m=dev)
50. [hip3-market · 513:21641](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=513-21641&m=dev)
51. [hip3-market · 513:21456](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=513-21456&m=dev)
52. [bstocks-market · 543:11158](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=543-11158&m=dev)
53. [hip3-market · 543:12636](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=543-12636&m=dev)
54. [Frame 119](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=513-23347&m=dev)

### 设置 (6)

1. [Screen / All stocks · 527:9559](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=527-9559&m=dev)
2. [Screen / Home / Product-defined · 461:6587](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=461-6587&m=dev)
3. [Screen / Home / Product-defined · 461:6678](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=461-6678&m=dev)
4. [Screen / Home / Product-defined · 461:6764](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=461-6764&m=dev)
5. [Screen / Home / Product-defined · 461:6858](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=461-6858&m=dev)
6. [Screen / All stocks · 540:10746](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=540-10746&m=dev)

### 历史记录 (4)

1. [Activity · 560:20700](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=560-20700&m=dev)
2. [Activity · 560:22713](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=560-22713&m=dev)
3. [Activity · 560:23164](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=560-23164&m=dev)
4. [Activity · 560:23454](https://www.figma.com/design/2lg6R4iTPpSBpkLahu7vQh/RWA?node-id=560-23454&m=dev)
