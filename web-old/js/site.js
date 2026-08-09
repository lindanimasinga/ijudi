/**
 * iZinga Marketing Site — site.js
 * Design Composition v2 (FINAL) — REQ-30
 * Vanilla JS only. No frameworks.
 */

'use strict';

/* ============================================================
   NAV — scroll behaviour + hamburger drawer + More menu
   ============================================================ */
(function () {
  var nav = document.getElementById('iz-nav');
  var hamburger = document.getElementById('hamburgerBtn');
  var drawer = document.getElementById('iz-drawer');
  var overlay = document.getElementById('iz-overlay');
  var drawerCloseBtn = document.getElementById('drawerClose');
  var moreBtn = document.getElementById('moreBtn');
  var moreDropdown = document.getElementById('moreDropdown');
  var moreWrap = moreBtn ? moreBtn.closest('.iz-nav__more-wrap') : null;

  /* Scroll → nav background */
  function handleScroll() {
    if (window.scrollY > 80) {
      nav.classList.add('scrolled');
    } else {
      nav.classList.remove('scrolled');
    }
  }
  window.addEventListener('scroll', handleScroll, { passive: true });
  handleScroll();

  /* Drawer open/close */
  function openDrawer() {
    drawer.classList.add('open');
    overlay.classList.add('open');
    drawer.setAttribute('aria-hidden', 'false');
    overlay.setAttribute('aria-hidden', 'false');
    hamburger.setAttribute('aria-expanded', 'true');
    document.body.style.overflow = 'hidden';
  }

  window.closeDrawer = function () {
    drawer.classList.remove('open');
    overlay.classList.remove('open');
    drawer.setAttribute('aria-hidden', 'true');
    overlay.setAttribute('aria-hidden', 'true');
    hamburger.setAttribute('aria-expanded', 'false');
    document.body.style.overflow = '';
  };

  if (hamburger) hamburger.addEventListener('click', openDrawer);
  if (drawerCloseBtn) drawerCloseBtn.addEventListener('click', window.closeDrawer);
  if (overlay) overlay.addEventListener('click', window.closeDrawer);

  /* Close drawer on Escape */
  document.addEventListener('keydown', function (e) {
    if (e.key === 'Escape' && drawer && drawer.classList.contains('open')) {
      window.closeDrawer();
      hamburger.focus();
    }
  });

  /* More menu (960–1279px) */
  function setupMoreMenu() {
    if (!moreBtn || !moreWrap) return;
    var links = document.querySelectorAll('.iz-nav__links .hide-at-960');
    var vw = window.innerWidth;

    if (vw >= 960 && vw <= 1279) {
      moreWrap.style.display = 'block';
      /* Populate dropdown if empty */
      if (moreDropdown && moreDropdown.children.length === 0) {
        links.forEach(function (a) {
          var li = document.createElement('li');
          var clone = a.cloneNode(true);
          clone.classList.remove('hide-at-960');
          li.appendChild(clone);
          moreDropdown.appendChild(li);
        });
      }
    } else {
      moreWrap.style.display = 'none';
      if (moreDropdown) moreDropdown.classList.remove('open');
    }
  }

  if (moreBtn) {
    moreBtn.addEventListener('click', function () {
      var open = moreDropdown.classList.toggle('open');
      moreBtn.setAttribute('aria-expanded', open ? 'true' : 'false');
    });
  }

  /* Close More dropdown on outside click */
  document.addEventListener('click', function (e) {
    if (moreWrap && !moreWrap.contains(e.target)) {
      if (moreDropdown) moreDropdown.classList.remove('open');
      if (moreBtn) moreBtn.setAttribute('aria-expanded', 'false');
    }
  });

  setupMoreMenu();
  window.addEventListener('resize', setupMoreMenu, { passive: true });

})();


/* ============================================================
   STATS COUNTER (used when DevOps uncomments the stats strip)
   [Component H — Spec S02]
   ============================================================ */
