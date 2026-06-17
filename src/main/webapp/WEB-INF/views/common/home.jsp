<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BookFlow — Online Library Management System</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600;700&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bookflow.css">
</head>
<body>

<!-- ============ Navbar ============ -->
<header class="navbar">
    <a href="${pageContext.request.contextPath}/" class="navbar__brand">
        <span class="navbar__logo-icon">
            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M4 4.5C4 3.67 4.67 3 5.5 3H11V21H5.5C4.67 21 4 20.33 4 19.5V4.5Z" fill="currentColor" opacity="0.85"/>
                <path d="M20 4.5C20 3.67 19.33 3 18.5 3H13V21H18.5C19.33 21 20 20.33 20 19.5V4.5Z" fill="currentColor" opacity="0.5"/>
            </svg>
        </span>
        <div>
            <div class="navbar__title">Book<span>Flow</span></div>
            <div class="navbar__subtitle">Online Library Management System</div>
        </div>
    </a>

    <nav class="navbar__links">
        <a href="${pageContext.request.contextPath}/" class="navbar__link navbar__link--active">Home</a>
        <a href="#about" class="navbar__link">About</a>
        <a href="#features" class="navbar__link">Features</a>
        <a href="#modules" class="navbar__link">Modules</a>
        <a href="#contact" class="navbar__link">Contact</a>
    </nav>

    <div class="navbar__right">
        <button class="theme-toggle" data-theme-toggle role="switch" aria-checked="false" aria-label="Toggle dark mode" tabindex="0">
            <span class="theme-toggle__track">
                <span class="theme-toggle__thumb">
                    <svg class="icon-sun" width="11" height="11" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <circle cx="12" cy="12" r="4" stroke="currentColor" stroke-width="2"/>
                        <path d="M12 2V5M12 19V22M4.22 4.22L6.34 6.34M17.66 17.66L19.78 19.78M2 12H5M19 12H22M4.22 19.78L6.34 17.66M17.66 6.34L19.78 4.22" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
                    </svg>
                    <svg class="icon-moon" width="11" height="11" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style="display:none;">
                        <path d="M21 12.79A9 9 0 1111.21 3 7 7 0 0021 12.79Z" stroke="currentColor" stroke-width="2" stroke-linejoin="round"/>
                    </svg>
                </span>
            </span>
        </button>
        <a href="${pageContext.request.contextPath}/auth/login" class="btn-login">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M12 12C14.7614 12 17 9.76142 17 7C17 4.23858 14.7614 2 12 2C9.23858 2 7 4.23858 7 7C7 9.76142 9.23858 12 12 12Z" stroke="white" stroke-width="1.6"/>
                <path d="M20.5899 22C20.5899 18.13 16.7399 15 11.9999 15C7.25991 15 3.40991 18.13 3.40991 22" stroke="white" stroke-width="1.6" stroke-linecap="round"/>
            </svg>
            Login
        </a>
    </div>
</header>

<!-- ============ Hero ============ -->
<section class="hero">
    <div class="hero__bg"></div>
    <div class="hero__content">
        <p class="hero__eyebrow">Smart Library. Seamless Experience.</p>
        <h1 class="hero__title">Manage. Organize.<br>Inspire with <span class="accent">Books.</span></h1>
        <p class="hero__desc">
            BookFlow is a role-based Online Library Management System built to simplify
            library operations, enhance user experience, and promote a culture of reading.
        </p>
        <div class="hero__actions">
            <a href="${pageContext.request.contextPath}/auth/login" class="btn btn-primary">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M12 12C14.7614 12 17 9.76142 17 7C17 4.23858 14.7614 2 12 2C9.23858 2 7 4.23858 7 7C7 9.76142 9.23858 12 12 12Z" stroke="white" stroke-width="1.6"/>
                    <path d="M20.5899 22C20.5899 18.13 16.7399 15 11.9999 15C7.25991 15 3.40991 18.13 3.40991 22" stroke="white" stroke-width="1.6" stroke-linecap="round"/>
                </svg>
                Login to Your Account
            </a>
            <a href="#features" class="btn btn-outline">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M4 4.5C4 3.67 4.67 3 5.5 3H11V21H5.5C4.67 21 4 20.33 4 19.5V4.5Z" stroke="currentColor" stroke-width="1.6" stroke-linejoin="round"/>
                    <path d="M20 4.5C20 3.67 19.33 3 18.5 3H13V21H18.5C19.33 21 20 20.33 20 19.5V4.5Z" stroke="currentColor" stroke-width="1.6" stroke-linejoin="round"/>
                </svg>
                Explore Features
            </a>
        </div>
    </div>
</section>

