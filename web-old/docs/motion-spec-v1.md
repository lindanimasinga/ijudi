# iZinga Marketing Site — Motion Specification v1

**Owner:** iZinga Design System agent
**Applies to:** `web-old/` — `index.html`, `business.html`, `css/rebuild.css`, `js/site.js`
**Status:** Authoritative. Implement directly from this document.
**Commissioned by:** Lindani Masinga (co-founder/CEO), with delegated authority on creative boldness.
**Supersedes:** the motion fragments scattered through `design-composition-v2-final.md` (nav swap, drawer slide, count-up, pin hover). Those specs remain valid; this document absorbs them into a token system and extends around them.

---

## 0. What this document is and is not

This is a **specification**, not code. A developer agent implements it. Every rule here is written to be implementable without asking a follow-up question. Where a value is stated, it is the value — do not "tune to taste."

Two things this spec refuses to do, on purpose:

- It does not introduce shadow, elevation, or border-radius in any form. See §1.4.
- It does not introduce any looping or ambient motion. See §5.5.

---

## 1. Motion token set

### 1.1 Duration tokens

The existing site speaks in 150 / 200 / 240 / 300ms ease-out, plus 1400ms for the count-up. That is a real, if small, vocabulary. These tokens **name what already exists** and add exactly three values above it. Nothing existing changes value.

Add to the `:root` block in `css/rebuild.css`, directly after the spacing scale:

```css
:root {
  /* --- MOTION: duration --- */
  --dur-instant:    100ms;  /* colour-only swaps, focus rings, tooltip opacity */
  --dur-quick:      150ms;  /* micro: link colour, icon nudge, dot scale */
  --dur-base:       200ms;  /* DEFAULT. hover states, surface tone shift, filter */
  --dur-moderate:   240ms;  /* drawer, overlay, accent-rule draw, card hover set */
  --dur-slow:       300ms;  /* entrance reveals (rise, fade), carousel slide */
  --dur-deliberate: 420ms;  /* wipe and mask entrances — the "considered" tier */
  --dur-count:     1400ms;  /* stat count-up. RESERVED. Do not reuse. */
  --dur-trace:     1600ms;  /* SA map self-draw. RESERVED. Single use, S09 only. */
}
```

Rules of use:

- `--dur-base` is the default for anything not otherwise specified. If you are unsure, use it.
- Nothing between `--dur-deliberate` and `--dur-count` exists. If a motion feels like it needs 700ms, it is doing too much — decompose it into two staged motions instead.
- `--dur-count` and `--dur-trace` are reserved. They mark the site's two "moments." Using them anywhere else devalues both.

### 1.2 Easing tokens

```css
:root {
  /* --- MOTION: easing --- */
  --ease-out:      cubic-bezier(0.215, 0.61, 0.355, 1);  /* easeOutCubic. DEFAULT. */
  --ease-standard: cubic-bezier(0.4, 0, 0.2, 1);          /* two-way: hover on AND off */
  --ease-trace:    cubic-bezier(0.65, 0, 0.35, 1);        /* easeInOutCubic. Map draw only. */
}
```

`--ease-out` is the exact CSS-bezier equivalent of the `1 - (1-t)^3` curve already running in `site.js:113-163`. This is deliberate: the count-up and every CSS reveal on the page will now share one identical acceleration curve. That single fact does more for "designed system" perception than any individual effect in this document.

`--ease-standard` exists only for **hover**, which is bidirectional. `--ease-out` on a hover-out feels like the element is escaping. Use `--ease-standard` wherever a `:hover` transition can run in reverse.

`--ease-trace` is ease-in-out because a drawn route should start slow, cover ground, and arrive slow. It is used exactly once.

There is no `--ease-in`. Elements never accelerate out of view on this site.

### 1.3 Stagger and distance tokens

```css
:root {
  /* --- MOTION: stagger & distance --- */
  --stagger-tight: 60ms;   /* 4+ sibling items (tile grids, footer columns) */
  --stagger-base:  80ms;   /* DEFAULT. 2-4 siblings */
  --stagger-loose: 120ms;  /* 2 siblings only, or deliberately theatrical pairs */
  --reveal-dist:    16px;  /* rise distance, DEFAULT */
  --reveal-dist-lg: 24px;  /* rise distance for full-width section headers only */
}
```

Stagger index is **capped at 6** (see §6.3). A 12-item list must not take 960ms to finish arriving.

### 1.4 Tokens deliberately OMITTED — and why

**No `--shadow-*`. No `--radius-*`. No `--elevation-*`.**

This is a design decision, not an oversight, and it is the single most load-bearing decision in this document.

The CEO directive of 21 July (all filled buttons `#212121`, `border-radius: 0` globally) and the design-system rule "elevation only for modals and overlays" have already been violated and reverted at least once inside this org. The reliable failure mode is not a designer deciding to break the rule — it is a future agent finding a `--shadow-sm` token in `:root`, concluding it is sanctioned because it exists, and using it. **A token is a permission slip.** The absence of these tokens means any future violation requires writing a raw `box-shadow` or `border-radius` value into a stylesheet, which is visible in review and greppable in CI.

If a future requirement genuinely needs elevation (a modal, per the design system), it is written inline at the modal, with a comment naming the exemption. It does not get a token.

Recommend to the developer: add a CI grep gate on `css/rebuild.css` for `box-shadow` and `border-radius` outside an allowlist. Current legitimate exceptions in the file are `border-radius: 50%` on `.pin-dot` / `.map-legend-dot` / `.dot` (circular data marks, not UI surfaces) and the `box-shadow` on `.pin-tooltip` (an overlay). Everything else is a violation.

---

## 2. The unifying motion grammar

### 2.1 The signature: **Travel, not lift.**

iZinga moves things from an origin to a destination. That is the entire business. The site's motion signature is therefore **one-dimensional directional travel along an axis** — never depth, never scale, never rotation.

Every motion on this site is one of exactly three things:

1. **A rule that draws** — a line grows from its origin along one axis (`transform: scaleX/scaleY`, origin at the leading edge).
2. **A surface that arrives** — content translates a short distance along one axis and resolves (`transform: translateY`, `opacity`).
3. **An edge that clears** — a mask or clip retracts along one axis to expose content already in place (`clip-path: inset`).

All three are the same gesture at different scales: *something moves along a line from where it started to where it belongs.* That is a delivery. That is the brand.

### 2.2 The three laws

**Law 1 — One axis.** No motion combines horizontal and vertical travel. No diagonal. A card either rises or wipes; never both.

**Law 2 — Reading direction.** Horizontal motion is always left-to-right, origin at left. Vertical entrance motion is always upward (content rises into place from +16px). Vertical *arrival* motion (things that land from above — pins, tooltips) is downward. Nothing on this site moves right-to-left or falls downward-and-away.

**Law 3 — Nothing changes size.** No element on this site scales in a way that changes its perceived size. The only `scale()` permitted is on a line (`scaleX`, drawing a rule from 0 length) and on circular data marks under 16px (`.pin-dot`, `.dot`). Buttons, cards, images, tiles never scale.

Law 3 is what replaces the shadow-lift. See §3.

### 2.3 Why this reads as a system

If Laws 1–3 hold across 12 sections, a visitor scrolling the page sees the same gesture at every scale: a 3px accent rule drawing across 40px on card hover, a tile rising 16px into place, a section header's underline drawing across 60px, and a 500px route tracing across South Africa. It is one idea, repeated at four magnitudes. That is what makes a set of effects read as design rather than as a demo reel.

---

## 3. The flat-design motion vocabulary

This is the creative core. Shadow, elevation and radius are unavailable, so the entire standard "premium web" hover toolkit — lift, depth-bloom, soft glow, rounded-corner morph — is off the table. Depth and quality must come from **drawing, filling, clipping, tone, rule-lines, and letterform**.

### 3.1 Hover vocabulary for a flat, borderless, zero-radius card

This is the canonical card hover. It applies to `.delivery-card`, `.pay-tile`, `.merchant-tile`, `.rp-item`, `.biz-programme` — every card-shaped surface on both pages. It is composed of four simultaneous layers. All four run together; none is optional.

**Layer 1 — The accent rule (the primary signal).**

