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
                <span class="theme-toggle__thumb">☀️</span>
            </span>
        </button>
        <a href="${pageContext.request.contextPath}/auth/login" class="btn-login">
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
                Login to Your Account
            </a>
            <a href="#features" class="btn btn-outline">
                Explore Features
            </a>
        </div>
    </div>
</section>

<!-- ============ Feature Cards ============ -->
<section class="features" id="features">
    <div class="feature-card">
        <div class="feature-card__icon feature-card__icon--blue">👥</div>
        <h3 class="feature-card__title">Role Based Access</h3>
        <p class="feature-card__desc">
            Secure dashboards and modules for Admin, Librarian and Students with specific permissions.
        </p>
        <a href="#" class="feature-card__link">Learn More →</a>
    </div>

    <div class="feature-card">
        <div class="feature-card__icon feature-card__icon--green">📖</div>
        <h3 class="feature-card__title">Smart Management</h3>
        <p class="feature-card__desc">
            Manage books, members, issues, returns, fines, reservations and much more in one place.
        </p>
        <a href="#" class="feature-card__link">Learn More →</a>
    </div>

    <div class="feature-card">
        <div class="feature-card__icon feature-card__icon--purple">✨</div>
        <h3 class="feature-card__title">AI Recommendations</h3>
        <p class="feature-card__desc">
            Get AI-powered book recommendations based on your reading history.
        </p>
        <a href="#" class="feature-card__link">Learn More →</a>
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
            <div class="stat-card__icon stat-card__icon--blue">📚</div>
            <div>
                <p class="stat-card__label">Total Books</p>
                <p class="stat-card__value">${totalBooks != null ? totalBooks : '—'}</p>
                <a href="#" class="stat-card__link">View all books →</a>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-card__icon stat-card__icon--green">👥</div>
            <div>
                <p class="stat-card__label">Total Members</p>
                <p class="stat-card__value">${totalMembers != null ? totalMembers : '—'}</p>
                <a href="#" class="stat-card__link">View all members →</a>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-card__icon stat-card__icon--orange">📋</div>
            <div>
                <p class="stat-card__label">Books Issued Today</p>
                <p class="stat-card__value">${booksIssuedToday != null ? booksIssuedToday : '—'}</p>
                <a href="#" class="stat-card__link">View transactions →</a>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-card__icon stat-card__icon--purple">₹</div>
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
                <a href="#" aria-label="Facebook">f</a>
                <a href="#" aria-label="Twitter">𝕏</a>
                <a href="#" aria-label="LinkedIn">in</a>
                <a href="#" aria-label="GitHub">gh</a>
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
