package com.bookflow.service;

import com.bookflow.dto.RegistrationRequest;
import com.bookflow.exception.BookFlowException;
import com.bookflow.model.AuditLog;
import com.bookflow.model.User;
import com.bookflow.repository.UserRepository;
import com.bookflow.util.PasswordPolicy;
import com.bookflow.util.SystemIdGenerator;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Service
public class UserService {

    @Value("${bookflow.security.max-login-attempts:5}")
    private int maxFailedAttempts;

    private final UserRepository userRepository;
    private final SystemIdGenerator systemIdGenerator;
    private final AuditLogService auditLogService;

    public UserService(UserRepository userRepository,
                       SystemIdGenerator systemIdGenerator,
                       AuditLogService auditLogService) {
        this.userRepository = userRepository;
        this.systemIdGenerator = systemIdGenerator;
        this.auditLogService = auditLogService;
    }

    @Transactional
    public User register(RegistrationRequest request) {

        if (!request.passwordsMatch()) {
            throw new BookFlowException("Password and confirm password do not match");
        }
        if (!request.isAgreedToTerms()) {
            throw new BookFlowException("You must agree to the Terms & Privacy Policy");
        }
        if (userRepository.existsByEmail(request.getEmail())) {
            throw new BookFlowException("An account with this email already exists");
        }

        PasswordPolicy.validate(request.getPassword(), request.getRole());

        String systemId = systemIdGenerator.generate(request.getFirstName(), request.getRole());

        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder(
                PasswordPolicy.bcryptStrengthFor(request.getRole())
        );
        String hash = encoder.encode(request.getPassword());

        User user = User.builder()
                .systemId(systemId)
                .firstName(request.getFirstName().trim())
                .lastName(request.getLastName().trim())
                .email(request.getEmail().trim().toLowerCase())
                .phone(request.getPhone())
                .role(request.getRole())
                .passwordHash(hash)
                .status(User.UserStatus.ACTIVE)
                .build();

        userRepository.save(user);

        auditLogService.log(systemId, AuditLog.AuditAction.MEMBER_CREATED,
                "New " + request.getRole().getDisplayName() + " account registered: " + systemId);

        return user;
    }

    @Transactional
    public void recordFailedLogin(String systemId) {
        Optional<User> userOpt = userRepository.findById(systemId);
        if (userOpt.isEmpty()) return;

        User user = userOpt.get();
        int attempts = user.getFailedLoginAttempts() + 1;
        user.setFailedLoginAttempts(attempts);

        if (attempts >= maxFailedAttempts) {
            user.setStatus(User.UserStatus.LOCKED);
            userRepository.save(user);
            auditLogService.log(systemId, AuditLog.AuditAction.ACCOUNT_LOCKED,
                    "Account locked after " + attempts + " failed login attempts");
        } else {
            userRepository.save(user);
        }

        auditLogService.log(systemId, AuditLog.AuditAction.LOGIN_FAILED,
                "Failed login attempt #" + attempts);
    }

    @Transactional
    public void recordSuccessfulLogin(String systemId) {
        userRepository.resetFailedAttempts(systemId);
        auditLogService.log(systemId, AuditLog.AuditAction.LOGIN, "Successful login");
    }

    @Transactional
    public void resetPassword(String targetSystemId, String newPassword, String resetByAdminId) {
        User target = userRepository.findById(targetSystemId)
                .orElseThrow(() -> new BookFlowException("User not found: " + targetSystemId));

        PasswordPolicy.validate(newPassword, target.getRole());

        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder(
                PasswordPolicy.bcryptStrengthFor(target.getRole())
        );
        target.setPasswordHash(encoder.encode(newPassword));
        target.setFailedLoginAttempts(0);
        target.setStatus(User.UserStatus.ACTIVE);
        userRepository.save(target);

        auditLogService.log(resetByAdminId, AuditLog.AuditAction.PASSWORD_RESET,
                "Password reset for " + targetSystemId + " by " + resetByAdminId);
    }

    @Transactional(readOnly = true)
    public User getBySystemId(String systemId) {
        return userRepository.findById(systemId)
                .orElseThrow(() -> new BookFlowException("User not found: " + systemId));
    }

    @Transactional(readOnly = true)
    public java.util.List<User> getAllByRole(User.Role role) {
        return userRepository.findByRole(role);
    }
}