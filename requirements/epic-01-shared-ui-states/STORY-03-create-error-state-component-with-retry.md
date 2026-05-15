# STORY-03: Create Error State Component With Retry

## User Story
As a mobile user, I want consistent and recoverable error states so I can retry failed operations.

## Problem Statement
Error rendering is inconsistent and often lacks an obvious recovery action.

## In Scope
- Create reusable error-state component in `lib/components/`
- Provide message, optional details, and retry callback

## Out of Scope
- API retry logic changes in service layer

## Complexity
3 points

## Dependencies
None

## Tasks
- [ ] Create `lib/components/error-state.dart`
- [ ] Include primary retry CTA
- [ ] Include optional secondary action slot
- [ ] Keep style aligned with existing theme

## Acceptance Criteria
- Error-state component supports retry action.
- Component works with both short and long messages.
- Component does not depend on any specific ViewModel.

## Verification
- `flutter analyze`
- Trigger simulated error in one screen and verify retry callback fires

## Risks and Mitigations
- Risk: duplicate error dialogs and inline state colliding.
- Mitigation: define usage rule per screen (dialog vs inline state).

## Affected Files
- `lib/components/error-state.dart`
