# STORY-02: Create Empty State Component

## User Story
As a mobile user, I want clear empty-state messaging so I know why no content is shown and what to do next.

## Problem Statement
Some screens show blank lists without actionable guidance.

## In Scope
- Create reusable empty-state widget in `lib/components/`
- Support icon, message, and optional CTA button callback

## Out of Scope
- Screen-level adoption

## Complexity
2 points

## Dependencies
None

## Tasks
- [ ] Create `lib/components/empty-state.dart`
- [ ] Add configurable headline/body/action label
- [ ] Add optional callback for CTA
- [ ] Align visuals with theme tokens

## Acceptance Criteria
- A reusable empty-state widget exists and compiles.
- CTA can be hidden or shown by configuration.
- Component remains presentation-only.

## Verification
- `flutter analyze`
- Local render check in one screen

## Risks and Mitigations
- Risk: over-specific copy in component.
- Mitigation: keep all copy inputs configurable.

## Affected Files
- `lib/components/empty-state.dart`
