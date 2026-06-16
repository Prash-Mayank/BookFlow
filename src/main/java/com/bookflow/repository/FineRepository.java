package com.bookflow.repository;

import com.bookflow.model.Fine;
import com.bookflow.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Repository
public interface FineRepository extends JpaRepository<Fine, Long> {

    List<Fine> findByMemberAndPaidFalseAndWaivedFalse(User member);

    List<Fine> findByMemberOrderByCreatedAtDesc(User member);

    Optional<Fine> findByTransactionTxnId(Long txnId);

    @Query("SELECT COALESCE(SUM(f.amount), 0) FROM Fine f WHERE f.member = :member AND f.paid = false AND f.waived = false")
    BigDecimal getTotalOutstandingByMember(@Param("member") User member);

    @Query("SELECT COALESCE(SUM(f.amount), 0) FROM Fine f WHERE f.paid = true")
    BigDecimal getTotalCollected();

    @Query("SELECT COALESCE(SUM(f.amount), 0) FROM Fine f WHERE f.paid = true AND f.paymentDate BETWEEN :from AND :to")
    BigDecimal getTotalCollectedBetween(@Param("from") java.time.LocalDate from, @Param("to") java.time.LocalDate to);

    boolean existsByMemberAndPaidFalseAndWaivedFalse(User member);
}