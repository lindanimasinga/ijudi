# STORY-08: Create Spacing, Radius, and Typography Tokens

## User Story
As a developer, I want centralized UI tokens so styling remains consistent and easy to maintain.

## Problem Statement
Multiple views use hardcoded spacing and text styles, causing inconsistency.

## In Scope
- Add shared spacing/radius/typography token definitions in util/theme layer
- Keep compatibility with existing style usage

## Out of Scope
- Migrating all screens in one story

## Complexity
5 points

## Dependencies
None

## Tasks
- [ ] Define spacing scale constants
- [ ] Define radius constants
- [ ] Define typography aliases tied to existing style system
- [ ] Document intended usage inside token file comments

## Acceptance Criteria
- Token definitions exist and compile.
- Tokens are named consistently and reusable.
- Existing styles remain backwards compatible.

## Verification
- `flutter analyze`
- Build and open at least one screen using new tokens

## Risks and Mitigations
- Risk: token duplication with existing theme utilities.
- Mitigation: extend existing theme utilities rather than creating parallel systems.

## Affected Files
- `lib/util/theme-utils.dart`
- Optional new helper file in `lib/util/`
