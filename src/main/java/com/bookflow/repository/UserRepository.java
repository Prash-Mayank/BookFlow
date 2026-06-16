package com.bookflow.repository;

import com.bookflow.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, String> {

    Optional<User> findByEmail(String email);

    List<User> findByRole(User.Role role);

    List<User> findByRoleAndStatus(User.Role role, User.UserStatus status);

    long countByRole(User.Role role);

    long countByStatus(User.UserStatus status);

    boolean existsByEmail(String email);

    @Modifying
    @Query("UPDATE User u SET u.failedLoginAttempts = u.failedLoginAttempts + 1 WHERE u.systemId = :id")
    void incrementFailedAttempts(@Param("id") String systemId);

    @Modifying
    @Query("UPDATE User u SET u.failedLoginAttempts = 0, u.status = 'ACTIVE' WHERE u.systemId = :id")
    void resetFailedAttempts(@Param("id") String systemId);

    @Modifying
    @Query("UPDATE User u SET u.status = 'LOCKED' WHERE u.systemId = :id")
    void lockAccount(@Param("id") String systemId);
}