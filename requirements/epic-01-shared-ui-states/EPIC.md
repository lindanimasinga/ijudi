# EPIC 01: Shared UI States

## Goal
Introduce reusable loading, empty, and error UI state components and adopt them in priority customer-flow screens.

## Business Value
- Improves UX consistency
- Reduces duplicated state-rendering code
- Increases implementation speed for future screens

## In Scope
- Shared components in `lib/components/`
- Adoption in selected screens:
  - `all-shops-view.dart`
  - `shop-profile-view.dart`
  - `order-history-view.dart`
  - `final-order-view.dart`

## Out of Scope
- Backend contract changes
- Navigation redesign
- Cross-app theming overhaul

## Stories
- [STORY-01](./STORY-01-create-loading-state-component.md)
- [STORY-02](./STORY-02-create-empty-state-component.md)
- [STORY-03](./STORY-03-create-error-state-component-with-retry.md)
- [STORY-04](./STORY-04-adopt-shared-states-in-all-shops.md)
- [STORY-05](./STORY-05-adopt-shared-states-in-shop-profile.md)
- [STORY-06](./STORY-06-adopt-shared-states-in-order-history.md)
- [STORY-07](./STORY-07-adopt-shared-states-in-final-order.md)
