document.addEventListener('DOMContentLoaded', function () {
  document.querySelectorAll('[data-toggle-password]').forEach(function (btn) {
    btn.addEventListener('click', function () {
      const targetId = btn.getAttribute('data-toggle-password');
      const input = document.getElementById(targetId);
      if (!input) return;

      const openIcon = btn.querySelector('.icon-eye-open');
      const closedIcon = btn.querySelector('.icon-eye-closed');

      if (input.type === 'password') {
        input.type = 'text';
        if (openIcon) openIcon.style.display = 'none';
        if (closedIcon) closedIcon.style.display = 'block';
        btn.setAttribute('aria-label', 'Hide password');
      } else {
        input.type = 'password';
        if (openIcon) openIcon.style.display = 'block';
        if (closedIcon) closedIcon.style.display = 'none';
        btn.setAttribute('aria-label', 'Show password');
      }
    });
  });
});