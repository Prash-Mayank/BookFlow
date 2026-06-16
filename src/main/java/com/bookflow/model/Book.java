package com.bookflow.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.*;
import java.time.LocalDateTime;

/**
 * Book master catalogue.
 * isbn is the PRIMARY KEY (VARCHAR 13).
 * available is auto-decremented on issue and incremented on return.
 */
@Entity
@Table(name = "books", indexes = {
        @Index(name = "idx_title",    columnList = "title"),
        @Index(name = "idx_author",   columnList = "author"),
        @Index(name = "idx_category", columnList = "category")
})
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Book {

    @Id
    @Column(name = "isbn", length = 13, nullable = false)
    private String isbn;

    @NotBlank
    @Column(name = "title", length = 200, nullable = false)
    private String title;

    @NotBlank
    @Column(name = "author", length = 100, nullable = false)
    private String author;

    @Enumerated(EnumType.STRING)
    @Column(name = "category", nullable = false, length = 20)
    private BookCategory category;

    @Column(name = "publisher", length = 150)
    private String publisher;

    @Column(name = "year")
    private Integer year;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "language", length = 50)
    @Builder.Default
    private String language = "English";

    @Column(name = "pages")
    private Integer pages;

    @Min(0)
    @Column(name = "total_copies", nullable = false)
    @Builder.Default
    private int totalCopies = 1;

    @Min(0)
    @Column(name = "available", nullable = false)
    @Builder.Default
    private int available = 1;

    @Column(name = "cover_path")
    private String coverPath;

    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false, length = 15)
    @Builder.Default
    private BookStatus status = BookStatus.AVAILABLE;

    @Column(name = "added_at", updatable = false)
    private LocalDateTime addedAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @PrePersist
    protected void onCreate() {
        addedAt   = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        syncStatus();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
        syncStatus();
    }

    /** Keep status field in sync with available count */
    private void syncStatus() {
        if (available > 0) {
            status = BookStatus.AVAILABLE;
        } else {
            if (status != BookStatus.RESERVED) {
                status = BookStatus.ISSUED;
            }
        }
    }

    // ---- Enums ----

    public enum BookCategory {
        NOVEL, TEXTBOOK, REFERENCE, MAGAZINE, BIOGRAPHY, SCIENCE, HISTORY, TECHNOLOGY, OTHER;

        public String getDisplayName() {
            return name().charAt(0) + name().substring(1).toLowerCase();
        }
    }

    public enum BookStatus {
        AVAILABLE, ISSUED, RESERVED
    }

    // ---- Helpers ----

    public boolean isAvailable() {
        return available > 0;
    }

    /** Called on book issue — decrements available */
    public void decrementAvailable() {
        if (available <= 0) throw new IllegalStateException("No copies available for: " + isbn);
        available--;
        syncStatus();
    }

    /** Called on book return — increments available */
    public void incrementAvailable() {
        available++;
        syncStatus();
    }
}