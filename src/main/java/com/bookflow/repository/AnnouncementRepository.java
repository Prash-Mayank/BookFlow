package com.bookflow.repository;

import com.bookflow.model.Announcement;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface AnnouncementRepository extends JpaRepository<Announcement, Long> {

    List<Announcement> findByActiveTrueOrderByCreatedAtDesc();

    List<Announcement> findByTargetRoleOrTargetRoleOrderByCreatedAtDesc(
            Announcement.TargetRole role1, Announcement.TargetRole role2
    );
}