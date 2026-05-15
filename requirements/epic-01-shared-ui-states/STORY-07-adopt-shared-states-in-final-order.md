# STORY-07: Adopt Shared States In Final Order

## User Story
As a user completing checkout, I want reliable state messaging so I can recover quickly from loading or errors.

## Problem Statement
`final-order-view.dart` is part of critical conversion flow and needs robust, consistent state UX.

## In Scope
- Integrate shared loading/empty/error components in final-order screen where applicable
- Preserve checkout and order confirmation flow behavior

## Out of Scope
- Payment gateway integration changes

## Complexity
3 points

## Dependencies
- STORY-01
- STORY-02
- STORY-03

## Tasks
- [ ] Replace local loading placeholders with shared component
- [ ] Add empty-state where no order payload exists
- [ ] Add error-state with retry/reload option
- [ ] Validate no disruption to checkout completion journey

## Acceptance Criteria
- Shared state components are used in final-order flow.
- Order confirmation behavior remains unchanged on success path.
- Error and retry paths are user-actionable.

## Verification
- `flutter analyze`
- Manual check in checkout -> final order scenarios

## Risks and Mitigations
- Risk: introducing friction in payment-complete flow.
- Mitigation: keep success-state path untouched and only improve non-success states.

## Affected Files
- `lib/view/final-order-view.dart`
