# Design Composition v1 — Consolidated Critiques from the Five Designers

**For:** iZinga Design System (lead) — integrate into design-composition-v2 (final)
**Date:** 21 July 2026
**Verdict summary:** No structural rejections from any reviewer. The composition is fundamentally sound. Below are every amendment, reject-with-replacement, and answered open question, organized by reviewer. Where reviewers conflict or an item needs a non-designer decision, it is flagged at the end.

---

## 1. DELIVERY UI/UX DESIGNER

**Open Q1 (WhatsApp primary CTA on Furniture card):** Conditional approve. Correct for residential customers. REQUIRED ADD: the Furniture card needs a B2B escape hatch — one line below the secondary quote link: "Furniture retailer or estate agent? See our Business programme →" in `var(--btn-pill-color)`, 0.75rem, linking to /business.html.

**Open Q2 (calculator field set):** Not confirmed against backend reality. Delivery app prices by zone/coordinates, not free-text area names. Placeholder copy must say "Suburb name" not "Area". If backend needs constrained suburb-to-zone lookup, use autocomplete/select of supported suburbs, not open text. Must be confirmed with iZinga Backend Platform before the active state is built; otherwise launch in Coming Soon state with fields hidden.

**Amendments:**
- D1. Furniture card visual primacy over Parcel: Furniture left-border 6px (Parcel stays 4px) + Teal eyebrow "FEATURED SERVICE" 0.65rem uppercase above the H3.
- D2. B2B escape hatch line (per Q1 above).
- D3. Furniture card's 3 feature bullets are undefined — spec must define them. Recommended floor copy (Operations to confirm): "Large-item specialists — sofas, appliances, wardrobes" / "Two-person team for items over 30 kg" / "Johannesburg and Durban — same-day available".
- D4. Hero sub-copy "delivered same-day" is inaccurate for scheduled furniture jobs. Replace with: "Furniture, parcels, and food — delivered on your schedule by iZinga drivers across Johannesburg, Durban, and Cape Town."
- D5. Coverage map per-city service lists are UNVERIFIED. Pin service lists must be confirmed by Operations before the SVG is built. Add an ops-dependency gate note to the spec.
- D6. No continuity path to delivery.izinga.co.za for returning users. Add below the WhatsApp button: "Already have the iZinga app? [Open app]" — Teal, 0.72rem, no border, subordinate.
- D7. B2B form "Role / title" must be REQUIRED (qualification signal), label "Job title *" with Coral asterisk.
- D8. Remove "iZinga Pay Integration" from the B2B service-interest select. Limit options to: Furniture Delivery — Preferred Provider / White-Label Delivery (Estate Agents) / Both–Not sure yet. Pay leads get a separate route later.
- D9. /business.html programme summary boxes have no defined copy. Define content floor per box: programme name (Catamaran 800), one-line value statement, three bullet benefits at 0.8rem, no CTA inside the box.
- D11. If the quote calculator launches in Coming Soon state, the Furniture card's "Get an instant quote ↓" link must be conditionally replaced with: "Quote calculator coming soon — book via WhatsApp for an immediate estimate." (0.75rem muted). Spec the conditional now.

**Approvals:** WhatsApp button spec, role-color discipline, B2B form styling, map SVG approach, calculator result panel concept, dark/light rhythm, disclaimer treatment.

---

## 2. ONBOARDING UI/UX DEVELOPER

**Open Q1 (earnings calculator Coming Soon?):** Remove the disabled state — it's buildable now. Formula: `estimated_weekly = hours_per_day × days_per_week × rate_per_hour[city]` from a static 3-figure rate table (JHB/Durban/CPT) supplied by Operations. Keep Coming Soon only until rates arrive. Link the result panel's nudge text to the "Register to Drive" CTA anchor.