(function () {
  function animateCounter(el) {
    var target = parseInt(el.dataset.target, 10);
    if (isNaN(target)) return;
    var numEl = el.querySelector('.stat-num-value');
    if (!numEl) return;

    if (window.matchMedia('(prefers-reduced-motion: reduce)').matches) {
      numEl.textContent = target;
      return;
    }

    var start = performance.now();
    (function step(now) {
      /* 1400ms === the --dur-count token (motion-spec-v1 §1.1, RESERVED).
         Kept as a literal so the count-up has no CSSOM dependency. */
      var t = Math.min((now - start) / 1400, 1);
      numEl.textContent = Math.ceil((1 - Math.pow(1 - t, 3)) * target);
      if (t < 1) {
        requestAnimationFrame(step);
      } else {
        numEl.textContent = target;
      }
    })(performance.now());
  }

  /* Date label injection [B4] */
  function injectDateLabels() {
    document.querySelectorAll('.stat-item[data-date]').forEach(function (el) {
      var label = el.querySelector('.stat-date');
      if (label && el.dataset.date) {
        label.textContent = 'As of ' + el.dataset.date;
      }
    });
  }

  var statItems = document.querySelectorAll('.stat-item[data-target]');
  if (statItems.length > 0) {
    injectDateLabels();
    var counterObserver = new IntersectionObserver(function (entries) {
      entries.forEach(function (entry) {
        if (entry.isIntersecting) {
          animateCounter(entry.target);
          counterObserver.unobserve(entry.target);
        }
      });
    }, { threshold: 0.3 });

    statItems.forEach(function (el) {
      counterObserver.observe(el);
    });
  }
})();


/* ============================================================
   TESTIMONIALS — conditional H2 toggle [Component B / P5]
   ============================================================ */
(function () {
  var section = document.querySelector('.testimonials-section');
  if (!section) return;
  var populated = section.querySelectorAll('.testimonial-card--populated');
  if (populated.length > 0) {
    section.classList.add('section--populated');
    var trustH2 = section.querySelector('.testimonials-heading-trust');
    if (trustH2) trustH2.removeAttribute('aria-hidden');
    var placeholderH2 = section.querySelector('.testimonials-heading-placeholder');
    if (placeholderH2) placeholderH2.setAttribute('aria-hidden', 'true');
  }
})();


/* ============================================================
   FOOTER ACCORDION (mobile <768px) [S12]
   ============================================================ */
(function () {
  function setupFooterAccordion() {
    var cols = document.querySelectorAll('.footer-col');
    if (window.innerWidth > 767) {
      cols.forEach(function (col) {
        var ul = col.querySelector('ul');
        if (ul) ul.style.display = '';
      });
      return;
    }
    cols.forEach(function (col) {
      var h4 = col.querySelector('h4');
      var ul = col.querySelector('ul');
      if (!h4 || !ul) return;

      ul.style.display = col.classList.contains('open') ? 'block' : 'none';

      /* Avoid stacking duplicate listeners */
      if (!h4.dataset.accordionBound) {
        h4.dataset.accordionBound = '1';
        h4.addEventListener('click', function () {
          var isOpen = col.classList.toggle('open');
          ul.style.display = isOpen ? 'block' : 'none';
        });
      }
    });
  }

  setupFooterAccordion();
  window.addEventListener('resize', setupFooterAccordion, { passive: true });
})();


/* ============================================================
   MAP PINS — keyboard + tap interaction [Component E]
   ============================================================ */
(function () {
  var pins = document.querySelectorAll('.map-pin');
  pins.forEach(function (pin) {
    function toggle() {
      pin.classList.toggle('pin-active');
    }

    pin.addEventListener('click', toggle);
    pin.addEventListener('keydown', function (e) {
      if (e.key === 'Enter' || e.key === ' ') {
        e.preventDefault();
        toggle();
      }
    });
  });
})();


/* ============================================================
   B2B FORM — source tag + validation + success state [Component G]
   ============================================================ */
