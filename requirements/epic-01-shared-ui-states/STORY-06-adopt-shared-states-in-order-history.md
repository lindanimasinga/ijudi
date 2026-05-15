# STORY-06: Adopt Shared States In Order History

## User Story
As a user, I want clear order-history states so I know when orders are loading, missing, or failed to load.

## Problem Statement
Order history currently does not present state transitions in a uniform way.

## In Scope
- Integrate shared state components in order history view
- Preserve current order list rendering and navigation

## Out of Scope
- Real-time tracking updates

## Complexity
3 points

## Dependencies
- STORY-01
- STORY-02
- STORY-03

## Tasks
- [ ] Add shared loading-state to order-history view
- [ ] Add shared empty-state for no past orders
- [ ] Add shared error-state with retry action
- [ ] Verify route navigation to order details remains unchanged

## Acceptance Criteria
- State rendering is consistent with other screens.
- Existing order item tap/navigation still works.
- Retry action refreshes order-history data.

## Verification
- `flutter analyze`
- Manual check for all three states and order navigation

## Risks and Mitigations
- Risk: conflicting visual hierarchy with order cards.
- Mitigation: keep state components outside list-item styling scope.

## Affected Files
- `lib/view/order-history-view.dart`