**Open Q2 (driver CTA target):** Onboarding app has no driver-direct entry. Recommend a separate ticket: add `?role=driver` query-param handling at `WelcomeIndivisualsComponent` to auto-select the driver path and advance to phone verification. CTA href becomes `https://onboarding.izinga.co.za/?role=driver` once wired; until then link to root.

**REJECT (with replacement):**
- O1. `var(--rule)` is used ~14 places in the spec but NEVER DEFINED in the token table — every occurrence would silently render invisible. FIX: add `--rule: #e0dfdf` to the Section 1 token table.

**Amendments:**
- O2. Component J contrast claim "#666 on #212121 = 5.4:1" is WRONG — actual is ~2.6:1 (fails AA). The disclaimer only appears on light sections (S07/S08) anyway. Remove the dark-section claim entirely; replace with: "Disclaimer color on light sections: #666. On --bkg-color (#F8F7F7) ≈ 4.9:1 — passes AA. Never apply #666 on #212121; use #aaa or lighter if it ever moves to a dark section."
- O3. `.hero-image-col::after` stripe needs `position: relative` on `.hero-image-col` — add it to the snippet (same anchor-bug class as tonight's wave failure). (NOTE: see Brand B1 — the stripe may move to the hero section container instead, which changes which element needs `position: relative`.)
- O4. Condensed nav "More ▾" dropdown: specify `position: absolute; top: 100%; left: 0; right: 0` on a `position: relative` nav container, `z-index: 1000`. NOT `position: fixed`.
- O5. Calculator result panel `#212121` is invisible against the S05 dark-section card (#2a2a2a). On dark-section calculators use `background: #1a1a1a; border: 1px solid #444`. Keep #212121 on light sections.
- O6. The spec violates its own "no hex in component CSS" rule (`#ccc`, `#aaa`, `#666`, `#333`, `#555` throughout). Add named tokens: `--dark-text-primary: #fff`, `--dark-text-secondary: #ccc`, `--dark-text-muted: #aaa`, `--dark-text-faint: #666`, `--dark-rule: #333` — and reference them.
- O7. Hero image suppression below 420px viewport height requires an explicit `@media (max-height: 420px)` HEIGHT query call-out — spec must state this is independent of width breakpoints.
- O8. "Coming Soon" badge in S05 (driver/Teal section) uses Utility Blue — breaks single-accent-per-section. Change badge to `var(--btn-green-color)` Teal (white text at 700 weight acceptable for a badge). Moot if Coming Soon state removed per Q1.
- O9. Mobile drawer Close X: `position: absolute; top: 20px; right: 24px` INSIDE the drawer element (drawer `position: relative`), so it animates with the drawer. Not viewport-fixed.
- O10. Nav accent bars: implement as `border-left: 4px solid [token]` on the `<a>`, with `padding-left` reduced 28px→24px on accented items for optical alignment.

**Approvals:** S07/S08 disclaimer+CTA column split (keep disclaimer above CTA in DOM source order for screen readers — do not reorder with flex/grid `order`). Footer accordion initial state is developer's choice (document in ticket).

---

## 3. BRAND DESIGNER

**Open Q1 (three-color hero stripe):** Approved as concept — but see B1.
**Open Q2 (bikeDriver.png on #2a2a2a):** Pre-build QA gate — inspect the PNG. If it has a light/white background, re-export as a transparent cutout. NO vignette (conflicts with flat brand tone).
**Open Q3 (footer Gold top rail):** Approved — Gold as page bookend (stats strip + footer) is intentional and works.

**Amendments:**
- B1. Hero stripe placement CONFLICT: S01 says full-width 100vw; Component A CSS scopes it to `.hero-image-col` (right 45% only). Resolve: apply the three-segment gradient as `::after` on the HERO SECTION CONTAINER — `bottom: 0; left: 0; width: 100%`. (Supersedes O3's anchor location; the hero container gets `position: relative`.)
- B2. S07/S08 identical "Register Your Interest" CTAs are ambiguous. Change S07 button to "Register — Referral Partner" and S08 to "Register — Ambassador Programme". Same Utility Blue flat treatment. Disclaimer text untouched. (FLAG: the PO spec REQ-14/15 mandates the exact label "Register Your Interest" — this amendment needs PO/business sign-off before adoption. See Conflicts section.)
- B3. Footer copyright is LEGALLY INACCURATE: "© 2026 iZinga (Pty) Ltd" — iZinga is not a registered entity. Change to "© 2026 Curiousoft (Pty) Ltd. Trading as iZinga. All rights reserved." Route final wording to Legal & Compliance. Must not ship as-specced.
- B4. Stats "As of [Month Year]" must be a content variable (`data-date` attribute or equivalent), not hardcoded prose — stale dates undermine all five figures.
- B5. Furniture and Parcel cards indistinguishable at scan speed. Add service chips top-right: "Furniture" solid Teal-tinted chip; "Parcel" outlined Teal chip. (Overlaps with D1 — lead to reconcile: eyebrow+border-weight (D1) vs chips (B5), or both.)

**Approvals:** dark/light rhythm, WhatsApp green exception, coverage map pin logic, testimonial role-color chips, mobile drawer accent bars.

---

## 4. PAY UI/UX DESIGNER

**Open Q1 (S04 distinction from S03):** Insufficient — 5 brightness points invisible on OLED. Add `border-top: 3px solid var(--btn-pill-color)` edge-to-edge at top of S04.
**Open Q2 (Pay feature tiles):** "Split Bill" is NOT a confirmed product capability — must not ship without PO sign-off. "Instant Payout" framing misleads customers. Replacement tile set (all substantiated): Payment Links ("Share a link, get paid instantly") / Tip Your Driver ("Scan a QR code, tip in seconds") / Yoco-Powered ("Trusted South African card processing") / No App Required ("Customers pay without downloading anything").

**Amendments:**
- P2. S04 opening Utility Blue border-top (per Q1).
- P3. Replace the placeholder tile set (per Q2).
- P4. "Get iZinga Pay" CTA is ambiguous (merchant vs customer reading). Recommended: "Pay or Tip with iZinga Pay" → pay.izinga.co.za. FLAG TO PO: CTA target determines section audience framing — needs PO decision.
- P5. S11 testimonials H2 "Trusted by drivers, merchants, and customers." above empty skeletons is a claim the page can't substantiate. Make conditional: placeholder state shows "Share your iZinga experience."; swap to the trust claim only when ≥1 populated card (JS `section--populated` class toggle).
- P6. Placeholder sub-line "be the first to share your experience" is a dead-end (no mechanism). Either plain "Testimonials coming soon." or add a WhatsApp share link (`wa.me/...?text=I+want+to+share+my+iZinga+experience`, 0.72rem Utility Blue underlined, Operations confirms number).
- P7. Stats strip needs a HARD LAUNCH GATE: render `display: none` by default, toggled via Firebase Remote Config flag (`stats_strip_live`), set by DevOps only after Data Intelligence approves final figures. Would-be REJECT if shipped without a gate. (NOTE: PO spec says figures are known/static — lead to reconcile the gate mechanism vs. the simpler hardcode-with-verified-values approach; the principle both agree on: no placeholder numbers can ever render publicly.)
- P8. Calculator result must show currency prefix: `R` as `<span class="result-currency">`, Catamaran 800, 1.25rem, top-aligned.
- P9. Result must display a RANGE ("R [low] — R [high]", ±15% of mid if no exact zone pricing), not a single figure. If range impossible, strengthen disclaimer to "Indicative estimate only. Your driver will confirm the final price before pickup."
- P11. B2B form success panel: interpolate the submitted email — "We'll email you within 1 business day. Keep an eye on [email]."
- P12. WhatsApp button: the WhatsApp ICON is REQUIRED (not optional) with `alt="WhatsApp"` on the SVG — Teal card accent + WhatsApp green are tonally adjacent; icon+label do the disambiguation.

**Approvals:** section rhythm, B2B form validation/success approach.

---

## 5. FOOD WEB UI/UX DESIGNER

**Open Q1 ("Durban Only" chip):** REJECT the chip. Leads with constraint at the same visual weight as the H3. Replace with positive sub-copy: "Available now in Durban" — Catamaran 400, 0.8rem, muted, below the feature bullets. (If an explicit chip is required for other reasons, use "Live in Durban" — present-tense, active.)
**Open Q2 (carousel labels):** "Home · Track Order · Pay" DO NOT match real cs-lifestyle screens. Replace with "Browse Stores · Add to Cart · Track Your Order" (maps to the real `main`, `checkout`, `orders` components). Update before any asset is commissioned.

**Amendments:**
- F1. TOKEN SCOPE: the composition's tokens DO NOT EXIST in cs-lifestyle (`styles.css` has no custom properties; primary is `#494949`). Add a note: "Tokens scoped to ijudi web (izinga.co.za) only." Prevents a developer assuming cross-app cascade. (Architecture-level; resolve before build.)
- F2. Button radius: marketing site flat (0) vs cs-lifestyle pill (1rem) is an accepted platform boundary — add a transition note under S03 Card 3 so no one tries to override either side.
- F3. Card padding 28px too heavy at 375px: add `@media (max-width: 767px) { .service-card { padding: 16px; } }` (matches cs-lifestyle's mobile card convention).
- F4. CTA tap targets compute ~41-42px — below 44px minimum. All card CTAs: `padding: 14px 18px` minimum or explicit `min-height: 44px`. Applies to S03 cards and S10 download buttons.
- F7. "Order Food" CTA sets wrong expectation (lands on a store LIST, not an order form). Change to "Browse Food Stores" or "Find Food Near You".
- F10. Add a transition/hand-off note for the cs-lifestyle boundary (separate app, different origin, landing on `/main` store list, no shared layout).

**Approvals:** Durban map pin (annotate the expansion path), S10 Coral QR frame, S09 mobile map treatment.

---

## CONFLICTS AND NON-DESIGNER DECISIONS — LEAD TO RESOLVE OR ESCALATE

1. **CTA labels on S07/S08** — Brand wants programme-specific labels ("Register — Referral Partner"); the PO spec REQ-14/15 mandates exactly "Register Your Interest". ESCALATE to PO/Orchestrator: recommend a compromise that satisfies both, e.g. keep "Register Your Interest" as the button text with the programme name in the card H2 immediately above, or get PO approval for the amended labels.
2. **Furniture card primacy** — Delivery D1 (6px border + eyebrow) vs Brand B5 (service chips). Compatible; lead decides whether to adopt one or both without over-decorating.
3. **Stats gate mechanism** — Pay P7 (Remote Config flag) vs PO spec (static verified figures, "as of" label). Principle shared: nothing unverified ever renders. Lead recommends mechanism; note Firebase Remote Config adds an external dependency the vanilla-JS constraint may not want — a build-time hard-coded verified value with the B4 `data-date` variable may satisfy both. Escalate if unsure.
4. **Hero stripe anchor** — B1 (hero container, full-width) supersedes O3 (image column). Adopt B1; apply O3's `position: relative` lesson to the hero container.
5. **Ops inputs needed before build** (route to Orchestrator → Lindani/Hloniphani/Operations): coverage-map per-city service lists (D5), Furniture card bullet confirmations (D3), programme box copy confirmations (D9), driver rate table (O-Q1), WhatsApp share number for testimonials (P6), quote calculator backend field confirmation (D-Q2 — iZinga Backend Platform).
6. **Legal wording** — footer copyright line (B3) to Legal & Compliance.
7. **New ticket for izinga-onboarding** — `?role=driver` deep-link (O-Q2). Route to Orchestrator to dispatch separately.
