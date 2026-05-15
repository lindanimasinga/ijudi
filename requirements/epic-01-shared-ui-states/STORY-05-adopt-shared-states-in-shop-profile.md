# STORY-05: Adopt Shared States In Shop Profile

## User Story
As a shopper, I want consistent state handling in shop profile so I can clearly understand load and failure conditions.

## Problem Statement
`shop-profile-view.dart` can show inconsistent placeholders and error behavior.

## In Scope
- Integrate shared loading/empty/error components in shop profile view
- Keep menu/item rendering unchanged for successful data state

## Out of Scope
- Changing menu grouping logic

## Complexity
3 points

## Dependencies
- STORY-01
- STORY-02
- STORY-03

## Tasks
- [ ] Replace inline loading indicator with shared component
- [ ] Replace empty-content rendering with shared empty-state
- [ ] Replace error rendering with shared error-state and retry
- [ ] Validate interactions with existing ViewModel lifecycle

## Acceptance Criteria
- Shop profile uses shared state components consistently.
- Existing user interactions (item tap, add to basket) remain intact.
- Retry action reuses existing load method.

## Verification
- `flutter analyze`
- Manual check: loading, no items, API error

## Risks and Mitigations
- Risk: layout jump when switching states.
- Mitigation: keep container constraints stable across states.

## Affected Files
- `lib/view/shop-profile-view.dart`
