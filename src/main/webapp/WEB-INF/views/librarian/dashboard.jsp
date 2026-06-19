<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Librarian Dashboard — BookFlow</title>
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
            <span class="sidebar__role-badge sidebar__role-badge--librarian">Librarian</span>
        </div>

        <nav class="sidebar__nav">
            <a href="${pageContext.request.contextPath}/librarian/dashboard" class="sidebar__nav-item sidebar__nav-item--active">
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
            <a href="#issue-section" class="sidebar__nav-item">
                <span class="sidebar__nav-icon">
                    <svg width="17" height="17" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M9 11L12 14L22 4" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M21 12V19C21 19.5304 20.7893 20.0391 20.4142 20.4142C20.0391 20.7893 19.5304 21 19 21H5C4.46957 21 3.96086 20.7893 3.58579 20.4142C3.21071 20.0391 3 19.5304 3 19V5C3 4.46957 3.21071 3.96086 3.58579 3.58579C3.96086 3.21071 4.46957 3 5 3H16" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </span>
                Issue Book
            </a>
            <a href="#return-section" class="sidebar__nav-item">
                <span class="sidebar__nav-icon">
                    <svg width="17" height="17" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M1 4V10H7" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M3.51 15C4.46 17.4 6.71 19.23 9.45 19.78C12.19 20.33 15.02 19.5 17.02 17.62C19.02 15.74 19.9 13 19.47 10.31C19.03 7.62 17.37 5.26 14.95 3.93C12.53 2.6 9.67 2.47 7.13 3.58L1 9" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </span>
                Return Book
            </a>
            <a href="#overdue-section" class="sidebar__nav-item">
                <span class="sidebar__nav-icon">
                    <svg width="17" height="17" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M10.29 3.86L1.82 18A2 2 0 003.54 21H20.46A2 2 0 0022.18 18L13.71 3.86A2 2 0 0010.29 3.86Z" stroke="currentColor" stroke-width="1.6" stroke-linejoin="round"/>
                        <path d="M12 9V13M12 17H12.01" stroke="currentColor" stroke-width="1.8" stroke-linecap="round"/>
                    </svg>
                </span>
                Overdue Alerts
                <c:if test="${not empty overdue}">
                    <span class="sidebar__nav-badge">${overdue.size()}</span>
                </c:if>
            </a>
            <a href="${pageContext.request.contextPath}/librarian/books/search" class="sidebar__nav-item">
                <span class="sidebar__nav-icon">
                    <svg width="17" height="17" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <circle cx="11" cy="11" r="7" stroke="currentColor" stroke-width="1.7"/>
                        <path d="M16.5 16.5L21 21" stroke="currentColor" stroke-width="1.7" stroke-linecap="round"/>
                    </svg>
                </span>
                Book Search
            </a>
            <a href="#reservations-section" class="sidebar__nav-item">
                <span class="sidebar__nav-icon">
                    <svg width="17" height="17" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <rect x="3" y="4" width="18" height="18" rx="2" stroke="currentColor" stroke-width="1.6"/>
                        <path d="M16 2V6M8 2V6M3 10H21" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/>
                    </svg>
                </span>
                Reservations
                <c:if test="${not empty pendingReservations}">
                    <span class="sidebar__nav-badge sidebar__nav-badge--new">${pendingReservations.size()}</span>
                </c:if>
            </a>
            <a href="${pageContext.request.contextPath}/librarian/activity" class="sidebar__nav-item">
                <span class="sidebar__nav-icon">
                    <svg width="17" height="17" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <circle cx="12" cy="12" r="9" stroke="currentColor" stroke-width="1.6"/>
                        <path d="M12 7V12L15 15" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </span>
                Daily Activity
            </a>
        </nav>

        <div class="sidebar__quote">
            "A librarian's job is to put information where people can find it."<br>
            <span style="opacity:0.5">— Anonymous</span>
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
                <input type="text" id="librarySearchInput" placeholder="Search books by title, author, ISBN or category...">
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
                <p class="welcome-banner__subtitle">Manage issues, returns, and member requests.</p>
            </div>

            <c:if test="${not empty errorMessage}">
                <div class="alert alert-error">${errorMessage}</div>
            </c:if>
            <c:if test="${param.issued == 'true'}">
                <div class="alert alert-success">Book issued successfully.</div>
            </c:if>
            <c:if test="${param.returned == 'true'}">
                <div class="alert alert-success">Book returned successfully.</div>
            </c:if>
            <c:if test="${param.finePaid == 'true'}">
                <div class="alert alert-success">Fine payment recorded successfully.</div>
            </c:if>

            <!-- Stat Cards -->
            <div class="stat-cards-row">
                <div class="dash-stat-card">
                    <div class="dash-stat-card__icon dash-stat-card__icon--blue">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M9 11L12 14L22 4" stroke="white" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M21 12V19C21 19.5304 20.7893 20.0391 20.4142 20.4142C20.0391 20.7893 19.5304 21 19 21H5C4.46957 21 3.96086 20.7893 3.58579 20.4142C3.21071 20.0391 3 19.5304 3 19V5C3 4.46957 3.21071 3.96086 3.58579 3.58579C3.96086 3.21071 4.46957 3 5 3H16" stroke="white" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                    </div>
                    <p class="dash-stat-card__label">Books Issued Today</p>
                    <p class="dash-stat-card__value">${issuedToday}</p>
                </div>

                <div class="dash-stat-card">
                    <div class="dash-stat-card__icon dash-stat-card__icon--green">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M4 19.5C4 18.5717 4.15224 17.7426 5.24264 16.6522C5.6075 16.5 7 16.5 7 16.5H17" stroke="white" stroke-width="1.7" stroke-linecap="round"/>
                            <path d="M6 4.5H17C18.3925 4.5 20 5.57165 20 7.5V19.5H6V4.5Z" stroke="white" stroke-width="1.7" stroke-linejoin="round"/>
                        </svg>
                    </div>
                    <p class="dash-stat-card__label">Currently Issued</p>
                    <p class="dash-stat-card__value">${currentlyIssued.size()}</p>
                </div>

                <div class="dash-stat-card">
                    <div class="dash-stat-card__icon dash-stat-card__icon--orange">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M10.29 3.86L1.82 18A2 2 0 003.54 21H20.46A2 2 0 0022.18 18L13.71 3.86A2 2 0 0010.29 3.86Z" stroke="white" stroke-width="1.6" stroke-linejoin="round"/>
                            <path d="M12 9V13M12 17H12.01" stroke="white" stroke-width="1.8" stroke-linecap="round"/>
                        </svg>
                    </div>
                    <p class="dash-stat-card__label">Overdue Books</p>
                    <p class="dash-stat-card__value dash-stat-card__value--orange">${overdue.size()}</p>
                </div>

                <div class="dash-stat-card">
                    <div class="dash-stat-card__icon dash-stat-card__icon--purple">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <rect x="3" y="4" width="18" height="18" rx="2" stroke="white" stroke-width="1.6"/>
                            <path d="M16 2V6M8 2V6M3 10H21" stroke="white" stroke-width="1.6" stroke-linecap="round"/>
                        </svg>
                    </div>
                    <p class="dash-stat-card__label">Pending Reservations</p>
                    <p class="dash-stat-card__value dash-stat-card__value--purple">${pendingReservations.size()}</p>
                </div>
            </div>

            <!-- Issue / Return Forms (side by side) -->
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-bottom: 20px;" id="issue-section">

                <!-- Issue Book Form -->
                <div class="panel-card" style="margin-bottom: 0;">
                    <h3 class="panel-card__title">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" style="color: var(--brand-blue)">
                            <path d="M9 11L12 14L22 4" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M21 12V19C21 19.5304 20.7893 20.0391 20.4142 20.4142C20.0391 20.7893 19.5304 21 19 21H5C4.46957 21 3.96086 20.7893 3.58579 20.4142C3.21071 20.0391 3 19.5304 3 19V5C3 4.46957 3.21071 3.96086 3.58579 3.58579C3.96086 3.21071 4.46957 3 5 3H16" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        Issue Book
                    </h3>
                    <form method="post" action="${pageContext.request.contextPath}/librarian/issue">
                        <c:if test="${not empty _csrf}">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        </c:if>

                        <div class="form-group">
                            <label class="form-label" for="issueMemberId">Member ID</label>
                            <input type="text" id="issueMemberId" name="memberId" class="form-input" style="padding-left:14px;" placeholder="e.g. PRIYA095312STU" required>
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="issueIsbn">Book ISBN</label>
                            <input type="text" id="issueIsbn" name="isbn" class="form-input" style="padding-left:14px;" placeholder="Enter book ISBN" required>
                        </div>

                        <button type="submit" class="btn btn-primary btn-block">
                            <svg width="15" height="15" viewBox="0 0 24 24" fill="none"><path d="M9 11L12 14L22 4" stroke="white" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/><path d="M21 12V19C21 19.5304 20.7893 20.0391 20.4142 20.4142C20.0391 20.7893 19.5304 21 19 21H5C4.46957 21 3.96086 20.7893 3.58579 20.4142C3.21071 20.0391 3 19.5304 3 19V5C3 4.46957 3.21071 3.96086 3.58579 3.58579C3.96086 3.21071 4.46957 3 5 3H16" stroke="white" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/></svg>
                            Issue Book
                        </button>
                    </form>
                </div>

                <!-- Return Book Form -->
                <div class="panel-card" style="margin-bottom: 0;" id="return-section">
                    <h3 class="panel-card__title">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" style="color: var(--brand-green)">
                            <path d="M1 4V10H7" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M3.51 15C4.46 17.4 6.71 19.23 9.45 19.78C12.19 20.33 15.02 19.5 17.02 17.62C19.02 15.74 19.9 13 19.47 10.31C19.03 7.62 17.37 5.26 14.95 3.93C12.53 2.6 9.67 2.47 7.13 3.58L1 9" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        Return Book
                    </h3>
                    <form method="post" action="${pageContext.request.contextPath}/librarian/return">
                        <c:if test="${not empty _csrf}">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        </c:if>

                        <div class="form-group">
                            <label class="form-label" for="returnTxnId">Select Transaction</label>
                            <select id="returnTxnId" name="txnId" class="form-input" style="padding-left:14px;" required>
                                <option value="" disabled selected>-- Select an issued book --</option>
                                <c:forEach var="txn" items="${currentlyIssued}">
                                    <option value="${txn.txnId}">
                                        ${txn.book.title} — ${txn.member.systemId}
                                        <c:if test="${txn.overdue}"> (OVERDUE)</c:if>
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <p id="fineCalcPreview" style="font-size: 12.5px; color: var(--text-muted); margin: -8px 0 14px 2px; display:none;"></p>

                        <button type="submit" class="btn btn-primary btn-block">
                            <svg width="15" height="15" viewBox="0 0 24 24" fill="none"><path d="M1 4V10H7" stroke="white" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/><path d="M3.51 15C4.46 17.4 6.71 19.23 9.45 19.78C12.19 20.33 15.02 19.5 17.02 17.62C19.02 15.74 19.9 13 19.47 10.31C19.03 7.62 17.37 5.26 14.95 3.93C12.53 2.6 9.67 2.47 7.13 3.58L1 9" stroke="white" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/></svg>
                            Confirm Return
                        </button>
                    </form>
                </div>
            </div>

            <!-- Overdue Alerts -->
            <div class="section-header" id="overdue-section">
                <h2 class="section-header__title">
                    <svg width="17" height="17" viewBox="0 0 24 24" fill="none" style="color:#dc2626">
                        <path d="M10.29 3.86L1.82 18A2 2 0 003.54 21H20.46A2 2 0 0022.18 18L13.71 3.86A2 2 0 0010.29 3.86Z" stroke="currentColor" stroke-width="1.6" stroke-linejoin="round"/>
                        <path d="M12 9V13M12 17H12.01" stroke="currentColor" stroke-width="1.8" stroke-linecap="round"/>
                    </svg>
                    Overdue Alerts
                </h2>
            </div>

            <div class="books-table" style="margin-bottom: 20px;">
                <c:choose>
                    <c:when test="${empty overdue}">
                        <div style="padding: 28px; text-align: center; color: var(--text-muted); font-size: 13.5px;">
                            No overdue books right now.
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="txn" items="${overdue}">
                            <div class="books-table__row" style="grid-template-columns: 1fr 140px 120px 100px 120px;">
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
                                <span style="font-size:12px; color: var(--text-muted);">Txn #${txn.txnId}</span>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Reservations -->
            <div class="section-header" id="reservations-section">
                <h2 class="section-header__title">
                    <svg width="17" height="17" viewBox="0 0 24 24" fill="none" style="color: var(--brand-purple)">
                        <rect x="3" y="4" width="18" height="18" rx="2" stroke="currentColor" stroke-width="1.6"/>
                        <path d="M16 2V6M8 2V6M3 10H21" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/>
                    </svg>
                    Pending Reservations
                </h2>
            </div>

            <div class="books-table">
                <c:choose>
                    <c:when test="${empty pendingReservations}">
                        <div style="padding: 28px; text-align: center; color: var(--text-muted); font-size: 13.5px;">
                            No pending reservations.
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="rsv" items="${pendingReservations}">
                            <div class="books-table__row" style="grid-template-columns: 1fr 140px 120px;">
                                <div>
                                    <p class="books-table__title">${rsv.book.title}</p>
                                    <p class="books-table__author">${rsv.member.systemId} — ${rsv.member.fullName}</p>
                                </div>
                                <div>
                                    <p class="books-table__date-label">Requested</p>
                                    <p class="books-table__date"><fmt:formatDate value="${rsv.requestDate}" pattern="MMM dd, yyyy"/></p>
                                </div>
                                <form method="post" action="${pageContext.request.contextPath}/librarian/reservations/${rsv.rsvId}/fulfill">
                                    <c:if test="${not empty _csrf}">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    </c:if>
                                    <button type="submit" class="btn-renew">Fulfill</button>
                                </form>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>

        </div>
    </main>

    <!-- ================================================== -->
    <!-- RIGHT PANEL                                        -->
    <!-- ================================================== -->
    <aside class="dashboard-right">

        <!-- Book Search Panel -->
        <div class="panel-card">
            <h3 class="panel-card__title">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" style="color: var(--brand-blue)">
                    <circle cx="11" cy="11" r="7" stroke="currentColor" stroke-width="1.7"/>
                    <path d="M16.5 16.5L21 21" stroke="currentColor" stroke-width="1.7" stroke-linecap="round"/>
                </svg>
                Quick Book Search
            </h3>
            <input type="text" id="quickSearchInput" class="form-input" style="padding-left:14px; margin-bottom:10px;" placeholder="Title, author, ISBN...">
            <div id="quickSearchResults" style="font-size:12.5px; color: var(--text-muted);">
                Type to search the catalogue.
            </div>
        </div>

        <!-- Member Lookup -->
        <div class="panel-card">
            <h3 class="panel-card__title">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" style="color: var(--brand-green)">
                    <circle cx="12" cy="8" r="4" stroke="currentColor" stroke-width="1.6"/>
                    <path d="M4 20C4 17.3333 5.6 12 12 12C18.4 12 20 17.3333 20 20" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/>
                </svg>
                Member Lookup
            </h3>
            <input type="text" id="memberLookupInput" class="form-input" style="padding-left:14px;" placeholder="Enter member System ID">
        </div>

        <!-- Daily Activity Log -->
        <div class="panel-card">
            <h3 class="panel-card__title">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" style="color: var(--brand-purple)">
                    <circle cx="12" cy="12" r="9" stroke="currentColor" stroke-width="1.6"/>
                    <path d="M12 7V12L15 15" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
                Today's Activity
            </h3>
            <c:choose>
                <c:when test="${empty currentlyIssued}">
                    <p style="font-size:12.5px; color: var(--text-muted); text-align:center; padding:12px 0;">No activity yet today.</p>
                </c:when>
                <c:otherwise>
                    <c:forEach var="txn" items="${currentlyIssued}" end="4">
                        <div class="due-item">
                            <div class="due-item__cover">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none"><path d="M4 19.5C4 18.5717 4.15224 17.7426 5.24264 16.6522C5.6075 16.5 7 16.5 7 16.5H17" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/><path d="M6 4.5H17C18.3925 4.5 20 5.57165 20 7.5V19.5H6V4.5Z" stroke="currentColor" stroke-width="1.6" stroke-linejoin="round"/></svg>
                            </div>
                            <div>
                                <p class="due-item__title">${txn.book.title}</p>
                                <p class="due-item__author">${txn.member.systemId}</p>
                                <p class="due-item__days">Issued <fmt:formatDate value="${txn.issueDate}" pattern="MMM dd"/></p>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>

    </aside>

</div>

<script src="${pageContext.request.contextPath}/js/theme.js"></script>
<script src="${pageContext.request.contextPath}/js/librarian-dashboard.js"></script>
</body>
</html>
