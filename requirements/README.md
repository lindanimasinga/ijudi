# ijudi Agile Requirements

## Objective
Deliver a structured, agile requirements package for the Flutter app improvement program:
- PR 1: missing feature implementation (shared loading/empty/error states)
- PR 2: UI consistency upgrade (tokens, spacing, typography, CTA hierarchy)

This package decomposes work into small, achievable stories with explicit complexity, dependencies, acceptance criteria, and verification steps.

## Complexity Scale
- 1 point: tiny change, low risk, single file or very small surface
- 2 points: small change, low risk, narrow component/view scope
- 3 points: small-medium change, moderate scope, multiple files in one area
- 5 points: medium change, cross-screen impact, requires regression checks
- 8 points: large change, broad or complex impact (avoid in first two PRs)

## Delivery Plan
1. PR 1 (Feature): Epic 01 stories
2. PR 2 (UI): Epic 02 stories
3. Release readiness: Epic 03 stories

## Epics
- Epic 01: [Shared UI States](./epic-01-shared-ui-states/EPIC.md)
- Epic 02: [UI Consistency](./epic-02-ui-consistency/EPIC.md)
- Epic 03: [Verification and Rollout](./epic-03-verification-and-rollout/EPIC.md)

## Dependency Summary
- STORY-01, STORY-02, STORY-03 are foundational and can be done in parallel.
- STORY-04 through STORY-07 depend on STORY-01/02/03.
- STORY-08 is foundational for Epic 02.
- STORY-09 and STORY-10 depend on STORY-08.
- STORY-11 depends on STORY-09 and STORY-10.
- STORY-12 and STORY-13 depend on completed implementation stories.
- STORY-14 depends on STORY-12 and STORY-13.

## Guardrails
- Keep MVVM boundaries intact (no business logic moved into views).
- Preserve route contracts and navigation behavior.
- Do not change backend API contracts in this requirement scope.
- Keep component changes reusable and incremental.
