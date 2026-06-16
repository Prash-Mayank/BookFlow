package com.bookflow.model;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * Fine record linked to a Transaction.
 * amount = overdue_days × daily_rate + processing_charge (if any)
 * Admin can waive a fine; waiver reason is logged.
 */
@Entity
@Table(name = "fines", indexes = {
        @Index(name = "idx_fine_member", columnList = "member_id"),
        @Index(name = "idx_fine_txn",    columnList = "txn_id"),
        @Index(name = "idx_fine_paid",   columnList = "paid")
})
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Fine {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "fine_id")
    private Long fineId;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "txn_id", nullable = false, unique = true)
    private Transaction transaction;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id", nullable = false)
    private User member;

    @Column(name = "amount", precision = 10, scale = 2, nullable = false)
    private BigDecimal amount;

    @Column(name = "overdue_days", nullable = false)
    @Builder.Default
    private long overdueDays = 0;

    @Column(name = "daily_rate", precision = 6, scale = 2, nullable = false)
    @Builder.Default
    private BigDecimal dailyRate = BigDecimal.valueOf(5.00);

    @Column(name = "processing_charge", precision = 6, scale = 2)
    @Builder.Default
    private BigDecimal processingCharge = BigDecimal.ZERO;

    @Column(name = "paid", nullable = false)
    @Builder.Default
    private boolean paid = false;

    @Column(name = "waived", nullable = false)
    @Builder.Default
    private boolean waived = false;

    @Column(name = "waiver_reason", columnDefinition = "TEXT")
    private String waiverReason;

    @Column(name = "waived_by", length = 25)
    private String waivedBy;

    @Column(name = "payment_date")
    private LocalDate paymentDate;

    @Column(name = "payment_mode", length = 30)
    private String paymentMode;

    @Column(name = "receipt_number", length = 50, unique = true)
    private String receiptNumber;

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }

    // ---- Helpers ----

    public boolean isOutstanding() {
        return !paid && !waived;
    }

    public BigDecimal getTotalAmount() {
        return amount.add(processingCharge != null ? processingCharge : BigDecimal.ZERO);
    }
}