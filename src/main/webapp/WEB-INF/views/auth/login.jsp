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
                        <span class="form-input-wrap__icon">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M12 12C14.7614 12 17 9.76142 17 7C17 4.23858 14.7614 2 12 2C9.23858 2 7 4.23858 7 7C7 9.76142 9.23858 12 12 12Z" stroke="currentColor" stroke-width="1.6"/>
                                <path d="M20.5899 22C20.5899 18.13 16.7399 15 11.9999 15C7.25991 15 3.40991 18.13 3.40991 22" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/>
                            </svg>
                        </span>
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
                        <span class="form-input-wrap__icon">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <rect x="4" y="11" width="16" height="10" rx="2" stroke="currentColor" stroke-width="1.6"/>
                                <path d="M8 11V7C8 4.79086 9.79086 3 12 3C14.2091 3 16 4.79086 16 7V11" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/>
                            </svg>
                        </span>
                        <input
                            type="password"
                            id="password"
                            name="password"
                            class="form-input"
                            placeholder="Enter your password"
                            autocomplete="current-password"
                            required
                        >
                        <button type="button" class="form-input-toggle" data-toggle-password="password" aria-label="Show password">
                            <svg class="icon-eye-open" width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M2 12C2 12 5.5 5 12 5C18.5 5 22 12 22 12C22 12 18.5 19 12 19C5.5 19 2 12 2 12Z" stroke="currentColor" stroke-width="1.6" stroke-linejoin="round"/>
                                <circle cx="12" cy="12" r="3" stroke="currentColor" stroke-width="1.6"/>
                            </svg>
                            <svg class="icon-eye-closed" width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style="display:none;">
                                <path d="M3 3L21 21" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/>
                                <path d="M10.6 6.2C11.05 6.07 11.52 6 12 6C18.5 6 22 12 22 12C21.5 12.9 20.7 14.1 19.6 15.2M6.5 7.5C4.6 8.9 3.2 10.7 2 12C2 12 5.5 19 12 19C13.4 19 14.6 18.7 15.7 18.2" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/>
                                <path d="M9.9 9.9C9.34 10.46 9 11.19 9 12C9 13.66 10.34 15 12 15C12.81 15 13.54 14.66 14.1 14.1" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/>
                            </svg>
                        </button>
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
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M15 3H19C19.5304 3 20.0391 3.21071 20.4142 3.58579C20.7893 3.96086 21 4.46957 21 5V19C21 19.5304 20.7893 20.0391 20.4142 20.4142C20.0391 20.7893 19.5304 21 19 21H15" stroke="white" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M10 17L15 12L10 7" stroke="white" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M15 12H3" stroke="white" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    Login
                </button>
            </form>

            <p class="auth-page__footer-text">
                Don't have an account?
                <a href="${pageContext.request.contextPath}/auth/register" class="form-link">Register here</a>
            </p>

            <div class="auth-page__secure-note">
                <span>
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M12 2L4 5V11C4 16.55 7.84 21.74 12 23C16.16 21.74 20 16.55 20 11V5L12 2Z" stroke="currentColor" stroke-width="1.5" stroke-linejoin="round"/>
                        <path d="M9.5 12L11.5 14L15 10" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </span>
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
            <div class="quote-card__mark">
                <svg width="32" height="24" viewBox="0 0 32 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M0 24V14.4C0 9.6 1.067 6.133 3.2 4C5.333 1.867 8.267 0.533 12 0L13.6 3.2C11.2 3.733 9.333 4.667 8 6C6.667 7.333 6 8.933 6 10.8H12V24H0ZM18 24V14.4C18 9.6 19.067 6.133 21.2 4C23.333 1.867 26.267 0.533 30 0L31.6 3.2C29.2 3.733 27.333 4.667 26 6C24.667 7.333 24 8.933 24 10.8H30V24H18Z" fill="var(--brand-blue)"/>
                </svg>
            </div>
            <p class="quote-card__text">A library is not a luxury but one of the necessities of life.</p>
            <p class="quote-card__author">— Henry Ward Beecher</p>
        </div>
    </div>

</div>

<script src="${pageContext.request.contextPath}/js/theme.js"></script>
<script src="${pageContext.request.contextPath}/js/password-toggle.js"></script>
</body>
</html>
