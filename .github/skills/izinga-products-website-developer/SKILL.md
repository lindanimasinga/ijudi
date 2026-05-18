---
name: izinga-products-website-developer
description: "Frontend developer skill for iZinga product websites. Use when scanning HTML, CSS, and JavaScript to implement safe, phased UI improvements, maintain product routes, fix interaction bugs, and verify responsive behavior and accessibility."
argument-hint: "Provide target file(s), desired phase, and whether to audit only or implement code changes."
user-invocable: true
---

# iZinga Products Website Developer Workflow

## Outcome
- Reliable product-link integrity.
- Clean HTML/CSS/JS updates with minimal regressions.
- Phase-based execution with validation after each step.

## Product and Route Integrity Checklist
Validate and preserve these links unless explicitly changed:
- https://delivery.izinga.co.za/
- https://shop.izinga.co.za/
- https://pay.izinga.co.za/
- https://onboard.izinga.co.za?type=driver

## Technical Scan Steps
1. HTML audit:
- Identify section structure, IDs, CTA anchors, semantic heading order.
- Extract product names from cards and JSON-LD services.

2. CSS audit:
- Identify typography system, spacing scale, color palette, button variants.
- Locate responsive breakpoints and duplicated/conflicting selectors.

3. JavaScript audit:
- Map nav, scroll, FAB, parallax, particles, and carousel selectors.
- Ensure selectors map to current DOM after edits.

## Implementation Phases
1. Baseline: fix malformed markup and dead links.
2. Hero/Product clarity: update structure and CTA mapping.
3. Responsive layout: enforce row/col desktop behavior and mobile stacking.
4. Interaction integrity: align scripts with DOM changes.
5. Performance and accessibility: reduce heavy effects where needed, improve control semantics.

## Branching Logic
- Navbar changes:
- Remove request: delete nav markup + nav CSS include + nav JS include together.
- Restore request: add all three back with synchronized selectors and aria states.

- Animation-heavy pages:
- If FPS or responsiveness drops, reduce particles count and expensive effects before adding new animations.

- Legacy mixed assets:
- If old and new style systems conflict, isolate overrides and remove duplicate rules gradually.

## Completion Checks
- No placeholder action links.
- No DOM selector errors from JS interactions.
- Key sections render correctly across target breakpoints.
- Product copy, metadata, and outbound links are consistent.
- No obvious accessibility blockers for keyboard/touch use.

## Example Prompts
- "Scan this iZinga page and implement phase 2 and phase 3 safely."
- "Fix navbar behavior and ensure scripts match current markup."
- "Improve look and feel but keep all product routes intact."
