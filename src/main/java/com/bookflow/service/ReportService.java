package com.bookflow.service;

import com.bookflow.model.AuditLog;
import com.bookflow.model.Book;
import com.bookflow.model.Transaction;
import com.bookflow.model.User;
import com.bookflow.repository.*;
import com.bookflow.util.CsvExporter;
import com.bookflow.util.PdfReceiptGenerator;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

@Service
public class ReportService {

    private final UserRepository userRepository;
    private final BookRepository bookRepository;
    private final TransactionRepository transactionRepository;
    private final FineRepository fineRepository;
    private final CsvExporter csvExporter;
    private final PdfReceiptGenerator pdfReceiptGenerator;
    private final AuditLogService auditLogService;

    public ReportService(UserRepository userRepository,
                         BookRepository bookRepository,
                         TransactionRepository transactionRepository,
                         FineRepository fineRepository,
                         CsvExporter csvExporter,
                         PdfReceiptGenerator pdfReceiptGenerator,
                         AuditLogService auditLogService) {
        this.userRepository = userRepository;
        this.bookRepository = bookRepository;
        this.transactionRepository = transactionRepository;
        this.fineRepository = fineRepository;
        this.csvExporter = csvExporter;
        this.pdfReceiptGenerator = pdfReceiptGenerator;
        this.auditLogService = auditLogService;
    }

    // ---- Admin Dashboard stat cards ----

    @Transactional(readOnly = true)
    public Map<String, Object> getAdminDashboardStats() {
        return Map.of(
                "totalBooks", bookRepository.count(),
                "totalMembers", userRepository.countByRole(User.Role.STU) + userRepository.countByRole(User.Role.LIB),
                "booksIssuedToday", transactionRepository.countByIssueDate(LocalDate.now()),
                "totalFinesCollected", fineRepository.getTotalCollected()
        );
    }

    // ---- Librarian Dashboard: daily activity ----

    @Transactional(readOnly = true)
    public List<Transaction> getOverdueBooks() {
        return transactionRepository.findAllOverdue();
    }

    @Transactional(readOnly = true)
    public List<Transaction> getCurrentlyIssued() {
        return transactionRepository.findAllCurrentlyIssued();
    }

    // ---- Most borrowed books report ----

    @Transactional(readOnly = true)
    public List<Book> getMostBorrowedBooks(int topN) {
        return bookRepository.findMostBorrowed(org.springframework.data.domain.PageRequest.of(0, topN));
    }

    @Transactional(readOnly = true)
    public BigDecimal getTotalFineRevenue() {
        return fineRepository.getTotalCollected();
    }

    @Transactional(readOnly = true)
    public BigDecimal getFineRevenueBetween(LocalDate from, LocalDate to) {
        return fineRepository.getTotalCollectedBetween(from, to);
    }

    // ---- PDF Export ----

    @Transactional(readOnly = true)
    public byte[] exportOverdueReportPdf() {
        List<Transaction> overdue = transactionRepository.findAllOverdue();
        // Reuses the borrow-history PDF layout grouped under one "report" title
        return pdfReceiptGenerator.generateBorrowHistory("Overdue Report", "ALL-MEMBERS", overdue);
    }

    @Transactional(readOnly = true)
    public byte[] exportBooksCsv() {
        return csvExporter.exportBooks(bookRepository.findAll());
    }

    @Transactional(readOnly = true)
    public byte[] exportTransactionsCsv() {
        return csvExporter.exportTransactions(transactionRepository.findAll());
    }

    @Transactional(readOnly = true)
    public byte[] exportUsersCsv() {
        return csvExporter.exportUsers(userRepository.findAll());
    }

    @Transactional
    public void logExport(String userId, String reportType) {
        auditLogService.log(userId, AuditLog.AuditAction.REPORT_EXPORTED,
                "Exported report: " + reportType);
    }
}