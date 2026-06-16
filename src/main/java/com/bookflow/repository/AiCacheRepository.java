package com.bookflow.repository;

import com.bookflow.model.AiCache;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AiCacheRepository extends JpaRepository<AiCache, String> {
    // findById(memberId) provided by JpaRepository — used to check cache validity
}