<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password — BookFlow</title>
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
                <c:when test="${submitted}">

                    <!-- ============ Confirmation state ============ -->
                    <div style="width: 56px; height: 56px; border-radius: 50%; background: var(--bg-surface-alt); display: flex; align-items: center; justify-content: center; margin-bottom: 22px; color: var(--brand-green);">
                        <svg width="26" height="26" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <rect x="2" y="4" width="20" height="16" rx="2" stroke="currentColor" stroke-width="1.6"/>
                            <path d="M2 6L11.2 12.8C11.7 13.16 12.3 13.16 12.8 12.8L22 6" stroke="currentColor" stroke-width="1.6" stroke-linejoin="round"/>
                        </svg>
                    </div>

                    <h1 class="auth-page__title">Check Your Email</h1>
                    <p class="auth-page__subtitle">
                        If an account exists for <strong>${submittedEmail}</strong>, we've sent a password
                        reset link. It will expire in 30 minutes.
                    </p>

                    <a href="${pageContext.request.contextPath}/auth/login" class="btn btn-primary btn-block" style="margin-top: 8px;">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M19 12H5M5 12L12 19M5 12L12 5" stroke="white" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        Back to Login
                    </a>

                    <p class="auth-page__footer-text">
                        Didn't get the email?
                        <a href="${pageContext.request.contextPath}/auth/forgot-password" class="form-link">Try again</a>
                    </p>

                </c:when>
                <c:otherwise>

                    <!-- ============ Request form state ============ -->
                    <h1 class="auth-page__title">Forgot Password?</h1>
                    <p class="auth-page__subtitle">Enter your email and we'll send you a link to reset your password.</p>

                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-error">${errorMessage}</div>
                    </c:if>

                    <form method="post" action="${pageContext.request.contextPath}/auth/forgot-password">
                        <c:if test="${not empty _csrf}">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        </c:if>

                        <div class="form-group">
                            <label class="form-label" for="email">Email Address</label>
                            <div class="form-input-wrap">
                                <span class="form-input-wrap__icon">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <rect x="2" y="4" width="20" height="16" rx="2" stroke="currentColor" stroke-width="1.6"/>
                                        <path d="M2 6L11.2 12.8C11.7 13.16 12.3 13.16 12.8 12.8L22 6" stroke="currentColor" stroke-width="1.6" stroke-linejoin="round"/>
                                    </svg>
                                </span>
                                <input
                                    type="email"
                                    id="email"
                                    name="email"
                                    class="form-input"
                                    placeholder="Enter your registered email"
                                    required
                                    autofocus
                                >
                            </div>
                        </div>

                        <button type="submit" class="btn btn-primary btn-block">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <rect x="2" y="4" width="20" height="16" rx="2" stroke="white" stroke-width="1.6"/>
                                <path d="M2 6L11.2 12.8C11.7 13.16 12.3 13.16 12.8 12.8L22 6" stroke="white" stroke-width="1.6" stroke-linejoin="round"/>
                            </svg>
                            Send Reset Link
                        </button>
                    </form>

                    <p class="auth-page__footer-text">
                        Remembered your password?
                        <a href="${pageContext.request.contextPath}/auth/login" class="form-link">Back to Login</a>
                    </p>

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
</body>
</html>
