# STORY-11: Align CTA Hierarchy and Form Visual Consistency

## User Story
As a user, I want primary and secondary actions to be visually clear so I can complete tasks confidently.

## Problem Statement
Some screens show inconsistent CTA emphasis and form treatment.

## In Scope
- Align CTA hierarchy in target flow screens
- Normalize form visual patterns (labels, spacing, helper/error placement)

## Out of Scope
- New form validation rules

## Complexity
3 points

## Dependencies
- STORY-09
- STORY-10

## Tasks
- [ ] Audit CTA levels in target screens
- [ ] Apply consistent primary/secondary/destructive styling
- [ ] Standardize key form block spacing and label treatment
- [ ] Verify tap-target clarity and accessibility basics

## Acceptance Criteria
- CTA hierarchy is consistent in target screens.
- Form blocks look and behave consistently with app style language.
- No action-routing regressions are introduced.

## Verification
- `flutter analyze`
- Manual interaction walkthrough on all target screens

## Risks and Mitigations
- Risk: accidental behavior change while restyling actions.
- Mitigation: keep action callbacks untouched and only update presentation.

## Affected Files
- `lib/view/all-shops-view.dart`
- `lib/view/shop-profile-view.dart`
- `lib/view/final-order-view.dart`
- `lib/view/order-history-view.dart`
