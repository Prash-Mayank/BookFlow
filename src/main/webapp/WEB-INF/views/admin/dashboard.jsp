<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard — BookFlow</title>
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
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar__nav-item sidebar__nav-item--active">
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
            <a href="${pageContext.request.contextPath}/admin/books" class="sidebar__nav-item">
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
                        <path d="M23 21V19C22.9993 18.1137 22.7044 17.2528 22.1614 16.5523C21.6184 15.8519 20.8581 15.3516 20 15.13" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M16 3.13C16.8604 3.3503 17.623 3.8507 18.1676 4.55231C18.7122 5.25392 19.0078 6.11683 19.0078 7.005C19.0078 7.89317 18.7122 8.75608 18.1676 9.45769C17.623 10.1593 16.8604 10.6597 16 10.88" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </span>
                User Management
            </a>
            <a href="#overdue-section" class="sidebar__nav-item">
                <span class="sidebar__nav-icon">
                    <svg width="17" height="17" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M10.29 3.86L1.82 18A2 2 0 003.54 21H20.46A2 2 0 0022.18 18L13.71 3.86A2 2 0 0010.29 3.86Z" stroke="currentColor" stroke-width="1.6" stroke-linejoin="round"/>
                        <path d="M12 9V13M12 17H12.01" stroke="currentColor" stroke-width="1.8" stroke-linecap="round"/>
                    </svg>
                </span>
                Overdue Books
                <c:if test="${not empty overdueBooks}">
                    <span class="sidebar__nav-badge">${overdueBooks.size()}</span>
                </c:if>
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

        <!-- Top Navbar -->
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
                <input type="text" placeholder="Search books, members, transactions...">
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
                    <div class="top-navbar__user-avatar">
                        ${user.firstName.substring(0,1)}${user.lastName.substring(0,1)}
                    </div>
                    <span class="top-navbar__user-id">${user.systemId}</span>
                </div>
            </div>
        </div>

        <!-- Dashboard body -->
        <div class="dashboard-body">

            <!-- Welcome Banner -->
            <div class="welcome-banner">
                <h1 class="welcome-banner__title">Welcome back, ${user.firstName}!</h1>
                <p class="welcome-banner__subtitle">Here's what's happening across BookFlow today.</p>
            </div>

            <c:if test="${not empty errorMessage}">
                <div class="alert alert-error">${errorMessage}</div>
            </c:if>

            <!-- Stat Cards -->
            <div class="stat-cards-row" id="statCardsRow">
                <div class="dash-stat-card">
                    <div class="dash-stat-card__icon dash-stat-card__icon--blue">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M4 19.5C4 18.5717 4.15224 17.7426 5.24264 16.6522C5.6075 16.5 7 16.5 7 16.5H17" stroke="white" stroke-width="1.7" stroke-linecap="round"/>
                            <path d="M6 4.5H17C18.3925 4.5 20 5.57165 20 7.5V19.5H6V4.5Z" stroke="white" stroke-width="1.7" stroke-linejoin="round"/>
                        </svg>
                    </div>
                    <p class="dash-stat-card__label">Total Books</p>
                    <p class="dash-stat-card__value" data-stat="totalBooks">${stats.totalBooks}</p>
                    <a href="${pageContext.request.contextPath}/admin/books" class="dash-stat-card__link">
                        View all books
                        <svg width="11" height="11" viewBox="0 0 24 24" fill="none"><path d="M5 12H19M19 12L12 5M19 12L12 19" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/></svg>
                    </a>
                </div>

                <div class="dash-stat-card">
                    <div class="dash-stat-card__icon dash-stat-card__icon--green">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M17 21V19C17 17.9391 16.5786 16.9217 15.8284 16.1716C15.0783 15.4214 14.0609 15 13 15H5C3.93913 15 2.92172 15.4214 2.17157 16.1716C1.42143 16.9217 1 17.9391 1 19V21" stroke="white" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M9 11C11.2091 11 13 9.20914 13 7C13 4.79086 11.2091 3 9 3C6.79086 3 5 4.79086 5 7C5 9.20914 6.79086 11 9 11Z" stroke="white" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                    </div>
                    <p class="dash-stat-card__label">Total Members</p>
                    <p class="dash-stat-card__value" data-stat="totalMembers">${stats.totalMembers}</p>
                    <a href="${pageContext.request.contextPath}/admin/users" class="dash-stat-card__link">
                        View all members
                        <svg width="11" height="11" viewBox="0 0 24 24" fill="none"><path d="M5 12H19M19 12L12 5M19 12L12 19" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/></svg>
                    </a>
                </div>

                <div class="dash-stat-card">
                    <div class="dash-stat-card__icon dash-stat-card__icon--orange">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M9 2H15M12 2V6" stroke="white" stroke-width="1.7" stroke-linecap="round"/>
                            <rect x="4" y="6" width="16" height="16" rx="2" stroke="white" stroke-width="1.7"/>
                            <path d="M8 12H16M8 16H13" stroke="white" stroke-width="1.7" stroke-linecap="round"/>
                        </svg>
                    </div>
                    <p class="dash-stat-card__label">Books Issued Today</p>
                    <p class="dash-stat-card__value dash-stat-card__value--orange" data-stat="booksIssuedToday">${stats.booksIssuedToday}</p>
                    <a href="${pageContext.request.contextPath}/admin/reports/export/csv?type=transactions" class="dash-stat-card__link">
                        View transactions
                        <svg width="11" height="11" viewBox="0 0 24 24" fill="none"><path d="M5 12H19M19 12L12 5M19 12L12 19" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/></svg>
                    </a>
                </div>

                <div class="dash-stat-card">
                    <div class="dash-stat-card__icon dash-stat-card__icon--purple">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M12 2V22M17 5H9.5C8.567 5 7.672 5.369 7.005 6.034C6.339 6.7 5.97 7.595 5.97 8.528C5.97 9.461 6.339 10.357 7.005 11.022C7.672 11.687 8.567 12.056 9.5 12.056H14.5C15.433 12.056 16.328 12.426 16.995 13.091C17.661 13.756 18.03 14.652 18.03 15.585C18.03 16.518 17.661 17.413 16.995 18.079C16.328 18.744 15.433 19.113 14.5 19.113H6" stroke="white" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                    </div>
                    <p class="dash-stat-card__label">Total Fines Collected</p>
                    <p class="dash-stat-card__value dash-stat-card__value--purple" data-stat="totalFinesCollected">
                        ₹<fmt:formatNumber value="${stats.totalFinesCollected}" pattern="#,##0.00"/>
                    </p>
                    <a href="${pageContext.request.contextPath}/admin/reports/export/csv?type=transactions" class="dash-stat-card__link">
                        View details
                        <svg width="11" height="11" viewBox="0 0 24 24" fill="none"><path d="M5 12H19M19 12L12 5M19 12L12 19" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/></svg>
                    </a>
                </div>
            </div>

            <!-- Overdue Books Table -->
            <div class="section-header" id="overdue-section">
                <h2 class="section-header__title">
                    <svg width="17" height="17" viewBox="0 0 24 24" fill="none" style="color:#dc2626">
                        <path d="M10.29 3.86L1.82 18A2 2 0 003.54 21H20.46A2 2 0 0022.18 18L13.71 3.86A2 2 0 0010.29 3.86Z" stroke="currentColor" stroke-width="1.6" stroke-linejoin="round"/>
                        <path d="M12 9V13M12 17H12.01" stroke="currentColor" stroke-width="1.8" stroke-linecap="round"/>
                    </svg>
                    Overdue Books
                </h2>
                <a href="${pageContext.request.contextPath}/admin/reports/export/pdf" class="section-header__link">Export PDF</a>
            </div>

            <div class="books-table" style="margin-bottom: 20px;">
                <c:choose>
                    <c:when test="${empty overdueBooks}">
                        <div style="padding: 28px; text-align: center; color: var(--text-muted); font-size: 13.5px;">
                            No overdue books — everything is on track.
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="txn" items="${overdueBooks}">
                            <div class="books-table__row" style="grid-template-columns: 1fr 140px 120px 110px;">
                                <div>
                                    <p class="books-table__title">${txn.book.title}</p>
                                    <p class="books-table__author">${txn.member.systemId} — ${txn.member.fullName}</p>
                                </div>
                                <div>
                                    <p class="books-table__date-label">Due Date</p>
                                    <p class="books-table__date books-table__date--overdue"><fmt:formatDate value="${txn.dueDate}" pattern="MMM dd, yyyy"/></p>
                                </div>
                                <c:choose>
                                    <c:when test="${txn.overdueDays >= 4}">
                                        <span class="days-pill days-pill--danger">${txn.overdueDays} days overdue</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="days-pill days-pill--warn">${txn.overdueDays} days overdue</span>
                                    </c:otherwise>
                                </c:choose>
                                <span style="font-size:12px; color: var(--text-muted);">${txn.member.phone}</span>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Quick Links -->
            <div class="section-header">
                <h2 class="section-header__title">Quick Actions</h2>
            </div>

            <div class="quick-actions" style="grid-template-columns: repeat(4, 1fr); margin-bottom: 20px;">
                <a href="${pageContext.request.contextPath}/admin/books" class="quick-action-btn">
                    <span class="quick-action-btn__icon quick-action-btn__icon--blue">
                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none"><path d="M4 19.5C4 18.5717 4.15224 17.7426 5.24264 16.6522C7 16.5 7 16.5 7 16.5H17" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/><path d="M6 4.5H17C18.3925 4.5 20 5.57165 20 7.5V19.5H6V4.5Z" stroke="currentColor" stroke-width="1.6" stroke-linejoin="round"/></svg>
                    </span>
                    Manage Books
                </a>
                <a href="${pageContext.request.contextPath}/admin/users" class="quick-action-btn">
                    <span class="quick-action-btn__icon quick-action-btn__icon--green">
                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none"><path d="M17 21V19C17 17.9391 16.5786 16.9217 13 15H5C3.93913 15 1 17.9391 1 19V21" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"/><path d="M9 11C11.2091 11 13 9.20914 13 7C13 4.79086 11.2091 3 9 3C6.79086 3 5 4.79086 5 7C5 9.20914 6.79086 11 9 11Z" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"/></svg>
                    </span>
                    Manage Users
                </a>
                <a href="${pageContext.request.contextPath}/admin/reports/export/csv?type=books" class="quick-action-btn">
                    <span class="quick-action-btn__icon quick-action-btn__icon--purple">
                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none"><path d="M12 15L12 3M12 15L8 11M12 15L16 11" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/><path d="M3 17V19C3 20.1 3.9 21 5 21H19C20.1 21 21 20.1 21 19V17" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/></svg>
                    </span>
                    Export CSV
                </a>
                <a href="${pageContext.request.contextPath}/admin/reports/export/pdf" class="quick-action-btn">
                    <span class="quick-action-btn__icon quick-action-btn__icon--orange">
                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none"><path d="M14 2H6C5.46957 2 4.96086 2.21071 4.58579 2.58579C4.21071 2.96086 4 3.46957 4 4V20C4 20.5304 4.21071 21.0391 4.58579 21.4142C4.96086 21.7893 5.46957 22 6 22H18C18.5304 22 19.0391 21.7893 19.4142 21.4142C19.7893 21.0391 20 20.5304 20 20V8L14 2Z" stroke="currentColor" stroke-width="1.6" stroke-linejoin="round"/><path d="M14 2V8H20" stroke="currentColor" stroke-width="1.6" stroke-linejoin="round"/></svg>
                    </span>
                    Export PDF
                </a>
            </div>

        </div>
    </main>

    <!-- ================================================== -->
    <!-- RIGHT PANEL                                        -->
    <!-- ================================================== -->
    <aside class="dashboard-right">

        <!-- System Health -->
        <div class="panel-card">
            <h3 class="panel-card__title">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" style="color: var(--brand-green)">
                    <path d="M22 12H18L15 21L9 3L6 12H2" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
                System Snapshot
            </h3>
            <div class="fine-balance-card__row">
                <span>Active Librarians</span>
                <span style="font-weight:600; color: var(--text-primary);">${librarianCount}</span>
            </div>
            <div class="fine-balance-card__row">
                <span>Active Students</span>
                <span style="font-weight:600; color: var(--text-primary);">${studentCount}</span>
            </div>
            <div class="fine-balance-card__row">
                <span>Books Available</span>
                <span style="font-weight:600; color: var(--text-primary);">${availableBookCount}</span>
            </div>
        </div>

        <!-- Export Reports -->
        <div class="panel-card">
            <h3 class="panel-card__title">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" style="color: var(--brand-blue)">
                    <path d="M14 2H6C5.46957 2 4.96086 2.21071 4.58579 2.58579C4.21071 2.96086 4 3.46957 4 4V20C4 20.5304 4.21071 21.0391 4.58579 21.4142C4.96086 21.7893 5.46957 22 6 22H18C18.5304 22 19.0391 21.7893 19.4142 21.4142C19.7893 21.0391 20 20.5304 20 20V8L14 2Z" stroke="currentColor" stroke-width="1.6" stroke-linejoin="round"/>
                    <path d="M14 2V8H20" stroke="currentColor" stroke-width="1.6" stroke-linejoin="round"/>
                </svg>
                Reports
            </h3>
            <a href="${pageContext.request.contextPath}/admin/reports/export/csv?type=books" class="btn-renew" style="width:100%; justify-content:center; margin-bottom:8px;">Books CSV</a>
            <a href="${pageContext.request.contextPath}/admin/reports/export/csv?type=transactions" class="btn-renew" style="width:100%; justify-content:center; margin-bottom:8px;">Transactions CSV</a>
            <a href="${pageContext.request.contextPath}/admin/reports/export/csv?type=users" class="btn-renew" style="width:100%; justify-content:center; margin-bottom:8px;">Users CSV</a>
            <a href="${pageContext.request.contextPath}/admin/reports/export/pdf" class="btn-renew" style="width:100%; justify-content:center;">Overdue PDF</a>
        </div>

    </aside>

</div>

<script src="${pageContext.request.contextPath}/js/theme.js"></script>
<script src="${pageContext.request.contextPath}/js/admin-dashboard.js"></script>
</body>
</html>
