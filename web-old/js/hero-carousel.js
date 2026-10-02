/* ==========================================================================
   hero-carousel.js — homepage-draft.html ONLY
   Draft-only script; do NOT load in index.html or any other page.

   Behaviour:
   - Crossfade between three hero photos via opacity transitions (CSS-driven).
   - User-initiated ONLY — no setInterval, no setTimeout, no autoplay.
   - Dot buttons: click to switch; left/right arrow keys when focused.
   - prefers-reduced-motion: handled by rebuild.css blanket (transition-duration
     0.01ms !important on *) — no inline transitions are set by this script.
   ========================================================================== */
(function () {
  'use strict';

  var slides  = document.querySelectorAll('.hero-carousel-slide');
  var dots    = document.querySelectorAll('.hero-dot');

  if (slides.length < 2 || dots.length !== slides.length) return;

  var current = 0;

  function goTo(n) {
    /* Deactivate current */
    slides[current].classList.remove('hero-carousel-slide--active');
    dots[current].classList.remove('hero-dot--active');
    dots[current].setAttribute('aria-current', 'false');

    /* Advance index */
    current = ((n % slides.length) + slides.length) % slides.length;

    /* Activate next */
    slides[current].classList.add('hero-carousel-slide--active');
    dots[current].classList.add('hero-dot--active');
    dots[current].setAttribute('aria-current', 'true');
  }

  dots.forEach(function (dot, i) {
    dot.addEventListener('click', function () {
      goTo(i);
    });

    dot.addEventListener('keydown', function (e) {
      if (e.key === 'ArrowRight') {
        e.preventDefault();
        goTo(current + 1);
        dots[current].focus();
      } else if (e.key === 'ArrowLeft') {
        e.preventDefault();
        goTo(current - 1);
        dots[current].focus();
      }
    });
  });
}());
