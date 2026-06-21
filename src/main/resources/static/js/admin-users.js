(function () {
  window.switchTab = function (tabName, buttonEl) {
    document.querySelectorAll('.user-tab-panel').forEach(function (panel) {
      panel.style.display = 'none';
    });
    document.querySelectorAll('.user-tab').forEach(function (tab) {
      tab.classList.remove('user-tab--active');
    });

    const panel = document.getElementById('tab-' + tabName);
    if (panel) panel.style.display = '';
    buttonEl.classList.add('user-tab--active');

    applySearchFilter(); // re-apply search to the newly visible tab
  };

  const resetModal = document.getElementById('resetPasswordModal');
  const resetForm = document.getElementById('resetPasswordForm');
  const resetTargetName = document.getElementById('resetTargetName');

  window.openResetModal = function (systemId, fullName) {
    resetForm.action = CONTEXT_PATH + '/admin/users/' + encodeURIComponent(systemId) + '/reset-password';
    resetTargetName.textContent = fullName + ' (' + systemId + ')';
    document.getElementById('newPasswordInput').value = '';
    resetModal.classList.add('modal-overlay--open');
  };

  window.closeResetModal = function () {
    resetModal.classList.remove('modal-overlay--open');
  };

  resetModal.addEventListener('click', function (e) {
    if (e.target === resetModal) closeResetModal();
  });

  document.addEventListener('keydown', function (e) {
    if (e.key === 'Escape') closeResetModal();
  });

  // ---- Live search across the currently visible tab ----
  const searchInput = document.getElementById('userSearchInput');

  function applySearchFilter() {
    const query = (searchInput?.value || '').toLowerCase().trim();
    const visiblePanel = document.querySelector('.user-tab-panel:not([style*="display: none"])');
    if (!visiblePanel) return;

    const rows = visiblePanel.querySelectorAll('tbody tr');
    rows.forEach(function (row) {
      const searchText = (row.getAttribute('data-search') || '').toLowerCase();
      row.style.display = (!query || searchText.includes(query)) ? '' : 'none';
    });
  }

  if (searchInput) searchInput.addEventListener('input', applySearchFilter);
})();
