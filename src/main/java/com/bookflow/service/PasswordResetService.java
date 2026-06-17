package com.bookflow.service;

import com.bookflow.exception.BookFlowException;
import com.bookflow.model.AuditLog;
import com.bookflow.model.PasswordResetToken;
import com.bookflow.model.User;
import com.bookflow.repository.PasswordResetTokenRepository;
import com.bookflow.repository.UserRepository;
import com.bookflow.util.PasswordPolicy;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.security.SecureRandom;
import java.time.LocalDateTime;
import java.util.Base64;
import java.util.Optional;

@Service
public class PasswordResetService {

    private static final SecureRandom RANDOM = new SecureRandom();

    @Value("${bookflow.password-reset.token-expiry-minutes:30}")
    private int tokenExpiryMinutes;

    @Value("${bookflow.mail.simulate:true}")
    private boolean simulateMail;

    @Value("${bookflow.mail.from:no-reply@bookflow.com}")
    private String mailFrom;

    @Value("${bookflow.app.base-url:http://localhost:8080/bookflow}")
    private String baseUrl;

    private final UserRepository userRepository;
    private final PasswordResetTokenRepository tokenRepository;
    private final AuditLogService auditLogService;
    private final JavaMailSender mailSender;

    public PasswordResetService(UserRepository userRepository,
                                PasswordResetTokenRepository tokenRepository,
                                AuditLogService auditLogService,
                                JavaMailSender mailSender) {
        this.userRepository = userRepository;
        this.tokenRepository = tokenRepository;
        this.auditLogService = auditLogService;
        this.mailSender = mailSender;
    }
    @Transactional
    public void requestReset(String email) {
        Optional<User> userOpt = userRepository.findByEmail(email.trim().toLowerCase());

        if (userOpt.isEmpty()) {
            // Deliberately do nothing further — same response either way at the controller level
            return;
        }

        User user = userOpt.get();

        // Invalidate any previous outstanding tokens for this user
        tokenRepository.deleteAllForUser(user.getSystemId());

        String rawToken = generateToken();

        PasswordResetToken resetToken = PasswordResetToken.builder()
                .token(rawToken)
                .user(user)
                .expiresAt(LocalDateTime.now().plusMinutes(tokenExpiryMinutes))
                .build();

        tokenRepository.save(resetToken);

        String resetLink = baseUrl + "/auth/reset-password?token=" + rawToken;

        sendResetEmail(user, resetLink);

        auditLogService.log(user.getSystemId(), AuditLog.AuditAction.PASSWORD_RESET,
                "Password reset requested — link issued, expires in " + tokenExpiryMinutes + " minutes");
    }

    /** Validates a token without consuming it — used to render the "set new password" form. */
    @Transactional(readOnly = true)
    public PasswordResetToken validateToken(String rawToken) {
        PasswordResetToken token = tokenRepository.findByToken(rawToken)
                .orElseThrow(() -> new BookFlowException("This reset link is invalid."));

        if (!token.isValid()) {
            throw new BookFlowException("This reset link has expired or already been used. Please request a new one.");
        }
        return token;
    }

    /** Consumes the token and sets the new password, validated against the user's role policy. */
    @Transactional
    public void completeReset(String rawToken, String newPassword, String confirmPassword) {
        PasswordResetToken token = validateToken(rawToken);

        if (!newPassword.equals(confirmPassword)) {
            throw new BookFlowException("Password and confirm password do not match");
        }

        User user = token.getUser();
        PasswordPolicy.validate(newPassword, user.getRole());

        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder(
                PasswordPolicy.bcryptStrengthFor(user.getRole())
        );
        user.setPasswordHash(encoder.encode(newPassword));
        user.setFailedLoginAttempts(0);
        user.setStatus(User.UserStatus.ACTIVE);
        userRepository.save(user);

        token.setUsedAt(LocalDateTime.now());
        tokenRepository.save(token);

        auditLogService.log(user.getSystemId(), AuditLog.AuditAction.PASSWORD_RESET,
                "Password reset completed via self-service link");
    }

    // ---- Private helpers ----

    private String generateToken() {
        byte[] bytes = new byte[32];
        RANDOM.nextBytes(bytes);
        return Base64.getUrlEncoder().withoutPadding().encodeToString(bytes);
    }

    private void sendResetEmail(User user, String resetLink) {
        if (simulateMail) {
            // No real SMTP configured yet — log the link so it can be used during development/testing.
            System.out.println("=================================================================");
            System.out.println("BookFlow — SIMULATED password reset email (bookflow.mail.simulate=true)");
            System.out.println("To: " + user.getEmail());
            System.out.println("System ID: " + user.getSystemId());
            System.out.println("Reset link (valid " + tokenExpiryMinutes + " min): " + resetLink);
            System.out.println("=================================================================");
            return;
        }

        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom(mailFrom);
        message.setTo(user.getEmail());
        message.setSubject("BookFlow — Reset your password");
        message.setText(
                "Hi " + user.getFirstName() + ",\n\n" +
                        "We received a request to reset your BookFlow password.\n\n" +
                        "Click the link below to set a new password (valid for " + tokenExpiryMinutes + " minutes):\n" +
                        resetLink + "\n\n" +
                        "If you didn't request this, you can safely ignore this email.\n\n" +
                        "— BookFlow"
        );

        mailSender.send(message);
    }
}