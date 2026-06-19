(function () {
  function getContextPath() {
    const path = window.location.pathname;
    const match = path.match(/^(\/[^/]+)\//);
    return match ? match[1] : '';
  }

  const basePath = getContextPath();
  const REFRESH_INTERVAL_MS = 30000;

  function formatCurrency(value) {
    const num = Number(value) || 0;
    return num.toLocaleString('en-IN', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
  }

  function refreshStats() {
    fetch(basePath + '/admin/dashboard/stats')
      .then(function (res) { return res.json(); })
      .then(function (data) {
        const totalBooksEl = document.querySelector('[data-stat="totalBooks"]');
        const totalMembersEl = document.querySelector('[data-stat="totalMembers"]');
        const issuedTodayEl = document.querySelector('[data-stat="booksIssuedToday"]');
        const finesEl = document.querySelector('[data-stat="totalFinesCollected"]');

        if (totalBooksEl) totalBooksEl.textContent = data.totalBooks;
        if (totalMembersEl) totalMembersEl.textContent = data.totalMembers;
        if (issuedTodayEl) issuedTodayEl.textContent = data.booksIssuedToday;
        if (finesEl) finesEl.textContent = '₹' + formatCurrency(data.totalFinesCollected);
      })
      .catch(function () {
        // Silently ignore — stats will retry on next interval
      });
  }

  document.addEventListener('DOMContentLoaded', function () {
    if (document.getElementById('statCardsRow')) {
      setInterval(refreshStats, REFRESH_INTERVAL_MS);
    }
  });
})();
