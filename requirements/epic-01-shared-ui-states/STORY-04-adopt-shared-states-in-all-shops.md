# STORY-04: Adopt Shared States In All Shops

## User Story
As a shopper, I want clear loading, empty, and error states on the shop list so browsing feels predictable.

## Problem Statement
`all-shops-view.dart` handles states with ad-hoc rendering.

## In Scope
- Integrate shared loading/empty/error components in all shops screen
- Preserve existing ViewModel data and state transitions

## Out of Scope
- Changing API query behavior

## Complexity
3 points

## Dependencies
- STORY-01
- STORY-02
- STORY-03

## Tasks
- [ ] Replace ad-hoc loading widget usage
- [ ] Replace empty list placeholder usage
- [ ] Replace ad-hoc error rendering with shared component
- [ ] Verify retry invokes existing reload flow

## Acceptance Criteria
- All three state types use shared components.
- Existing shop list rendering remains unchanged when data is present.
- Retry action triggers existing load function.

## Verification
- `flutter analyze`
- Manual check: slow network, empty result, error simulation

## Risks and Mitigations
- Risk: regression in initial load behavior.
- Mitigation: test cold start and pull-to-refresh scenarios.

## Affected Files
- `lib/view/all-shops-view.dart`
