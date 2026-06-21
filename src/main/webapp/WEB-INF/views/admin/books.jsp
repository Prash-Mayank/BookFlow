<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Catalogue — BookFlow Admin</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600;700&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bookflow.css">
</head>
<body>

<div class="dashboard-layout">

    <!-- ================================================== -->
    <!-- SIDEBAR                                            -->
    <!-- ================================================== -->
    <aside class="sidebar">
        <div class="sidebar__header">
            <span class="sidebar__logo-icon">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M4 4.5C4 3.67 4.67 3 5.5 3H11V21H5.5C4.67 21 4 20.33 4 19.5V4.5Z" fill="white" opacity="0.9"/>
                    <path d="M20 4.5C20 3.67 19.33 3 18.5 3H13V21H18.5C19.33 21 20 20.33 20 19.5V4.5Z" fill="white" opacity="0.5"/>
                </svg>
            </span>
            <div>
                <div class="sidebar__brand-name">Book<span>Flow</span></div>
                <div class="sidebar__brand-sub">Online Library Management System</div>
            </div>
        </div>

        <div class="sidebar__profile">
            <div class="sidebar__avatar">
                ${user.firstName.substring(0,1)}${user.lastName.substring(0,1)}
                <span class="sidebar__avatar-online"></span>
            </div>
            <div class="sidebar__profile-name">${user.fullName}</div>
            <div class="sidebar__profile-id">${user.systemId}</div>
            <span class="sidebar__role-badge sidebar__role-badge--admin">Administrator</span>
        </div>

        <nav class="sidebar__nav">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar__nav-item">
                <span class="sidebar__nav-icon">
                    <svg width="17" height="17" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <rect x="3" y="3" width="7" height="7" rx="1" stroke="currentColor" stroke-width="1.7"/>
                        <rect x="14" y="3" width="7" height="7" rx="1" stroke="currentColor" stroke-width="1.7"/>
                        <rect x="3" y="14" width="7" height="7" rx="1" stroke="currentColor" stroke-width="1.7"/>
                        <rect x="14" y="14" width="7" height="7" rx="1" stroke="currentColor" stroke-width="1.7"/>
                    </svg>
                </span>
                Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/admin/books" class="sidebar__nav-item sidebar__nav-item--active">
                <span class="sidebar__nav-icon">
                    <svg width="17" height="17" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M4 19.5C4 18.5717 4.15224 17.7426 5.24264 16.6522C5.6075 16.5 7 16.5 7 16.5H17" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/>
                        <path d="M6 4.5H17C18.3925 4.5 20 5.57165 20 7.5V19.5H6V4.5Z" stroke="currentColor" stroke-width="1.6" stroke-linejoin="round"/>
                    </svg>
                </span>
                Book Catalogue
            </a>
            <a href="${pageContext.request.contextPath}/admin/users" class="sidebar__nav-item">
                <span class="sidebar__nav-icon">
                    <svg width="17" height="17" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M17 21V19C17 17.9391 16.5786 16.9217 15.8284 16.1716C15.0783 15.4214 14.0609 15 13 15H5C3.93913 15 2.92172 15.4214 2.17157 16.1716C1.42143 16.9217 1 17.9391 1 19V21" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M9 11C11.2091 11 13 9.20914 13 7C13 4.79086 11.2091 3 9 3C6.79086 3 5 4.79086 5 7C5 9.20914 6.79086 11 9 11Z" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </span>
                User Management
            </a>
            <a href="${pageContext.request.contextPath}/admin/dashboard#overdue-section" class="sidebar__nav-item">
                <span class="sidebar__nav-icon">
                    <svg width="17" height="17" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M10.29 3.86L1.82 18A2 2 0 003.54 21H20.46A2 2 0 0022.18 18L13.71 3.86A2 2 0 0010.29 3.86Z" stroke="currentColor" stroke-width="1.6" stroke-linejoin="round"/>
                        <path d="M12 9V13M12 17H12.01" stroke="currentColor" stroke-width="1.8" stroke-linecap="round"/>
                    </svg>
                </span>
                Overdue Books
            </a>
            <a href="${pageContext.request.contextPath}/admin/reports/export/csv?type=books" class="sidebar__nav-item">
                <span class="sidebar__nav-icon">
                    <svg width="17" height="17" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M14 2H6C5.46957 2 4.96086 2.21071 4.58579 2.58579C4.21071 2.96086 4 3.46957 4 4V20C4 20.5304 4.21071 21.0391 4.58579 21.4142C4.96086 21.7893 5.46957 22 6 22H18C18.5304 22 19.0391 21.7893 19.4142 21.4142C19.7893 21.0391 20 20.5304 20 20V8L14 2Z" stroke="currentColor" stroke-width="1.6" stroke-linejoin="round"/>
                        <path d="M14 2V8H20" stroke="currentColor" stroke-width="1.6" stroke-linejoin="round"/>
                    </svg>
                </span>
                Reports &amp; Export
            </a>
        </nav>

        <div class="sidebar__quote">
            "A great library contains the diary of the human race."<br>
            <span style="opacity:0.5">— George Mercer Dawson</span>
        </div>
    </aside>

    <!-- ================================================== -->
    <!-- MAIN CONTENT                                       -->
    <!-- ================================================== -->
    <main class="dashboard-main">

        <div class="top-navbar">
            <button class="top-navbar__hamburger" aria-label="Toggle sidebar">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M3 12H21M3 6H21M3 18H21" stroke="currentColor" stroke-width="1.8" stroke-linecap="round"/>
                </svg>
            </button>
            <div class="top-navbar__search">
                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <circle cx="11" cy="11" r="7" stroke="currentColor" stroke-width="1.6"/>
                    <path d="M16.5 16.5L21 21" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/>
                </svg>
                <input type="text" placeholder="Search anything...">
            </div>
            <div class="top-navbar__right">
                <button class="theme-toggle top-navbar__icon-btn" data-theme-toggle aria-label="Toggle theme">
                    <span class="theme-toggle__track" style="width:40px; height:22px;">
                        <span class="theme-toggle__thumb" style="width:16px; height:16px; top:3px; left:3px;">
                            <svg class="icon-sun" width="10" height="10" viewBox="0 0 24 24" fill="none">
                                <circle cx="12" cy="12" r="4" stroke="currentColor" stroke-width="2"/>
                                <path d="M12 2V5M12 19V22M4.22 4.22L6.34 6.34M17.66 17.66L19.78 19.78M2 12H5M19 12H22M4.22 19.78L6.34 17.66M17.66 6.34L19.78 4.22" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
                            </svg>
                            <svg class="icon-moon" width="10" height="10" viewBox="0 0 24 24" fill="none" style="display:none;">
                                <path d="M21 12.79A9 9 0 1111.21 3 7 7 0 0021 12.79Z" stroke="currentColor" stroke-width="2" stroke-linejoin="round"/>
                            </svg>
                        </span>
                    </span>
                </button>
                <div class="top-navbar__user">
                    <div class="top-navbar__user-avatar">${user.firstName.substring(0,1)}${user.lastName.substring(0,1)}</div>
                    <span class="top-navbar__user-id">${user.systemId}</span>
                </div>
            </div>
        </div>

        <div class="dashboard-body">

            <div class="mgmt-page-header">
                <div>
                    <h1 class="mgmt-page-header__title">Book Catalogue</h1>
                    <p class="mgmt-page-header__subtitle">${books.size()} books in the library</p>
                </div>
                <button class="btn-add" onclick="openAddModal()">
                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none"><path d="M12 5V19M5 12H19" stroke="white" stroke-width="2" stroke-linecap="round"/></svg>
                    Add Book
                </button>
            </div>

            <c:if test="${not empty errorMessage}">
                <div class="alert alert-error">${errorMessage}</div>
            </c:if>

            <div class="mgmt-toolbar">
                <div class="mgmt-toolbar__search">
                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <circle cx="11" cy="11" r="7" stroke="currentColor" stroke-width="1.6"/>
                        <path d="M16.5 16.5L21 21" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/>
                    </svg>
                    <input type="text" id="bookSearchInput" placeholder="Search by title, author, ISBN...">
                </div>
                <select class="mgmt-toolbar__select" id="categoryFilter">
                    <option value="">All Categories</option>
                    <c:forEach var="cat" items="${categories}">
                        <option value="${cat}">${cat}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="data-table-wrap">
                <c:choose>
                    <c:when test="${empty books}">
                        <div class="empty-state">
                            <svg width="40" height="40" viewBox="0 0 24 24" fill="none" style="margin: 0 auto 12px; display:block; opacity:0.3;">
                                <path d="M4 19.5C4 18.5717 4.15224 17.7426 5.24264 16.6522C5.6075 16.5 7 16.5 7 16.5H17" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/>
                                <path d="M6 4.5H17C18.3925 4.5 20 5.57165 20 7.5V19.5H6V4.5Z" stroke="currentColor" stroke-width="1.6" stroke-linejoin="round"/>
                            </svg>
                            No books in the catalogue yet. Click "Add Book" to get started.
                        </div>
                    </c:when>
                    <c:otherwise>
                        <table class="data-table" id="booksTable">
                            <thead>
                                <tr>
                                    <th>Cover</th>
                                    <th>Title &amp; Author</th>
                                    <th>ISBN</th>
                                    <th>Category</th>
                                    <th>Copies</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="book" items="${books}">
                                    <tr data-category="${book.category}" data-search="${book.title} ${book.author} ${book.isbn}"
                                        data-isbn="${book.isbn}"
                                        data-title="${book.title}"
                                        data-author="${book.author}"
                                        data-publisher="${book.publisher}"
                                        data-year="${book.year}"
                                        data-copies="${book.totalCopies}"
                                        data-description="${book.description}">
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty book.coverPath}">
                                                    <img src="${pageContext.request.contextPath}/${book.coverPath}" alt="${book.title}" class="data-table__cover">
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="data-table__cover" style="display:flex;align-items:center;justify-content:center;color:var(--text-muted);">
                                                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none"><path d="M4 19.5C4 18.5717 4.15224 17.7426 5.24264 16.6522C7 16.5 7 16.5 7 16.5H17" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/><path d="M6 4.5H17C18.3925 4.5 20 5.57165 20 7.5V19.5H6V4.5Z" stroke="currentColor" stroke-width="1.6" stroke-linejoin="round"/></svg>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div style="font-weight:600;">${book.title}</div>
                                            <div style="font-size:12px; color:var(--text-muted);">${book.author}</div>
                                        </td>
                                        <td>${book.isbn}</td>
                                        <td>${book.category}</td>
                                        <td>${book.available} / ${book.totalCopies}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${book.status == 'AVAILABLE'}">
                                                    <span class="status-badge status-badge--available">Available</span>
                                                </c:when>
                                                <c:when test="${book.status == 'RESERVED'}">
                                                    <span class="status-badge status-badge--reserved">Reserved</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-badge status-badge--issued">Issued</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="table-actions">
                                                <button class="table-action-btn" title="Edit" onclick="openEditModalFromRow(this)">
                                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none"><path d="M11 4H4C3.46957 4 2.96086 4.21071 2.58579 4.58579C2.21071 4.96086 2 5.46957 2 6V20C2 20.5304 2.21071 21.0391 2.58579 21.4142C2.96086 21.7893 3.46957 22 4 22H18C18.5304 22 19.0391 21.7893 19.4142 21.4142C19.7893 21.0391 20 20.5304 20 20V13" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/><path d="M18.5 2.5C18.8978 2.10218 19.4374 1.87868 20 1.87868C20.5626 1.87868 21.1022 2.10218 21.5 2.5C21.8978 2.89782 22.1213 3.43739 22.1213 4C22.1213 4.56261 21.8978 5.10218 21.5 5.5L12 15L8 16L9 12L18.5 2.5Z" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/></svg>
                                                </button>
                                                <form method="post" action="${pageContext.request.contextPath}/admin/books/${book.isbn}/delete" style="display:inline;" onsubmit="return confirm('Delete this book? This cannot be undone.');">
                                                    <c:if test="${not empty _csrf}">
                                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                                    </c:if>
                                                    <button type="submit" class="table-action-btn table-action-btn--danger" title="Delete">
                                                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none"><path d="M3 6H5H21" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/><path d="M8 6V4C8 3.46957 8.21071 2.96086 8.58579 2.58579C8.96086 2.21071 9.46957 2 10 2H14C14.5304 2 15.0391 2.21071 15.4142 2.58579C15.7893 2.96086 16 3.46957 16 4V6M19 6V20C19 20.5304 18.7893 21.0391 18.4142 21.4142C18.0391 21.7893 17.5304 22 17 22H7C6.46957 22 5.96086 21.7893 5.58579 21.4142C5.21071 21.0391 5 20.5304 5 20V6H19Z" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/></svg>
                                                    </button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:otherwise>
                </c:choose>
            </div>

        </div>
    </main>

    <aside class="dashboard-right">
        <div class="panel-card">
            <h3 class="panel-card__title">Catalogue Stats</h3>
            <div class="fine-balance-card__row">
                <span>Total Titles</span>
                <span style="font-weight:600; color: var(--text-primary);">${books.size()}</span>
            </div>
        </div>
    </aside>

