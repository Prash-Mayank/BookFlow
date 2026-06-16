package com.bookflow.model;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

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

    public boolean isValid() {
        return cachedAt != null &&
                cachedAt.isAfter(LocalDateTime.now().minusHours(24));
    }
}