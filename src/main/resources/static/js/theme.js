(function () {
  const STORAGE_KEY = 'bookflow-theme';

  function getStoredTheme() {
    try {
      return localStorage.getItem(STORAGE_KEY);
    } catch (e) {
      return null;
    }
  }

  function setStoredTheme(theme) {
    try {
      localStorage.setItem(STORAGE_KEY, theme);
    } catch (e) {
      /* ignore — private browsing / storage disabled */
    }
  }

  function applyTheme(theme) {
    document.documentElement.setAttribute('data-theme', theme);
    document.querySelectorAll('[data-theme-toggle]').forEach(function (toggle) {
      const sunIcon = toggle.querySelector('.icon-sun');
      const moonIcon = toggle.querySelector('.icon-moon');
      if (sunIcon && moonIcon) {
        sunIcon.style.display = theme === 'dark' ? 'none' : 'block';
        moonIcon.style.display = theme === 'dark' ? 'block' : 'none';
      }
      toggle.setAttribute('aria-checked', theme === 'dark' ? 'true' : 'false');
    });
  }

  function initTheme() {
    const stored = getStoredTheme();
    const prefersDark = window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches;
    const theme = stored || (prefersDark ? 'dark' : 'light');
    applyTheme(theme);
  }

  function toggleTheme() {
    const current = document.documentElement.getAttribute('data-theme') || 'light';
    const next = current === 'dark' ? 'light' : 'dark';
    applyTheme(next);
    setStoredTheme(next);
  }

  // Apply theme immediately (before DOMContentLoaded) to avoid flash of wrong theme
  initTheme();

  document.addEventListener('DOMContentLoaded', function () {
    initTheme(); // re-apply once DOM is ready so icon elements definitely exist
    document.querySelectorAll('[data-theme-toggle]').forEach(function (toggle) {
      toggle.addEventListener('click', toggleTheme);
      toggle.addEventListener('keydown', function (e) {
        if (e.key === 'Enter' || e.key === ' ') {
          e.preventDefault();
          toggleTheme();
        }
      });
    });
  });
})();