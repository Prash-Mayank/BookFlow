package com.bookflow.model;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

/**
 * Caches Gemini API recommendation responses per student.
 * TTL = 24 hours — refreshed on next login after expiry.
 * Prevents repeated API calls for the same student.
 */
@Entity
@Table(name = "ai_cache")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AiCache {

    @Id
    @Column(name = "member_id", length = 25)
    private String memberId;

    /** JSON array of 5 book recommendations from Gemini */
    @Column(name = "recommendations", columnDefinition = "JSON")
    private String recommendations;

    @Column(name = "cached_at", nullable = false)
    private LocalDateTime cachedAt;

    @PrePersist
    @PreUpdate
    protected void onSave() {
        cachedAt = LocalDateTime.now();
    }

    /** Returns true if cache is still valid (within 24 hours) */
    public boolean isValid() {
        return cachedAt != null &&
                cachedAt.isAfter(LocalDateTime.now().minusHours(24));
    }
}