<!-- ============ Feature Cards ============ -->
<section class="features" id="features">
    <div class="feature-card">
        <div class="feature-card__icon feature-card__icon--blue">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M17 21V19C17 17.9391 16.5786 16.9217 15.8284 16.1716C15.0783 15.4214 14.0609 15 13 15H5C3.93913 15 2.92172 15.4214 2.17157 16.1716C1.42143 16.9217 1 17.9391 1 19V21" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"/>
                <path d="M9 11C11.2091 11 13 9.20914 13 7C13 4.79086 11.2091 3 9 3C6.79086 3 5 4.79086 5 7C5 9.20914 6.79086 11 9 11Z" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"/>
                <path d="M23 21V19C22.9993 18.1137 22.7044 17.2528 22.1614 16.5523C21.6184 15.8519 20.8581 15.3516 20 15.13" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"/>
                <path d="M16 3.13C16.8604 3.3503 17.623 3.8507 18.1676 4.55231C18.7122 5.25392 19.0078 6.11683 19.0078 7.005C19.0078 7.89317 18.7122 8.75608 18.1676 9.45769C17.623 10.1593 16.8604 10.6597 16 10.88" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
        </div>
        <h3 class="feature-card__title">Role Based Access</h3>
        <p class="feature-card__desc">
            Secure dashboards and modules for Admin, Librarian and Students with specific permissions.
        </p>
        <a href="#" class="feature-card__link">
            Learn More
            <svg width="13" height="13" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M5 12H19M19 12L12 5M19 12L12 19" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
        </a>
    </div>

    <div class="feature-card">
        <div class="feature-card__icon feature-card__icon--green">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M4 19.5C4 18.5717 4 18.1075 4.15224 17.7426C4.35523 17.2493 4.74935 16.8552 5.24264 16.6522C5.6075 16.5 6.07165 16.5 7 16.5H17C17.9284 16.5 18.3925 16.5 18.7574 16.6522C19.2506 16.8552 19.6448 17.2493 19.8478 17.7426C20 18.1075 20 18.5717 20 19.5" stroke="currentColor" stroke-width="1.7" stroke-linecap="round"/>
                <path d="M6 4.5C6 3.5717 6 3.10751 6.15224 2.74264C6.35523 2.24935 6.74935 1.85523 7.24264 1.65224C7.6075 1.5 8.07165 1.5 9 1.5H15C15.9284 1.5 16.3925 1.5 16.7574 1.65224C17.2506 1.85523 17.6448 2.24935 17.8478 2.74264C18 3.10751 18 3.5717 18 4.5V16.5H6V4.5Z" stroke="currentColor" stroke-width="1.7" stroke-linejoin="round"/>
                <path d="M9 5.5H15M9 9H15M9 12.5H13" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/>
            </svg>
        </div>
        <h3 class="feature-card__title">Smart Management</h3>
        <p class="feature-card__desc">
            Manage books, members, issues, returns, fines, reservations and much more in one place.
        </p>
        <a href="#" class="feature-card__link">
            Learn More
            <svg width="13" height="13" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M5 12H19M19 12L12 5M19 12L12 19" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
        </a>
    </div>

    <div class="feature-card">
        <div class="feature-card__icon feature-card__icon--purple">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M12 2L14.5 8.5L21 11L14.5 13.5L12 20L9.5 13.5L3 11L9.5 8.5L12 2Z" stroke="currentColor" stroke-width="1.6" stroke-linejoin="round"/>
                <path d="M19 2.5L19.7 4.3L21.5 5L19.7 5.7L19 7.5L18.3 5.7L16.5 5L18.3 4.3L19 2.5Z" fill="currentColor"/>
            </svg>
        </div>
        <h3 class="feature-card__title">AI Recommendations</h3>
        <p class="feature-card__desc">
            Get AI-powered book recommendations based on your reading history.
        </p>
        <a href="#" class="feature-card__link">
            Learn More
            <svg width="13" height="13" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M5 12H19M19 12L12 5M19 12L12 19" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
        </a>
    </div>
</section>