A 3px bar in the section's accent colour draws along the card's **left** edge, from top origin.

```css
.iz-card { position: relative; }
.iz-card::before {
  content: '';
  position: absolute;
  left: 0; top: 0;
  width: 3px; height: 100%;
  background: var(--section-accent);   /* set per-section, see §4 */
  transform: scaleY(0);
  transform-origin: top;
  transition: transform var(--dur-moderate) var(--ease-standard);
}
.iz-card:hover::before,
.iz-card:focus-within::before { transform: scaleY(1); }
```

This is the flat-design substitute for elevation. It is **already precedent in this design system** — the mobile drawer at `design-composition-v2-final.md:155` uses `border-left: 4px solid [role token]` for exactly this purpose. The card accent bar is the drawer's language applied to a card, not a new invention. 3px (not the drawer's 4px) because a card is a smaller surface.

`:focus-within` is included so keyboard users get the identical signal. This is not optional.

**Layer 2 — Tonal separation (the depth substitute).**

The card surface shifts one step away from its section background. Depth without shadow is achieved by *increasing the contrast between the surface and what it sits on*.

```css
/* Light sections */
.iz-card { background: var(--bkg-card-color); transition: background var(--dur-base) var(--ease-standard); }
.iz-card:hover, .iz-card:focus-within { background: #ffffff; }

/* Dark sections */
.section--dark .iz-card { background: #212121; }
.section--dark .iz-card:hover, .section--dark .iz-card:focus-within { background: #2b2b2b; }
```

On light sections the card gets *brighter* than the page (`#f3f2f2` → `#ffffff`). On dark sections it gets *lighter* than the page (`#212121` → `#2b2b2b`). The direction is consistent: hovering always moves the surface toward light. That consistency is what makes it read as "forward" without any shadow.

**Layer 3 — Letterform opening.**

The card's `h3` gains `0.01em` of letter-spacing.

```css
.iz-card h3 { transition: letter-spacing var(--dur-moderate) var(--ease-standard); }
.iz-card:hover h3, .iz-card:focus-within h3 { letter-spacing: 0.01em; }
```

At Catamaran 700 / ~1.1rem this is roughly 1px of total width change on a 20-character heading — below the threshold of conscious perception, above the threshold of felt quality. It is the most "expensive-feeling" thing available in a flat system.

**Caveat the developer must respect:** `letter-spacing` triggers layout, not compositing. It is permitted **only** on a single short heading element inside a card, never on body copy, never on a list, never on more than one element per card. If the card's h3 wraps to two lines at any breakpoint, drop Layer 3 for that component rather than risk reflow jitter. Test at 375px.

**Layer 4 — Directional cue on the card's link (only where a link exists).**

```css
.iz-card .card-link-arrow {
  display: inline-block;
  transition: transform var(--dur-quick) var(--ease-standard);
}
.iz-card:hover .card-link-arrow,
.iz-card:focus-within .card-link-arrow { transform: translateX(4px); }
```

4px, left-to-right, per Law 2.

**Explicitly banned on cards:** `box-shadow`, `filter: drop-shadow`, `transform: scale`, `transform: translateY` on hover, `border-radius`, `outline` as decoration, `border` appearing on hover (a border that appears causes a 1px layout shift on a zero-radius flat card and looks like a bug).

### 3.2 Button hover — unchanged, formalised

The existing `filter: brightness(0.85)` / `brightness(0.9)` at 200ms is correct and stays. Retokenise only:

```css
.btn, .store-btn, .iz-btn {
  transition: filter var(--dur-base) var(--ease-standard);
}
.btn:hover, .store-btn:hover, .iz-btn:hover { filter: brightness(0.9); }
```

Filled buttons remain `#212121`. Zero radius. No accent rule on buttons — the accent rule is card vocabulary; putting it on buttons dilutes it.

### 3.3 Section-header rule — the recurring motif

Every section `h2` gets a drawn rule beneath it, in the section's accent colour. This is the single most repeated element in the choreography and is what visually binds the 12 sections together.

```css
.section-rule {
  display: block;
  width: 60px; height: 3px;
  background: var(--section-accent);
  transform: scaleX(0);
  transform-origin: left;
  transition: transform var(--dur-slow) var(--ease-out);
  margin-top: 12px;
}
html.js-reveal [data-reveal="draw"]:not(.is-revealed) .section-rule,
html.js-reveal .section-rule[data-reveal="draw"]:not(.is-revealed) { transform: scaleX(0); }
.section-rule.is-revealed { transform: scaleX(1); }
```

On centre-aligned sections (`.testimonials-section`, and any `text-align: center` header) use `transform-origin: center` and `margin: 12px auto 0`. This is the one sanctioned deviation from Law 2 — a centred rule drawing from one end reads as broken, not as directional.

### 3.4 Entrance vocabulary — the six reveal patterns

These are the complete set. There are no others. Adding a seventh requires Design System sign-off.

| ID | `data-reveal` value | From → To | Duration | Easing | Use for |
|---|---|---|---|---|---|
| R1 | `rise` | `opacity:0; translateY(16px)` → `opacity:1; translateY(0)` | `--dur-slow` | `--ease-out` | **Default.** Text blocks, tiles, CTA stacks, list items |
| R2 | `wipe` | `clip-path: inset(0 100% 0 0)` → `inset(0 0 0 0)`, opacity stays 1 | `--dur-deliberate` | `--ease-out` | Card grids, image-plus-caption units, programme rows |
| R3 | `draw` | `scaleX(0)` origin left → `scaleX(1)` | `--dur-slow` | `--ease-out` | Section rules, dividers, underlines, progress bars |
| R4 | `settle` | `opacity:0; translateY(-12px)` → `opacity:1; translateY(0)` | `--dur-moderate` | `--ease-out` | Things that *land*: map pins, badges, tooltips, floating elements |
| R5 | `mask` | `clip-path: inset(100% 0 0 0)` → `inset(0 0 0 0)`, opacity stays 1 | `--dur-deliberate` | `--ease-out` | Photography, large imagery, hero-scale headings on secondary pages |
| R6 | `fade` | `opacity:0` → `opacity:1` | `--dur-slow` | `--ease-out` | LCP-adjacent imagery, skeleton placeholders, anything where translate risks CLS |

Notes:

- **R2 vs R5 are the same gesture on different axes.** R2 clears horizontally (a wipe), R5 clears vertically (a mask). Both leave `opacity: 1` throughout — the content is never faded, it is *uncovered*. This is what makes them feel more expensive than R1, and why they are reserved for hero-tier content.
- **R2 and R5 require the element to have a background or be a self-contained visual block.** Clipping loose body text mid-word for 420ms looks like a rendering fault. Never put R2/R5 on a bare `<p>`.
- **R6 exists specifically for the LCP element and for skeleton content.** `bikeDriver.png` in the hero must never translate.
- `clip-path` on `inset()` is compositor-accelerated in Chromium and WebKit and is the only "reveal" primitive that avoids both layout and paint. It is the right choice for the low-end-Android target.

### 3.5 Global constraint on the animatable property set

The **only** properties any rule in this spec may transition or animate:

`opacity`, `transform` (translate/scaleX/scaleY only), `clip-path`, `filter: brightness()`, `background-color`, `color`, `border-color`, `letter-spacing` (§3.1 Layer 3 only), `stroke-dashoffset` and `fill-opacity` (§5 only).

**`transition: all` is banned.** Two existing violations must be fixed as part of this work: `css/rebuild.css:980` (`.dot { transition: all 200ms }`) and the `all`-adjacent `.phone-frame { transition: transform 200ms, opacity 200ms }` at :952 which is fine but must be retokenised. Enumerate every property.

---

## 4. Per-section choreography

### 4.0 Rules governing the table

