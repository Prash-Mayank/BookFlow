(function () {
  const contextPath = document.querySelector('meta[name="context-path"]')?.content || '';

  function getContextPath() {
    // Fallback: derive from current script's known base path
    const path = window.location.pathname;
    const match = path.match(/^(\/[^/]+)\//);
    return match ? match[1] : '';
  }

  const basePath = getContextPath();

  // ---- Fine Calculator Preview on Return select ----
  document.addEventListener('DOMContentLoaded', function () {
    const returnSelect = document.getElementById('returnTxnId');
    const preview = document.getElementById('fineCalcPreview');

    if (returnSelect && preview) {
      returnSelect.addEventListener('change', function () {
        const txnId = returnSelect.value;
        if (!txnId) {
          preview.style.display = 'none';
          return;
        }

        fetch(basePath + '/librarian/return/preview?txnId=' + encodeURIComponent(txnId))
          .then(function (res) { return res.json(); })
          .then(function (data) {
            const days = data.overdueDays || 0;
            preview.style.display = 'block';
            if (days > 0) {
              preview.textContent = '⚠ This book is ' + days + ' day(s) overdue — a fine will be calculated automatically on return.';
              preview.style.color = '#dc2626';
            } else {
              preview.textContent = 'On time — no fine will be applied.';
              preview.style.color = 'var(--brand-green)';
            }
          })
          .catch(function () {
            preview.style.display = 'none';
          });
      });
    }

    // ---- Quick Book Search ----
    const quickSearchInput = document.getElementById('quickSearchInput');
    const quickSearchResults = document.getElementById('quickSearchResults');
    let searchTimeout = null;

    if (quickSearchInput && quickSearchResults) {
      quickSearchInput.addEventListener('input', function () {
        clearTimeout(searchTimeout);
        const query = quickSearchInput.value.trim();

        if (query.length < 2) {
          quickSearchResults.innerHTML = 'Type to search the catalogue.';
          return;
        }

        searchTimeout = setTimeout(function () {
          fetch(basePath + '/librarian/books/search?q=' + encodeURIComponent(query) + '&size=5')
            .then(function (res) { return res.json(); })
            .then(function (data) {
              const books = data.content || [];
              if (books.length === 0) {
                quickSearchResults.innerHTML = 'No books found.';
                return;
              }
              quickSearchResults.innerHTML = books.map(function (b) {
                const availClass = b.available > 0 ? 'var(--brand-green)' : '#dc2626';
                const availText = b.available > 0 ? (b.available + ' available') : 'Not available';
                return '<div style="padding:8px 0; border-bottom:1px solid var(--border-color);">' +
                  '<div style="font-weight:600; font-size:12.5px; color:var(--text-primary);">' + escapeHtml(b.title) + '</div>' +
                  '<div style="font-size:11.5px; color:var(--text-muted);">' + escapeHtml(b.author) + ' — ISBN ' + escapeHtml(b.isbn) + '</div>' +
                  '<div style="font-size:11px; color:' + availClass + '; font-weight:600;">' + availText + '</div>' +
                  '</div>';
              }).join('');
            })
            .catch(function () {
              quickSearchResults.innerHTML = 'Search failed. Try again.';
            });
        }, 300);
      });
    }
  });

  function escapeHtml(str) {
    if (!str) return '';
    return str
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;');
  }
})();
