<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register — BookFlow</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600;700&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bookflow.css">
</head>
<body>

<div class="auth-page">

    <!-- ============ Form side ============ -->
    <div class="auth-page__form-side">
        <div style="max-width: 440px; width: 100%; margin: 0 auto;">

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

            <h1 class="auth-page__title">Create Your Account</h1>
            <p class="auth-page__subtitle">Fill in your details to get started</p>

            <c:if test="${not empty errorMessage}">
                <div class="alert alert-error">${errorMessage}</div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/auth/register" id="registerForm">
                <c:if test="${not empty _csrf}">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                </c:if>

                <div class="form-row-2col">
                    <div class="form-group">
                        <label class="form-label" for="firstName">First Name</label>
                        <div class="form-input-wrap">
                            <span class="form-input-wrap__icon">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M12 12C14.7614 12 17 9.76142 17 7C17 4.23858 14.7614 2 12 2C9.23858 2 7 4.23858 7 7C7 9.76142 9.23858 12 12 12Z" stroke="currentColor" stroke-width="1.6"/>
                                    <path d="M20.5899 22C20.5899 18.13 16.7399 15 11.9999 15C7.25991 15 3.40991 18.13 3.40991 22" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/>
                                </svg>
                            </span>
                            <input
                                type="text"
                                id="firstName"
                                name="firstName"
                                class="form-input"
                                placeholder="Enter first name"
                                value="${registrationRequest.firstName}"
                                required
                                autofocus
                            >
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="lastName">Last Name</label>
                        <div class="form-input-wrap">
                            <span class="form-input-wrap__icon">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M12 12C14.7614 12 17 9.76142 17 7C17 4.23858 14.7614 2 12 2C9.23858 2 7 4.23858 7 7C7 9.76142 9.23858 12 12 12Z" stroke="currentColor" stroke-width="1.6"/>
                                    <path d="M20.5899 22C20.5899 18.13 16.7399 15 11.9999 15C7.25991 15 3.40991 18.13 3.40991 22" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/>
                                </svg>
                            </span>
                            <input
                                type="text"
                                id="lastName"
                                name="lastName"
                                class="form-input"
                                placeholder="Enter last name"
                                value="${registrationRequest.lastName}"
                                required
                            >
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label">System ID will be generated automatically</label>
                    <div class="form-input-wrap">
                        <span class="form-input-wrap__icon">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <rect x="3" y="5" width="18" height="14" rx="2" stroke="currentColor" stroke-width="1.6"/>
                                <path d="M3 9H21" stroke="currentColor" stroke-width="1.6"/>
                                <path d="M7 13H11" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/>
                            </svg>
                        </span>
                        <input
                            type="text"
                            class="form-input"
                            value="FIRSTNAME + 6 DIGITS + ROLE CODE"
                            disabled
                            style="color: var(--text-muted); cursor: not-allowed;"
                        >
                    </div>
                </div>

                <div class="form-row-2col">
                    <div class="form-group">
                        <label class="form-label" for="email">Email</label>
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
                                placeholder="Enter your email"
                                value="${registrationRequest.email}"
                                required
                            >
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="phone">Phone Number</label>
                        <div class="form-input-wrap">
                            <span class="form-input-wrap__icon">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M3 5C3 3.9 3.9 3 5 3H8L10 8L7.5 9.5C8.6 11.7 10.3 13.4 12.5 14.5L14 12L19 14V17C19 18.1 18.1 19 17 19H16C8.8 19 3 13.2 3 6V5Z" stroke="currentColor" stroke-width="1.6" stroke-linejoin="round"/>
                                </svg>
                            </span>
                            <input
                                type="tel"
                                id="phone"
                                name="phone"
                                class="form-input"
                                placeholder="Enter your phone number"
                                value="${registrationRequest.phone}"
                                pattern="[6-9][0-9]{9}"
                                title="Enter a valid 10-digit phone number"
                                required
                            >
                        </div>
                    </div>
                </div>

                <div class="form-row-2col">
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
                                placeholder="Create password"
                                autocomplete="new-password"
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

                    <div class="form-group">
                        <label class="form-label" for="confirmPassword">Confirm Password</label>
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
                                placeholder="Confirm password"
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
                </div>

                <p id="passwordHint" style="font-size: 12px; color: var(--text-muted); margin: -10px 0 16px 2px;">
                    Password rules depend on the role selected below.
                </p>

                <div class="form-group">
                    <label class="form-label" for="role">Select Role</label>
                    <div class="form-input-wrap">
                        <select id="role" name="role" class="form-input" style="padding-left: 14px;" required>
                            <option value="" disabled selected>-- Select Role --</option>
                            <c:forEach var="r" items="${roles}">
                                <option value="${r}">
                                    <c:choose>
                                        <c:when test="${r == 'ADM'}">Admin</c:when>
                                        <c:when test="${r == 'LIB'}">Librarian</c:when>
                                        <c:when test="${r == 'STU'}">Student</c:when>
                                        <c:otherwise>${r}</c:otherwise>
                                    </c:choose>
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <label class="form-checkbox" style="margin-bottom: 22px; align-items: flex-start;">
                    <input type="checkbox" name="agreedToTerms" required style="margin-top: 2px;">
                    <span>I agree to the <a href="#" class="form-link">Terms &amp; Conditions</a> and <a href="#" class="form-link">Privacy Policy</a></span>
                </label>

                <button type="submit" class="btn btn-primary btn-block">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M16 21V19C16 17.9391 15.5786 16.9217 14.8284 16.1716C14.0783 15.4214 13.0609 15 12 15H5C3.93913 15 2.92172 15.4214 2.17157 16.1716C1.42143 16.9217 1 17.9391 1 19V21" stroke="white" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M8.5 11C10.7091 11 12.5 9.20914 12.5 7C12.5 4.79086 10.7091 3 8.5 3C6.29086 3 4.5 4.79086 4.5 7C4.5 9.20914 6.29086 11 8.5 11Z" stroke="white" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M19 8V14M22 11H16" stroke="white" stroke-width="1.6" stroke-linecap="round"/>
                    </svg>
                    Register
                </button>
            </form>

            <p class="auth-page__footer-text">
                Already have an account?
                <a href="${pageContext.request.contextPath}/auth/login" class="form-link">Login here</a>
            </p>
        </div>
    </div>

    <!-- ============ Visual side ============ -->
    <div class="auth-page__visual-side">
        <div class="quote-card" style="max-width: 340px;">
            <p class="quote-card__author" style="color: var(--brand-green); font-weight: 700; font-size: 16px; margin-bottom: 16px;">Join BookFlow Today!</p>

            <div style="display: flex; flex-direction: column; gap: 16px;">
                <div style="display: flex; align-items: flex-start; gap: 12px;">
                    <span class="feature-card__icon feature-card__icon--green" style="width: 32px; height: 32px; margin-bottom: 0; flex-shrink: 0;">
                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M4 4.5C4 3.67 4.67 3 5.5 3H11V21H5.5C4.67 21 4 20.33 4 19.5V4.5Z" stroke="currentColor" stroke-width="1.6" stroke-linejoin="round"/>
                            <path d="M20 4.5C20 3.67 19.33 3 18.5 3H13V21H18.5C19.33 21 20 20.33 20 19.5V4.5Z" stroke="currentColor" stroke-width="1.6" stroke-linejoin="round"/>
                        </svg>
                    </span>
                    <p class="quote-card__text" style="font-size: 13.5px; margin: 0;">Manage your library activities seamlessly</p>
                </div>

                <div style="display: flex; align-items: flex-start; gap: 12px;">
                    <span class="feature-card__icon feature-card__icon--blue" style="width: 32px; height: 32px; margin-bottom: 0; flex-shrink: 0;">
                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M4 19V5C4 3.9 4.9 3 6 3H18C19.1 3 20 3.9 20 5V19" stroke="currentColor" stroke-width="1.6" stroke-linejoin="round"/>
                            <path d="M4 19H20M8 7H16M8 11H16" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/>
                        </svg>
                    </span>
                    <p class="quote-card__text" style="font-size: 13.5px; margin: 0;">Access a vast collection of books</p>
                </div>

                <div style="display: flex; align-items: flex-start; gap: 12px;">
                    <span class="feature-card__icon feature-card__icon--orange" style="width: 32px; height: 32px; margin-bottom: 0; flex-shrink: 0;">
                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M9 11L12 14L22 4" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M21 12V19C21 19.5304 20.7893 20.0391 20.4142 20.4142C20.0391 20.7893 19.5304 21 19 21H5C4.46957 21 3.96086 20.7893 3.58579 20.4142C3.21071 20.0391 3 19.5304 3 19V5C3 4.46957 3.21071 3.96086 3.58579 3.58579C3.96086 3.21071 4.46957 3 5 3H16" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                    </span>
                    <p class="quote-card__text" style="font-size: 13.5px; margin: 0;">Track issued &amp; returned books</p>
                </div>

                <div style="display: flex; align-items: flex-start; gap: 12px;">
                    <span class="feature-card__icon feature-card__icon--purple" style="width: 32px; height: 32px; margin-bottom: 0; flex-shrink: 0;">
                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M12 2L14.5 8.5L21 11L14.5 13.5L12 20L9.5 13.5L3 11L9.5 8.5L12 2Z" stroke="currentColor" stroke-width="1.6" stroke-linejoin="round"/>
                        </svg>
                    </span>
                    <p class="quote-card__text" style="font-size: 13.5px; margin: 0;">Get AI-powered book recommendations</p>
                </div>
            </div>
        </div>
    </div>

</div>

<script src="${pageContext.request.contextPath}/js/theme.js"></script>
<script src="${pageContext.request.contextPath}/js/password-toggle.js"></script>
</body>
</html>
