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
   NAV ACTIVE STATE on scroll (index.html section tracking)
   ============================================================ */
(function () {
  var navLinks = document.querySelectorAll('.iz-nav__links a[href^="#"]');
  if (!navLinks.length) return;

  var sections = Array.from(navLinks).map(function (a) {
    var id = a.getAttribute('href').replace('#', '');
    return { el: document.getElementById(id), link: a };
  }).filter(function (s) { return s.el; });

  function updateActive() {
    var scrollY = window.scrollY + 80;
    var current = null;
    sections.forEach(function (s) {
      if (s.el.offsetTop <= scrollY) current = s;
    });
    navLinks.forEach(function (a) { a.classList.remove('active'); });
    if (current) current.link.classList.add('active');
  }

  window.addEventListener('scroll', updateActive, { passive: true });
  updateActive();
})();
