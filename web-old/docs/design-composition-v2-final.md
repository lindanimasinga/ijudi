# iZinga Website Rebuild — Design Composition v2 (FINAL)

**Document ref:** REQ-30
**Author:** iZinga Design System (Lead)
**Date:** 21 July 2026
**Status:** FINAL — all five designer critiques integrated. Every change marked with critique ID.
**Based on:** design-composition-v1.md + design-critiques-v1.md
**Stack:** Vanilla HTML/CSS/JS · Self-hosted assets only · No frameworks

Amendment markers: `[O1]`, `[P9]` etc. identify the critique that drove each change.
CONFLICT resolutions are labeled `[CONFLICT n — RESOLVED]`.
Items needing external input before build carry `[PENDING INPUT]`.

---

## Conflict Resolutions (Lead decisions)

### CONFLICT 1 — CTA labels S07/S08 [CONFLICT 1 — RESOLVED]
Brand B2 wants programme-specific button labels. PO spec REQ-14/15 mandates exact string "Register Your Interest".
**Resolution:** Keep "Register Your Interest" as literal button text verbatim. Programme name appears in H2 immediately above the CTA card. B2 is incorporated at heading level, not button level. No PO escalation required.

### CONFLICT 2 — Furniture card primacy: D1 vs B5 [CONFLICT 2 — RESOLVED]
**Resolution:** Adopt both. D1 eyebrow establishes hierarchy; B5 chips provide scan-speed identification. Compatible — no over-decoration at card size.

### CONFLICT 3 — Stats gate: P7 vs PO spec [CONFLICT 3 — RESOLVED]
Firebase Remote Config violates the vanilla/self-hosted constraint.
**Resolution:** Stats strip ships `display: none` by default (HTML comment-wrapped). DevOps uncomments only after Data Intelligence approves all five verified figures. No runtime flag. `data-date` attribute handles the date label per B4.