- **One accent per section**, taken from the established S01–S12 role assignment. Set it once per section as a scoped custom property:
  ```css
  .hero-section      { --section-accent: var(--btn-red-color);   }  /* Coral */
  .stats-strip       { --section-accent: var(--btn-bg-color);    }  /* Gold */
  .delivery-section  { --section-accent: var(--btn-green-color); }  /* Teal */
  .pay-section       { --section-accent: var(--btn-pill-color);  }  /* Blue */
  .drivers-section   { --section-accent: var(--btn-green-color); }  /* Teal */
  .merchants-section { --section-accent: var(--btn-bg-color);    }  /* Gold */
  .rp-section        { --section-accent: var(--btn-pill-color);  }  /* Blue */
  .ambassador-section{ --section-accent: var(--btn-pill-color);  }  /* Blue */
  .coverage-section  { --section-accent: var(--btn-green-color); }  /* Teal */
  .app-section       { --section-accent: var(--btn-red-color);   }  /* Coral */
  .testimonials-section { --section-accent: var(--btn-pill-color); } /* Blue */
  .iz-footer         { --section-accent: var(--btn-green-color); }  /* Teal */
  .biz-hero, .biz-main  { --section-accent: var(--btn-pill-color); } /* Blue */
  ```
  S03 Delivery carries Teal **and** Coral in the existing composition (per-card role colouring). The *motion* accent for S03 is Teal for the section rule; individual delivery cards may carry their own role colour on their §3.1 accent bar. This is the one sanctioned dual-accent section and it is dual because the cards genuinely represent two different roles.
- **No two adjacent sections share a dominant entrance pattern** (PO brief requirement). Verified below.
- **Constraint 6 is absolute:** never put `transform`, `clip-path` or `overflow` on `.row` or any `.col-*`. Every `data-reveal` in the table below is placed on a **child** of the column, never the column. Where a column has no wrapper child, the developer adds one `<div class="reveal-wrap">`. That wrapper carries no layout styles — it exists only to be animated.

### 4.1 Adjacency verification

| S01 | S02 | S03 | S04 | S05 | S06 | S07 | S08 | S09 | S10 | S11 | S12 |
|---|---|---|---|---|---|---|---|---|---|---|---|
| rise | count | wipe | rise | mask | wipe | rise | mask | trace | rise | fade | draw |

No two adjacent cells match. ✔

### 4.2 S01 — Hero (dark / Coral) — dominant: **R1 rise**

The hero does **not** wait for scroll. It fires on `DOMContentLoaded` (or immediately if the document is already interactive), with no IntersectionObserver.

| # | Element | Pattern | Delay | Duration | Notes |
|---|---|---|---|---|---|
| 1 | `.hero-section h1` | **none — static** | 0 | — | Renders immediately at full opacity. See §8(a). |
| 2 | Coral rule under h1 | R3 `draw` | 120ms | `--dur-slow` | 60px × 3px, `--btn-red-color`, origin left |
| 3 | Hero subhead `<p>` | R1 `rise` | 200ms | `--dur-slow` | |
| 4 | CTA stack buttons | R1 `rise`, staggered | 300ms + `--stagger-base` per button | `--dur-slow` | Cap at 6 |
| 5 | `bikeDriver.png` | R6 `fade` | 0 | `--dur-slow` | **LCP element.** Opacity only. Never translate, never clip. `fetchpriority="high"` stays. |

Hero total settle time: ~700ms. The h1 is legible at frame 1.

**Nav:** existing `transition: background var(--dur-base) var(--ease-standard)` on scroll past 80px. Retokenise, no behaviour change.

**Drawer:** existing `translateX(100%) → 0` at 240ms. Retokenise to `--dur-moderate` / `--ease-out`. Overlay opacity `--dur-moderate`. No behaviour change.

### 4.3 S02 — Stats strip (dark / Gold) — dominant: **count**

| # | Element | Pattern | Delay | Duration | Notes |
|---|---|---|---|---|---|
| 1 | `.stat-item` containers | R1 `rise`, staggered | `--stagger-tight` per item | `--dur-slow` | Fires at threshold 0.15 |
| 2 | `.stat-num-value` | existing rAF count-up | fires at threshold **0.3** (unchanged) | `--dur-count` | **Do not rewrite `site.js:113-163`.** Only change: swap the hardcoded `1400` for a value read from the `--dur-count` custom property, or leave as-is with a comment pointing at the token. |
| 3 | Gold rule under each stat | R3 `draw`, staggered | matches item stagger + 200ms | `--dur-slow` | 40px × 2px |
| 4 | `.stat-date` label | R6 `fade` | 400ms | `--dur-slow` | Arrives after the number settles |

The two thresholds (0.15 for the container rise, 0.3 for the count) are intentional and existing. Do not unify them — the container should already be in place when the number starts running.

This section is currently HTML-commented pending data approval. Ship the CSS and JS; it activates when the markup is uncommented. **The reveal engine must not error on zero matches** — every `querySelectorAll` loop guards on length, as `site.js` already does.

### 4.4 S03 — Delivery (light / Teal + Coral) — dominant: **R2 wipe**

| # | Element | Pattern | Delay | Duration | Notes |
|---|---|---|---|---|---|
| 1 | `#delivery-h2` | R1 `rise` | 0 | `--dur-slow` | |
| 2 | Teal section rule | R3 `draw` | 120ms | `--dur-slow` | centred (this header is centred) |
| 3 | `.section-sub` | R1 `rise` | 180ms | `--dur-slow` | |
| 4 | `.delivery-grid` children | R2 `wipe`, staggered | 260ms + `--stagger-base` per card | `--dur-deliberate` | `data-reveal-stagger` on `.delivery-grid` |

`.delivery-grid` is CSS Grid, not a Bootstrap row — `data-reveal-stagger` may sit on the grid container safely. **The 900px collapse must not regress:** the wipe uses `clip-path` only, which does not affect grid track sizing. Verify at 899px and 901px.

Each delivery card takes §3.1 hover, with its own role colour on the accent bar (furniture/parcel → Teal, food → Coral), not the section accent. This is the sanctioned S03 exception.

### 4.5 S04 — iZinga Pay (card-tone / Blue) — dominant: **R1 rise**

| # | Element | Pattern | Delay | Duration | Notes |
|---|---|---|---|---|---|
| 1 | `#pay-h2` | R1 `rise` | 0 | `--dur-slow` | |
| 2 | Blue section rule | R3 `draw` | 120ms | `--dur-slow` | |
| 3 | `.pay-inner` copy block | R1 `rise` | 180ms | `--dur-slow` | On the copy block, **not** on `.pay-inner` if it is a Bootstrap row |
| 4 | `.pay-tiles.row` children | R1 `rise`, staggered | 260ms + `--stagger-tight` | `--dur-slow` | **`.pay-tiles` is a Bootstrap `.row`.** `data-reveal-stagger` may sit on the row (it sets a custom property on children; it applies no transform). The `data-reveal` itself goes on the tile div **inside** each `.col-*`, never on the col. |

Tiles take §3.1 hover with Blue accent bar.

### 4.6 S05 — Drivers (dark / Teal) — dominant: **R5 mask**

| # | Element | Pattern | Delay | Duration | Notes |
|---|---|---|---|---|---|
| 1 | `.drivers-photo img` | R5 `mask` | 0 | `--dur-deliberate` | `clip-path: inset(100% 0 0 0)` → `inset(0)`. Wrapper div inside the col carries the reveal, per constraint 6. |
| 2 | `#drivers-h2` | R1 `rise` | 140ms | `--dur-slow` | |
| 3 | Teal section rule | R3 `draw` | 260ms | `--dur-slow` | |
| 4 | Benefit list items | R1 `rise`, staggered | 320ms + `--stagger-tight` | `--dur-slow` | Cap 6 |
| 5 | Driver CTA | R1 `rise` | 620ms | `--dur-slow` | |

The photo leading the section (rather than the heading) is deliberate — this is a recruitment section and the human image is the argument. It is also what makes S05 read differently from S04 without adding a new pattern.

`.drivers-inner` is a Bootstrap `.row`. Reveals go on children inside the columns.

### 4.7 S06 — Merchants (light / Gold) — dominant: **R2 wipe**

| # | Element | Pattern | Delay | Duration | Notes |
|---|---|---|---|---|---|
| 1 | `#merchants-h2` | R1 `rise` | 0 | `--dur-slow` | |
| 2 | Gold section rule | R3 `draw` | 120ms | `--dur-slow` | |
| 3 | `.merchants-tiles.row` tile children | R2 `wipe`, staggered | 200ms + `--stagger-base` | `--dur-deliberate` | Reveal on the tile inside the col |