<!-- ============ System Overview ============ -->
<section class="overview">
    <div class="overview__header">
        <div>
            <h2 class="overview__title">System Overview</h2>
            <p class="overview__subtitle">Real-time overview of your library</p>
        </div>
        <a href="${pageContext.request.contextPath}/auth/login" class="overview__cta">View Dashboard</a>
    </div>

    <div class="overview__grid">
        <div class="stat-card">
            <div class="stat-card__icon stat-card__icon--blue">
                <svg width="17" height="17" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M4 19.5C4 18.5717 4 18.1075 4.15224 17.7426C4.35523 17.2493 4.74935 16.8552 5.24264 16.6522C5.6075 16.5 6.07165 16.5 7 16.5H17C17.9284 16.5 18.3925 16.5 18.7574 16.6522C19.2506 16.8552 19.6448 17.2493 19.8478 17.7426C20 18.1075 20 18.5717 20 19.5" stroke="currentColor" stroke-width="1.7" stroke-linecap="round"/>
                    <path d="M6 4.5C6 3.5717 6 3.10751 6.15224 2.74264C6.35523 2.24935 6.74935 1.85523 7.24264 1.65224C7.6075 1.5 8.07165 1.5 9 1.5H15C15.9284 1.5 16.3925 1.5 16.7574 1.65224C17.2506 1.85523 17.6448 2.24935 17.8478 2.74264C18 3.10751 18 3.5717 18 4.5V16.5H6V4.5Z" stroke="currentColor" stroke-width="1.7" stroke-linejoin="round"/>
                </svg>
            </div>
            <div>
                <p class="stat-card__label">Total Books</p>
                <p class="stat-card__value">${totalBooks != null ? totalBooks : '—'}</p>
                <a href="#" class="stat-card__link">View all books →</a>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-card__icon stat-card__icon--green">
                <svg width="17" height="17" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M17 21V19C17 17.9391 16.5786 16.9217 15.8284 16.1716C15.0783 15.4214 14.0609 15 13 15H5C3.93913 15 2.92172 15.4214 2.17157 16.1716C1.42143 16.9217 1 17.9391 1 19V21" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M9 11C11.2091 11 13 9.20914 13 7C13 4.79086 11.2091 3 9 3C6.79086 3 5 4.79086 5 7C5 9.20914 6.79086 11 9 11Z" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </div>
            <div>
                <p class="stat-card__label">Total Members</p>
                <p class="stat-card__value">${totalMembers != null ? totalMembers : '—'}</p>
                <a href="#" class="stat-card__link">View all members →</a>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-card__icon stat-card__icon--orange">
                <svg width="17" height="17" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M9 2H15M12 2V6" stroke="currentColor" stroke-width="1.7" stroke-linecap="round"/>
                    <rect x="4" y="6" width="16" height="16" rx="2" stroke="currentColor" stroke-width="1.7"/>
                    <path d="M8 12H16M8 16H13" stroke="currentColor" stroke-width="1.7" stroke-linecap="round"/>
                </svg>
            </div>
            <div>
                <p class="stat-card__label">Books Issued Today</p>
                <p class="stat-card__value">${booksIssuedToday != null ? booksIssuedToday : '—'}</p>
                <a href="#" class="stat-card__link">View transactions →</a>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-card__icon stat-card__icon--purple">
                <svg width="17" height="17" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M12 2V22M17 5H9.5C8.567 5 7.672 5.369 7.005 6.034C6.339 6.7 5.97 7.595 5.97 8.528C5.97 9.461 6.339 10.357 7.005 11.022C7.672 11.687 8.567 12.056 9.5 12.056H14.5C15.433 12.056 16.328 12.426 16.995 13.091C17.661 13.756 18.03 14.652 18.03 15.585C18.03 16.518 17.661 17.413 16.995 18.079C16.328 18.744 15.433 19.113 14.5 19.113H6" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </div>
            <div>
                <p class="stat-card__label">Total Fines Collected</p>
                <p class="stat-card__value">₹${totalFinesCollected != null ? totalFinesCollected : '0'}</p>
                <a href="#" class="stat-card__link">View details →</a>
            </div>
        </div>
    </div>
</section>

