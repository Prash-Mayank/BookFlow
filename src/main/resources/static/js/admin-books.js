(function () {
  const modal = document.getElementById('bookModal');
  const form = document.getElementById('bookForm');
  const modalTitle = document.getElementById('modalTitle');
  const modalSubmitText = document.getElementById('modalSubmitText');
  const isbnInput = document.getElementById('modalIsbn');

  window.openAddModal = function () {
    form.reset();
    form.action = CONTEXT_PATH + '/admin/books';
    isbnInput.readOnly = false;
    isbnInput.style.background = '';
    isbnInput.style.cursor = '';
    modalTitle.textContent = 'Add Book';
    modalSubmitText.textContent = 'Add Book';
    modal.classList.add('modal-overlay--open');
  };

  window.openEditModalFromRow = function (buttonEl) {
    const row = buttonEl.closest('tr');
    if (!row) return;

    const isbn = row.getAttribute('data-isbn');

    form.reset();
    form.action = CONTEXT_PATH + '/admin/books/' + encodeURIComponent(isbn) + '/edit';

    document.getElementById('modalIsbn').value = isbn;
    document.getElementById('modalIsbn').readOnly = true; // ISBN is the primary key — not editable, but must still submit
    document.getElementById('modalIsbn').style.background = 'var(--bg-surface-alt)';
    document.getElementById('modalIsbn').style.cursor = 'not-allowed';    document.getElementById('modalTitleInput').value = row.getAttribute('data-title') || '';
    document.getElementById('modalAuthor').value = row.getAttribute('data-author') || '';
    document.getElementById('modalCategory').value = row.getAttribute('data-category') || '';
    document.getElementById('modalPublisher').value = row.getAttribute('data-publisher') || '';
    document.getElementById('modalYear').value = row.getAttribute('data-year') || '';
    document.getElementById('modalCopies').value = row.getAttribute('data-copies') || 1;
    document.getElementById('modalDescription').value = row.getAttribute('data-description') || '';

    modalTitle.textContent = 'Edit Book';
    modalSubmitText.textContent = 'Save Changes';
    modal.classList.add('modal-overlay--open');
  };

  window.closeModal = function () {
    modal.classList.remove('modal-overlay--open');
  };

  modal.addEventListener('click', function (e) {
    if (e.target === modal) closeModal();
  });

  document.addEventListener('keydown', function (e) {
    if (e.key === 'Escape') closeModal();
  });

  // ---- Live search + category filter ----
  const searchInput = document.getElementById('bookSearchInput');
  const categoryFilter = document.getElementById('categoryFilter');
  const tableRows = document.querySelectorAll('#booksTable tbody tr');

  function applyFilters() {
    const query = (searchInput?.value || '').toLowerCase().trim();
    const category = categoryFilter?.value || '';

    tableRows.forEach(function (row) {
      const searchText = (row.getAttribute('data-search') || '').toLowerCase();
      const rowCategory = row.getAttribute('data-category') || '';

      const matchesSearch = !query || searchText.includes(query);
      const matchesCategory = !category || rowCategory === category;

      row.style.display = (matchesSearch && matchesCategory) ? '' : 'none';
    });
  }

  if (searchInput) searchInput.addEventListener('input', applyFilters);
  if (categoryFilter) categoryFilter.addEventListener('change', applyFilters);
})();
