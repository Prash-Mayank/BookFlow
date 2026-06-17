<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login — BookFlow</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600;700&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bookflow.css">
</head>
<body>

<div class="auth-page">

    <!-- ============ Form side ============ -->
    <div class="auth-page__form-side">
        <div style="max-width: 380px; width: 100%; margin: 0 auto;">

            <a href="${pageContext.request.contextPath}/" class="auth-page__brand">
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

            <h1 class="auth-page__title">Welcome Back!</h1>
            <p class="auth-page__subtitle">Sign in to continue to your account</p>

            <c:if test="${not empty errorMessage}">
                <div class="alert alert-error">${errorMessage}</div>
            </c:if>
            <c:if test="${not empty infoMessage}">
                <div class="alert alert-info">${infoMessage}</div>
            </c:if>
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success">${successMessage}</div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/auth/login">
                <c:if test="${not empty _csrf}">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                </c:if>

                <div class="form-group">
                    <label class="form-label" for="systemId">System ID</label>
                    <div class="form-input-wrap">
                        <span class="form-input-wrap__icon">👤</span>
                        <input
                            type="text"
                            id="systemId"
                            name="systemId"
                            class="form-input"
                            placeholder="Enter your system ID"
                            autocomplete="username"
                            required
                            autofocus
                        >
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label" for="password">Password</label>
                    <div class="form-input-wrap">
                        <span class="form-input-wrap__icon">🔒</span>
                        <input
                            type="password"
                            id="password"
                            name="password"
                            class="form-input"
                            placeholder="Enter your password"
                            autocomplete="current-password"
                            required
                        >
                        <button type="button" class="form-input-toggle" data-toggle-password="password" aria-label="Show password">👁</button>
                    </div>
                </div>

                <div class="form-row">
                    <label class="form-checkbox">
                        <input type="checkbox" name="remember-me">
                        Remember me
                    </label>
                    <a href="${pageContext.request.contextPath}/auth/forgot-password" class="form-link">Forgot Password?</a>
                </div>

                <button type="submit" class="btn btn-primary btn-block">
                    <span>👤</span> Login
                </button>
            </form>

            <p class="auth-page__footer-text">
                Don't have an account?
                <a href="${pageContext.request.contextPath}/auth/register" class="form-link">Register here</a>
            </p>

            <div class="auth-page__secure-note">
                <span>🛡️</span>
                <div>
                    <strong>Secure Login</strong>
                    Your data is protected with 256-bit SSL encryption
                </div>
            </div>
        </div>
    </div>

    <!-- ============ Visual side ============ -->
    <div class="auth-page__visual-side">
        <div class="quote-card">
            <div class="quote-card__mark">"</div>
            <p class="quote-card__text">A library is not a luxury but one of the necessities of life.</p>
            <p class="quote-card__author">— Henry Ward Beecher</p>
        </div>
    </div>

</div>

<script src="${pageContext.request.contextPath}/js/theme.js"></script>
<script src="${pageContext.request.contextPath}/js/password-toggle.js"></script>
</body>
</html>
