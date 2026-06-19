package com.bookflow.repository;

import com.bookflow.model.Transaction;
import com.bookflow.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface TransactionRepository extends JpaRepository<Transaction, Long> {

    List<Transaction> findByMemberAndStatus(User member, Transaction.TxnStatus status);

    long countByMemberAndStatus(User member, Transaction.TxnStatus status);

    @Query("SELECT t FROM Transaction t JOIN FETCH t.book JOIN FETCH t.member WHERE t.status = 'ISSUED' AND t.dueDate < CURRENT_DATE ORDER BY t.dueDate ASC")
    List<Transaction> findAllOverdue();

    @Query("SELECT t FROM Transaction t JOIN FETCH t.book WHERE t.member.systemId = :memberId ORDER BY t.issueDate DESC")
    List<Transaction> findAllByMemberId(@Param("memberId") String memberId);

    @Query("SELECT t FROM Transaction t JOIN FETCH t.book WHERE t.member.systemId = :memberId AND t.status = 'ISSUED'")
    List<Transaction> findActiveByMember(@Param("memberId") String memberId);

    @Query("SELECT t FROM Transaction t WHERE t.status = 'ISSUED' AND t.dueDate = :date")
    List<Transaction> findDueOn(@Param("date") LocalDate date);

    @Query("SELECT t FROM Transaction t JOIN FETCH t.book JOIN FETCH t.member WHERE t.status = 'ISSUED' ORDER BY t.dueDate ASC")
    List<Transaction> findAllCurrentlyIssued();

    long countByStatusAndIssueDateBetween(Transaction.TxnStatus status, LocalDate from, LocalDate to);

    long countByIssueDate(LocalDate issueDate);

    Optional<Transaction> findByMemberSystemIdAndBookIsbnAndStatus(
        String memberId, String isbn, Transaction.TxnStatus status
    );
}
