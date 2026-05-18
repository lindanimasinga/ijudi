---
name: izinga-products-website-ui-ux-developer
description: "Create and improve iZinga product websites by scanning HTML, CSS, and JavaScript, listing all offered products and destination URLs, then applying a phased UI/UX and frontend implementation workflow to improve look, feel, usability, accessibility, and conversion. Use for landing-page redesigns, hero/CTA improvements, navbar issues, mobile responsiveness, and visual consistency work."
argument-hint: "Provide page path, target product pages, and whether you want audit only or audit + implementation."
user-invocable: true
---

# iZinga Products Website UI/UX + Developer Skill

## What This Skill Produces
- A verified list of iZinga products and product website links from the current source.
- A UI/UX audit of the landing page structure, hierarchy, visual consistency, and mobile behavior.
- A developer-ready implementation plan for HTML/CSS/JS improvements.
- A phased execution checklist with validation gates after each phase.

## When To Use
- You need to list all products offered by iZinga from website source code.
- You want to modernize look and feel without breaking existing flows.
- You are fixing navbar/header/hero/CTA layout issues.
- You are improving responsive behavior across mobile/tablet/desktop.
- You are cleaning legacy frontend code while preserving business links and SEO metadata.

## Known iZinga Product Inventory (Current Site Pattern)
Use this as the first baseline and re-verify from source on each run.

- Parcel and Furniture Delivery: https://delivery.izinga.co.za/
- Food Market: https://shop.izinga.co.za/
- iZinga Pay: https://pay.izinga.co.za/
- Driver Onboarding (for delivery/market): https://onboard.izinga.co.za?type=driver

Also verify structured data product labels in JSON-LD:
- Food Delivery
- Parcel Delivery
- Furniture Delivery
- Payment Gateway

## Source Scan Procedure
1. Scan HTML for primary service cards, CTA buttons, and outbound product URLs.
2. Extract structured data (`application/ld+json`) and confirm service naming consistency.
3. Scan CSS files for visual system primitives: typography, color palette, spacing, shadows, button variants, breakpoints.
4. Scan JavaScript for interaction patterns: nav behavior, smooth scroll, floating actions, parallax, particle/background effects, carousel, counters.
5. Record all third-party dependencies and assess impact on performance and maintainability.

## Phased Implementation Workflow

### Phase 1: Baseline and Safety
1. Confirm file inventory and current behavior in browser.
2. Capture current product links and ensure none are placeholders.
3. Keep existing business-critical URLs unchanged unless explicitly requested.

Completion checks:
- No broken critical links.
- Core sections still render correctly on mobile and desktop.

### Phase 2: Hero and Value Proposition
1. Make the hero headline explicit and product-focused.
2. Add short supporting description clarifying the platform scope.
3. Add strong primary CTA (for example: Get Started) and clear secondary CTAs.
4. Surface product options as visually distinct cards/chips with direct product links.

Completion checks:
- Headline explains value in one glance.
- CTAs are visible, clickable, and semantically correct.
- Product options align with product inventory.

### Phase 3: Product Section Architecture
1. Rebuild product/service stack using responsive row/column structure.
2. On large screens, align product cards horizontally.
3. On smaller screens, stack cleanly with consistent spacing and readable type.

Completion checks:
- Horizontal alignment works at desktop breakpoints.
- No card overlap or clipped content.

### Phase 4: Visual Consistency and Brand Language
1. Normalize type scale, spacing rhythm, and button treatments.
2. Reduce style duplication and inline CSS where practical.
3. Keep iZinga orange accents and contrast-safe foreground/background combinations.

Completion checks:
- Consistent spacing scale and typography hierarchy.
- Brand colors used intentionally and accessibly.

### Phase 5: Interaction and Navigation Behavior
1. Validate navbar behavior if present: toggle, collapse, scroll state, transparency/solid transitions.
2. If navbar is intentionally removed, remove dead nav scripts/classes and confirm no JS errors.
3. Validate floating action button behavior and close-on-outside-click.

Decision branch:
- If user says remove navbar, strip nav markup, nav script include, and nav style include together.
- If user says restore navbar, re-add markup + CSS + JS as one coherent unit.

Completion checks:
- No orphaned nav selectors or listeners.
- Interactions do not block key CTAs.

### Phase 6: Polish, Accessibility, and Performance
1. Ensure alt text quality, heading order, and keyboard-usable controls.
2. Verify touch target size and readable font sizes on mobile.
3. Remove invalid markup and fix duplicate IDs/classes.
4. Audit heavy effects (particles/parallax/carousel) and reduce where performance suffers.

Completion checks:
- No obvious accessibility blockers.
- Stable performance and smooth scrolling on mobile.
- No console errors from removed/renamed elements.

## Developer Rules for Safe Edits
- Prefer minimal, targeted edits over large rewrites.
- Keep existing external product URLs intact.
- Avoid introducing placeholder links like `href="#"`.
- When changing structure, update related JS selectors in the same pass.
- Validate after each phase to catch regressions early.

## Quality Gates (Required)
- Product links resolve to expected destination domains.
- HTML contains no accidental partial tags or malformed blocks.
- CSS changes preserve responsive behavior at key breakpoints.
- JS interactions fail gracefully if optional sections are absent.
- Metadata (title, description, OG/Twitter, canonical) stays aligned with visible messaging.

## Suggested Output Format For Each Run
1. Product Inventory: names + URLs + source location.
2. Findings: ordered by severity (broken behavior, UX issues, maintainability risks).
3. Proposed Changes: phase-labeled implementation steps.
4. Validation Results: what was tested and what remains unverified.

## Example Prompts
- "List all iZinga products from this website and fix the hero to match them."
- "Audit HTML/CSS/JS and improve look and feel without changing product links."
- "Rebuild the product cards so desktop is horizontal row/col and mobile is stacked."
- "Remove navbar completely and clean all related scripts and styles."
- "Restore a transparent navbar with logo and accessible toggle behavior."
