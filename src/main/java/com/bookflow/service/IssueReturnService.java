package com.bookflow.service;

import com.bookflow.dto.IssueBookRequest;
import com.bookflow.exception.BookFlowException;
import com.bookflow.model.*;
import com.bookflow.repository.FineRepository;
import com.bookflow.repository.TransactionRepository;
import com.bookflow.repository.UserRepository;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;

/**
 * Core library workflow: issue, return, and the checks that gate them
 * (borrow limit, unpaid fines, book availability).
 *
 * Maps to Implementation Plan §4.2 (Issue & Return Workflow) and
 * Weeks 7-8 (Issue, Return & Fine Engine).
 */
@Service
public class IssueReturnService {

    @Value("${bookflow.borrow.limit:3}")
    private int borrowLimit;

    @Value("${bookflow.borrow.duration-days:14}")
    private int borrowDurationDays;

    private final TransactionRepository transactionRepository;
    private final UserRepository userRepository;
    private final FineRepository fineRepository;
    private final BookService bookService;
    private final FineService fineService;
    private final AuditLogService auditLogService;

    public IssueReturnService(TransactionRepository transactionRepository,
                               UserRepository userRepository,
                               FineRepository fineRepository,
                               BookService bookService,
                               FineService fineService,
                               AuditLogService auditLogService) {
        this.transactionRepository = transactionRepository;
        this.userRepository = userRepository;
        this.fineRepository = fineRepository;
        this.bookService = bookService;
        this.fineService = fineService;
        this.auditLogService = auditLogService;
    }

    /**
     * Issues a book to a member.
     * Pre-checks: member exists & active, borrow limit (max 3), no unpaid fines,
     * book has available copies.
     */
    @Transactional
    public Transaction issueBook(IssueBookRequest request, String issuedByLibrarianId) {

        User member = userRepository.findById(request.getMemberId())
            .orElseThrow(() -> new BookFlowException("Member not found: " + request.getMemberId()));

        if (!member.isActive()) {
            throw new BookFlowException("Member account is " + member.getStatus() + " — cannot issue book");
        }

        Book book = bookService.getByIsbn(request.getIsbn());

        if (!book.hasAvailableCopies()) {
            throw new BookFlowException("No copies available for: " + book.getTitle());
        }

        long activeCount = transactionRepository.countByMemberAndStatus(member, Transaction.TxnStatus.ISSUED);
        if (activeCount >= borrowLimit) {
            throw new BookFlowException(
                "Member has reached the borrow limit (" + borrowLimit + " books). Return a book before issuing another."
            );
        }

        boolean hasUnpaidFines = fineRepository.existsByMemberAndPaidFalseAndWaivedFalse(member);
        if (hasUnpaidFines) {
            throw new BookFlowException("Member has outstanding fines. Clear fines before issuing a new book.");
        }

        LocalDate issueDate = LocalDate.now();
        LocalDate dueDate = issueDate.plusDays(borrowDurationDays);

        Transaction txn = Transaction.builder()
            .member(member)
            .book(book)
            .issueDate(issueDate)
            .dueDate(dueDate)
            .status(Transaction.TxnStatus.ISSUED)
            .issuedBy(issuedByLibrarianId)
            .build();

        transactionRepository.save(txn);
        bookService.decrementStock(book.getIsbn());

        auditLogService.log(issuedByLibrarianId, AuditLog.AuditAction.BOOK_ISSUED,
            "Issued '" + book.getTitle() + "' to " + member.getSystemId() + ", due " + dueDate);

        return txn;
    }

    /**
     * Returns a book. Calculates overdue fine automatically if past due date.
     * Increments book stock.
     */
    @Transactional
    public Transaction returnBook(Long txnId, String returnedByLibrarianId) {

        Transaction txn = transactionRepository.findById(txnId)
            .orElseThrow(() -> new BookFlowException("Transaction not found: " + txnId));

        if (txn.getStatus() == Transaction.TxnStatus.RETURNED) {
            throw new BookFlowException("This book has already been returned");
        }

        LocalDate returnDate = LocalDate.now();
        txn.setReturnDate(returnDate);
        txn.setStatus(Transaction.TxnStatus.RETURNED);
        txn.setReturnedBy(returnedByLibrarianId);
        transactionRepository.save(txn);

        bookService.incrementStock(txn.getBook().getIsbn());

        // Auto-calculate fine if overdue
        long overdueDays = Math.max(0,
            java.time.temporal.ChronoUnit.DAYS.between(txn.getDueDate(), returnDate));

        if (overdueDays > 0) {
            fineService.createFineForTransaction(txn, overdueDays);
        }

        auditLogService.log(returnedByLibrarianId, AuditLog.AuditAction.BOOK_RETURNED,
            "Returned '" + txn.getBook().getTitle() + "' from " + txn.getMember().getSystemId()
                + (overdueDays > 0 ? " (" + overdueDays + " days overdue)" : " (on time)"));

        return txn;
    }

    /** Preview fine before confirming return — used by the Fine Calculator Widget. */
    @Transactional(readOnly = true)
    public long previewOverdueDays(Long txnId) {
        Transaction txn = transactionRepository.findById(txnId)
            .orElseThrow(() -> new BookFlowException("Transaction not found: " + txnId));
        return Math.max(0,
            java.time.temporal.ChronoUnit.DAYS.between(txn.getDueDate(), LocalDate.now()));
    }

    @Transactional(readOnly = true)
    public List<Transaction> getActiveTransactionsForMember(String memberId) {
        return transactionRepository.findActiveByMember(memberId);
    }

    @Transactional(readOnly = true)
    public List<Transaction> getAllOverdue() {
        return transactionRepository.findAllOverdue();
    }

    @Transactional(readOnly = true)
    public List<Transaction> getAllCurrentlyIssued() {
        return transactionRepository.findAllCurrentlyIssued();
    }

    @Transactional(readOnly = true)
    public List<Transaction> getHistoryForMember(String memberId) {
        return transactionRepository.findAllByMemberId(memberId);
    }

    @Transactional(readOnly = true)
    public long countIssuedToday() {
        return transactionRepository.countByIssueDate(LocalDate.now());
    }
}
