# STORY-09: Migrate All Shops and Shop Profile to Tokens

## User Story
As a shopper, I want consistent spacing and typography in browse screens so the app feels polished and readable.

## Problem Statement
Browse screens use mixed hardcoded values and style patterns.

## In Scope
- Replace hardcoded spacing/radius/text values with shared tokens in:
  - `all-shops-view.dart`
  - `shop-profile-view.dart`

## Out of Scope
- Functional changes to shop retrieval and basket logic

## Complexity
5 points

## Dependencies
- STORY-08

## Tasks
- [ ] Refactor layout spacing to token usage
- [ ] Refactor text style references to tokenized typography
- [ ] Preserve current visual intent and responsiveness
- [ ] Verify no interaction regressions

## Acceptance Criteria
- Hardcoded style values in target areas are replaced by shared tokens.
- Visual hierarchy remains clear on mobile layouts.
- Existing actions and navigation remain unchanged.

## Verification
- `flutter analyze`
- Manual visual check on browse flow

## Risks and Mitigations
- Risk: subtle spacing regressions.
- Mitigation: compare before/after screenshots in key screen states.

## Affected Files
- `lib/view/all-shops-view.dart`
- `lib/view/shop-profile-view.dart`