(function () {
  var form = document.getElementById('biz-enquiry-form');
  if (!form) return;

  /* Source tag injection */
  var sourceInput = form.querySelector('input[name="source"]');
  if (sourceInput) {
    var params = new URLSearchParams(window.location.search);
    var src = params.get('source')
      || (document.referrer
          ? (function () { try { return new URL(document.referrer).hostname; } catch (e) { return 'direct'; } })()
          : 'direct');
    sourceInput.value = src;
  }

  /* Validation helpers */
  function showError(groupId, errId) {
    var group = document.getElementById(groupId);
    var err = document.getElementById(errId);
    if (group) group.classList.add('has-error');
    if (err) err.style.display = 'block';
  }
  function clearError(groupId, errId) {
    var group = document.getElementById(groupId);
    var err = document.getElementById(errId);
    if (group) group.classList.remove('has-error');
    if (err) err.style.display = 'none';
  }

  /* Inline clear on input */
  var fields = [
    { inputId: 'f-name',     groupId: 'fg-name',     errId: 'err-name'     },
    { inputId: 'f-company',  groupId: 'fg-company',  errId: 'err-company'  },
    { inputId: 'f-jobtitle', groupId: 'fg-jobtitle', errId: 'err-jobtitle' },
    { inputId: 'f-email',    groupId: 'fg-email',    errId: 'err-email'    },
    { inputId: 'f-service',  groupId: 'fg-service',  errId: 'err-service'  },
    { inputId: 'f-message',  groupId: 'fg-message',  errId: 'err-message'  }
  ];
  fields.forEach(function (f) {
    var el = document.getElementById(f.inputId);
    if (el) {
      el.addEventListener('input', function () { clearError(f.groupId, f.errId); });
      el.addEventListener('change', function () { clearError(f.groupId, f.errId); });
    }
  });

  form.addEventListener('submit', function (e) {
    e.preventDefault();

    var valid = true;

    /* Validate each required field */
    fields.forEach(function (f) {
      var el = document.getElementById(f.inputId);
      if (!el) return;
      /* Phone is optional */
      if (f.inputId === 'f-phone') return;
      clearError(f.groupId, f.errId);
      if (!el.value.trim()) {
        showError(f.groupId, f.errId);
        valid = false;
      }
    });

    /* Email format check */
    var emailEl = document.getElementById('f-email');
    if (emailEl && emailEl.value.trim() && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(emailEl.value.trim())) {
      showError('fg-email', 'err-email');
      var errEl = document.getElementById('err-email');
      if (errEl) errEl.textContent = 'Please enter a valid email address.';
      valid = false;
    }

    if (!valid) {
      /* Focus first error field */
      var firstErr = form.querySelector('.has-error input, .has-error select, .has-error textarea');
      if (firstErr) firstErr.focus();
      return;
    }

    /* [P11] Success state — replace form content, not page redirect */
    var emailValue = emailEl ? emailEl.value.trim() : '';
    var successPanel = document.getElementById('form-success');
    var successEmailSpan = successPanel ? successPanel.querySelector('.success-email') : null;
    if (successEmailSpan) successEmailSpan.textContent = emailValue;

    form.style.display = 'none';
    if (successPanel) {
      successPanel.classList.add('visible');
      successPanel.focus();
    }

    /* NOTE: No actual form submission until routing is confirmed.
       Form submit action is intentionally stubbed per spec.
       Data is NOT silently sent anywhere. */
  });
})();


/* ============================================================
   NAV ACTIVE STATE — IntersectionObserver (replaces the unthrottled
   offsetTop scroll listener, which forced a layout read on every
   scroll event). Falls back to a no-op if IO is unavailable: the
   server-rendered `.active` class on the first link simply stays.
   ============================================================ */
(function () {
  var navLinks = document.querySelectorAll('.iz-nav__links a[href^="#"]');
  if (!navLinks.length) return;
  if (!('IntersectionObserver' in window)) return;

  var sections = Array.prototype.map.call(navLinks, function (a) {
    var id = a.getAttribute('href').replace('#', '');
    return { el: document.getElementById(id), link: a };
  }).filter(function (s) { return s.el; });
  if (!sections.length) return;

  var visible = new Set();

  function paint() {
    /* Match the previous semantics: the LAST section in DOM order whose
       top has passed under the nav wins. */
    var current = null;
    sections.forEach(function (s) {
      if (visible.has(s.el)) current = s;
    });
    if (!current) return;
    navLinks.forEach(function (a) { a.classList.remove('active'); });
    current.link.classList.add('active');
  }

  var navObserver = new IntersectionObserver(function (entries) {
    entries.forEach(function (entry) {
      if (entry.isIntersecting) {
        visible.add(entry.target);
      } else {
        visible.delete(entry.target);
      }
    });
    paint();
  }, {
    /* Top edge sits just under the 64px fixed nav; bottom edge pulled up
       so only the section occupying the upper viewport counts as current. */
    rootMargin: '-80px 0px -55% 0px',
    threshold: 0
  });

  sections.forEach(function (s) { navObserver.observe(s.el); });
})();


