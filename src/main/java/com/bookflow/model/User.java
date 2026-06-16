package com.bookflow.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.*;
import java.time.LocalDateTime;

/**
 * Represents all system users: Admin (ADM), Librarian (LIB), Student (STU).
 * system_id is the PRIMARY KEY and login username.
 * Format: FIRSTNAME + 6DIGITS + ROLECODE  e.g. PRIYA095312STU
 */
@Entity
@Table(name = "users", indexes = {
        @Index(name = "idx_email", columnList = "email"),
        @Index(name = "idx_role",  columnList = "role")
})
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User {

    @Id
    @Column(name = "system_id", length = 25, nullable = false, updatable = false)
    private String systemId;

    @NotBlank
    @Column(name = "first_name", length = 50, nullable = false)
    private String firstName;

    @NotBlank
    @Column(name = "last_name", length = 50, nullable = false)
    private String lastName;

    @NotBlank
    @Column(name = "password_hash", nullable = false)
    private String passwordHash;

    @Enumerated(EnumType.STRING)
    @Column(name = "role", nullable = false, length = 10)
    private Role role;

    @Email
    @Column(name = "email", length = 100, unique = true, nullable = false)
    private String email;

    @Column(name = "phone", length = 15)
    private String phone;

    @Column(name = "address", columnDefinition = "TEXT")
    private String address;

    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false, length = 10)
    @Builder.Default
    private UserStatus status = UserStatus.ACTIVE;

    @Column(name = "failed_login_attempts")
    @Builder.Default
    private int failedLoginAttempts = 0;

    @Column(name = "profile_image_path")
    private String profileImagePath;

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

    // ---- Enums ----

    public enum Role {
        ADM, LIB, STU;

        public String getRoleCode() {
            return this.name();
        }

        /** Display-friendly label */
        public String getDisplayName() {
            return switch (this) {
                case ADM -> "Administrator";
                case LIB -> "Librarian";
                case STU -> "Student";
            };
        }
    }

    public enum UserStatus {
        ACTIVE, LOCKED, INACTIVE
    }

    // ---- Helpers ----

    public String getFullName() {
        return firstName + " " + lastName;
    }

    public boolean isActive() {
        return status == UserStatus.ACTIVE;
    }

    public boolean isLocked() {
        return status == UserStatus.LOCKED;
    }
}