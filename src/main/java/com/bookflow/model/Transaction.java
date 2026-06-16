package com.bookflow.model;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

/**
 * Records every book issue and return event.
 * Links a member (User) to a Book for a specific period.
 * return_date is NULL until the book is returned.
 */
@Entity
@Table(name = "transactions", indexes = {
        @Index(name = "idx_txn_member", columnList = "member_id"),
        @Index(name = "idx_txn_isbn",   columnList = "isbn"),
        @Index(name = "idx_txn_status", columnList = "status"),
        @Index(name = "idx_due_date",   columnList = "due_date")
})
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Transaction {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "txn_id")
    private Long txnId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id", nullable = false)
    private User member;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "isbn", nullable = false)
    private Book book;

    @Column(name = "issue_date", nullable = false)
    private LocalDate issueDate;

    @Column(name = "due_date", nullable = false)
    private LocalDate dueDate;

    @Column(name = "return_date")
    private LocalDate returnDate;

    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false, length = 10)
    @Builder.Default
    private TxnStatus status = TxnStatus.ISSUED;

    /** ID of the librarian who processed the issue */
    @Column(name = "issued_by", length = 25)
    private String issuedBy;

    /** ID of the librarian who processed the return */
    @Column(name = "returned_by", length = 25)
    private String returnedBy;

    @Column(name = "notes", columnDefinition = "TEXT")
    private String notes;

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        if (issueDate == null) issueDate = LocalDate.now();
        if (dueDate  == null) dueDate   = issueDate.plusDays(14);
    }

    // ---- Enum ----

    public enum TxnStatus {
        ISSUED, RETURNED, LOST
    }

    // ---- Helpers ----

    public boolean isOverdue() {
        if (status == TxnStatus.RETURNED) return false;
        return LocalDate.now().isAfter(dueDate);
    }

    public long getOverdueDays() {
        if (!isOverdue()) return 0;
        LocalDate end = (returnDate != null) ? returnDate : LocalDate.now();
        return ChronoUnit.DAYS.between(dueDate, end);
    }

    public long getDaysRemaining() {
        if (status == TxnStatus.RETURNED) return 0;
        long days = ChronoUnit.DAYS.between(LocalDate.now(), dueDate);
        return Math.max(days, 0);
    }

    public boolean isDueSoon() {
        long remaining = getDaysRemaining();
        return remaining >= 0 && remaining <= 3 && !isOverdue();
    }
}