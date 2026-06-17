<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password — BookFlow</title>
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

            <c:choose>
                <c:when test="${invalidToken}">

                    <!-- ============ Invalid/expired token state ============ -->
                    <div style="width: 56px; height: 56px; border-radius: 50%; background: var(--bg-surface-alt); display: flex; align-items: center; justify-content: center; margin-bottom: 22px; color: #dc2626;">
                        <svg width="26" height="26" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <circle cx="12" cy="12" r="9" stroke="currentColor" stroke-width="1.6"/>
                            <path d="M12 8V13M12 16H12.01" stroke="currentColor" stroke-width="1.8" stroke-linecap="round"/>
                        </svg>
                    </div>

                    <h1 class="auth-page__title">Link Expired</h1>
                    <p class="auth-page__subtitle">${errorMessage}</p>

                    <a href="${pageContext.request.contextPath}/auth/forgot-password" class="btn btn-primary btn-block">
                        Request a New Link
                    </a>

                </c:when>
                <c:otherwise>

                    <!-- ============ Set new password form ============ -->
                    <h1 class="auth-page__title">Set New Password</h1>
                    <p class="auth-page__subtitle">
                        <c:if test="${not empty userFirstName}">Hi ${userFirstName}, </c:if>
                        choose a new password for your account.
                    </p>

                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-error">${errorMessage}</div>
                    </c:if>

                    <form method="post" action="${pageContext.request.contextPath}/auth/reset-password">
                        <c:if test="${not empty _csrf}">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        </c:if>
                        <input type="hidden" name="token" value="${token}"/>

                        <div class="form-group">
                            <label class="form-label" for="password">New Password</label>
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
                                    placeholder="Enter new password"
                                    autocomplete="new-password"
                                    required
                                    autofocus
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

                        <div class="form-group">
                            <label class="form-label" for="confirmPassword">Confirm New Password</label>
                            <div class="form-input-wrap">
                                <span class="form-input-wrap__icon">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <rect x="4" y="11" width="16" height="10" rx="2" stroke="currentColor" stroke-width="1.6"/>
                                        <path d="M8 11V7C8 4.79086 9.79086 3 12 3C14.2091 3 16 4.79086 16 7V11" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/>
                                    </svg>
                                </span>
                                <input
                                    type="password"
                                    id="confirmPassword"
                                    name="confirmPassword"
                                    class="form-input"
                                    placeholder="Confirm new password"
                                    autocomplete="new-password"
                                    required
                                >
                                <button type="button" class="form-input-toggle" data-toggle-password="confirmPassword" aria-label="Show password">
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

                        <button type="submit" class="btn btn-primary btn-block">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M9 11L12 14L22 4" stroke="white" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/>
                                <path d="M21 12V19C21 19.5304 20.7893 20.0391 20.4142 20.4142C20.0391 20.7893 19.5304 21 19 21H5C4.46957 21 3.96086 20.7893 3.58579 20.4142C3.21071 20.0391 3 19.5304 3 19V5C3 4.46957 3.21071 3.96086 3.58579 3.58579C3.96086 3.21071 4.46957 3 5 3H16" stroke="white" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                            Reset Password
                        </button>
                    </form>

                </c:otherwise>
            </c:choose>

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