Same wipe as S03, but S03 and S06 are not adjacent (S04, S05 sit between), so repetition here is *rhythm*, not monotony. Deliberate: the two "grid of offerings" sections share a pattern, which teaches the visitor that wipe means "here is a set of things."

Tiles take §3.1 hover with Gold accent bar.

### 4.8 S07 — Rewards Programme (Blue) — dominant: **R1 rise**

| # | Element | Pattern | Delay | Duration | Notes |
|---|---|---|---|---|---|
| 1 | `#rp-h2` | R1 `rise` | 0 | `--dur-slow` | |
| 2 | Blue section rule | R3 `draw` | 120ms | `--dur-slow` | |
| 3 | `.rp-inner` copy | R1 `rise` | 180ms | `--dur-slow` | |
| 4 | `.rp-item` list | R1 `rise`, staggered | 260ms + `--stagger-base` | `--dur-slow` | |

`.rp-inner` is CSS Grid collapsing at 900px. Stagger container is safe on it.

### 4.9 S08 — Ambassador (Blue) — dominant: **R5 mask**

| # | Element | Pattern | Delay | Duration | Notes |
|---|---|---|---|---|---|
| 1 | `.ambassador-photo-col img` | R5 `mask` | 0 | `--dur-deliberate` | Wrapper div carries the reveal |
| 2 | `#amb-h2` | R1 `rise` | 140ms | `--dur-slow` | |
| 3 | Blue section rule | R3 `draw` | 260ms | `--dur-slow` | |
| 4 | Ambassador copy + CTA | R1 `rise`, staggered | 320ms + `--stagger-loose` | `--dur-slow` | Only 2 items — loose stagger |

S07 and S08 are both Blue. That is the existing composition and this spec does not change it. The **patterns** differ (rise vs mask), which is what the PO brief requires.

`.ambassador-inner` is CSS Grid, 900px collapse. Safe.

### 4.10 S09 — Coverage map (dark / Teal) — dominant: **trace**. Full spec in §5.

### 4.11 S10 — App downloads (light / Coral) — dominant: **R1 rise**

| # | Element | Pattern | Delay | Duration | Notes |
|---|---|---|---|---|---|
| 1 | `#app-h2` | R1 `rise` | 0 | `--dur-slow` | |
| 2 | Coral section rule | R3 `draw` | 120ms | `--dur-slow` | |
| 3 | `.app-copy p` | R1 `rise` | 180ms | `--dur-slow` | |
| 4 | `.store-btn` items | R1 `rise`, staggered | 260ms + `--stagger-base` | `--dur-slow` | |
| 5 | `.qr-frame` | R1 `rise` | 420ms | `--dur-slow` | |
| 6 | `.phone-frame` carousel | R1 `rise`, staggered | 300ms + `--stagger-base` | `--dur-slow` | Reveal on `.app-carousel` children inside the col |

**Carousel motion (existing, retokenised):** `.phone-frame` uses `transition: transform var(--dur-base) var(--ease-standard), opacity var(--dur-base) var(--ease-standard)`. The `.phone-frame.adjacent { transform: scale(0.9) }` is an **existing static state**, not a hover scale, so it does not violate Law 3 — it is a fixed layout expression of focus, unchanged between frames. Do not add a scale *on hover*.

**`.dot { transition: all 200ms }` at `rebuild.css:980` must be rewritten** to `transition: width var(--dur-base) var(--ease-standard), background-color var(--dur-base) var(--ease-standard);`. The `border-radius` change between `.dot` and `.dot.active` is a data-mark shape change, permitted, but it must **not** be transitioned (it currently is, via `all`, and transitioning radius is exactly the kind of thing this org reverts).

Carousel slide: `translateX`, `--dur-slow`, `--ease-out`, per the existing v2 spec.

### 4.12 S11 — Testimonials (card tone / Blue) — dominant: **R6 fade**

This section is currently in skeleton state (`.skeleton-grid.row`, conditional H2 toggle in `site.js`).

| # | Element | Pattern | Delay | Duration | Notes |
|---|---|---|---|---|---|
| 1 | Active `h2` (whichever the toggle exposes) | R6 `fade` | 0 | `--dur-slow` | |
| 2 | Blue section rule | R3 `draw` | 120ms | `--dur-slow` | `transform-origin: center` — this section is centred |
| 3 | `.skeleton-grid` children | R6 `fade`, staggered | 200ms + `--stagger-tight` | `--dur-slow` | Reveal on the card inside each col |

**Fade, not rise, is deliberate.** A skeleton placeholder that animates energetically into place is promising content it does not have. A quiet fade is honest. When real testimonials land, the developer may upgrade this section to R1 `rise` — S10 is rise and S11 would then be adjacent-identical, so at that point S11 becomes R2 `wipe`. Noted here so the future change does not silently break the adjacency rule.

**Skeleton shimmer is banned.** It is looping ambient motion (constraint 8) and it burns CPU on the exact devices this site is built for. Static placeholders.

### 4.13 S12 — Footer (dark / Teal) — dominant: **R3 draw**

| # | Element | Pattern | Delay | Duration | Notes |
|---|---|---|---|---|---|
| 1 | Top hairline rule (`--dark-rule`) | R3 `draw` | 0 | `--dur-deliberate` | Full container width, origin left. The page's closing gesture — the longest single rule on the site apart from the map. |
| 2 | Footer columns | R6 `fade`, staggered | 200ms + `--stagger-tight` | `--dur-slow` | Reveal on the column's inner div |
| 3 | `.footer-social a` | existing `transition: color var(--dur-quick)` | — | — | Retokenise only |
| 4 | Legal line | R6 `fade` | 500ms | `--dur-slow` | |

The footer closing with the same drawn-rule gesture the hero opened with (S01 item 2) is the intended bookend. Hero draws a 60px rule; footer draws a full-width one. Same gesture, page-scale.

### 4.14 `.iz-fab` (WhatsApp float)

| Element | Pattern | Delay | Duration | Notes |
|---|---|---|---|---|
| `.iz-fab` | R4 `settle` — but on **entry into viewport-persistent state**, fired once ~600ms after `DOMContentLoaded` | 600ms | `--dur-moderate` | Arrives, then is permanently static. |

Hover: `filter: brightness(0.9)`, `--dur-base`. **No pulse, no bounce, no attention loop.** A permanently animating floating button is the single most common "cheap-looking site" tell and it is banned by constraint 8. Zero radius applies here too — if `.iz-fab` currently has a radius, that is a pre-existing violation to raise separately, not something this spec changes.

### 4.15 `business.html`

| Section | Dominant | Elements |
|---|---|---|
| `.biz-hero` | R1 `rise` | h1 static → Blue rule R3 @120ms → subhead R1 @200ms → CTA R1 @300ms. Same structure as S01, including **static h1**. |
| `.biz-programmes` | R2 `wipe` | Programme rows, `--stagger-base`, `--dur-deliberate`. §3.1 hover with Blue accent bar. |
| `.biz-form-surface` | R3 `draw` + R1 `rise` | Surface's top rule draws (`--dur-deliberate`), then field groups R1 rise staggered `--stagger-tight` from 200ms. |

Adjacency across business.html: rise → wipe → draw. ✔

**Form field focus motion** (`rebuild.css:1243` currently `transition: border-color 150ms, box-shadow 150ms`):

```css
.biz-form-surface .form-control {
  transition: border-color var(--dur-quick) var(--ease-standard);
}
```

**Drop the `box-shadow` transition entirely.** A focus glow is elevation on a form field — it violates "elevation only for modals and overlays" and it is exactly the kind of thing that gets reverted. Focus indication comes from the existing `:focus-visible { outline: 2px solid var(--btn-pill-color) }` at `rebuild.css:1852`, which is already correct, accessible, and radius-free. If the field currently paints a `box-shadow` on focus, remove the shadow, not just its transition.

---

## 5. The coverage map — the signature moment

### 5.1 Prerequisite markup changes

