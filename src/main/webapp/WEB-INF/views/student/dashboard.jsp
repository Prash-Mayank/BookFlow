<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard — BookFlow</title>
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
            <span class="sidebar__role-badge">Student</span>
        </div>

        <nav class="sidebar__nav">
            <a href="${pageContext.request.contextPath}/student/dashboard" class="sidebar__nav-item sidebar__nav-item--active">
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
            <a href="${pageContext.request.contextPath}/student/books" class="sidebar__nav-item">
                <span class="sidebar__nav-icon">
                    <svg width="17" height="17" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M4 19.5C4 18.5717 4 18.1075 4.15224 17.7426C4.35523 17.2493 4.74935 16.8552 5.24264 16.6522C5.6075 16.5 6.07165 16.5 7 16.5H17" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/>
                        <path d="M6 4.5H17C17.9284 4.5 18.3925 4.5 18.7574 4.65224C19.2506 4.85523 19.6448 5.24935 19.8478 5.74264C20 6.1075 20 6.57165 20 7.5V19.5H6V4.5Z" stroke="currentColor" stroke-width="1.6" stroke-linejoin="round"/>
                    </svg>
                </span>
                Browse Books
            </a>
            <a href="${pageContext.request.contextPath}/student/history" class="sidebar__nav-item">
                <span class="sidebar__nav-icon">
                    <svg width="17" height="17" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M4 19.5C4 18.5717 4 18.1075 4.15224 17.7426C4.35523 17.2493 4.74935 16.8552 5.24264 16.6522C5.6075 16.5 6.07165 16.5 7 16.5H17" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/>
                        <path d="M6 4.5H17C17.9284 4.5 18.3925 4.5 18.7574 4.65224C19.2506 4.85523 19.6448 5.24935 19.8478 5.74264C20 6.1075 20 6.57165 20 7.5V19.5H6V4.5Z" stroke="currentColor" stroke-width="1.6" stroke-linejoin="round"/>
                    </svg>
                </span>
                My Borrowed Books
            </a>
            <a href="${pageContext.request.contextPath}/student/reservations" class="sidebar__nav-item">
                <span class="sidebar__nav-icon">
                    <svg width="17" height="17" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <rect x="3" y="4" width="18" height="18" rx="2" stroke="currentColor" stroke-width="1.6"/>
                        <path d="M16 2V6M8 2V6M3 10H21" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/>
                    </svg>
                </span>
                Reservations
            </a>
            <a href="${pageContext.request.contextPath}/student/fines" class="sidebar__nav-item">
                <span class="sidebar__nav-icon">
                    <svg width="17" height="17" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M12 2V22M17 5H9.5C8.567 5 7.672 5.369 7.005 6.034C6.339 6.7 5.97 7.595 5.97 8.528C5.97 9.461 6.339 10.357 7.005 11.022C7.672 11.687 8.567 12.056 9.5 12.056H14.5C15.433 12.056 16.328 12.426 16.995 13.091C17.661 13.756 18.03 14.652 18.03 15.585C18.03 16.518 17.661 17.413 16.995 18.079C16.328 18.744 15.433 19.113 14.5 19.113H6" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </span>
                Fine &amp; Payments
            </a>
            <a href="${pageContext.request.contextPath}/student/recommendations" class="sidebar__nav-item">
                <span class="sidebar__nav-icon">
                    <svg width="17" height="17" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M12 2L14.5 8.5L21 11L14.5 13.5L12 20L9.5 13.5L3 11L9.5 8.5L12 2Z" stroke="currentColor" stroke-width="1.6" stroke-linejoin="round"/>
                    </svg>
                </span>
                AI Recommendations
                <span class="sidebar__nav-badge sidebar__nav-badge--new">New</span>
            </a>
            <a href="${pageContext.request.contextPath}/student/history" class="sidebar__nav-item">
                <span class="sidebar__nav-icon">
                    <svg width="17" height="17" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <circle cx="12" cy="12" r="9" stroke="currentColor" stroke-width="1.6"/>
                        <path d="M12 7V12L15 15" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </span>
                Borrow History
            </a>
            <a href="${pageContext.request.contextPath}/student/profile" class="sidebar__nav-item">
                <span class="sidebar__nav-icon">
                    <svg width="17" height="17" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <circle cx="12" cy="8" r="4" stroke="currentColor" stroke-width="1.6"/>
                        <path d="M4 20C4 17.3333 5.6 12 12 12C18.4 12 20 17.3333 20 20" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/>
                    </svg>
                </span>
                Profile Settings
            </a>
            <a href="#" class="sidebar__nav-item">
                <span class="sidebar__nav-icon">
                    <svg width="17" height="17" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M18 8C18 6.4087 17.3679 4.88258 16.2426 3.75736C15.1174 2.63214 13.5913 2 12 2C10.4087 2 8.88258 2.63214 7.75736 3.75736C6.63214 4.88258 6 6.4087 6 8C6 15 3 17 3 17H21C21 17 18 15 18 8Z" stroke="currentColor" stroke-width="1.6" stroke-linejoin="round"/>
                        <path d="M13.73 21C13.5542 21.3031 13.3019 21.5547 12.9982 21.7295C12.6946 21.9044 12.3504 21.9965 12 21.9965C11.6496 21.9965 11.3054 21.9044 11.0018 21.7295C10.6982 21.5547 10.4458 21.3031 10.27 21" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </span>
                Notifications
                <c:if test="${notificationCount > 0}">
                    <span class="sidebar__nav-badge">${notificationCount}</span>
                </c:if>
            </a>
            <a href="#" class="sidebar__nav-item">
                <span class="sidebar__nav-icon">
                    <svg width="17" height="17" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <circle cx="12" cy="12" r="9" stroke="currentColor" stroke-width="1.6"/>
                        <path d="M12 8V13M12 16H12.01" stroke="currentColor" stroke-width="1.8" stroke-linecap="round"/>
                    </svg>
                </span>
                Help &amp; Support
            </a>
        </nav>

        <div class="sidebar__quote">
            "A room without books is like a body without a soul."<br>
            <span style="opacity:0.5">— Marcus Tullius Cicero</span>
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
                <input type="text" placeholder="Search by title, author, ISBN or category...">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <circle cx="11" cy="11" r="7" stroke="currentColor" stroke-width="1.6"/>
                    <path d="M16.5 16.5L21 21" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/>
                </svg>
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

                <button class="top-navbar__icon-btn" aria-label="Notifications">
                    <svg width="19" height="19" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M18 8C18 6.4087 17.3679 4.88258 16.2426 3.75736C15.1174 2.63214 13.5913 2 12 2C10.4087 2 8.88258 2.63214 7.75736 3.75736C6.63214 4.88258 6 6.4087 6 8C6 15 3 17 3 17H21C21 17 18 15 18 8Z" stroke="currentColor" stroke-width="1.6" stroke-linejoin="round"/>
                        <path d="M13.73 21C13.5542 21.3031 13.3019 21.5547 12.9982 21.7295C12.6946 21.9044 12.3504 21.9965 12 21.9965C11.6496 21.9965 11.3054 21.9044 11.0018 21.7295C10.6982 21.5547 10.4458 21.3031 10.27 21" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    <c:if test="${notificationCount > 0}">
                        <span class="top-navbar__badge">${notificationCount}</span>
                    </c:if>
                </button>

                <div class="top-navbar__user">
                    <div class="top-navbar__user-avatar">
                        ${user.firstName.substring(0,1)}${user.lastName.substring(0,1)}
                    </div>
                    <span class="top-navbar__user-id">${user.systemId}</span>
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M6 9L12 15L18 9" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </div>
            </div>
        </div>

        <!-- Dashboard body -->
        <div class="dashboard-body">

            <!-- Welcome Banner -->
            <div class="welcome-banner">
                <h1 class="welcome-banner__title">Good Morning, ${user.firstName}!</h1>
                <p class="welcome-banner__subtitle">Explore. Learn. Grow.</p>
                <p class="welcome-banner__quote">"The more you read, the more things you will know. The more that you learn, the more places you'll go."</p>
            </div>

            <!-- Stat Cards -->
            <div class="stat-cards-row">
                <div class="dash-stat-card">
                    <div class="dash-stat-card__icon dash-stat-card__icon--blue">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M4 19.5C4 18.5717 4 18.1075 4.15224 17.7426C4.35523 17.2493 4.74935 16.8552 5.24264 16.6522C5.6075 16.5 6.07165 16.5 7 16.5H17" stroke="white" stroke-width="1.7" stroke-linecap="round"/>
                            <path d="M6 4.5H17C17.9284 4.5 18.3925 4.5 18.7574 4.65224C19.2506 4.85523 19.6448 5.24935 19.8478 5.74264C20 6.1075 20 6.57165 20 7.5V19.5H6V4.5Z" stroke="white" stroke-width="1.7" stroke-linejoin="round"/>
                        </svg>
                    </div>
                    <p class="dash-stat-card__label">Currently Borrowed</p>
                    <p class="dash-stat-card__value">${borrowedCount}</p>
                    <p class="dash-stat-card__sub">Books</p>
                    <a href="${pageContext.request.contextPath}/student/history" class="dash-stat-card__link">
                        View all
                        <svg width="11" height="11" viewBox="0 0 24 24" fill="none"><path d="M5 12H19M19 12L12 5M19 12L12 19" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/></svg>
                    </a>
                </div>

                <div class="dash-stat-card">
                    <div class="dash-stat-card__icon dash-stat-card__icon--green">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <rect x="3" y="4" width="18" height="18" rx="2" stroke="white" stroke-width="1.6"/>
                            <path d="M16 2V6M8 2V6M3 10H21" stroke="white" stroke-width="1.6" stroke-linecap="round"/>
                        </svg>
                    </div>
                    <p class="dash-stat-card__label">Due Soon</p>
                    <p class="dash-stat-card__value">${dueSoonCount}</p>
                    <p class="dash-stat-card__sub">Book</p>
                    <a href="${pageContext.request.contextPath}/student/history" class="dash-stat-card__link">
                        View details
                        <svg width="11" height="11" viewBox="0 0 24 24" fill="none"><path d="M5 12H19M19 12L12 5M19 12L12 19" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/></svg>
                    </a>
                </div>

                <div class="dash-stat-card">
                    <div class="dash-stat-card__icon dash-stat-card__icon--purple">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M12 2V22M17 5H9.5C8.567 5 7.672 5.369 7.005 6.034C6.339 6.7 5.97 7.595 5.97 8.528C5.97 9.461 6.339 10.357 7.005 11.022C7.672 11.687 8.567 12.056 9.5 12.056H14.5C15.433 12.056 16.328 12.426 16.995 13.091C17.661 13.756 18.03 14.652 18.03 15.585C18.03 16.518 17.661 17.413 16.995 18.079C16.328 18.744 15.433 19.113 14.5 19.113H6" stroke="white" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                    </div>
                    <p class="dash-stat-card__label">Fine Balance</p>
                    <p class="dash-stat-card__value dash-stat-card__value--purple">
                        ₹<fmt:formatNumber value="${fineBalance}" pattern="#,##0.00"/>
                    </p>
                    <a href="${pageContext.request.contextPath}/student/fines" class="dash-stat-card__link">
                        Pay Now
                        <svg width="11" height="11" viewBox="0 0 24 24" fill="none"><path d="M5 12H19M19 12L12 5M19 12L12 19" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/></svg>
                    </a>
                </div>

                <div class="dash-stat-card">
                    <div class="dash-stat-card__icon dash-stat-card__icon--orange">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <circle cx="12" cy="12" r="9" stroke="white" stroke-width="1.6"/>
                            <path d="M12 7V12L15 15" stroke="white" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                    </div>
                    <p class="dash-stat-card__label">Days Remaining</p>
                    <p class="dash-stat-card__value dash-stat-card__value--orange">
                        <c:choose>
                            <c:when test="${not empty borrowedBooks}">
                                <c:set var="minDays" value="999"/>
                                <c:forEach var="txn" items="${borrowedBooks}">
                                    <c:if test="${txn.daysRemaining < minDays}">
                                        <c:set var="minDays" value="${txn.daysRemaining}"/>
                                    </c:if>
                                </c:forEach>
                                ${minDays}
                            </c:when>
                            <c:otherwise>—</c:otherwise>
                        </c:choose>
                    </p>
                    <p class="dash-stat-card__sub">On nearest due</p>
                </div>
            </div>

            <!-- My Borrowed Books -->
            <div class="section-header">
                <h2 class="section-header__title">
                    <svg width="17" height="17" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M4 19.5C4 18.5717 4.15224 17.7426 4.35523 17.2493C4.74935 16.8552 5.24264 16.6522 7 16.5H17" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/>
                        <path d="M6 4.5H17C18.3925 4.5 19.6448 5.24935 19.8478 5.74264C20 6.1075 20 6.57165 20 7.5V19.5H6V4.5Z" stroke="currentColor" stroke-width="1.6" stroke-linejoin="round"/>
                    </svg>
                    My Borrowed Books
                </h2>
                <a href="${pageContext.request.contextPath}/student/history" class="section-header__link">View all</a>
            </div>

            <div class="books-table">
                <c:choose>
                    <c:when test="${empty borrowedBooks}">
                        <div style="padding: 32px; text-align: center; color: var(--text-muted); font-size: 13.5px;">
                            <svg width="36" height="36" viewBox="0 0 24 24" fill="none" style="margin: 0 auto 10px; display: block; opacity: 0.3;">
                                <path d="M4 19.5C4 18.5717 4.15224 17.7426 5.24264 16.6522C5.6075 16.5 7 16.5 7 16.5H17C18.3925 16.5 20 17.2493 20 19.5" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/>
                                <path d="M6 4.5H17C18.3925 4.5 20 5.57165 20 7.5V19.5H6V4.5Z" stroke="currentColor" stroke-width="1.6" stroke-linejoin="round"/>
                            </svg>
                            No books currently borrowed. <a href="${pageContext.request.contextPath}/student/books" class="form-link">Browse the catalogue →</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="txn" items="${borrowedBooks}">
                            <div class="books-table__row">
                                <div class="books-table__cover">
                                    <c:choose>
                                        <c:when test="${not empty txn.book.coverPath}">
                                            <img src="${pageContext.request.contextPath}/${txn.book.coverPath}" alt="${txn.book.title}">
                                        </c:when>
                                        <c:otherwise>
                                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none"><path d="M4 19.5C4 18.5717 4.15224 17.7426 5.24264 16.6522C5.6075 16.5 7 16.5 7 16.5H17" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/><path d="M6 4.5H17C18.3925 4.5 20 5.57165 20 7.5V19.5H6V4.5Z" stroke="currentColor" stroke-width="1.6" stroke-linejoin="round"/></svg>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div>
                                    <p class="books-table__title">${txn.book.title}</p>
                                    <p class="books-table__author">${txn.book.author}</p>
                                </div>
                                <div>
                                    <p class="books-table__date-label">Borrowed on</p>
                                    <p class="books-table__date"><fmt:formatDate value="${txn.issueDate}" pattern="MMM dd, yyyy"/></p>
                                </div>
                                <div>
                                    <p class="books-table__date-label">Due Date</p>
                                    <p class="books-table__date ${txn.overdue ? 'books-table__date--overdue' : ''}">
                                        <fmt:formatDate value="${txn.dueDate}" pattern="MMM dd, yyyy"/>
                                    </p>
                                </div>
                                <c:choose>
                                    <c:when test="${txn.overdue}">
                                        <span class="days-pill days-pill--danger">Overdue</span>
                                    </c:when>
                                    <c:when test="${txn.daysRemaining <= 3}">
                                        <span class="days-pill days-pill--warn">${txn.daysRemaining} days left</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="days-pill days-pill--safe">${txn.daysRemaining} days left</span>
                                    </c:otherwise>
                                </c:choose>
                                <a href="#" class="btn-renew">
                                    <svg width="13" height="13" viewBox="0 0 24 24" fill="none"><path d="M1 4V10H7" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/><path d="M3.51 15C4.46 17.4 6.71 19.23 9.45 19.78C12.19 20.33 15.02 19.5 17.02 17.62C19.02 15.74 19.9 13 19.47 10.31C19.03 7.62 17.37 5.26 14.95 3.93C12.53 2.6 9.67 2.47 7.13 3.58L1 9" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/></svg>
                                    Renew
                                </a>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- AI Recommendations -->
            <div class="ai-section">
                <div class="ai-section__header">
                    <h2 class="ai-section__title">
                        <svg width="17" height="17" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M12 2L14.5 8.5L21 11L14.5 13.5L12 20L9.5 13.5L3 11L9.5 8.5L12 2Z" stroke="var(--brand-purple)" stroke-width="1.6" stroke-linejoin="round"/>
                        </svg>
                        AI Recommended for You
                        <span class="ai-section__subtitle">Based on your reading history</span>
                    </h2>
                    <a href="${pageContext.request.contextPath}/student/recommendations" class="section-header__link">View all</a>
                </div>

                <div class="ai-books-row">
                    <c:choose>
                        <c:when test="${not empty recommendations}">
                            <c:forEach var="rec" items="${recommendations}" end="5">
                                <div class="ai-book-card">
                                    <div class="ai-book-card__cover">
                                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none"><path d="M4 19.5C4 18.5717 4.15224 17.7426 5.24264 16.6522C5.6075 16.5 7 16.5 7 16.5H17" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/><path d="M6 4.5H17C18.3925 4.5 20 5.57165 20 7.5V19.5H6V4.5Z" stroke="currentColor" stroke-width="1.6" stroke-linejoin="round"/></svg>
                                    </div>
                                    <p class="ai-book-card__title">${rec.title}</p>
                                    <p class="ai-book-card__author">${rec.author}</p>
                                    <div class="ai-book-card__rating">
                                        <svg width="11" height="11" viewBox="0 0 24 24" fill="#d97706"><path d="M12 2L15.09 8.26L22 9.27L17 14.14L18.18 21.02L12 17.77L5.82 21.02L7 14.14L2 9.27L8.91 8.26L12 2Z"/></svg>
                                        ${rec.genre}
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div style="grid-column: 1/-1; text-align: center; padding: 20px; color: var(--text-muted); font-size: 13px;">
                                Borrow a few books first to get AI-powered recommendations.
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

        </div>
    </main>

    <!-- ================================================== -->
    <!-- RIGHT PANEL                                        -->
    <!-- ================================================== -->
    <aside class="dashboard-right">

        <!-- Upcoming Due Dates -->
        <div class="panel-card">
            <h3 class="panel-card__title">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style="color: var(--brand-blue)">
                    <rect x="3" y="4" width="18" height="18" rx="2" stroke="currentColor" stroke-width="1.6"/>
                    <path d="M16 2V6M8 2V6M3 10H21" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/>
                </svg>
                Upcoming Due Dates
            </h3>
            <c:choose>
                <c:when test="${empty borrowedBooks}">
                    <p style="font-size:12.5px; color: var(--text-muted); text-align: center; padding: 12px 0;">No books due.</p>
                </c:when>
                <c:otherwise>
                    <c:forEach var="txn" items="${borrowedBooks}">
                        <div class="due-item">
                            <div class="due-item__cover">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none"><path d="M4 19.5C4 18.5717 4.15224 17.7426 5.24264 16.6522C5.6075 16.5 7 16.5 7 16.5H17" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/><path d="M6 4.5H17C18.3925 4.5 20 5.57165 20 7.5V19.5H6V4.5Z" stroke="currentColor" stroke-width="1.6" stroke-linejoin="round"/></svg>
                            </div>
                            <div>
                                <p class="due-item__title">${txn.book.title}</p>
                                <p class="due-item__author">${txn.book.author}</p>
                                <p class="due-item__date"><fmt:formatDate value="${txn.dueDate}" pattern="MMM dd, yyyy"/></p>
                                <p class="due-item__days">${txn.daysRemaining} days left</p>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            <a href="${pageContext.request.contextPath}/student/history" style="font-size: 12.5px; font-weight: 600; color: var(--brand-blue); display: block; text-align: center; margin-top: 10px;">
                View all due dates →
            </a>
        </div>

        <!-- Fine Balance -->
        <div class="fine-balance-card">
            <h3 class="fine-balance-card__title">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style="color: var(--brand-green)">
                    <circle cx="12" cy="12" r="9" stroke="currentColor" stroke-width="1.6"/>
                    <path d="M12 6V18M9 9H14.5C15.33 9 16 9.67 16 10.5C16 11.33 15.33 12 14.5 12H9.5C8.67 12 8 12.67 8 13.5C8 14.33 8.67 15 9.5 15H15" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/>
                </svg>
                Fine Balance
            </h3>
            <p class="fine-balance-card__total-label">Total Outstanding</p>
            <p class="fine-balance-card__total-value">₹<fmt:formatNumber value="${fineBalance}" pattern="#,##0.00"/></p>
            <div class="fine-balance-card__row">
                <span>Overdue Fine</span>
                <span>₹<fmt:formatNumber value="${fineBalance}" pattern="#,##0.00"/></span>
            </div>
            <div class="fine-balance-card__row">
                <span>Processing Charges</span>
                <span>₹0.00</span>
            </div>
            <c:if test="${fineBalance > 0}">
                <a href="${pageContext.request.contextPath}/student/fines" class="btn-pay">
                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none"><rect x="2" y="5" width="20" height="14" rx="2" stroke="white" stroke-width="1.6"/><path d="M2 10H22" stroke="white" stroke-width="1.6"/></svg>
                    Pay Fine Online
                </a>
            </c:if>
        </div>

        <!-- Quick Actions -->
        <div class="panel-card">
            <h3 class="panel-card__title">Quick Actions</h3>
            <div class="quick-actions">
                <a href="${pageContext.request.contextPath}/student/books" class="quick-action-btn">
                    <span class="quick-action-btn__icon quick-action-btn__icon--blue">
                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none"><path d="M4 19.5C4 18.5717 4.15224 17.7426 5.24264 16.6522C7 16.5 7 16.5 7 16.5H17" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/><path d="M6 4.5H17C18.3925 4.5 20 5.57165 20 7.5V19.5H6V4.5Z" stroke="currentColor" stroke-width="1.6" stroke-linejoin="round"/></svg>
                    </span>
                    Browse Books
                </a>
                <a href="${pageContext.request.contextPath}/student/reservations" class="quick-action-btn">
                    <span class="quick-action-btn__icon quick-action-btn__icon--green">
                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none"><rect x="3" y="4" width="18" height="18" rx="2" stroke="currentColor" stroke-width="1.6"/><path d="M16 2V6M8 2V6M3 10H21" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/></svg>
                    </span>
                    Reserve Book
                </a>
                <a href="${pageContext.request.contextPath}/student/history" class="quick-action-btn">
                    <span class="quick-action-btn__icon quick-action-btn__icon--purple">
                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none"><circle cx="12" cy="12" r="9" stroke="currentColor" stroke-width="1.6"/><path d="M12 7V12L15 15" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/></svg>
                    </span>
                    My History
                </a>
                <a href="${pageContext.request.contextPath}/student/download-receipt" class="quick-action-btn">
                    <span class="quick-action-btn__icon quick-action-btn__icon--orange">
                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none"><path d="M12 15L12 3M12 15L8 11M12 15L16 11" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/><path d="M3 17V19C3 20.1 3.9 21 5 21H19C20.1 21 21 20.1 21 19V17" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/></svg>
                    </span>
                    Download Receipt
                </a>
            </div>
        </div>

        <!-- Recent Notifications -->
        <div class="panel-card">
            <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:12px;">
                <h3 class="panel-card__title" style="margin-bottom:0;">Recent Notifications</h3>
                <a href="#" style="font-size:12px; font-weight:600; color: var(--brand-blue);">View all</a>
            </div>
            <div class="notif-item">
                <div class="notif-item__icon notif-item__icon--success">
                    <svg width="13" height="13" viewBox="0 0 24 24" fill="none"><path d="M9 12L11 14L15 10M12 3C7.02944 3 3 7.02944 3 12C3 16.9706 7.02944 21 12 21C16.9706 21 21 16.9706 21 12C21 7.02944 16.9706 3 12 3Z" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/></svg>
                </div>
                <div>
                    <p class="notif-item__text">Welcome to BookFlow! Start browsing books.</p>
                    <p class="notif-item__time">Just now</p>
                </div>
            </div>
        </div>

    </aside>

</div>

<script src="${pageContext.request.contextPath}/js/theme.js"></script>
</body>
</html>
