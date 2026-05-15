# STORY-01: Create Loading State Component

## User Story
As a mobile user, I want a consistent loading experience so I can understand that data is being fetched.

## Problem Statement
Loading indicators are currently inconsistent across screens.

## In Scope
- Create reusable loading state widget in `lib/components/`
- Support optional message and icon/animation slot

## Out of Scope
- Screen-level adoption

## Complexity
2 points

## Dependencies
None

## Tasks
- [ ] Create `lib/components/loading-state.dart`
- [ ] Add configurable title/subtitle
- [ ] Use theme utilities for colors and typography
- [ ] Add usage note in component comments

## Acceptance Criteria
- A reusable loading widget exists and compiles.
- The component supports default and custom text.
- No hardcoded screen-specific behavior is embedded.

## Verification
- `flutter analyze`
- Smoke render in one test/sandbox screen

## Risks and Mitigations
- Risk: style mismatch with existing components.
- Mitigation: consume theme styles from `theme-utils.dart`.

## Affected Files
- `lib/components/loading-state.dart`