<!-- ============ Footer ============ -->
<footer class="footer" id="contact">
    <div class="footer__grid">
        <div>
            <a href="${pageContext.request.contextPath}/" class="navbar__brand" style="margin-bottom: 4px;">
                <span class="navbar__logo-icon">
                    <svg width="22" height="22" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M4 4.5C4 3.67 4.67 3 5.5 3H11V21H5.5C4.67 21 4 20.33 4 19.5V4.5Z" fill="currentColor" opacity="0.85"/>
                        <path d="M20 4.5C20 3.67 19.33 3 18.5 3H13V21H18.5C19.33 21 20 20.33 20 19.5V4.5Z" fill="currentColor" opacity="0.5"/>
                    </svg>
                </span>
                <div>
                    <div class="navbar__title">Book<span>Flow</span></div>
                    <div class="navbar__subtitle">Online Library Management System</div>
                </div>
            </a>
            <p class="footer__brand-desc">
                Empowering libraries, enabling learners, and inspiring a lifelong love for reading.
            </p>
            <div class="footer__social">
                <a href="#" aria-label="Facebook">
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                        <path d="M22 12.06C22 6.51 17.52 2 12 2C6.48 2 2 6.51 2 12.06C2 17.06 5.66 21.21 10.44 21.94V14.89H7.9V12.06H10.44V9.91C10.44 7.39 11.93 6 14.21 6C15.31 6 16.46 6.2 16.46 6.2V8.74H15.19C13.95 8.74 13.56 9.5 13.56 10.29V12.06H16.34L15.89 14.89H13.56V21.94C18.34 21.21 22 17.06 22 12.06Z"/>
                    </svg>
                </a>
                <a href="#" aria-label="Twitter/X">
                    <svg width="13" height="13" viewBox="0 0 24 24" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                        <path d="M18.9 1.5H22.6L14.6 10.6L24 22.5H16.6L10.8 15.1L4.2 22.5H0.5L9 12.8L0 1.5H7.6L12.8 8.3L18.9 1.5ZM17.6 20.3H19.6L6.5 3.6H4.3L17.6 20.3Z"/>
                    </svg>
                </a>
                <a href="#" aria-label="LinkedIn">
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                        <path d="M19 3A2 2 0 0121 5V19A2 2 0 0119 21H5A2 2 0 013 19V5A2 2 0 015 3H19ZM18.5 18.5V13.2C18.5 11.4 17.3 10.4 15.6 10.4C14.9 10.4 14.1 10.7 13.7 11.4V10.6H10.9V18.5H13.7V13.6C13.7 12.9 14.2 12.4 14.9 12.4C15.6 12.4 16 12.9 16 13.6V18.5H18.5ZM7.8 9C8.7 9 9.4 8.3 9.4 7.5C9.4 6.6 8.7 6 7.8 6C6.9 6 6.2 6.7 6.2 7.5C6.2 8.3 6.9 9 7.8 9ZM9.2 18.5V10.6H6.4V18.5H9.2Z"/>
                    </svg>
                </a>
                <a href="#" aria-label="GitHub">
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                        <path d="M12 2C6.48 2 2 6.58 2 12.25C2 16.77 4.87 20.6 8.84 21.96C9.34 22.06 9.5 21.74 9.5 21.46C9.5 21.21 9.49 20.32 9.49 19.36C7 19.86 6.35 18.78 6.15 18.21C6.04 17.92 5.55 16.99 5.12 16.74C4.77 16.55 4.27 16.05 5.11 16.04C5.9 16.03 6.45 16.77 6.64 17.07C7.5 18.5 8.84 18.11 9.36 17.84C9.45 17.19 9.72 16.75 10.02 16.5C7.65 16.25 5.18 15.31 5.18 11.45C5.18 10.36 5.55 9.46 6.66 8.78C6.48 8.53 6.13 7.5 6.77 6.15C6.77 6.15 7.65 5.89 9.51 7.13C10.27 6.92 11.08 6.81 11.89 6.81C12.7 6.81 13.51 6.92 14.27 7.13C16.13 5.88 17.01 6.15 17.01 6.15C17.65 7.5 17.3 8.53 17.12 8.78C18.23 9.47 18.6 10.35 18.6 11.45C18.6 15.32 16.12 16.25 13.75 16.5C14.13 16.81 14.46 17.42 14.46 18.36C14.46 19.71 14.45 21.1 14.45 21.46C14.45 21.74 14.62 22.07 15.11 21.96C17.0834 21.2663 18.7929 19.9888 20.0099 18.2956C21.2268 16.6024 21.8964 14.5749 21.93 12.49C21.93 6.58 17.45 2 12 2Z"/>
                    </svg>
                </a>
            </div>
        </div>

        <div class="footer__col">
            <p class="footer__col-title">Quick Links</p>
            <a href="${pageContext.request.contextPath}/">Home</a>
            <a href="#about">About Us</a>
            <a href="#features">Features</a>
            <a href="#modules">Modules</a>
            <a href="#contact">Contact</a>
        </div>

        <div class="footer__col">
            <p class="footer__col-title">Modules</p>
            <a href="${pageContext.request.contextPath}/admin/dashboard">Admin</a>
            <a href="${pageContext.request.contextPath}/librarian/dashboard">Librarian</a>
            <a href="${pageContext.request.contextPath}/student/dashboard">Student</a>
            <a href="#">Catalogue</a>
            <a href="#">Reports</a>
        </div>

        <div class="footer__col">
            <p class="footer__col-title">Support</p>
            <a href="#">Help Center</a>
            <a href="#">User Guide</a>
            <a href="#">FAQs</a>
            <a href="#">Privacy Policy</a>
            <a href="#">Terms &amp; Conditions</a>
        </div>

        <div class="footer__col">
            <p class="footer__col-title">Contact Us</p>
            <p>support@bookflow.com</p>
            <p>+91 98765 43210</p>
            <p>123 Library Street,<br>Knowledge City, India</p>
        </div>
    </div>

    <div class="footer__bottom">
        © 2026 BookFlow. All rights reserved.
    </div>
</footer>

<script src="${pageContext.request.contextPath}/js/theme.js"></script>
</body>
</html>