</div>

<!-- ============ Add/Edit Book Modal ============ -->
<div class="modal-overlay" id="bookModal">
    <div class="modal-box">
        <div class="modal-box__header">
            <h3 class="modal-box__title" id="modalTitle">Add Book</h3>
            <button class="modal-box__close" onclick="closeModal()">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none"><path d="M18 6L6 18M6 6L18 18" stroke="currentColor" stroke-width="1.8" stroke-linecap="round"/></svg>
            </button>
        </div>

        <form method="post" id="bookForm" enctype="multipart/form-data">
            <c:if test="${not empty _csrf}">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            </c:if>

            <div class="form-row-2col">
                <div class="form-group">
                    <label class="form-label" for="modalIsbn">ISBN</label>
                    <input type="text" id="modalIsbn" name="isbn" class="form-input" style="padding-left:14px;" required>
                </div>
                <div class="form-group">
                    <label class="form-label" for="modalCategory">Category</label>
                    <select id="modalCategory" name="category" class="form-input" style="padding-left:14px;" required>
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat}">${cat}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label class="form-label" for="modalTitleInput">Title</label>
                <input type="text" id="modalTitleInput" name="title" class="form-input" style="padding-left:14px;" required>
            </div>

            <div class="form-row-2col">
                <div class="form-group">
                    <label class="form-label" for="modalAuthor">Author</label>
                    <input type="text" id="modalAuthor" name="author" class="form-input" style="padding-left:14px;" required>
                </div>
                <div class="form-group">
                    <label class="form-label" for="modalPublisher">Publisher</label>
                    <input type="text" id="modalPublisher" name="publisher" class="form-input" style="padding-left:14px;">
                </div>
            </div>

            <div class="form-row-2col">
                <div class="form-group">
                    <label class="form-label" for="modalYear">Year</label>
                    <input type="number" id="modalYear" name="year" class="form-input" style="padding-left:14px;" min="1000" max="2100">
                </div>
                <div class="form-group">
                    <label class="form-label" for="modalCopies">Total Copies</label>
                    <input type="number" id="modalCopies" name="totalCopies" class="form-input" style="padding-left:14px;" min="1" value="1" required>
                </div>
            </div>

            <div class="form-group">
                <label class="form-label" for="modalDescription">Description</label>
                <textarea id="modalDescription" name="description" class="form-input" style="padding-left:14px; min-height:70px; resize:vertical;"></textarea>
            </div>

            <div class="form-group">
                <label class="form-label">Cover Image</label>
                <label class="file-input-wrap" for="modalCoverImage">
                    <svg width="22" height="22" viewBox="0 0 24 24" fill="none" style="margin:0 auto 6px; display:block; color:var(--text-muted);"><path d="M12 15L12 3M12 15L8 11M12 15L16 11" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/><path d="M3 17V19C3 20.1 3.9 21 5 21H19C20.1 21 21 20.1 21 19V17" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/></svg>
                    <span style="font-size:12.5px; color:var(--text-muted);">Click to upload cover image (optional)</span>
                    <input type="file" id="modalCoverImage" name="coverImage" accept="image/*">
                </label>
            </div>

            <button type="submit" class="btn btn-primary btn-block" style="margin-top:8px;">
                <span id="modalSubmitText">Add Book</span>
            </button>
        </form>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/theme.js"></script>
<script>
    const CONTEXT_PATH = '${pageContext.request.contextPath}';
</script>
<script src="${pageContext.request.contextPath}/js/admin-books.js"></script>
</body>
</html>
