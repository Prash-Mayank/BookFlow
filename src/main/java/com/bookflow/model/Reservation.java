package com.bookflow.model;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "reservations", indexes = {
        @Index(name = "idx_rsv_member", columnList = "member_id"),
        @Index(name = "idx_rsv_isbn",   columnList = "isbn"),
        @Index(name = "idx_rsv_status", columnList = "status")
})
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Reservation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "rsv_id")
    private Long rsvId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id", nullable = false)
    private User member;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "isbn", nullable = false)
    private Book book;

    @Column(name = "request_date", nullable = false)
    @Builder.Default
    private LocalDate requestDate = LocalDate.now();

    @Column(name = "expiry_date")
    private LocalDate expiryDate;

    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false, length = 15)
    @Builder.Default
    private ReservationStatus status = ReservationStatus.PENDING;

    @Column(name = "fulfilled_at")
    private LocalDateTime fulfilledAt;

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @PrePersist
    protected void onCreate() {
        createdAt    = LocalDateTime.now();
        requestDate  = LocalDate.now();
        expiryDate   = requestDate.plusDays(7);
    }

    public enum ReservationStatus {
        PENDING, FULFILLED, CANCELLED, EXPIRED
    }
}