1. **Inline the SVG.** Replace `<img src="./assets/images/sa-map.svg" alt="" aria-hidden="true">` at `index.html:559` with the file's contents. It is 3.6KB — inlining removes a request and is a net performance win independent of motion. Keep `aria-hidden="true"` on the `<svg>`; the accessible name lives on the `.coverage-map-wrapper` `role="img" aria-label="..."`, which is correct and unchanged.
2. **Add `pathLength="1"` to the SA outline `<path>`.** This normalises the path to a unit length so the developer never has to measure it with `getTotalLength()` in JS, and the animation survives any future edit to the path data. This is the single most important implementation detail in this section.
3. **Migrate the inline pin transforms.** `index.html:563/569/575` carry `style="left:42%;top:36%;transform:translate(-50%,-50%);"`. Inline style wins over the stylesheet, so any `transform` animation on `.map-pin` is dead on arrival. Two options — **take option A**:
   - **A (required):** keep `left`/`top` inline (they are content-positional data, correctly authored inline), move `transform: translate(-50%,-50%)` into `.map-pin` in `rebuild.css`. Then `.map-pin` transforms are stylesheet-controllable and composable.
   - B (rejected): animate only `.pin-dot`. Rejected because the pin's arrival needs to move the whole pin group including its ring.
4. **Consolidate the duplicate pin rules.** `.map-pin .pin-dot { transition: transform 150ms ease }` and the `scale(1.33)` / `scale(1.4)` hover exist **twice** — `rebuild.css:884-889` and `rebuild.css:1461-1506` — with *conflicting* scale values. Delete the block at 884-889 and keep the fuller block at 1461+, standardising on `scale(1.4)`. This is a pre-existing bug this work must fix, not introduce.

### 5.2 The self-draw

```css
.coverage-section .sa-outline path {
  stroke: var(--btn-green-color);        /* Teal — S09 accent */
  stroke-width: 2;
  fill: var(--btn-green-color);
  fill-opacity: 0;
  stroke-dasharray: 1;
  stroke-dashoffset: 0;                  /* DEFAULT = fully drawn. See §6.1. */
}

html.js-reveal .coverage-section[data-reveal="trace"]:not(.is-revealed) .sa-outline path {
  stroke-dashoffset: 1;
  fill-opacity: 0;
}

.coverage-section[data-reveal="trace"].is-revealed .sa-outline path {
  stroke-dashoffset: 0;
  fill-opacity: 0.08;
  transition:
    stroke-dashoffset var(--dur-trace) var(--ease-trace),
    fill-opacity var(--dur-deliberate) var(--ease-out) 1200ms;
}
```

Timeline:

| t | Event |
|---|---|
| 0ms | Trace begins at the path's start point (northwest, `M 85,80`), travels the full outline |
| 1200ms | Fill begins fading in behind the still-completing stroke (`fill-opacity: 0 → 0.08`) |
| 1600ms | Outline closes. Fill settles at 8% Teal. |

The fill starting *before* the stroke completes is what stops this reading as two separate events. The country appears to be filling in as it is being drawn.

`fill-opacity: 0.08` — low, because this is a dark section and Teal at higher opacity over `#1a1a1a` competes with the pins. The pins are the payload; the outline is the stage.

**Honest performance note the developer must act on:** `stroke-dashoffset` is a *paint* property, not compositor-only. It is the one exception to constraint 8 in this entire document, and it is justified by three facts: the path is a single simple polyline (~40 points, no curves), it is rendered at ~500×420 CSS px, and it runs exactly once, below the fold, when nothing else on the page is animating. **Requirement:** the trace must not overlap the S08 ambassador reveal. Threshold for S09 is `0.25` (higher than the global `0.15`) specifically to push the trace start later and guarantee separation. Profile on a mid-range Android before sign-off; if the trace drops below 50fps, reduce `stroke-width` to 1.5 and re-measure before considering removing the effect.

### 5.3 Pin arrival

Pins fire only after the trace completes. Order is **north to south — Johannesburg → Durban → Cape Town** — which is both the geographic reading order and the actual national delivery corridor. It is also the order the pins already appear in the DOM (`index.html:563/569/575`), so the developer needs no reordering.

```css
.map-pin {
  transform: translate(-50%, -50%);      /* migrated from inline, per §5.1(3) */
}

html.js-reveal .coverage-section[data-reveal="trace"]:not(.is-revealed) .map-pin {
  opacity: 0;
  transform: translate(-50%, calc(-50% - 12px));
}

.coverage-section[data-reveal="trace"].is-revealed .map-pin {
  opacity: 1;
  transform: translate(-50%, -50%);
  transition:
    opacity var(--dur-moderate) var(--ease-out),
    transform var(--dur-moderate) var(--ease-out);
  transition-delay: calc(1600ms + (var(--pin-i, 0) * 140ms));
}
```

`--pin-i` is set by JS (0, 1, 2) on each `.map-pin` at boot, alongside the reveal engine's stagger indices. 140ms between pins — slower than `--stagger-base` because these are three discrete arrivals, not a list, and they should register individually.

Pattern is **R4 `settle`**: the pin comes down 12px onto its position. Per Law 2, things that *arrive at a destination* move downward. A delivery pin dropping onto a city is the only motion on this site where downward travel is correct, and it is correct because it is literal.

`.map-legend` fades in (R6) at `1600ms + 420ms = 2020ms`, after the last pin has landed.

### 5.4 The pin ring — fires once

Each pin emits a single expanding ring on arrival, then stops permanently.

```css
.map-pin .pin-dot::after {
  content: '';
  position: absolute;
  inset: -2px;
  border-radius: 50%;                    /* circular data mark — sanctioned, see §1.4 */
  border: 2px solid currentColor;
  opacity: 0;
  pointer-events: none;
}

.coverage-section[data-reveal="trace"].is-revealed .map-pin .pin-dot::after {
  animation: pin-arrive 700ms var(--ease-out) forwards;
  animation-delay: calc(1600ms + (var(--pin-i, 0) * 140ms) + 120ms);
}

@keyframes pin-arrive {
  from { opacity: 0.7; transform: scale(1); }
  to   { opacity: 0;   transform: scale(2.6); }
}
```

`animation-fill-mode: forwards` leaves the ring at `opacity: 0`. It never runs again. `.map-pin--teal .pin-dot { color: var(--btn-green-color) }` and `.map-pin--coral .pin-dot { color: var(--btn-red-color) }` so `currentColor` picks up the right role colour per pin.

### 5.5 **Does the pin pulse loop? No. It fires once.** — justification

This was flagged as an open question. The answer is a firm no, for four reasons, in order of weight:

