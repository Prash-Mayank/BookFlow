package com.bookflow.model;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

/**
 * Security and audit trail.
 * Every login, logout, and critical action (fine waiver, account lock,
 * book delete, etc.) is recorded here with actor, timestamp, and IP.
 */
@Entity
@Table(name = "audit_log", indexes = {
        @Index(name = "idx_audit_user",   columnList = "user_id"),
        @Index(name = "idx_audit_action", columnList = "action"),
        @Index(name = "idx_audit_time",   columnList = "created_at")
})
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AuditLog {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "log_id")
    private Long logId;

    @Column(name = "user_id", length = 25)
    private String userId;

    @Enumerated(EnumType.STRING)
    @Column(name = "action", nullable = false, length = 30)
    private AuditAction action;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "ip_address", length = 45)
    private String ipAddress;

    @Column(name = "user_agent", length = 255)
    private String userAgent;

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }

    public enum AuditAction {
        LOGIN,
        LOGOUT,
        LOGIN_FAILED,
        ACCOUNT_LOCKED,
        PASSWORD_RESET,
        BOOK_ISSUED,
        BOOK_RETURNED,
        FINE_PAID,
        FINE_WAIVED,
        BOOK_ADDED,
        BOOK_DELETED,
        MEMBER_CREATED,
        MEMBER_DELETED,
        REPORT_EXPORTED
    }
}