/* ============================================================
   REVEAL ENGINE — motion-spec-v1 §6
   ------------------------------------------------------------
   FAIL-OPEN BY CONSTRUCTION. Every hidden state in rebuild.css is
   scoped under `html.js-reveal`, which is set ONLY by the blocking
   inline <head> script, and only when reduced motion is not requested
   and IntersectionObserver exists. If that class is absent — script
   blocked, parse error, old browser, reduced motion — nothing below
   runs and the page is already at its final, fully visible state.
   Therefore: bail out immediately if the class is not present.
   ============================================================ */
(function () {
  var root = document.documentElement;
  if (!root.classList.contains('js-reveal')) return;

  var STAGGER_CAP = 6;          /* §6.3 — a 12-item list must not take 960ms */
  var DEFAULT_STEP = 80;        /* --stagger-base */
  var DEFAULT_THRESHOLD = 0.15;

  /* --- 1. Stagger indices, fixed delays, and pin indices --------------
     Must complete BEFORE any observer is constructed. */
  document.querySelectorAll('[data-reveal-stagger]').forEach(function (container) {
    var step = parseInt(container.dataset.revealStagger, 10);
    if (isNaN(step)) step = DEFAULT_STEP;
    container.style.setProperty('--reveal-step', step + 'ms');
    /* :scope > — direct children only. A nested grid declares its own stagger.
       Bootstrap column pass-through: when NO direct child carries [data-reveal]
       (because the direct children are .col-* elements, which may never be
       transformed or clipped per constraint 6), index the single reveal wrapper
       one level down instead. This is a fallback, never a mixed mode. */
    var kids = container.querySelectorAll(':scope > [data-reveal]');
    if (!kids.length) kids = container.querySelectorAll(':scope > * > [data-reveal]');
    kids.forEach(function (el, i) {
      el.style.setProperty('--reveal-i', Math.min(i, STAGGER_CAP));
    });
  });

  document.querySelectorAll('[data-reveal-delay]').forEach(function (el) {
    var d = parseInt(el.dataset.revealDelay, 10);
    if (!isNaN(d)) el.style.setProperty('--reveal-delay', d + 'ms');
  });

  /* §5.3 — pin arrival order is north to south, which is already DOM order. */
  document.querySelectorAll('.map-pins-overlay .map-pin').forEach(function (pin, i) {
    pin.style.setProperty('--pin-i', i);
  });

  /* --- 2. Hero fires on DOM ready, no observer (§4.2) ----------------- */
  var immediate = document.querySelectorAll('[data-reveal-immediate]');
  if (immediate.length) {
    requestAnimationFrame(function () {
      requestAnimationFrame(function () {
        immediate.forEach(function (el) { el.classList.add('is-revealed'); });
      });
    });
  }

  /* --- 3. Visibility driver (§6.4) ------------------------------------
     This used to be an IntersectionObserver. It cannot be: IO computes
     the intersection rect from the target's *painted* geometry, after
     the target's own clip-path and transform are applied. Three of the
     six FROM states in rebuild.css are zero-area by construction —

       R2 wipe  clip-path: inset(0 100% 0 0)
       R5 mask  clip-path: inset(100% 0 0 0)
       R3 draw  transform: scaleX(0)

     — so those targets report intersectionRatio 0 no matter where the
     page is scrolled, and the observer that exists to remove the hidden
     state can never fire. The element stays invisible for the life of
     the page, and native lazy-loading of any <img> inside a clipped
     ancestor is suppressed by the same clip, so its photo never loads
     either. (Measured in Chrome: the same card, the same observer
     options — ratio 0.00 while clipped, 0.54 with the clip removed.)
     This is what took the whole Furniture/Parcel/Food card row off the
     page.

     getBoundingClientRect() reports *layout* geometry and is unaffected
     by clip-path, so it is the correct primitive here. Threshold and the
     -10% bottom margin are preserved, so visual timing is unchanged.

     Second guarantee: anything the viewport has already passed is
     revealed unconditionally. A fast flick, an anchor jump, or a restored
     scroll position can move the page further in one frame than an
     element is tall, and content the user has scrolled by must never
     still be sitting at opacity 0. */
  var pending = [];
  var ticking = false;

  function shouldReveal(el, threshold) {
    var r = el.getBoundingClientRect();
    var vh = window.innerHeight || document.documentElement.clientHeight;
    var vw = window.innerWidth || document.documentElement.clientWidth;
    if (r.bottom <= 0) return true;          /* already scrolled past */
    var rootBottom = vh * 0.9;               /* rootMargin 0 0 -10% 0 */
    var area = r.width * r.height;
    /* getBoundingClientRect is unaffected by clip-path but DOES apply
       transforms, so R3 draw (`transform: scaleX(0)`) still measures a
       zero-width box. A zero-area target has no ratio to threshold
       against — fall back to a position test on the axis that survives. */
    if (!area) return r.top >= 0 && r.top <= rootBottom;
    var iw = Math.min(r.right, vw) - Math.max(r.left, 0);
    var ih = Math.min(r.bottom, rootBottom) - Math.max(r.top, 0);
    if (iw <= 0 || ih <= 0) return false;
    /* An element taller than the shrunk root can never expose `threshold`
       of itself; treat "fills the root" as satisfied. */
    if (r.height >= rootBottom && ih >= rootBottom * 0.5) return true;
    return (iw * ih) / area >= threshold;
  }

  function check() {
    ticking = false;
    if (!pending.length) return;
    pending = pending.filter(function (item) {
      if (!shouldReveal(item.el, item.t)) return true;
      item.el.classList.add('is-revealed');
      return false;                          /* once-only, always (§6.2) */
    });
    if (!pending.length) {
      window.removeEventListener('scroll', onScroll);
      window.removeEventListener('resize', onScroll);
    }
  }

  function onScroll() {
    if (ticking) return;
    ticking = true;
    requestAnimationFrame(check);
  }

  var observed = [];
  document.querySelectorAll('[data-reveal]').forEach(function (el) {
    if (el.hasAttribute('data-reveal-immediate')) return;
    var t = parseFloat(el.dataset.revealThreshold);
    if (isNaN(t)) t = DEFAULT_THRESHOLD;
    pending.push({ el: el, t: t });
    observed.push(el);
  });

  if (pending.length) {
    window.addEventListener('scroll', onScroll, { passive: true });
    window.addEventListener('resize', onScroll, { passive: true });
    requestAnimationFrame(check);   /* whatever is already in view */
  }

  /* --- 4. End-of-document sweep -------------------------------------
     `rootMargin: '0px 0px -10% 0px'` shrinks the root's bottom edge, which
     is correct for mid-page content but means anything sitting inside the
     last 10% of the viewport when the document is already scrolled to its
     end can NEVER satisfy the observer — it would stay hidden forever.
     (Reproduced on business.html's .footer-copyright-strip.) When the user
     reaches the bottom of the document, reveal whatever is left. Passive,
     once-only, self-removing. */
  function sweepAtBottom() {
    if (window.scrollY + window.innerHeight < document.documentElement.scrollHeight - 2) return;
    observed.forEach(function (el) { el.classList.add('is-revealed'); });
    observed = [];
    pending = [];
    window.removeEventListener('scroll', onScroll);
    window.removeEventListener('resize', onScroll);
    window.removeEventListener('scroll', sweepAtBottom);
    window.removeEventListener('resize', sweepAtBottom);
  }
  window.addEventListener('scroll', sweepAtBottom, { passive: true });
  window.addEventListener('resize', sweepAtBottom, { passive: true });
  sweepAtBottom();   /* short pages are already at their end */
})();