1. **Constraint 8 bans looping/ambient motion outright**, and that constraint exists because the real audience is low-end Android on metered data. A three-pin infinite pulse is three permanently-compositing layers running for as long as the section is in the viewport, on a device that is already thermally constrained. This alone settles it.
2. **A pulse is an alert semantic.** Persistent pulsing means "something needs your attention now" — notification badges, live indicators, recording lights. These pins mean "we operate here," a statement of fact. Animating a fact indefinitely is a category error, and users read it as either a live-data indicator (which it isn't — the tooltips literally say "services being confirmed") or as decoration, which is worse.
3. **It would compete with the count-up.** S02's 1400ms count-up is the site's other reserved moment. If S09 has permanent motion, S02 stops being special. Both moments are protected by being finite.
4. **Once is more confident.** A thing that announces itself once and then holds still reads as certain. A thing that keeps pulsing reads as anxious for attention. Given the brief is "show full capabilities," restraint at the site's biggest moment is the stronger demonstration.

The full S09 moment therefore runs 0 → ~2.4s and then the section is completely static, with only hover/focus interactivity remaining. That is the correct shape.

### 5.6 Pin hover/focus — unchanged

Existing `.pin-dot` `transform: scale(1.4)` at `--dur-quick` and `.pin-tooltip` `opacity` at `--dur-quick`. Retokenise. Keyboard `tabindex="0"` + `.pin-active` toggle stays. The hover scale is on a 12px circular data mark and is exempt from Law 3.

**Composition conflict the developer must handle:** the pin's arrival transition and its hover transition both target `transform` on different elements (`.map-pin` for arrival, `.pin-dot` for hover). This is why the arrival animates the *pin* and the hover animates the *dot* — they never fight. Do not "simplify" this by moving both to one element.

---

## 6. Reveal engine contract

### 6.1 The safety inversion — non-negotiable

**The revealed state is the CSS default. The hidden state is scoped under a class that only JavaScript can set.**

Concretely: no `[data-reveal]` selector in `rebuild.css` may set `opacity: 0` or a hiding `clip-path` unless it is scoped under `html.js-reveal`. If `site.js` fails to parse, fails to load, is blocked by a network fault on a metered SA connection, or throws before the observer is wired, **the page renders fully visible and fully functional**. There is no scenario in which a script failure blanks content.

The class is set by a **blocking inline script in `<head>`**, before first paint, to avoid a flash of revealed-then-hidden content:

```html
<script>
  (function () {
    try {
      if (!window.matchMedia('(prefers-reduced-motion: reduce)').matches
          && 'IntersectionObserver' in window) {
        document.documentElement.className += ' js-reveal';
      }
    } catch (e) { /* fail open: no class, everything visible */ }
  })();
</script>
```

Three gates, all fail-open:
- No `matchMedia` support, or user prefers reduced motion → no class → everything visible, no observers ever created.
- No `IntersectionObserver` → no class → everything visible. **No polyfill.** Shipping a polyfill to save an animation on a browser that old is the wrong trade for this audience.
- Any exception → no class.

### 6.2 Attribute API

| Attribute | Values | Applies to | Meaning |
|---|---|---|---|
| `data-reveal` | `rise` \| `wipe` \| `draw` \| `settle` \| `mask` \| `fade` \| `trace` | any element **except** `.row` and `.col-*` | Element hides under `html.js-reveal` and reveals on intersection. `trace` is S09-only. |
| `data-reveal-delay` | integer ms, e.g. `"180"` | same element as `data-reveal` | Fixed delay applied via `transition-delay`. Mutually exclusive with being a stagger child. |
| `data-reveal-stagger` | integer ms step, e.g. `"80"`, or empty (defaults to 80) | a **container** | JS assigns `--reveal-i` to each direct child that carries `data-reveal`. |
| `data-reveal-threshold` | float, default `"0.15"` | same element as `data-reveal` | Per-element override. S02 uses `0.3` (existing), S09 uses `0.25`. |
| `data-reveal-once` | — | — | **Not an attribute.** All reveals are once-only, always. There is no repeat mode. |

Delay resolution, in the stylesheet:

```css
html.js-reveal [data-reveal] {
  transition-delay: calc(var(--reveal-i, 0) * var(--reveal-step, 0ms) + var(--reveal-delay, 0ms));
}
```

JS sets `--reveal-i` (integer, capped) on stagger children, `--reveal-step` on the stagger container (inherited by children), and `--reveal-delay` from `data-reveal-delay`. A single element with a fixed delay and no stagger parent resolves to `0 * 0ms + 180ms`. Clean, no JS-side arithmetic.

### 6.3 Stagger mechanism

```js
// index capped at 6 — a 12-item list must not take 960ms to arrive
var STAGGER_CAP = 6;
container.querySelectorAll(':scope > [data-reveal]').forEach(function (el, i) {
  el.style.setProperty('--reveal-i', Math.min(i, STAGGER_CAP));
});
container.style.setProperty('--reveal-step', (parseInt(container.dataset.revealStagger, 10) || 80) + 'ms');
```

`:scope >` — direct children only. A nested grid inside a staggered container must declare its own `data-reveal-stagger`; it does not inherit indices.

**A `data-reveal-stagger` container is permitted on a Bootstrap `.row`** — it only writes custom properties and applies no transform, clip, or overflow, so constraint 6 is not engaged. The `data-reveal` attributes themselves still go on elements *inside* the `.col-*`.

### 6.4 Observer

```js
var io = new IntersectionObserver(function (entries) {
  entries.forEach(function (entry) {
    if (!entry.isIntersecting) return;
    entry.target.classList.add('is-revealed');
    io.unobserve(entry.target);
  });
}, { threshold: 0.15, rootMargin: '0px 0px -10% 0px' });
```

- `rootMargin: '0px 0px -10% 0px'` — an element must be 10% into the viewport before firing, so reveals do not trigger on content technically touching the bottom edge during a fast scroll.
- `unobserve` immediately. Once-only, per §6.2.
- Elements needing a non-default threshold get their **own observer instance** (thresholds are per-observer, not per-element). Group by threshold: one observer at `0.15` (most of the page), one at `0.3` (S02 count-up, already exists in `site.js`), one at `0.25` (S09 trace).
- All scroll/resize listeners `{ passive: true }`, per constraint 7 and existing practice at `site.js:104`.
- **Elements above the fold at load** intersect immediately and reveal on the first observer callback. The hero does not use the observer at all (§4.2) — it fires on DOM ready.

### 6.5 Smooth scrolling

```css
html { scroll-behavior: smooth; }
@media (prefers-reduced-motion: reduce) {
  html { scroll-behavior: auto; }
}
```

Add `scroll-margin-top: 80px` to every `[id]` anchor target section so the fixed nav does not cover the heading on jump. Currently missing; anchor navigation is subtly broken without it.

### 6.6 Boot order in `site.js`

1. Inline head script sets `html.js-reveal` (§6.1) — **before** anything else, before first paint.
2. On `DOMContentLoaded`: assign stagger indices and `--pin-i` (§5.3, §6.3) — must complete **before** any observer fires.
3. Fire hero reveal immediately (§4.2), no observer.
4. Instantiate the three observers and observe.
5. Existing drawer / nav / carousel / more-menu IIFEs — unchanged.

Every step guards on element existence, as the existing file already does. Zero matches must never throw.

---

## 7. Reduced-motion specification

**The master gate:** if `prefers-reduced-motion: reduce`, the inline head script never adds `html.js-reveal`. Consequence: **every hidden state in §3.4, §4 and §5 is never applied. No observers are constructed. No stagger indices are assigned. The site renders complete and static at first paint.** This is a single control point, not thirty scattered fallbacks, and it cannot be partially applied.

The existing global blanket at `rebuild.css:1842` (`animation-duration: 0.01ms !important; transition-duration: 0.01ms !important`) stays as a second line of defence covering hover transitions, which are not gated by the JS class. Both mechanisms ship. Do not remove either.

Item-by-item, what a reduced-motion user gets:

| Spec item | Reduced-motion behaviour |
|---|---|
| §1 duration tokens | Values unchanged in `:root`; neutralised at use site by the two mechanisms above |
| §3.1 L1 card accent rule | Bar is **not shown by default and still appears on hover/focus — instantly** (`scaleY(1)` with no transition). The affordance is preserved; only the motion is removed. Do not delete the accent bar. |
| §3.1 L2 tonal shift | Instant colour change on hover/focus. Colour change is not motion; keep it. |
| §3.1 L3 letter-spacing | **Removed entirely.** Wrap in `@media (prefers-reduced-motion: no-preference)`. An instant letter-spacing jump is a visible text reflow and is genuinely unpleasant. |
| §3.1 L4 arrow nudge | Removed entirely. Same `no-preference` wrapper. |
| §3.2 button `brightness()` | Instant. Keep — it is the hover affordance. |
| §3.3 section rules | Rendered at `scaleX(1)` from the start. Fully visible, never animated. |
| §3.4 R1–R6 | All never applied. Content at final state at paint. |
| §4.2 hero | h1, rule, subhead, CTAs, image all present at frame 1. No sequence. |
| §4.3 S02 count-up | Existing behaviour at `site.js:118-121` — number jumps straight to target. Already correct, do not change. |
| §4.11 carousel | Slide becomes an instant cut (existing v2 spec). Dots change state instantly. |
| §4.14 `.iz-fab` | Present and static from load. |
| §5.2 map self-draw | `stroke-dashoffset: 0` and `fill-opacity: 0.08` are the **CSS defaults** (§5.2), so the map is fully drawn and filled at paint with zero JS involvement. |
| §5.3 pins | `opacity: 1`, `transform: translate(-50%,-50%)` are the defaults. All three pins present at paint. |
| §5.4 pin ring | `@keyframes` never triggers because `.is-revealed` is never added. Ring stays at `opacity: 0`, invisible. |
| §5.6 pin hover | Dot scale removed; **tooltip still appears instantly** and the label background still shifts to the role colour (per the existing v2 spec at `design-composition-v2-final.md:546`). Information is never withheld. |
| §6.5 smooth scroll | `scroll-behavior: auto` |
| §4.15 form focus | `border-color` change instant. `:focus-visible` outline unaffected — outlines are not motion and must never be suppressed. |

**Acceptance test:** with `prefers-reduced-motion: reduce` set at the OS level, and with JavaScript entirely disabled, `index.html` and `business.html` must render 100% of their content, and every hover and focus state must still be visually distinguishable. If any content is missing or any affordance is invisible in that configuration, the implementation is rejected.

---

## 8. Judgment calls

Three items were pre-flagged. I have delegated authority on boldness, so I have decided all three. Two are closed. One additional item that was *not* pre-flagged genuinely does need Lindani, and it is the last one.

### (a) Hero h1 mask-reveal — **DECIDED: NO. h1 renders immediately.** Closed.

A mask-reveal on the hero h1 would look good in a screen recording and would cost real money.

The h1 is above the fold, is the page's primary message, and sits adjacent to the LCP element. A 420ms mask means a first-time visitor on a 3G connection in Soweto — who has already waited for the document, the CSS, and the font — waits *another* 420ms after paint before the sentence that explains what iZinga is becomes readable. Catamaran is a webfont; if it is still swapping, the mask and the FOUT compound into something that reads as broken rather than as designed. And the visitors who would be impressed by a masked headline are not the visitors this business needs.

Worse, it is the one animation on the page that a returning visitor sees on **every single visit**. Everything else in this spec fires once per scroll, below the fold, when the visitor is already engaged. Delighting someone on visit one and taxing them on visits two through fifty is a bad trade.

**Spec'd alternative, already in §4.2 and §4.15:** the h1 is static and legible at frame one. The *hero rule beneath it* draws in Coral at 120ms (R3), the subhead rises at 200ms, the CTAs stagger in from 300ms. The hero still animates — it is the drawn rule, the site's signature gesture, introduced at the top of the page where it teaches the visitor the vocabulary they will see eleven more times. That is a better use of the hero than a mask, and it costs nothing.

This applies identically to `business.html`'s `.biz-hero` h1.

### (b) Map self-draw — **DECIDED: YES. Ship it.** Closed.

This is the correct place to spend the site's animation budget: below the fold, once per session, on the one asset that visually states the business's actual footprint, in a section that is otherwise a static picture. It is fully spec'd in §5.

Two conditions attach, and they are requirements, not suggestions:
1. The paint-cost profiling in §5.2 must be run on a real mid-range Android before sign-off.
2. Item (d) below must be resolved first.

No CEO input needed on the effect itself.

### (c) Card accent-bar as the hover vocabulary — **DECIDED: YES. It is the canonical card hover.** Closed.

The reason this was flagged is that a visible role-colour bar sits near the CEO's flat/`#212121` territory, and this org reverts violations of that directive.

It is not a violation, and there is direct precedent: the mobile drawer already ships `border-left: 4px solid [role token]` on its nav links (`design-composition-v2-final.md:155`), approved and in production. The card accent bar is that exact device, 1px thinner, on a card. The 21 July directive governs **filled button colour and border-radius**; the accent bar adds no radius, changes no button fill, and adds no elevation. It is drawn, flat, and zero-radius by construction.

More importantly, it is the only credible answer to the actual design problem. With shadow, radius and scale all unavailable, a flat borderless card has essentially no hover vocabulary left. The accent bar is what makes twelve sections of flat cards feel responsive instead of dead. Removing it does not leave a worse hover — it leaves no hover.

No CEO input needed.

### (d) **FLAG FOR LINDANI — the SA map outline is a crude approximation, and the self-draw will make people look at it.**

This is the one item I am escalating, and it was not on the pre-flagged list.

`assets/images/sa-map.svg` contains a hand-simplified ~40-point polyline. As a static background shape at low contrast, nobody examines it. **The moment you draw it over 1.6 seconds, you have explicitly directed the visitor's eye to trace the national border, point by point.** Animation is attention. A South African visitor watching a line slowly trace a wrong-shaped South Africa — no Lesotho enclave, coastline off — is a credibility cost on a section whose entire job is to establish credibility, and it lands hardest with exactly the local audience that matters most.

The fix is cheap. A reasonably accurate simplified SA outline, including the Lesotho enclave as a second `<path>`, is a small asset task and will still land well under 10KB. Everything in §5 works unchanged against a better path — that is precisely why §5.1 specifies `pathLength="1"` instead of measuring the geometry.

**Recommendation: replace the map asset before shipping the self-draw.** If the asset cannot be replaced in this cycle, ship the rest of the spec and hold S09 at pin-arrival only (drop the trace, keep the pins as R4 `settle` with no 1600ms offset). S09's dominant pattern then becomes `settle`, which remains distinct from S08 `mask` and S10 `rise`, so nothing else in the choreography breaks.

**Decision needed from Lindani:** replace the asset now and ship the full moment, or ship without the trace and add it when the asset lands.

### (e) Scope question worth a one-line answer from Lindani

The design-system amendment in §9 distinguishes marketing-surface from product-surface motion. **Marketing surface = `izinga.co.za` and `business.html` only.** The Angular product apps (cs-lifestyle, furniture-delivery-app, izinga-onboarding, izinga-pay) and the Flutter app stay under task-clarity-first rules and get none of the expressive vocabulary in §3.4. I have written the amendment that way. If Lindani intends this treatment to extend into the product apps, that is a materially larger piece of work and needs its own brief — it is not a side effect of approving this document.

---

## 9. Design-system amendment text

To be applied by the **Agent Tuner** to `izinga-design-system.md`, replacing the current five bullets under "Motion and Animation" in their entirety. I do not edit that file.

---

> ## Motion and Animation
>
> ### Two motion surfaces
>
> iZinga has two motion contexts with different licences. Identify which you are in before specifying any motion.
>
> **Product surfaces** — Angular apps (cs-lifestyle, furniture-delivery-app, izinga-onboarding, izinga-pay), the ijudi Flutter app, and all admin tooling. Motion here is **task-clarity-first**. It exists to show state change, direction of navigation, and the relationship between what was on screen and what is now on screen. Nothing else. Confine yourself to `--dur-quick` and `--dur-base`. No entrance choreography, no staggered reveals, no scroll-triggered motion. A user completing a delivery or a payment is doing a job; motion that draws attention to itself is a cost to them.
>
> **Marketing surfaces** — `izinga.co.za` (`web-old/`), campaign landing pages, and any page whose primary job is persuasion rather than task completion. Brand expression is permitted here. Entrance choreography, scroll-triggered reveal, and up to one reserved "signature moment" per page are sanctioned. The full vocabulary is specified in `web-old/docs/motion-spec-v1.md`, which is the authoritative reference for marketing motion. Marketing vocabulary must not be imported into product surfaces.
>
> ### Motion scale (both surfaces)
>
> These tokens are the complete iZinga motion scale. Extend by *composing* them. Do not introduce new duration or easing values.
>
> | Token | Value | Use |
> |---|---|---|
> | `--dur-instant` | 100ms | Colour-only swaps, focus rings, tooltip opacity |
> | `--dur-quick` | 150ms | Micro-interactions: link colour, icon nudge, small marks |
> | `--dur-base` | 200ms | **Default.** Hover states, surface tone shift, `filter` |
> | `--dur-moderate` | 240ms | Drawers, overlays, modals, accent-rule draw |
> | `--dur-slow` | 300ms | Entrance reveals, carousel slide *(marketing only)* |
> | `--dur-deliberate` | 420ms | Wipe and mask entrances *(marketing only)* |
> | `--dur-count` | 1400ms | Statistic count-up. **Reserved.** |
> | `--dur-trace` | 1600ms | SVG self-draw. **Reserved, one use per site.** |
>
> | Token | Value | Use |
> |---|---|---|
> | `--ease-out` | `cubic-bezier(0.215, 0.61, 0.355, 1)` | **Default.** One-way motion: entrances, arrivals. Matches the `1-(1-t)^3` curve used by JS count-ups. |
> | `--ease-standard` | `cubic-bezier(0.4, 0, 0.2, 1)` | Two-way motion: anything that reverses, i.e. all hover states. |
> | `--ease-trace` | `cubic-bezier(0.65, 0, 0.35, 1)` | SVG self-draw only. |
>
> There is no `--ease-in`. iZinga elements never accelerate out of view.
>
> Stagger: `--stagger-tight` 60ms (4+ siblings), `--stagger-base` 80ms (default), `--stagger-loose` 120ms (2 siblings). Cap the stagger index at 6 regardless of list length.
>
> ### The motion signature: travel, not lift
>
> iZinga moves things from an origin to a destination. Every motion is one of three expressions of that single gesture:
>
> 1. **A rule that draws** — a line grows from its origin along one axis (`scaleX`/`scaleY`, origin at the leading edge).
> 2. **A surface that arrives** — content translates a short distance along one axis and resolves (`translateY` + `opacity`).
> 3. **An edge that clears** — a mask retracts along one axis to expose content already in place (`clip-path: inset`).
>
> Three laws govern all of it:
>
> - **One axis.** No motion combines horizontal and vertical travel. No diagonals, no rotation.
> - **Reading direction.** Horizontal motion is left-to-right. Entrance motion rises. Only literal *arrivals* (a map pin landing on a city) move downward.
> - **Nothing changes size.** The only permitted `scale()` is on a line drawing from zero length, and on circular data marks under 16px. Cards, buttons, tiles and images never scale on interaction.
>
> ### Flat-surface interaction vocabulary
>
> iZinga cards are borderless, zero-radius, and carry no elevation, so the conventional hover toolkit — lift, shadow-bloom, radius morph, scale — is unavailable. **This is a constraint to design within, not around.** Depth and quality come from drawing, tone, and letterform.
>
> The canonical card hover, composed of four simultaneous layers:
>
> 1. **Accent rule** — a 3px bar in the section's role colour draws down the card's left edge, `scaleY(0) → scaleY(1)`, origin top, `--dur-moderate` `--ease-standard`. This is the elevation substitute. It shares its language with the mobile drawer's `border-left: 4px solid [role token]`.
> 2. **Tonal separation** — the card surface moves one step toward light relative to its section background (`--bkg-card-color` → `#ffffff` on light; `#212121` → `#2b2b2b` on dark), `--dur-base`. Contrast, not shadow, creates the sense of forwardness.
> 3. **Letterform opening** — the card heading gains `0.01em` letter-spacing, `--dur-moderate`. Permitted on a single short heading per card only, and dropped entirely if that heading ever wraps.
> 4. **Directional cue** — any inline link arrow travels `translateX(4px)`, `--dur-quick`.
>
> Every layer must also trigger on `:focus-within`. Keyboard users get the identical signal — this is not optional.
>
> **Banned on cards, permanently:** `box-shadow`, `filter: drop-shadow`, `transform: scale`, hover `translateY`, `border-radius`, and any border that appears on hover.
>
> ### Deliberately absent tokens
>
> There is **no** `--shadow-*`, `--radius-*`, or `--elevation-*` token in any iZinga stylesheet, and none may be added. Their absence is the enforcement mechanism for the flat, zero-radius brand: a token is a permission slip, and their existence is what causes the violations this org has already had to revert. The one sanctioned exception — elevation on modals and overlays — is written inline at the modal with a comment naming the exemption, and does not get a token.
>
> Recommended: a CI grep gate on `box-shadow` and `border-radius` in stylesheets, allowlisting only circular data marks (`border-radius: 50%` under 16px) and overlay/tooltip shadows.
>
> ### Permitted animatable properties
>
> `opacity`, `transform` (translate and scaleX/scaleY only), `clip-path`, `filter: brightness()`, `background-color`, `color`, `border-color`. Plus `letter-spacing` on a single card heading, and `stroke-dashoffset`/`fill-opacity` on a marketing-surface SVG signature moment.
>
> **`transition: all` is banned.** Enumerate every property.
>
> Anything triggering layout (`width`, `height`, `top`, `left`, `margin`, `padding`) is banned outright. The real audience is low-end Android on metered data in South Africa; this is a hard performance constraint, not a preference.
>
> ### Banned outright, both surfaces
>
> - **Looping or ambient motion of any kind** — pulses, shimmers, breathing effects, skeleton shimmer, attention-seeking floating buttons, infinite marquees. Motion announces once and then holds still. A thing that keeps moving reads as anxious; a thing that moves once and stops reads as certain.
> - Parallax, scroll-jacking, particles, 3D transforms, cursor-follow effects.
> - Any animation that delays the legibility of a page's primary headline. Hero headings render at frame one; motion goes to the elements around them.
>
> ### `prefers-reduced-motion` — required on every motion spec
>
> Non-negotiable, no exceptions, no partial compliance.
>
> Preferred implementation is a **single gate, not scattered fallbacks**: JavaScript checks `prefers-reduced-motion` before adding the class that enables hidden states, so a reduced-motion user constructs no observers and applies no hidden state at all. Retain a global `@media (prefers-reduced-motion: reduce)` blanket as a second line of defence for hover transitions.
>
> Reduced motion removes **motion**, never **information or affordance**. Hover and focus states still change — instantly. Tooltips still appear. Counters jump to their final value. Focus outlines are never suppressed.
>
> ### Fail-open reveal contract
>
> Any scroll-reveal implementation must make the **revealed state the CSS default**, with the hidden state scoped under a class that only JavaScript sets. A script failure, a blocked bundle, or an unsupported `IntersectionObserver` must leave the page fully visible and fully functional. No polyfills for animation — on a metered connection, shipping bytes to save an effect is the wrong trade.
>
> **Acceptance test for any page with motion:** with JavaScript disabled and `prefers-reduced-motion: reduce` set, the page renders 100% of its content and every hover and focus state remains visually distinguishable.

---

## 10. Implementation checklist

Pre-existing defects this work must fix:

- [ ] Delete duplicate `.map-pin .pin-dot` block at `css/rebuild.css:884-889`; keep `:1461+`, standardise hover on `scale(1.4)` (§5.1.4)
- [ ] Rewrite `.dot { transition: all 200ms }` at `css/rebuild.css:980` to enumerated properties; do not transition `border-radius` (§4.11)
- [ ] Remove the `box-shadow` transition (and the shadow itself) from form-field focus at `css/rebuild.css:1243` (§4.15)
- [ ] Migrate `transform: translate(-50%,-50%)` off the inline styles at `index.html:563/569/575` into `.map-pin` (§5.1.3)
- [ ] Add `scroll-margin-top: 80px` to all `[id]` anchor targets (§6.5)

New work:

- [ ] Motion tokens into `:root` (§1.1–1.3). **No shadow/radius tokens** (§1.4)
- [ ] Retokenise all 16 existing `transition` rules — values unchanged, tokens substituted
- [ ] `--section-accent` scoped per section (§4.0)
- [ ] Six reveal patterns as CSS (§3.4), all hidden states under `html.js-reveal`
- [ ] `.iz-card` four-layer hover, incl. `:focus-within` (§3.1)
- [ ] `.section-rule` component, centred variant (§3.3)
- [ ] Inline head script (§6.1) — blocking, in `<head>`, both HTML files
- [ ] Reveal engine in `site.js` (§6.3–6.6), three observers
- [ ] Inline `sa-map.svg` with `pathLength="1"` (§5.1) — **gated on §8(d)**
- [ ] S09 trace + pin sequence (§5.2–5.4) — **gated on §8(d)**
- [ ] Per-section attributes for S01–S12 + business.html (§4)

Verification gates:

- [ ] JS disabled: both pages fully render, all hover/focus states distinguishable
- [ ] `prefers-reduced-motion: reduce`: no observers constructed, everything static and complete at paint
- [ ] 899px and 901px: `.delivery-grid`, `.pay-inner`, `.rp-inner`, `.ambassador-inner`, `.biz-inner` collapse unchanged
- [ ] No `transform`, `clip-path` or `overflow` on any `.row` or `.col-*` — grep to confirm
- [ ] All tap targets still ≥44px; `:focus-visible` intact on every control
- [ ] Chrome DevTools paint-flashing during the S09 trace on a mid-range Android profile: ≥50fps (§5.2)
- [ ] No `@keyframes` with `infinite`; no `transition: all` — grep to confirm
- [ ] LCP not regressed: `bikeDriver.png` uses R6 `fade` only, no transform, no clip

---

*End of specification.*
