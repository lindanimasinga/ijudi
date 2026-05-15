# STORY-10: Migrate Final Order and Order History to Tokens

## User Story
As a user, I want checkout and order-history screens to look visually consistent so status and actions are easier to understand.

## Problem Statement
Order-related screens have inconsistent spacing and text treatments.

## In Scope
- Token migration in:
  - `final-order-view.dart`
  - `order-history-view.dart`

## Out of Scope
- Payment and order status business logic changes

## Complexity
5 points

## Dependencies
- STORY-08

## Tasks
- [ ] Replace hardcoded spacing/radius values
- [ ] Align typography usage to shared tokens
- [ ] Keep CTA prominence and status readability
- [ ] Validate responsive behavior on smaller devices

## Acceptance Criteria
- Target screens use shared tokens for spacing and typography.
- CTA and status sections remain understandable and stable.
- Existing flow behavior is preserved.

## Verification
- `flutter analyze`
- Manual check on order flow screens

## Risks and Mitigations
- Risk: reduced readability of status/content blocks.
- Mitigation: keep contrast and heading hierarchy aligned with existing theme.

## Affected Files
- `lib/view/final-order-view.dart`
- `lib/view/order-history-view.dart`
