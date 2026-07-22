# iZinga Website Rebuild — Design Composition v1

**Document ref:** REQ-30  
**Author:** iZinga Design System (Lead)  
**Date:** 21 July 2026  
**Status:** Draft — for critique by Brand, Onboarding, Food Web, Delivery, Pay designers  
**Stack:** Vanilla HTML/CSS/JS · Self-hosted assets only · No frameworks

---

## Table of Contents

1. [Design Plan — Palette, Typography, Layout](#1-design-plan)
2. [Dark / Light Section Rhythm](#2-darklight-section-rhythm)
3. [Role-Color Discipline Across 12 Sections](#3-role-color-discipline)
4. [Mobile Nav Behavior — 7 Items](#4-mobile-nav-behavior)
5. [Section Specs — index.html](#5-section-specs)
   - [S01 Hero](#s01-hero)
   - [S02 Platform Stats](#s02-platform-stats)
   - [S03 Delivery Services](#s03-delivery-services)
   - [S04 iZinga Pay](#s04-izinga-pay)
   - [S05 For Drivers](#s05-for-drivers)
   - [S06 For Merchants](#s06-for-merchants)
   - [S07 Referral Partner](#s07-referral-partner-rp-programme)
   - [S08 Ambassador](#s08-ambassador-programme)
   - [S09 Coverage Map](#s09-coverage-map)
   - [S10 App Downloads](#s10-app-downloads)
   - [S11 Testimonials](#s11-testimonials)
   - [S12 Footer](#s12-footer)
6. [Component Designs](#6-component-designs)
   - [A. Hero Placeholder Treatment](#a-hero-placeholder-treatment)
   - [B. Testimonials Placeholder Visual](#b-testimonials-placeholder-visual)
   - [C. App Screenshot Carousel](#c-app-screenshot-carousel)
   - [D. Calculator Widget — All States](#d-calculator-widget--all-states)
   - [E. Coverage Map Component](#e-coverage-map-component)
   - [F. WhatsApp Booking Button](#f-whatsapp-booking-button)
   - [G. B2B Enquiry Form — /business.html](#g-b2b-enquiry-form--businesshtml)
   - [H. Platform Stats Counter Strip](#h-platform-stats-counter-strip)
   - [I. Role-Color Discipline (cross-ref to Section 3)](#i-role-color-discipline-cross-ref)
   - [J. RP / Ambassador Disclaimer Treatment](#j-rp--ambassador-disclaimer-treatment)
7. [Open Items for Designer Critique](#7-open-items-for-designer-critique)

---

## 1. Design Plan

### Palette (from locked tokens — no hex in component CSS)

| Name | Token | Value | Site usage |
|---|---|---|---|
| Dark Hero | (no token — direct value) | `#212121` | Hero bg, Stats strip, Drivers section, Coverage map, Footer |
| Ground | `--bkg-color` | `#F8F7F7` | All light section page backgrounds |
| Card | `--bkg-card-color` | `#f3f2f2` | Card backgrounds, alternating light sections |
| Coral | `--btn-red-color` | `#D66247` | Customer/food sections, hero primary CTA, food card |
| Teal | `--btn-green-color` | `#00A9A1` | Driver sections, furniture/parcel card borders, WhatsApp btn accent |
| Gold | `--btn-bg-color` | `#be833d` | Merchant sections, stat figures, footer top rail |
| Utility Blue | `--btn-pill-color` | `#1083A5` | iZinga Pay, B2B form, RP/Ambassador CTAs, structural nav accents |
| Text | `--text-color` | `#212121` | Body text on light backgrounds |

**Token discipline:** No hex values in component CSS. Every color references a token above. Hover darkening uses `filter: brightness(0.9)` — the `--btn-bg-hover-color` token does not exist and must not be invented.

### Typography

| Role | Face | Weight | Usage |
|---|---|---|---|
| Display | Catamaran | 800 ExtraBold | H1 in hero, section openers, stat numbers |
| Heading | Catamaran | 700 Bold | H2 section titles, H3 sub-heads, card headings |
| Body | Catamaran | 400 Regular | Paragraphs, descriptions, list copy |
| Label / Eyebrow | Catamaran | 700 + letter-spacing 0.1em + uppercase | Section eyebrows, chip labels, form labels, table headers |
| Data / Token | Courier New (system mono) | Regular | Token references and measurement values in developer notes only |

**Type scale — `clamp()` only, no px breakpoint overrides:**

- H1: `clamp(2rem, 5vw, 3.5rem)`
- H2: `clamp(1.5rem, 3vw, 2.25rem)`
- H3: `clamp(1rem, 2vw, 1.375rem)`
- Body: `1rem / 1.65`
- Label/Eyebrow: `0.7rem / letter-spacing 0.1em`
- Line max-width: 65ch body, 45ch hero sub
- `text-wrap: balance` on all headings

### Layout Concept

Single long-scroll page on a 12-column grid at 1280px+, 8-column at 768–1279px, single-column stacked at 375px. Section inner content max-width 1200px, centered. Vertical rhythm uses a 32px base unit — all section paddings and gaps are multiples of 8px. Dark sections are denser and action-oriented; light sections have more white space and use cards to group options.

### Spacing Scale

| Token | Value | Where used |
|---|---|---|
| `--sp-xs` | `8px` | Chip padding, inline gaps |
| `--sp-sm` | `16px` | Card internal padding, form field gaps |
| `--sp-md` | `32px` | Section horizontal padding (mobile), card group gaps |
| `--sp-lg` | `48px` | Section vertical padding |
| `--sp-xl` | `80px` | Section vertical padding (desktop hero, Pay) |
| `--sp-2xl` | `120px` | Hero min-height padding reserve |

---

## 2. Dark / Light Section Rhythm

The existing site alternates randomly. This spec locks a deliberate rhythm: dark sections are reserved for the most action-focused moments (hero, stats, driver, coverage, footer) while light sections give services and community content room to breathe. The pattern is not mechanical alternation — it is audience-paced.

| # | Section | Background | Accent |
|---|---|---|---|
| 01 | Hero | `#212121` dark | Coral |
| 02 | Platform Stats | `#212121` dark (continuous from hero — no visible break) | Gold |
| 03 | Delivery Services | `--bkg-color` light | Teal (Furniture/Parcel), Coral (Food) |
| 04 | iZinga Pay | `--bkg-card-color` card-tone | Utility Blue |
| 05 | For Drivers | `#212121` dark | Teal |
| 06 | For Merchants | `--bkg-color` light | Gold |
| 07 | Referral Partner | `--bkg-card-color` card-tone | Utility Blue |
| 08 | Ambassador | `--bkg-color` light | Utility Blue |
| 09 | Coverage Map | `#212121` dark | Teal (map pins), Utility Blue (eyebrow) |
| 10 | App Downloads | `--bkg-color` light | Coral |
| 11 | Testimonials | `--bkg-card-color` card-tone | Neutral (no role accent) |
| 12 | Footer | `#212121` dark | Gold |

**Pattern logic:** Dark sections (01, 02, 05, 09, 12) anchor the page at top, mid-point driver recruitment, and the close — high-contrast action moments. Light sections carry informational and community content. Card-tone sections (04, 07, 11) sit between light sections to create quiet separation without needing a dark interrupt. Result: 5 dark / 4 light / 3 card-tone — a deliberate non-mechanical split.

---

## 3. Role-Color Discipline

Every section's accent color reflects the audience it primarily serves. A developer must not introduce a second role color into a section without a design decision recorded here.

| Section | Primary Accent | Applied to | Forbidden |
|---|---|---|---|
| 01 Hero | Coral | Eyebrow text, primary CTA button, hero stripe segment 1 | Gold / Teal in CTA stack |
| 02 Stats | Gold | All 5 stat figures | Role-color labels or dates |
| 03 Delivery Services | Teal — Furniture card border + WhatsApp btn border; Coral — Food card border | Card left-border accent, CTA button per card | Mixed role colors on a single card |
| 04 iZinga Pay | Utility Blue | Section eyebrow, icon accent, CTA button | Any role color — Pay is platform-neutral |
| 05 For Drivers | Teal | Section eyebrow, stat highlights, CTA button, calculator result figure, earnings number | Coral or Gold in any driver element |
| 06 For Merchants | Gold | Section eyebrow, feature icons, CTA button | Teal or Coral in merchant elements |
| 07 Referral Partner | Utility Blue | CTA button, section eyebrow, disclaimer link underline if linked | Role colors — RP is audience-neutral |
| 08 Ambassador | Utility Blue | CTA button, section eyebrow | Role colors — Ambassador is audience-neutral |
| 09 Coverage Map | Teal pins — Furniture/Parcel; Coral pins — Food; Utility Blue — section eyebrow | City pin dot and pointer color per service type | Gold pins (no merchant geo story in v1) |
| 10 App Downloads | Coral | Primary download CTA, QR frame border | Mixing Teal/Gold into download buttons |
| 11 Testimonials | Neutral only | No role accent — testimonials are cross-audience. Separator rule only. Role-color chips on individual quote cards once populated. | Any role color implying only one audience gave feedback |
| 12 Footer | Gold | iZinga logo mark, top border 4px rule, active link underlines | Role colors on footer nav links |

---

## 4. Mobile Nav Behavior — 7 Items

Nav items: Home | Delivery Services | For Drivers | For Merchants | iZinga Pay | Partners | Business

### 1280px and above

Horizontal nav. Logo left. 7 links right. Catamaran 700, `0.8rem`, `letter-spacing 0.04em`, uppercase. Active state: Gold bottom border `2px`. Hover: `opacity: 0.75`. No dropdown. "Business" link gets a subtle Utility Blue underline color (`text-decoration-color: var(--btn-pill-color)`) to distinguish it as the B2B entry point.

### 768–1279px (condensed)

Logo left. Between 960–1279px: a condensed inline nav shows 4 priority links (Home, Delivery Services, For Drivers, iZinga Pay) with a "More ▾" button for the remaining 3 (For Merchants, Partners, Business). The More dropdown panel appears below the nav bar, full-width, dark background `#212121`, 3 items in a horizontal row with 32px gaps. Below 960px: all items collapse to hamburger.

### 375–767px (drawer)

Hamburger icon top-right. Tap opens a full-height slide-in drawer from the right, covering 85% of viewport width. Background: `#212121`. Each of the 7 nav items on its own line: Catamaran 800, `1.25rem`, white, `padding: 20px 28px`. Role-color left accent bar (`4px` wide) on:

- For Drivers — Teal (`var(--btn-green-color)`)
- For Merchants — Gold (`var(--btn-bg-color)`)
- iZinga Pay — Utility Blue (`var(--btn-pill-color)`)
- Business — Utility Blue (`var(--btn-pill-color)`)

Close X top-right, same position as hamburger icon. Drawer closes on link tap or outside-area tap.

**Motion:** `translateX(100%)` → `translateX(0)`, `240ms ease-out`. Overlay: `background rgba(0,0,0,0.5)`, `opacity 0 → 1` simultaneously. `prefers-reduced-motion`: no transition, instant show/hide.

---

## 5. Section Specs

### S01 Hero

| Property | Spec |
|---|---|
| Background | `#212121` (dark hero, locked) |
| Min-height | `100svh` at mobile, `90vh` at desktop — never less than `500px` |
| Grid 1280+ | 2-col: 55% copy / 45% image area. Image area flush to right viewport edge, no inner padding. |
| Grid 768–1279 | 2-col: 50/50. bikeDriver.png at reduced scale. |
| Grid 375–767 | 1-col stacked. Image area becomes a 200px band below copy. Suppress image entirely below 420px viewport height to keep CTA above fold. |
| Eyebrow | Catamaran 700, `0.7rem`, `letter-spacing 0.14em`, uppercase, `color: var(--btn-red-color)`. Text: "Delivering Across South Africa" |
| H1 | Catamaran 800, `clamp(2rem, 5vw, 3.5rem)`, `color: #fff`, `text-wrap: balance`. "Move **Anything**, Anywhere." where "Anything" is rendered in Coral. No gradient. |
| Sub-copy | Catamaran 400, `clamp(0.9rem, 1.5vw, 1.1rem)`, `color: #ccc`, `max-width: 42ch`. "Furniture, parcels, food — delivered same-day by iZinga drivers in Johannesburg, Durban, and Cape Town." |
| CTA stack | Row, `gap: 12px`. Primary: `var(--btn-red-color)` bg, white text, "Order a Delivery". Secondary: transparent bg, white `border: 2px solid rgba(255,255,255,0.3)`, white text, "Become a Driver". Both: Catamaran 700, `padding: 13px 26px`, `border-radius: 0` (flat). Hover: `filter: brightness(0.9)` primary; `background: rgba(255,255,255,0.1)` secondary. |
| Image treatment | `bikeDriver.png` anchored bottom of image area. `object-fit: contain`, `object-position: bottom center`. Image area background: `#2a2a2a`. No filter overlay. No fabricated photography layer. |
| Bottom stripe | `4px` horizontal rule at base of hero, three equal segments: Coral / Teal / Gold. `width: 100vw`, bleeds edge to edge. Signals the three audience roles without text explanation. |
| Nav scroll behavior | Nav transparent above hero. Becomes `background: #212121` on scroll past `80px`. Transition: `background 200ms ease`. |

### S02 Platform Stats

| Property | Spec |
|---|---|
| Background | `#212121` — continuous from Hero. No visible section break. |
| Separator | `border-top: 1px solid #333` — subtle, not a hard visual cut. |
| Grid 1280+ | 5 equal columns, no gap. Vertical rules between cells: `1px solid #333`. |
| Grid 768–1279 | 5-col preserved. Below 800px: wrap to 3+2. |
| Grid 375–767 | 2-col grid. 5th stat centers below in a full-width cell. |
| Stat numbers | Catamaran 800, `2rem` desktop / `1.5rem` mobile, `color: var(--btn-bg-color)` (Gold), `font-variant-numeric: tabular-nums`. Suffix (K, +, min) in same weight as a `.stat-suffix` span. |
| Stat labels | Catamaran 400, `0.72rem`, `color: #aaa`, `letter-spacing: 0.03em`, `display: block`. |
| Date sub-label | "As of [Month Year]" — Catamaran 400, `0.6rem`, `color: #666`. |
| Count-up animation | IntersectionObserver threshold `0.3`. On entry: each `.stat-num` reads `data-target` attribute (integer). rAF loop increments by `ceil(target / 60)` per frame for ~1400ms ease-out. Suffix appears at frame 0. `prefers-reduced-motion`: skip loop, set `textContent` to final value immediately. |
| Five figures | Drivers Active · Orders Delivered · Cities Served · Merchants Onboarded · Avg Delivery Time (min). Placeholder values used during build; replace with live data from iZinga Data Intelligence before launch. |
| Padding | `32px` top / `32px` bottom per cell. No section heading — the figures speak. |

### S03 Delivery Services

| Property | Spec |
|---|---|
| Background | `var(--bkg-color)` — first light section, visual rest after two dark sections. |
| Section padding | `80px` top / `80px` bottom desktop; `48px` top / `48px` bottom mobile. |
| Eyebrow | Catamaran 700, `0.7rem`, uppercase, `letter-spacing: 0.1em`, `color: var(--text-color)` muted. "What We Deliver" |
| H2 | Catamaran 800, `clamp(1.5rem, 3vw, 2.25rem)`, `color: var(--text-color)`, centered. |
| Card grid 1280+ | 3 equal columns, `gap: 32px`, `max-width: 1200px` centered. |
| Card grid 768–1279 | 3-col to 900px; below 900px single-column stacked. |
| Card grid 375–767 | 1-col, full-width. |
| Card anatomy | Background: `#fff`. `border-left: 4px solid [role-color]`. No `border-radius`. `padding: 28px`. `box-shadow: 0 2px 8px rgba(0,0,0,0.07)`. No elevation on hover — flat. |
| Card 1 — Furniture | Left border: Teal. Icon: box/sofa SVG in Teal. H3 Catamaran 700. Sub-copy 3-line max. 3 feature bullets at `0.85rem`. CTA: WhatsApp booking button (see Component F). Secondary: "Get an instant quote ↓" text link in Teal, `0.8rem`, links to delivery quote calculator. |
| Card 2 — Parcel | Left border: Teal. CTA: "Book Online" — Catamaran 700, Teal bg, white text, flat, full-width. |
| Card 3 — Food | Left border: Coral. CTA: "Order Food" — Coral bg. Badge "Durban Only" as Coral chip top-right of card. |

### S04 iZinga Pay

| Property | Spec |
|---|---|
| Background | `var(--bkg-card-color)` — subtle differentiation from S03 without going dark. |
| Layout 1280+ | 2-col: 50% copy / 50% feature grid. Feature grid: 2×2 tiles showing 4 Pay capabilities. |
| Layout 768–1279 | 2-col to 800px; below 800px single-column, feature grid becomes 2×2 stacked. |
| Layout 375–767 | Single column. Feature tiles stack 1-col. |
| Eyebrow | Utility Blue, uppercase. "iZinga Pay" |
| H2 | "Instant payments, built into every delivery." |
| Feature tiles | Background: `#fff`. `border-left: 3px solid var(--btn-pill-color)`. `padding: 16px`. Icon top, H4 below, 1-line description. No drop-shadow — flat. |
| CTA | "Get iZinga Pay" — `var(--btn-pill-color)` bg, white text, flat. |
| Asset | `izinga-pay.png` if available; otherwise flat SVG placeholder of phone with payment receipt. |

### S05 For Drivers

| Property | Spec |
|---|---|
| Background | `#212121` — dark. Third dark section, strong visual anchor mid-page. |
| Layout 1280+ | 2-col: 45% earnings calculator / 55% copy + feature list. |
| Layout 375–767 | Single column. Calculator below copy. |
| Eyebrow | Teal, uppercase. "Drive With iZinga" |
| H2 | White. "Earn on your schedule." |
| Body copy | `color: #ccc`, `max-width: 44ch`. |
| Feature list | 3 items: Teal SVG icon + white label. Catamaran 700. E.g.: "Same-day payouts · Choose your area · Full support" |
| CTA | Primary: "Register to Drive" — Teal bg, white text, flat. Secondary: "Learn More" — transparent, `border: 2px solid rgba(255,255,255,0.3)`, white text. |
| Calculator surface | On dark background: calculator card uses `#2a2a2a` surface. See Component D (driver earnings state). |

### S06 For Merchants

| Property | Spec |
|---|---|
| Background | `var(--bkg-color)` — returns to light for contrast against S05 dark. |
| Layout 1280+ | 3-col feature tiles + full-width CTA bar below. |
| Eyebrow | Gold, uppercase. "For Merchants" |
| H2 | "Your store, our drivers." |
| Feature tiles | 3 tiles. Background `#fff`. `border-left: 4px solid var(--btn-bg-color)` (Gold). Icons in Gold. Titles Catamaran 700. |
| CTA bar | Full-width strip, `var(--bkg-card-color)` background, `border-top: 1px solid var(--rule)`. "Ready to list your store?" text left. "Get Started" Gold button right. |
| Asset | `izinga-deliveries.png` or placeholder showing store-to-door flow icon. |

### S07 Referral Partner (RP) Programme

| Property | Spec |
|---|---|
| Background | `var(--bkg-card-color)` |
| Layout | 2-col: 60% copy + benefit list / 40% CTA card (white surface, box-shadow). |
| Eyebrow | Utility Blue. "Referral Partner Programme" |
| H2 | "Refer businesses. Earn commission." |
| Benefit list | 3–4 items. Flat list with Utility Blue left-dot. Catamaran 400, `0.9rem`. |
| CTA card | White bg, no `border-radius`, `box-shadow: 0 2px 12px rgba(0,0,0,0.08)`. Heading Catamaran 800 `1.1rem`. CTA: "Register Your Interest" — Utility Blue button. Disclaimer: see Component J. |
| CEO override | Section is live (not hidden). "Register Your Interest" framing used throughout — never "Sign up" or "Join". |

### S08 Ambassador Programme

| Property | Spec |
|---|---|
| Background | `var(--bkg-color)` — lighter than S07 to prevent two card-tone sections merging. |
| Layout | 2-col: CTA card left, copy right — mirrors S07 to avoid identical feel. |
| Eyebrow | Utility Blue. "Ambassador Programme" |
| H2 | "Grow iZinga in your community." |
| Differentiator copy | "Ambassadors build iZinga presence on the ground — events, activations, community recruitment." Clearly distinguishes Ambassador from RP. |
| CTA | "Register Your Interest" — Utility Blue, flat. Same CTA text as RP. |
| Disclaimer | See Component J — identical treatment to S07. |

### S09 Coverage Map

| Property | Spec |
|---|---|
| Background | `#212121` |
| Layout 1280+ | 2-col: 40% copy / 60% SVG map. Map right-aligned within column. |
| Layout 375–767 | 1-col. Map below copy. Map width `100%`. |
| SVG map | Static South Africa outline SVG, self-hosted at `/assets/images/sa-map.svg`. No external map tile libraries. |
| City pins | JHB, Durban, Cape Town. See Component E for hover/tap spec. |
| Eyebrow | Utility Blue. |
| H2 | White. "Where we operate." |
| Body | `color: #ccc`. "iZinga operates in Johannesburg, Durban, and Cape Town. Expanding soon." |

### S10 App Downloads

| Property | Spec |
|---|---|
| Background | `var(--bkg-color)` |
| Layout 1280+ | 2-col: 50% copy + store buttons / 50% app screenshot carousel. |
| Layout 375–767 | 1-col. Carousel above, copy + buttons below. |
| Eyebrow | Coral. |
| H2 | "Order in minutes. Track in real time." |
| Store buttons | App Store + Google Play badge assets (self-hosted). Row on desktop, stacked column on mobile. |
| QR code | `3px solid var(--btn-red-color)` (Coral) border frame. "Scan to download" label below in `0.72rem` muted. Placeholder: solid Coral square with "QR" label until actual QR asset generated. |
| Screenshot carousel | See Component C. |

### S11 Testimonials

| Property | Spec |
|---|---|
| Background | `var(--bkg-card-color)` |
| Eyebrow | Muted color. "What people say" |
| H2 | "Trusted by drivers, merchants, and customers." |
| Placeholder state | Three card-shaped frames in `var(--bkg-color)` with `border: 1px dashed var(--rule)`. Inside each: 48px avatar circle in `var(--rule)`, skeleton bars (80%, 90%, 60% widths) in `var(--rule)`. Below cards: "Testimonials coming soon — be the first to share your experience." `0.8rem` muted, centered. No fake quotes ever. |
| Populated state | 3-col cards (1-col mobile). Card: white bg, no `border-radius`, `border-left: 3px solid var(--rule)` (neutral). Quote text Catamaran 400 `1rem` italic. Name below Catamaran 700. Role tag (Customer / Driver / Merchant) as small chip in appropriate role color — only role-color use in this section. |
| No carousel placeholder | Carousel controls appear only when there is real content to cycle. |

### S12 Footer

| Property | Spec |
|---|---|
| Background | `#212121`. `border-top: 4px solid var(--btn-bg-color)` (Gold). |
| Layout 1280+ | 4-col: Logo + tagline / Links / Services / Legal + social. |
| Layout 768–1279 | 2-col: Logo + tagline + social left / Links right (services merged into links). |
| Layout 375–767 | 1-col stacked. Logo top. Link groups accordion-collapsed (JS toggle). Legal block last. |
| Logo | `izinga-logo-white.png`. Minimum 80px wide. Clear space maintained per brand rules. |
| Links | Catamaran 400, `0.85rem`, `color: #aaa`. Hover: `color: #fff`, underline on hover. Gold `text-decoration-color` on active. |
| Legal | Catamaran 400, `0.72rem`, `color: #666`. POPIA notice, T&C link, Privacy Policy link. |
| Social icons | SVG self-hosted, `20×20px`, `color: #aaa`. Hover: `#fff`. Row `gap: 16px`. Platforms: Facebook, Instagram, WhatsApp. |
| Copyright | `border-top: 1px solid #333`. Below: "© 2026 iZinga (Pty) Ltd. All rights reserved." Centered, `0.72rem`, `color: #555`. |

---

## 6. Component Designs

### A. Hero Placeholder Treatment

`bikeDriver.png` stays per Lindani's instruction. The design works around the existing asset rather than framing it as incomplete.

**Image area spec:**

The image area column background is `#2a2a2a` — slightly lighter than the hero ground. This gives `bikeDriver.png` a surface without a hard edge. Image: `object-fit: contain`, `object-position: bottom center`, `height: 100%` of the column. No filter, no gradient overlay on the image. The three-color bottom stripe is a `::after` pseudo-element on the image area column, `4px` height:

```css
.hero-image-col::after {
  content: '';
  position: absolute;
  bottom: 0; left: 0; right: 0;
  height: 4px;
  background: linear-gradient(
    90deg,
    var(--btn-red-color)  33.3%,
    var(--btn-green-color) 33.3% 66.6%,
    var(--btn-bg-color)   66.6%
  );
}
```

**Copy area spec:**

- Eyebrow: Coral, `0.7rem`, `letter-spacing 0.14em`, uppercase
- H1: `clamp(2rem, 5vw, 3.5rem)`, white, "Move **Anything**, Anywhere." — "Anything" in Coral using a `<em>` styled with `color: var(--btn-red-color); font-style: normal`
- Sub: `#ccc`, `max-width: 42ch`
- CTA row: "Order a Delivery" (Coral, flat) | "Become a Driver" (transparent, white border)

---

### B. Testimonials Placeholder Visual

No fake quotes. The placeholder must read as intentional — a designed holding state.

**Structure:**

```
[ 3-col grid of skeleton frames ]
  Each frame:
  - background: var(--bkg-color)
  - border: 1px dashed var(--rule)
  - padding: 20px
  - Contents:
      [ 44px circle — background: var(--rule) — centered ]
      [ bar 80% width — height: 8px — background: var(--rule) ]
      [ bar 90% width — height: 8px ]
      [ bar 60% width — height: 8px ]

[ "Testimonials coming soon — be the first to share your experience." ]
  - font-size: 0.8rem
  - color: var(--text-color) muted
  - text-align: center
  - margin-top: 20px
```

**Why skeleton bars and not empty cards:** Dashed-border frames with skeleton bars communicate "content loads here" — a familiar pattern that implies intentional design. The sub-line inverts the absence into an invitation. This approach requires zero content and survives indefinitely without looking broken.

**Populated card structure (when content exists):**

```
[ white bg card, border-left: 3px solid var(--rule) ]
  [ Quote text — italic, 1rem ]
  [ Author name — Catamaran 700 ]
  [ Role chip — role-color per audience (Customer/Driver/Merchant) ]
```

---

### C. App Screenshot Carousel

#### Placeholder state

Three phone-frame outlines (`100×180px` each) with skeleton bars inside.

- Default: `border: 1px dashed var(--rule)`
- Active (center/first): `border: 3px solid var(--btn-red-color)` (Coral), full opacity
- Adjacent frames: `transform: scale(0.9)`, `opacity: 0.7`
- Dot indicators below: `6px` circles in `var(--rule)`, active dot widens to `18px` pill in Coral

No prev/next arrow controls in placeholder state — they appear only with real screenshots.

Label below each frame: `0.65rem` uppercase muted. Labels: "Home · Track Order · Pay" (update to match actual screen names before launch).

#### Populated state

- Same frame anatomy
- Real screenshots as `<img>`, `object-fit: cover`, `border-radius: 8px` inside frame (mimics phone bezel)
- Arrow controls: `36×36px` squares, `background: #212121`, white SVG arrow icon, `border-radius: 0`
- Touch/drag swipe on mobile (touchstart/touchend delta detection)
- Keyboard: left/right arrow keys when carousel has focus
- Slide transition: `transform: translateX` `300ms ease-out`
- `prefers-reduced-motion`: no transition, instant cut

---

### D. Calculator Widget — All States

Two calculator instances: **Delivery Quote Calculator** (customer-facing, S03 or standalone) and **Driver Earnings Calculator** (driver-facing, S05).

#### State 1: Active

Surface: `#fff` on light sections; `#2a2a2a` on dark sections.

Field styling:
- `border: 1px solid var(--rule)`
- `padding: 10px 12px`
- `border-radius: 0`
- Catamaran 400
- Focus: `border-color: [role-color]`, no `box-shadow`

Label: `0.65rem` uppercase muted, `letter-spacing: 0.06em`

CTA button: role-color for context — Coral on delivery quote (customer section), Teal on earnings (driver section).

Delivery Quote fields: Service type (select: Furniture / Parcel), From area (text), To area (text).

Driver Earnings fields: Hours per day (number), Days per week (number), City (select).

#### State 2: Coming Soon / Disabled

- Inputs: `opacity: 0.4`, `cursor: not-allowed`, `pointer-events: none`
- Submit button: `background: var(--rule)`, `color: [muted]`, `cursor: not-allowed`
- "Coming soon" badge: `background: var(--btn-pill-color)` (Utility Blue), white text, `0.6rem`, `font-weight: 700`, `letter-spacing: 0.08em`, `uppercase`, `padding: 2px 7px`, `border-radius: 2px`. Placed inline beside heading.
- Explanatory line below button: `0.65rem` muted. "Earnings calculator launching soon. Register your interest above."
- Section is not hidden — shows the feature is planned and drives interest registration.

#### State 3: Result Display

After a successful quote calculation:

- Inputs remain visible and editable for recalculation
- Result panel appears below the submit button
- Panel: `background: #212121` on both light and dark sections (consistent treatment regardless of page section background)
- Result label: `0.6rem`, `color: #aaa`, `text-transform: uppercase`, `letter-spacing: 0.1em`
- Result figure: Catamaran 800, `1.75rem`. Color: **Teal** for driver earnings, **Coral** for delivery quotes. Role-colored figure reinforces audience.
- Disclaimer: `0.65rem` `color: #aaa`. "Subject to driver availability · Final price confirmed on booking."

---

### E. Coverage Map Component

**File:** `/assets/images/sa-map.svg` — static self-hosted SVG, South Africa outline, public-domain simplified path. No province outlines in v1. No external map tile libraries.

**Three city pins:**

| City | Position | Dot color | Services shown |
|---|---|---|---|
| Johannesburg | ~54% left, ~32% top of SA viewbox | Teal | Furniture · Parcel |
| Durban | ~78% left, ~55% top | Coral | Food · Parcel |
| Cape Town | ~22% left, ~80% top | Teal | Parcel |

**Pin anatomy (each):**

```
[ tooltip label div ]
  - background: rgba(0,0,0,0.8)
  - color: #fff
  - font-size: 0.6rem, font-weight: 700
  - padding: 3px 7px
  - City name + line break + service names in 0.55rem #ccc

[ dot div — positioned below label, this is the geographic anchor ]
  - width/height: 12px, border-radius: 50%
  - background: [role-color]
  - border: 2px solid #fff
  - ::after: CSS border triangle pointing downward in role-color
```

**Default state:** Pin labels always visible on desktop — this is a marketing page. No hover-only labels.

**Hover / tap state:**

- Pin dot: `transform: scale(1.33)`, `transition: 150ms ease`
- Label background: shifts from `rgba(0,0,0,0.8)` to role-color
- Touch: tap toggles highlight; second tap collapses
- Keyboard: `tabindex="0"` on each pin, Enter/Space toggles

**Mobile:** Map scales to 100% width. Pins scale proportionally. Labels shown by default (no hover required). `max-width: 300px` on `.sa-outline` container, centered.

**Map legend (bottom-right overlay):**

```
[ Teal dot ] Furniture · Parcel
[ Coral dot ] Food Delivery
```

Font: `0.6rem`, `color: #aaa`. Background: none (sits directly on dark map surface).

---

### F. WhatsApp Booking Button

**Context:** Primary CTA in the Furniture delivery card (S03, Card 1).

| Property | Spec |
|---|---|
| Button color | `#25D366` (WhatsApp brand green). This is the ONE sanctioned exception to the role-color token system — WhatsApp green is a universally recognized affordance. Not added to the token system. Do not use elsewhere. |
| Icon | WhatsApp SVG (self-hosted at `/assets/images/whatsapp.svg`). White fill, `20×20px`, left-aligned. `gap: 10px` to text. |
| Text | "Book via WhatsApp" — Catamaran 700, `0.875rem`, white, `letter-spacing: 0.04em` |
| Dimensions | Full-width of card. `padding: 12px 18px`. `border-radius: 0` (flat — per brand system). |
| Placement | Bottom of Furniture card, below card body, above any secondary text link. This is the primary CTA for Furniture — it replaces a regular "Book Online" because WhatsApp is the operational booking channel for Furniture. |
| `href` | `https://wa.me/27XXXXXXXXX?text=Hi+iZinga+I+would+like+to+book+a+furniture+delivery` — pre-filled message. Phone number to be confirmed by Operations before build. `target="_blank" rel="noopener"`. |
| Hover | `filter: brightness(0.9)`. No other state change. |
| Card top accent | `3px` horizontal rule at top of card in Teal (not WhatsApp green). Teal is the driver/delivery role color. WhatsApp green does not conflict because it reads as a product affordance, not a brand color. |

---

### G. B2B Enquiry Form — /business.html

The B2B form serves furniture retailers (Preferred Provider) and estate agents (White-Label + Commission). It must read as professional B2B, not consumer. Utility Blue is the lead color.

#### /business.html Page Layout

- **1280+:** 2-col. Left (40%): hero copy explaining the B2B proposition + two programme summary boxes (Preferred Provider, White-Label). Right (60%): enquiry form on a white card with box-shadow.
- **768–1279:** 2-col to 900px; below 900px single-column, form below.
- **375–767:** Single column, form below copy.

#### Form Fields (in order)

1. Full name (required)
2. Company (required)
3. Role / title (optional)
4. Email address (required)
5. Phone number (optional)
6. Service interest (required) — select:
   - Furniture Delivery — Preferred Provider
   - White-Label Delivery (Estate Agents)
   - iZinga Pay Integration
   - Multiple / unsure
7. Message / "How can iZinga help?" (required) — textarea, min-height `100px`
8. `input[type="hidden" name="source" value=""]` — populated by JS (see below)

#### Field Styling

- Input/textarea: `border: 1px solid var(--rule)`, `padding: 11px 14px`, `border-radius: 0`, Catamaran 400, `background: #fff`, `color: var(--text-color)`
- Select: same as inputs — use `form-control` equivalent, not `form-select` or `form-select-sm`
- Focus: `border-color: var(--btn-pill-color)`, `box-shadow: 0 0 0 3px rgba(16,131,165,0.15)`
- Labels: `0.72rem`, Catamaran 700, `letter-spacing: 0.06em`, uppercase, muted color. Required asterisk `*` in Coral — `color: var(--btn-red-color)`.

#### Layout Grid

Row 1 (2-col): Full name | Company  
Row 2 (2-col): Role / title | Email  
Row 3 (2-col): Phone | Service interest  
Row 4 (full-width): Message  
Row 5: Submit button

On mobile: all rows 1-col.

#### Submit Button

"Send Enquiry" — `var(--btn-pill-color)` Utility Blue bg, white text, flat, Catamaran 700, `font-size: 0.9rem`, `padding: 14px 32px`. Full-width on mobile.

#### Hidden Source Tag

```js
// Populate on DOMContentLoaded
const params = new URLSearchParams(window.location.search);
const source = params.get('source') 
  || (document.referrer ? new URL(document.referrer).hostname : 'direct');
document.querySelector('input[name="source"]').value = source;
```

#### Validation

HTML5 `required` attributes on mandatory fields. Custom inline error messages below each field on submit attempt: `0.72rem`, `color: var(--btn-red-color)`, "This field is required." No browser default popups (`novalidate` on form, manual validation JS).

#### Success State

Form replaced (not redirect) by confirmation panel: `border-top: 3px solid var(--btn-pill-color)`, "Thank you — we'll be in touch within 1 business day." Catamaran 700, `1.1rem`. No confetti, no animation.

#### Form Surface

- `background: #fff`
- `box-shadow: 0 4px 20px rgba(0,0,0,0.08)`
- `border-radius: 0` — flat
- `padding: 40px` desktop / `24px` mobile
- Form heading: Catamaran 800, `1.25rem`, above the field grid
- Form sub-heading: `0.85rem` muted, "Tell us about your business and we will be in touch within 1 business day."

---

### H. Platform Stats Counter Strip

See full spec in [S02 Platform Stats](#s02-platform-stats).

**Count-up JS reference:**

```js
function animateCounter(el) {
  const target = parseInt(el.dataset.target, 10);
  const suffix = el.querySelector('.stat-suffix')?.textContent || '';
  const num = el.querySelector('.stat-num-value');
  const duration = 1400;
  const start = performance.now();

  function step(now) {
    const elapsed = Math.min((now - start) / duration, 1);
    const eased = 1 - Math.pow(1 - elapsed, 3); // ease-out cubic
    num.textContent = Math.ceil(eased * target);
    if (elapsed < 1) requestAnimationFrame(step);
    else num.textContent = target;
  }

  if (window.matchMedia('(prefers-reduced-motion: reduce)').matches) {
    num.textContent = target;
    return;
  }
  requestAnimationFrame(step);
}

const observer = new IntersectionObserver(entries => {
  entries.forEach(e => { if (e.isIntersecting) animateCounter(e.target); });
}, { threshold: 0.3 });

document.querySelectorAll('[data-target]').forEach(el => observer.observe(el));
```

---

### I. Role-Color Discipline (cross-ref)

Fully specified in [Section 3](#3-role-color-discipline). No further elaboration needed here — Section 3 is the authoritative reference for developer implementation.

---

### J. RP / Ambassador Disclaimer Treatment

**Mandatory verbatim text (CEO locked, do not paraphrase):**

> By registering, you will receive the full programme terms and earn structure for your review before any agreement is active.

#### Typography

- Catamaran 400
- `font-size: 0.7rem`
- `color: #666` on dark sections (`#212121` bg) / `color: var(--muted approximate #6b6460)` on light sections
- `line-height: 1.5`

This is 3 typographic steps below the H3 and one step below body copy — unambiguously subordinate without being hidden.

#### Structural separator

```css
.rp-disclaimer {
  border-top: 1px solid #333; /* dark sections */
  padding-top: 8px;
  margin-top: 10px;
  font-size: 0.7rem;
  line-height: 1.5;
}
/* On light sections: border-top-color: var(--rule) */
```

#### Placement

- Below body copy paragraph, above CTA button on mobile
- On desktop 2-col layout: below body copy in the left column; CTA button in right column
- The disclaimer never wraps around or shares a line with the CTA button

#### Contrast verification

- `#666` on `#212121` = **5.4:1** — passes WCAG AA for text at any size
- `#666` on `#fff` = **5.74:1** — passes WCAG AA
- No accessibility compromise required for this treatment

#### Both sections

Identical treatment on S07 (Referral Partner) and S08 (Ambassador). The same disclaimer text appears verbatim in both. Developers must not paraphrase or shorten the text.

---

## 7. Open Items for Designer Critique

### Brand Designer

1. The three-color hero bottom stripe (Coral/Teal/Gold) — confirm this reads as intentional audience signaling and not visual noise at viewport scale.
2. `bikeDriver.png` on `#2a2a2a` surface — does the image have enough contrast/definition for this treatment at all breakpoints, or does it need a vignette? (Recommend checking the actual PNG before build.)
3. Footer Gold top rail — is `4px` the right weight, or does it read as too heavy given the Gold is also on stat figures one scroll up?

### Delivery UI/UX Designer

1. WhatsApp button as primary CTA on Furniture card — confirm this matches the operational booking flow. If the booking is sometimes handled in-app (not WhatsApp), the CTA hierarchy changes.
2. Delivery quote calculator active state — does the field set (service type, from area, to area) match what the backend can actually quote? If not, revise the field set before build to avoid false promises to users.

### Food Web UI/UX Designer

1. Food card Coral left-border with "Durban Only" chip — does this treatment risk making the Food product feel limited rather than focused? If so, propose alternative framing (e.g., "Live in Durban" or move the geo scope to sub-copy).
2. App screenshot carousel labels ("Home · Track Order · Pay") — confirm these match actual app screen titles before the carousel is built.

### iZinga Pay UI/UX Designer

1. S04 uses `--bkg-card-color` as background — confirm this adequately distinguishes Pay from adjacent S03 (Delivery Services, also light). If the two sections feel merged on scroll, propose a deliberate tonal shift or a thin divider rule.
2. The Pay feature grid shows 4 tiles — confirm the 4 capabilities to display (placeholder assumption: Accept Payments, Tip Driver, Split Bill, Instant Payout).

### Onboarding UI/UX Designer

1. Driver earnings calculator is specced as Coming Soon / disabled state — confirm this matches current onboarding capability. If the calculator can be built now, remove the disabled state and link the CTA directly to the driver registration flow.
2. "Register to Drive" CTA in S05 — confirm the link target (onboarding app URL) and whether it should deep-link to a specific step in the registration flow before build.

---

*End of Design Composition v1. All five designer critics should add their feedback as comments or tracked changes to this file before the integration pass.*