### CONFLICT 4 — Hero stripe anchor: B1 vs O3 [CONFLICT 4 — RESOLVED]
**Resolution:** Adopt B1. Stripe is `::after` on the hero SECTION CONTAINER, not the image column. Hero container gets `position: relative` (applying O3's lesson to the correct element).

---

## Table of Contents

1. Design Plan
2. Dark / Light Section Rhythm
3. Role-Color Discipline Across 12 Sections
4. Mobile Nav Behavior — 7 Items
5. Section Specs — index.html
6. Component Designs (A through J)
7. Pending Inputs Before Build

---

## 1. Design Plan

### Palette

| Name | Token | Value | Site usage |
|---|---|---|---|
| Dark Hero | (direct value) | `#212121` | Hero, Stats, Drivers, Coverage map, Footer |
| Ground | `--bkg-color` | `#F8F7F7` | All light section backgrounds |
| Card | `--bkg-card-color` | `#f3f2f2` | Card backgrounds, alternating sections |
| Coral | `--btn-red-color` | `#D66247` | Customer/food sections, hero CTA |
| Teal | `--btn-green-color` | `#00A9A1` | Driver sections, Furniture/Parcel card accents |
| Gold | `--btn-bg-color` | `#be833d` | Merchant sections, stat figures, footer rail |
| Utility Blue | `--btn-pill-color` | `#1083A5` | Pay, B2B form, RP/Ambassador CTAs, nav accents |
| Text | `--text-color` | `#212121` | Body text on light backgrounds |
| Rule | `--rule` | `#e0dfdf` | Borders, dividers, skeleton bars, input borders **[O1]** |

Dark-section named tokens — use in place of bare hex on `#212121` backgrounds **[O6]**:

| Token | Value | Use |
|---|---|---|
| `--dark-text-primary` | `#ffffff` | Headings on dark |
| `--dark-text-secondary` | `#cccccc` | Body copy on dark |
| `--dark-text-muted` | `#aaaaaa` | Labels, sub-labels on dark |
| `--dark-text-faint` | `#666666` | Date labels, copyright on dark |
| `--dark-rule` | `#333333` | Borders on dark |

**Token discipline:** No bare hex in component CSS. Hover: `filter: brightness(0.9)`. `--btn-bg-hover-color` does not exist.

**Token scope:** Scoped to `izinga.co.za` (ijudi web) only. Not shared with cs-lifestyle, izinga-pay, or izinga-onboarding. **[F1]**

### Typography

| Role | Face | Weight | Usage |
|---|---|---|---|
| Display | Catamaran | 800 | H1, stat numbers |
| Heading | Catamaran | 700 | H2, H3, card headings |
| Body | Catamaran | 400 | Paragraphs, list copy |
| Label/Eyebrow | Catamaran | 700 + letter-spacing 0.1em + uppercase | Eyebrows, chip labels, form labels |
| Data/Token | Courier New (system mono) | Regular | Developer notes only |

Type scale (clamp only):
- H1: `clamp(2rem, 5vw, 3.5rem)`
- H2: `clamp(1.5rem, 3vw, 2.25rem)`
- H3: `clamp(1rem, 2vw, 1.375rem)`
- Body: `1rem / 1.65` · max-width 65ch
- Hero sub max-width: 45ch
- `text-wrap: balance` on all headings

### Spacing Scale

| Token | Value | Where |
|---|---|---|
| `--sp-xs` | `8px` | Chip padding, inline gaps |
| `--sp-sm` | `16px` | Card internal padding, form gaps |
| `--sp-md` | `32px` | Section horizontal padding (mobile) |
| `--sp-lg` | `48px` | Section vertical padding |
| `--sp-xl` | `80px` | Desktop hero and Pay padding |
| `--sp-2xl` | `120px` | Hero min-height reserve |

---

## 2. Dark / Light Section Rhythm

| # | Section | Background | Accent |
|---|---|---|---|
| 01 | Hero | `#212121` dark | Coral |
| 02 | Platform Stats | `#212121` dark (continuous from Hero) | Gold |
| 03 | Delivery Services | `--bkg-color` light | Teal (Furniture/Parcel), Coral (Food) |
| 04 | iZinga Pay | `--bkg-card-color` card-tone | Utility Blue |
| 05 | For Drivers | `#212121` dark | Teal |
| 06 | For Merchants | `--bkg-color` light | Gold |
| 07 | Referral Partner | `--bkg-card-color` card-tone | Utility Blue |
| 08 | Ambassador | `--bkg-color` light | Utility Blue |
| 09 | Coverage Map | `#212121` dark | Teal (pins), Blue (eyebrow) |
| 10 | App Downloads | `--bkg-color` light | Coral |
| 11 | Testimonials | `--bkg-card-color` card-tone | Neutral |
| 12 | Footer | `#212121` dark | Gold |

Pattern: 5 dark / 4 light / 3 card-tone. Non-mechanical. Dark sections are action-focused anchors.

---

## 3. Role-Color Discipline

| Section | Accent | Applied to | Forbidden |
|---|---|---|---|
| 01 Hero | Coral | Eyebrow, primary CTA, stripe segment 1 | Gold/Teal in CTA stack |
| 02 Stats | Gold | All 5 stat figures | Role-color on labels or dates |
| 03 Delivery | Teal (Furniture/Parcel cards); Coral (Food card) | Card left-border, CTA per card | Mixed role colors on a single card |
| 04 iZinga Pay | Utility Blue | Eyebrow, icons, CTA, top border | Any role color |
| 05 For Drivers | Teal | Eyebrow, CTA, calculator result, earnings figure | Coral or Gold |
| 06 For Merchants | Gold | Eyebrow, icons, CTA | Teal or Coral |
| 07 Referral Partner | Utility Blue | CTA, eyebrow | Role colors |
| 08 Ambassador | Utility Blue | CTA, eyebrow | Role colors |
| 09 Coverage Map | Teal pins (Furniture/Parcel); Coral pins (Food); Blue eyebrow | Pin dot color per service | Gold pins |
| 10 App Downloads | Coral | Download CTA, QR frame | Mixing Teal/Gold |
| 11 Testimonials | Neutral only in placeholder/heading | Role-color chips on individual quote cards when populated | Role color implying single-audience feedback |
| 12 Footer | Gold | Logo mark, top border, active link underlines | Role colors on nav links |

---

## 4. Mobile Nav Behavior — 7 Items

Items: Home | Delivery Services | For Drivers | For Merchants | iZinga Pay | Partners | Business

**1280px+:** Horizontal. Logo left. 7 links right. Catamaran 700, `0.8rem`, uppercase, `letter-spacing: 0.04em`. Active: Gold bottom underline `2px`. Hover: `opacity: 0.75`. "Business" link: `text-decoration-color: var(--btn-pill-color)` to signal B2B entry. No dropdown.

**960–1279px:** 4 priority links inline + "More ▾" for remaining 3. Dropdown: **[O4]** `position: absolute; top: 100%; left: 0; right: 0` on `position: relative` nav container, `z-index: 1000`, NOT `position: fixed`. Background `#212121`.

**375–767px (drawer):** Hamburger top-right. Drawer from right, 85% viewport width, `background: #212121`. 7 links: Catamaran 800, `1.25rem`, white, `padding: 20px 28px`. Role-color left bars **[O10]:** `border-left: 4px solid [token]` on `<a>`, `padding-left: 24px` on accented items (For Drivers → Teal; For Merchants → Gold; iZinga Pay → Blue; Business → Blue). Close X: **[O9]** `position: absolute; top: 20px; right: 24px` INSIDE drawer element (drawer `position: relative`). Motion: `translateX(100%) → translateX(0)`, `240ms ease-out`. Overlay: `rgba(0,0,0,0.5)`, `opacity 0→1`. `prefers-reduced-motion`: instant show/hide.

---

## 5. Section Specs

### S01 Hero

| Property | Spec |
|---|---|
| Background | `#212121` |
| Min-height | `100svh` mobile; `90vh` desktop; never < `500px` |
| Grid 1280+ | 2-col: 55% copy / 45% image. Image flush right viewport edge. |
| Grid 768–1279 | 2-col 50/50 |
| Grid 375–767 | 1-col stacked. Image: 200px band below copy. |
| Image suppression | **[O7]** `@media (max-height: 420px)` — suppress image. HEIGHT query, independent of width. |
| Eyebrow | Coral, `0.7rem`, `letter-spacing: 0.14em`, uppercase. "Delivering Across South Africa" |
| H1 | Catamaran 800, `clamp(2rem, 5vw, 3.5rem)`, `var(--dark-text-primary)`. "Move Anything, Anywhere." — "Anything" in Coral: `<em style="color:var(--btn-red-color);font-style:normal">` |
| Sub-copy | **[D4]** `var(--dark-text-secondary)`, `max-width: 42ch`. "Furniture, parcels, and food — delivered on your schedule by iZinga drivers across Johannesburg, Durban, and Cape Town." ("Same-day" removed — inaccurate for scheduled furniture.) |
| CTA stack | Row, `gap: 12px`. Primary: Coral bg, white, "Order a Delivery". Secondary: transparent, white border `2px`, "Become a Driver". Both: Catamaran 700, `padding: 13px 26px`, `border-radius: 0`, `min-height: 44px` **[F4]**. |
| Image treatment | `bikeDriver.png`. `object-fit: contain`, `object-position: bottom center`. Area bg: `#2a2a2a`. No filter. **[B-Q2 gate]** Inspect PNG before build — re-export as transparent cutout if white bg. No vignette. |
| Hero stripe | **[CONFLICT 4 — B1]** `::after` on hero SECTION CONTAINER. Container: `position: relative`. Stripe: `position: absolute; bottom: 0; left: 0; width: 100%; height: 4px`. `background: linear-gradient(90deg, var(--btn-red-color) 33.3%, var(--btn-green-color) 33.3% 66.6%, var(--btn-bg-color) 66.6%)`. |
| Nav on scroll | Transparent above hero → `background: #212121` after `80px`. `transition: background 200ms ease`. |

### S02 Platform Stats

**[CONFLICT 3]** Ships `display: none` by default. DevOps uncomments after Data Intelligence approves all 5 figures.

| Property | Spec |
|---|---|
| Background | `#212121` — continuous from Hero. `border-top: 1px solid var(--dark-rule)`. |
| Grid 1280+ | 5 equal columns. Vertical rules: `1px solid var(--dark-rule)`. |
| Grid 768–1279 | 5-col to 800px; below 800px: 3+2. |
| Grid 375–767 | 2-col; 5th full-width centered below. |
| Stat numbers | Catamaran 800, `2rem` desktop / `1.5rem` mobile, `color: var(--btn-bg-color)`, `font-variant-numeric: tabular-nums`. |
| Stat labels | Catamaran 400, `0.72rem`, `color: var(--dark-text-muted)`. |
| Date label | **[B4]** JS reads `data-date` attribute → renders "As of [value]". Never hardcoded prose. `0.6rem`, `color: var(--dark-text-faint)`. |
| Count-up | IntersectionObserver threshold `0.3`. rAF, `1400ms` ease-out cubic. `prefers-reduced-motion`: skip to final value. |
| Five figures | **[PENDING INPUT — Data Intelligence]** All five figures and dates must be verified before DevOps uncomments. |
| Padding | `32px` top/bottom per cell. |

### S03 Delivery Services

| Property | Spec |
|---|---|
| Background | `var(--bkg-color)` |
| Section padding | `80px` desktop; `48px` mobile |
| Eyebrow | Catamaran 700, `0.7rem`, uppercase, `letter-spacing: 0.1em`, muted. "What We Deliver" |
| H2 | Catamaran 800, `clamp(1.5rem, 3vw, 2.25rem)`, centered |
| Card grid 1280+ | 3-col, `gap: 32px`, `max-width: 1200px` centered |
| Card grid 768–1279 | 3-col to 900px; below 900px: 1-col |
| Card grid 375–767 | 1-col, `padding: 16px` **[F3]** |
| Card anatomy | `background: #fff`. `border-radius: 0`. `box-shadow: 0 2px 8px rgba(0,0,0,0.07)`. Flat — no hover elevation. |
| Platform boundary | **[F2]** `border-radius: 0` is correct for izinga.co.za. cs-lifestyle uses pill radius. Accepted platform boundary — do not attempt to unify. |

**Card 1 — Furniture [CONFLICT 2 — D1 + B5]:**
- `border-left: 6px solid var(--btn-green-color)` **[D1]**
- Eyebrow above H3: "FEATURED SERVICE" — `0.65rem`, uppercase, Teal **[D1]**
- Service chip top-right: solid Teal, `0.65rem`, white, `padding: 2px 8px`, label "Furniture" **[B5]**
- Feature bullets: **[D3 — PENDING INPUT — Operations to confirm]** Floor copy: "Large-item specialists — sofas, appliances, wardrobes" / "Two-person team for items over 30 kg" / "Available in Johannesburg and Durban — same-day bookings"
- CTA: WhatsApp button (Component F), `min-height: 44px` **[F4]**
- Below WhatsApp: **[D6]** "Already have the iZinga app? [Open app]" — Teal `0.72rem` inline text link, subordinate
- Secondary link **[D11]** (conditional): If calculator ACTIVE: "Get an instant quote ↓" — Teal text link, `0.8rem`. If calculator Coming Soon: "Quote calculator coming soon — book via WhatsApp for an immediate estimate." — `0.75rem` muted, not a link.
- B2B escape hatch **[D2]**: `0.75rem`, Utility Blue. "Furniture retailer or estate agent? See our Business programme →" → `/business.html`

**Card 2 — Parcel:**
- `border-left: 4px solid var(--btn-green-color)` (4px — standard weight)
- Service chip top-right: outlined Teal chip (transparent bg, Teal border, Teal text), label "Parcel" **[B5]**
- CTA: "Book Online" — Teal bg, white, flat, full-width, `min-height: 44px` **[F4]**

**Card 3 — Food:**
- `border-left: 4px solid var(--btn-red-color)` (Coral)
- Service chip top-right: solid Coral, label "Food" **[B5]**
- Below feature bullets: **[F-Q1 resolved]** "Available now in Durban" — Catamaran 400, `0.8rem`, muted. No "Durban Only" chip.
- CTA: **[F7]** "Browse Food Stores" — Coral bg, white, flat, `min-height: 44px` **[F4]** ("Order Food" removed — wrong expectation; landing is a store list)
- cs-lifestyle hand-off note **[F10]**: Separate app, different origin. Landing: `/main` (store list). `target="_blank" rel="noopener"`.

### S04 iZinga Pay

| Property | Spec |
|---|---|
| Background | `var(--bkg-card-color)` |
| Top border | **[P2]** `border-top: 3px solid var(--btn-pill-color)` edge-to-edge. Resolves OLED indistinguishability from S03. |
| Layout 1280+ | 2-col: 50% copy / 50% feature grid (2×2 tiles) |
| Layout 375–767 | 1-col. Tiles stack. |
| Eyebrow | Utility Blue, uppercase. "iZinga Pay" |
| H2 | "Instant payments, built into every delivery." |
| Tile set | **[P3]** Four confirmed capabilities: "Payment Links" (Share a link, get paid instantly) / "Tip Your Driver" (Scan a QR code, tip in seconds) / "Yoco-Powered" (Trusted South African card processing) / "No App Required" (Customers pay without downloading anything) |
| Tile styling | `background: #fff`. `border-left: 3px solid var(--btn-pill-color)`. `padding: 16px`. Icon, H4, 1-line description. Flat. |
| CTA | **[P4 — PENDING INPUT — PO to decide target and audience framing]** Interim: "Pay or Tip with iZinga Pay" → `pay.izinga.co.za` |
| Asset | `izinga-pay.png` or flat SVG placeholder |

### S05 For Drivers

| Property | Spec |
|---|---|
| Background | `#212121` |
| Layout 1280+ | 2-col: 45% calculator / 55% copy + feature list |
| Layout 375–767 | 1-col. Calculator below copy. |
| Eyebrow | Teal, uppercase. "Drive With iZinga" |
| H2 | `var(--dark-text-primary)`. "Earn on your schedule." |
| Body | `var(--dark-text-secondary)`, `max-width: 44ch` |
| Feature list | 3 items: Teal icon + white Catamaran 700 label |
| CTA | Primary: "Register to Drive" — Teal bg, white, flat, `min-height: 44px`. Secondary: transparent white border. **[F4]** |
| CTA href | **[O-Q2 — PENDING INPUT]** `https://onboarding.izinga.co.za/?role=driver` once deep-link wired (separate ticket). Until then: `https://onboarding.izinga.co.za/` |
| Calculator | `background: #2a2a2a` card. See Component D — driver earnings state. |

### S06 For Merchants

| Property | Spec |
|---|---|
| Background | `var(--bkg-color)` |
| Layout 1280+ | 3-col tiles + full-width CTA bar |
| Eyebrow | Gold, uppercase. "For Merchants" |
| H2 | "Your store, our drivers." |
| Feature tiles | `background: #fff`. `border-left: 4px solid var(--btn-bg-color)`. Gold icons. Catamaran 700 titles. |
| CTA bar | Full-width, `var(--bkg-card-color)` bg, `border-top: 1px solid var(--rule)`. Text left, Gold "Get Started" button right, `min-height: 44px`. **[F4]** |
| Asset | `izinga-deliveries.png` or placeholder |

### S07 Referral Partner (RP) Programme

| Property | Spec |
|---|---|
| Background | `var(--bkg-card-color)` |
| Layout | 2-col: 60% copy + benefit list / 40% CTA card |
| Eyebrow | Utility Blue. "Referral Partner Programme" |
| H2 | **[CONFLICT 1]** "Refer businesses. Earn commission." — programme name in H2 provides disambiguation. |
| Benefit list | 3–4 items. Utility Blue left-dot. Catamaran 400, `0.9rem`. |
| CTA card | White, `border-radius: 0`, `box-shadow: 0 2px 12px rgba(0,0,0,0.08)`. Catamaran 800 `1.1rem` heading. Button: "Register Your Interest" — Utility Blue flat. |
| DOM order | **[O approved]** Disclaimer above CTA button in DOM source. Do not reorder with CSS `order`. |
| Framing | "Register Your Interest" throughout. Never "Sign up" or "Join". |

### S08 Ambassador Programme

| Property | Spec |
|---|---|
| Background | `var(--bkg-color)` |
| Layout | 2-col: CTA card left, copy right (mirrored from S07) |
| Eyebrow | Utility Blue. "Ambassador Programme" |
| H2 | **[CONFLICT 1]** "Grow iZinga in your community." |
| Differentiator copy | "Ambassadors build iZinga presence on the ground — events, activations, community recruitment." |
| CTA | "Register Your Interest" — Utility Blue, flat, `min-height: 44px`. **[F4]** |
| DOM order | **[O approved]** Disclaimer above CTA in DOM source. Do not use CSS `order` to reorder. |
| Disclaimer | See Component J. Identical to S07. |

### S09 Coverage Map

| Property | Spec |
|---|---|
| Background | `#212121` |
| Layout 1280+ | 2-col: 40% copy / 60% SVG, right-aligned |
| Layout 375–767 | 1-col. Map below copy, `width: 100%`. |
| SVG | Self-hosted `/assets/images/sa-map.svg`. No external map libraries. |
| Eyebrow | Utility Blue, `var(--dark-text-muted)` |
| H2 | `var(--dark-text-primary)`. "Where we operate." |
| Body | `var(--dark-text-secondary)`. "iZinga operates in Johannesburg, Durban, and Cape Town. Expanding soon." |
| City pins | **[D5 — PENDING INPUT — Operations]** Per-city service lists must be confirmed before SVG is built. See Component E. |

### S10 App Downloads

| Property | Spec |
|---|---|
| Background | `var(--bkg-color)` |
| Layout 1280+ | 2-col: 50% copy + buttons / 50% carousel |
| Layout 375–767 | 1-col. Carousel above, copy+buttons below. |
| Eyebrow | Coral |
| H2 | "Order in minutes. Track in real time." |
| Store buttons | Self-hosted App Store + Google Play. Row desktop, stacked mobile. `min-height: 44px`. **[F4]** |
| QR frame | `border: 3px solid var(--btn-red-color)`. "Scan to download" `0.72rem` muted. Placeholder: solid Coral square with "QR". |
| Carousel labels | **[F-Q2]** "Browse Stores · Add to Cart · Track Your Order" (maps to `main`, `checkout`, `orders` in cs-lifestyle). |

### S11 Testimonials

| Property | Spec |
|---|---|
| Background | `var(--bkg-card-color)` |
| Eyebrow | Muted. "What people say" |
| H2 (conditional) | **[P5]** Placeholder state: "Share your iZinga experience." Populated state (JS `section--populated` on ≥1 real card): "Trusted by drivers, merchants, and customers." Never claim trust above empty skeletons. |
| Placeholder state | See Component B. |
| Sub-line | **[P6]** Default: "Testimonials coming soon." If Operations confirms a WhatsApp number: extend to link `wa.me/[number]?text=I+want+to+share+my+iZinga+experience` — `0.72rem` Utility Blue underlined. **[PENDING INPUT — Operations to confirm number]** |
| Populated cards | White, `border-left: 3px solid var(--rule)` **[O1]**, Catamaran 400 italic quote, Catamaran 700 name, role chip in role-color. |
| Carousel controls | Appear only when ≥1 real card. Not in placeholder state. |

### S12 Footer

| Property | Spec |
|---|---|
| Background | `#212121`. `border-top: 4px solid var(--btn-bg-color)`. |
| Layout 1280+ | 4-col: Logo + tagline / Links / Services / Legal + social |
| Layout 768–1279 | 2-col: Logo+tagline+social left / Links right |
| Layout 375–767 | 1-col. Link groups accordion-collapsed (JS toggle). |
| Logo | `izinga-logo-white.png`. Min 80px. Clear space maintained. |
| Links | Catamaran 400, `0.85rem`, `color: var(--dark-text-muted)`. Hover: `var(--dark-text-primary)`. Gold `text-decoration-color` on active. |
| Legal line | **[B3 — PENDING INPUT — Legal & Compliance]** Draft: "© 2026 Curiousoft (Pty) Ltd. Trading as iZinga. All rights reserved." Must not ship without Legal sign-off. "iZinga (Pty) Ltd" is not a registered entity. |
| Legal links | `0.72rem`, `color: var(--dark-text-faint)`. POPIA notice, T&C, Privacy Policy. |
| Social icons | Self-hosted SVGs, `20×20px`, `color: var(--dark-text-muted)`. Hover: `var(--dark-text-primary)`. Gap `16px`. Facebook, Instagram, WhatsApp. |
| Copyright strip | `border-top: 1px solid var(--dark-rule)`. Centered, `0.72rem`, `color: var(--dark-text-faint)`. |

---

## 6. Component Designs

### A. Hero Placeholder Treatment

`bikeDriver.png` stays per Lindani's instruction.

Image area: `background: #2a2a2a`. `object-fit: contain`, `object-position: bottom center`, `height: 100%`. No filter. Pre-build gate **[B-Q2]**: inspect PNG — re-export as transparent cutout if white/light background. No vignette.

Hero stripe **[CONFLICT 4 — B1]**:

```css
.hero-section {
  position: relative; /* B1 + O3 lesson applied to correct element */
}
.hero-section::after {
  content: '';
  position: absolute;
  bottom: 0; left: 0;
  width: 100%; height: 4px;
  background: linear-gradient(
    90deg,
    var(--btn-red-color)   33.3%,
    var(--btn-green-color) 33.3% 66.6%,
    var(--btn-bg-color)    66.6%
  );
}
```

H1: "Move Anything, Anywhere." — "Anything" = `<em style="color:var(--btn-red-color);font-style:normal">Anything</em>`

Sub-copy **[D4]**: "Furniture, parcels, and food — delivered on your schedule by iZinga drivers across Johannesburg, Durban, and Cape Town."

---

### B. Testimonials Placeholder Visual

No fake quotes. Designed holding state.

```
3-col grid (1-col mobile) of skeleton frames:
  Each frame:
    background: var(--bkg-color)
    border: 1px dashed var(--rule)  [O1 — now defined]
    padding: 20px

    44px circle — background: var(--rule) — centered, margin-bottom 14px
    bar 80% width, 8px high, background: var(--rule), border-radius 2px
    bar 90% width, 8px
    bar 60% width, 8px

Conditional sub-line below — see S11 spec for P5/P6 wording
  font-size: 0.8rem, color: muted, text-align: center, margin-top: 20px
```

JS toggle for conditional H2 **[P5]**:

```js
const section = document.querySelector('.testimonials-section');
if (section.querySelectorAll('.testimonial-card--populated').length > 0) {
  section.classList.add('section--populated');
}
// .section--populated .testimonials-heading-placeholder { display: none }
// .section--populated .testimonials-heading-trust { display: block }
```

Populated card structure: white bg, `border-left: 3px solid var(--rule)` **[O1]**, Catamaran 400 italic quote, Catamaran 700 name, role chip in role-color.

---

### C. App Screenshot Carousel

Carousel labels corrected **[F-Q2]**: "Browse Stores · Add to Cart · Track Your Order" (real cs-lifestyle screens: `main`, `checkout`, `orders`).

Placeholder state:
- Three phone frames `100×180px`
- Default: `border: 1px dashed var(--rule)` **[O1]**
- Active: `border: 3px solid var(--btn-red-color)`, full opacity
- Adjacent: `scale(0.9)`, `opacity: 0.7`
- Dots: `6px` circles in `var(--rule)`, active widens to `18px` Coral pill
- No arrow controls in placeholder

Populated state:
- Real `<img>` screenshots, `object-fit: cover`, `border-radius: 8px` inside frame
- Arrows: `36×36px`, `background: #212121`, white SVG, `border-radius: 0`, `min-height: 44px` / `min-width: 44px` **[F4]**
- Touch swipe, keyboard left/right, `translateX 300ms ease-out`
- `prefers-reduced-motion`: instant cut

---

### D. Calculator Widget — All States

**[O-Q1]** Driver Earnings Calculator: remove Coming Soon if Operations supplies rate table. Formula: `estimated_weekly = hours_per_day × days_per_week × rate_per_hour[city]`. Rate table: **[PENDING INPUT — Operations: 3 figures for JHB / Durban / CPT]**. Until rates arrive, keep Coming Soon for this instance only.

#### State 1: Active

Surface: `#fff` light sections; `#2a2a2a` dark sections.

Fields:
- `border: 1px solid var(--rule)` **[O1]**, `padding: 10px 12px`, `border-radius: 0`
- Focus: `border-color: [role-color]`
- Labels: `0.65rem`, uppercase, muted, `letter-spacing: 0.06em`
- CTA: Coral (delivery) / Teal (earnings). `min-height: 44px` **[F4]**

Delivery Quote fields **[D-Q2 — PENDING INPUT — iZinga Backend Platform to confirm]**: Use "Suburb name" not "Area". If backend requires constrained suburb-to-zone lookup, use autocomplete/select of supported suburbs. If field set cannot be confirmed before launch, ship entire calculator in Coming Soon state with fields hidden.

Driver Earnings fields: Hours per day (number), Days per week (number), City (select: Johannesburg / Durban / Cape Town).

#### State 2: Coming Soon / Disabled

- Inputs: `opacity: 0.4`, `cursor: not-allowed`, `pointer-events: none`
- Button: `background: var(--rule)` **[O1]**, muted text, `cursor: not-allowed`
- "Coming soon" badge **[O8]**: In S05 (driver/Teal section) → `background: var(--btn-green-color)` Teal, white 700 weight. In non-driver sections → `background: var(--btn-pill-color)` Utility Blue. `font-size: 0.6rem`, uppercase, `padding: 2px 7px`, `border-radius: 2px`.
- Explanatory line: `0.65rem` muted. "Earnings calculator launching soon. Register your interest above." (link text to S07/S08 anchor)
- Section not hidden.

#### State 3: Result Display

- Inputs remain editable
- Result panel below button
- Light sections: `background: #212121`
- Dark sections (S05) **[O5]**: `background: #1a1a1a; border: 1px solid #444` — avoids invisible panel on `#2a2a2a` card
- Result label: `0.6rem`, `var(--dark-text-muted)`, uppercase, `letter-spacing: 0.1em`
- Currency prefix **[P8]**: `<span class="result-currency">R</span>` — Catamaran 800, `1.25rem`, top-aligned, same color as result number
- Result display **[P9]**: RANGE format: "R [low] — R [high]". If backend returns single mid: `low = Math.floor(mid * 0.85)`, `high = Math.ceil(mid * 1.15)`. Color: Teal (driver earnings), Coral (delivery quotes).
- Disclaimer **[P9 strengthened]**: "Indicative estimate only. Your driver will confirm the final price before pickup." `0.65rem`, `var(--dark-text-muted)`.

Stats count-up JS **[H]**:

```js
function animateCounter(el) {
  const target = parseInt(el.dataset.target, 10);
  const numEl = el.querySelector('.stat-num-value');
  if (window.matchMedia('(prefers-reduced-motion: reduce)').matches) {
    numEl.textContent = target; return;
  }
  const start = performance.now();
  (function step(now) {
    const t = Math.min((now - start) / 1400, 1);
    numEl.textContent = Math.ceil((1 - Math.pow(1 - t, 3)) * target);
    if (t < 1) requestAnimationFrame(step); else numEl.textContent = target;
  })(performance.now());
}
new IntersectionObserver(
  entries => entries.forEach(e => { if (e.isIntersecting) animateCounter(e.target); }),
  { threshold: 0.3 }
).observe /* applied per-element */;
```

Date label injection **[B4]**:

```js
document.querySelectorAll('.stat-item[data-date]').forEach(el => {
  const label = el.querySelector('.stat-date');
  if (label) label.textContent = 'As of ' + el.dataset.date;
});
```

---

### E. Coverage Map Component

File: `/assets/images/sa-map.svg` — static self-hosted SA outline. No external map libraries. No province detail in v1.

City pins:

| City | Dot color | Services | Status |
|---|---|---|---|
| Johannesburg | Teal | **[PENDING INPUT — D5]** | Ops to confirm |
| Durban | Coral | **[PENDING INPUT — D5]** | Ops to confirm |
| Cape Town | Teal | **[PENDING INPUT — D5]** | Ops to confirm |

Ops gate: do not build SVG with hardcoded service lists until Operations confirms live services per city.

Pin anatomy:

```
Tooltip label div:
  background: rgba(0,0,0,0.8)
  color: var(--dark-text-primary)
  font-size: 0.6rem, font-weight: 700
  padding: 3px 7px
  City name + <br> + services (0.55rem, var(--dark-text-muted))

Dot div (geographic anchor):
  12px circle, border-radius: 50%
  background: [role-color], border: 2px solid #fff
  ::after: CSS border triangle downward in role-color
```

Default: labels always visible on desktop.

Hover/tap: dot `scale(1.33)`, `transition: 150ms ease`; label bg shifts to role-color. Touch: tap toggles; second tap collapses. Keyboard: `tabindex="0"`, Enter/Space toggles. `prefers-reduced-motion`: no scale, color shift only.

Mobile: `max-width: 300px` on `.sa-outline`, centered. Labels visible by default (no hover).

Map legend (bottom-right on dark surface): Teal dot "Furniture · Parcel" / Coral dot "Food Delivery". `0.6rem`, `var(--dark-text-muted)`.

---

### F. WhatsApp Booking Button

**[P12]** WhatsApp icon is REQUIRED. Teal card accent and WhatsApp green are tonally adjacent — icon + label do the disambiguation.

| Property | Spec |
|---|---|
| Color | `#25D366` — ONE sanctioned hex exception. Do not use elsewhere. |
| Icon | **[P12]** Self-hosted `/assets/images/whatsapp.svg`. White fill, `20×20px`. `alt="WhatsApp"`. `gap: 10px` to text. |
| Text | "Book via WhatsApp" — Catamaran 700, `0.875rem`, white, `letter-spacing: 0.04em` |
| Dimensions | Full-width of card. `padding: 12px 18px`. `border-radius: 0`. `min-height: 44px`. **[F4]** |
| href | **[PENDING INPUT — Operations to supply verified number]** `https://wa.me/27XXXXXXXXX?text=Hi+iZinga+I+would+like+to+book+a+furniture+delivery`. `target="_blank" rel="noopener"`. |
| Hover | `filter: brightness(0.9)`. |
| Card top accent | `3px` horizontal rule at top of Furniture card in Teal. WhatsApp green does not conflict — reads as product affordance, not brand color. |

---

### G. B2B Enquiry Form — /business.html

Utility Blue throughout. Professional B2B, not consumer.

Page layout: 1280+: 2-col (40% hero copy + programme boxes / 60% form). 768–1279: 2-col to 900px, then 1-col. 375–767: 1-col, form below.

Programme summary boxes (left column) **[D9 — structure only; copy PENDING INPUT]**: Each box: programme name Catamaran 800 + one-line value statement + 3 benefit bullets at `0.8rem`. No CTA inside box. **[PENDING INPUT — D9 — Operations/BD to supply copy]**

Form fields (in order):
1. Full name (required) *
2. Company (required) *
3. **[D7]** Job title (NOW REQUIRED — label "Job title *") — changed from optional, qualification signal
4. Email address (required) *
5. Phone number (optional)
6. Service interest (required) * — select **[D8]**:
   - Furniture Delivery — Preferred Provider
   - White-Label Delivery (Estate Agents)
   - Both — not sure yet
   - (Removed: "iZinga Pay Integration")
7. Message (required) * — textarea, `min-height: 100px`, `resize: vertical`
8. `<input type="hidden" name="source" value="">`

Grid: Row 1: Name | Company. Row 2: Job title | Email. Row 3: Phone | Service interest. Row 4: Message full-width. Row 5: Submit. Mobile: all 1-col.

Field styling: `border: 1px solid var(--rule)` **[O1]**, `padding: 11px 14px`, `border-radius: 0`, Catamaran 400. Select: `form-control` equivalent — NOT `form-select` or `form-select-sm`. Focus: `border-color: var(--btn-pill-color)`, `box-shadow: 0 0 0 3px rgba(16,131,165,0.15)`. Labels: `0.72rem`, Catamaran 700, uppercase, `letter-spacing: 0.06em`, muted. Required `*` in `var(--btn-red-color)`.

Submit: "Send Enquiry" — Utility Blue, white, flat, Catamaran 700, `padding: 14px 32px`, `min-height: 44px`. **[F4]** Full-width mobile.

Source tag JS:
```js
document.addEventListener('DOMContentLoaded', () => {
  const params = new URLSearchParams(window.location.search);
  const src = params.get('source')
    || (document.referrer ? new URL(document.referrer).hostname : 'direct');
  document.querySelector('input[name="source"]').value = src;
});
```

Validation: HTML5 `required` + `novalidate` on `<form>`. Custom inline errors: `0.72rem`, `var(--btn-red-color)`, "This field is required."

Success state **[P11]**: Form replaced (not redirected) by panel. `border-top: 3px solid var(--btn-pill-color)`. "Thank you — we'll be in touch within 1 business day. Keep an eye on [submitted email]." JS reads email field value into `.success-email` span before replacing form.

Form surface: `background: #fff`, `box-shadow: 0 4px 20px rgba(0,0,0,0.08)`, `border-radius: 0`, `padding: 40px` desktop / `24px` mobile.

---

### H. Platform Stats Counter Strip

Full spec in S02. Ships `display: none` by default **[CONFLICT 3]**.

HTML shell (ships comment-wrapped):

```html
<!-- STATS STRIP — DO NOT UNCOMMENT UNTIL DATA INTELLIGENCE APPROVES ALL FIGURES -->
<!--
<section class="stats-strip">
  <div class="stat-item" data-target="[VERIFIED]" data-date="[MONTH YEAR]">
    <span class="stat-num-value">0</span><span class="stat-suffix">+</span>
    <span class="stat-label">Active Drivers</span>
    <span class="stat-date"></span>
  </div>
  ... (5 total)
</section>
-->
```

DevOps: uncomment and populate `data-target` / `data-date` with Data Intelligence-approved values only.

---

### I. Role-Color Discipline

Authoritative reference: Section 3 of this document. Section 3 is the single source of truth for all developer implementation.

---

### J. RP / Ambassador Disclaimer Treatment

Mandatory verbatim text (CEO locked):

> By registering, you will receive the full programme terms and earn structure for your review before any agreement is active.

Typography: Catamaran 400, `0.7rem`, `line-height: 1.5`.

Contrast **[O2 — v1 was wrong]**: The disclaimer appears only on light sections (S07/S08).
- `#666` on `var(--bkg-color)` `#F8F7F7` ≈ 4.9:1 — passes WCAG AA
- `#666` on `var(--bkg-card-color)` `#f3f2f2` ≈ 4.8:1 — passes WCAG AA
- Never use `#666` on `#212121` dark (≈ 2.6:1, fails AA). If disclaimer ever moves to a dark section, use `var(--dark-text-muted)` (`#aaaaaa`) or lighter.

CSS:
```css
.rp-disclaimer {
  border-top: 1px solid var(--rule); /* [O1] */
  padding-top: 8px;
  margin-top: 10px;
  font-size: 0.7rem;
  line-height: 1.5;
  color: #666;
}
```

Placement: Below body copy, above CTA button in DOM source order **[O approved]** — do not reorder with CSS `order` (screen reader sequence). On desktop 2-col: disclaimer in left column; CTA in right column. Never shares a line with the CTA button.

Both S07 and S08: identical treatment. Verbatim text both places. Developers must not paraphrase.

---

## 7. Pending Inputs Before Build

Developers must not invent values for these items.

| # | Item | Blocking what | Owner | Critique IDs |
|---|---|---|---|---|
| 1 | Stats strip — 5 verified figures + dates | Stats section ships hidden until approved | Data Intelligence | P7, CONFLICT 3, B4 |
| 2 | Coverage map per-city service lists | SVG pin labels must not be hardcoded | Operations | D5 |
| 3 | Furniture card feature bullets | Floor copy in spec is placeholder only | Operations | D3 |
| 4 | B2B programme summary box copy (both boxes) | Box structure defined; copy is not | Operations / BD | D9 |
| 5 | Driver rate table (JHB / Durban / CPT per hour) | Driver earnings calculator stays Coming Soon | Operations | O-Q1 |
| 6 | WhatsApp booking number (Furniture card) | Button href ships with placeholder | Operations | F component |
| 7 | WhatsApp share number (Testimonials sub-line) | Plain-text fallback ships until confirmed | Operations | P6 |
| 8 | Quote calculator backend field set | Active state cannot be built until confirmed; otherwise ships Coming Soon with fields hidden | iZinga Backend Platform | D-Q2 |
| 9 | Footer legal wording | Draft in spec must not ship unreviewed | Legal & Compliance | B3 |
| 10 | iZinga Pay CTA target + audience framing | Interim label used until decided | Product Owner | P4 |
| 11 | `?role=driver` deep-link (izinga-onboarding) | CTA links to root until ticket wired | Orchestrator → new ticket | O-Q2 |

---

*End of Design Composition v2 (Final). All five designer critics: verify your critique IDs appear in the sections above before giving final sign-off.*
