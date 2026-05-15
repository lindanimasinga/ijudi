# STORY-13: Manual Regression for Critical User Flows

## User Story
As a product team, we want manual regression checks so key customer journeys remain stable after UI changes.

## Problem Statement
Automated checks alone do not guarantee conversion-path UX quality.

## In Scope
- Manual validation of flows:
  - browse shops
  - open shop profile
  - proceed through final order path
  - open order history

## Out of Scope
- Comprehensive exploratory testing of all app modules

## Complexity
3 points

## Dependencies
- STORY-12

## Tasks
- [ ] Execute critical flow checklist on emulator/device
- [ ] Validate loading/empty/error states
- [ ] Validate CTA hierarchy and readability
- [ ] Log findings and defects

## Acceptance Criteria
- Critical path checklist is completed.
- Defects are logged with reproducible steps.
- Blocking issues are resolved or explicitly deferred.

## Verification
- Run app on Android emulator and one additional target if available
- Capture screenshots for before/after where useful

## Risks and Mitigations
- Risk: environment-specific behavior differences.
- Mitigation: test at least one additional runtime target when possible.

## Affected Files
- N/A (process story)
