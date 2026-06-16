package com.bookflow.service;

import com.bookflow.exception.BookFlowException;
import com.bookflow.model.*;
import com.bookflow.repository.ConfigRepository;
import com.bookflow.repository.FineRepository;
import com.bookflow.util.PdfReceiptGenerator;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

/**
 * Fine calculation, payment recording, and admin waivers.
 *
 * Fine = overdue_days × daily_rate (rate depends on book category,
 * configurable via the config table / Fine Config Panel).
 *
 * Maps to Implementation Plan §4.3 (Fine & Fee Management).
 */
@Service
public class FineService {

    @Value("${bookflow.fine.default-daily-rate:5.00}")
    private String defaultDailyRateStr;

    @Value("${bookflow.fine.processing-charge:20.00}")
    private String processingChargeStr;

    private final FineRepository fineRepository;
    private final ConfigRepository configRepository;
    private final AuditLogService auditLogService;
    private final PdfReceiptGenerator pdfReceiptGenerator;

    public FineService(FineRepository fineRepository,
                       ConfigRepository configRepository,
                       AuditLogService auditLogService,
                       PdfReceiptGenerator pdfReceiptGenerator) {
        this.fineRepository = fineRepository;
        this.configRepository = configRepository;
        this.auditLogService = auditLogService;
        this.pdfReceiptGenerator = pdfReceiptGenerator;
    }

    /** Creates a fine record for an overdue return. Called from IssueReturnService. */
    @Transactional
    public Fine createFineForTransaction(Transaction txn, long overdueDays) {

        BigDecimal dailyRate = getDailyRateForCategory(txn.getBook().getCategory());
        BigDecimal amount = dailyRate.multiply(BigDecimal.valueOf(overdueDays))
                .setScale(2, RoundingMode.HALF_UP);

        Fine fine = Fine.builder()
                .transaction(txn)
                .member(txn.getMember())
                .amount(amount)
                .overdueDays(overdueDays)
                .dailyRate(dailyRate)
                .processingCharge(BigDecimal.ZERO) // applied at payment time
                .paid(false)
                .waived(false)
                .build();

        return fineRepository.save(fine);
    }

    /** Daily rate lookup by book category, falling back to default. */
    @Transactional(readOnly = true)
    public BigDecimal getDailyRateForCategory(Book.BookCategory category) {
        String key = "fine.rate." + category.name().toLowerCase();
        return configRepository.findById(key)
                .map(Config::getConfigValue)
                .map(BigDecimal::new)
                .orElseGet(() -> configRepository.findById("fine.rate.default")
                        .map(Config::getConfigValue)
                        .map(BigDecimal::new)
                        .orElse(new BigDecimal(defaultDailyRateStr)));
    }

    /** Records a fine payment, adds processing charge, generates a receipt number. */
    @Transactional
    public Fine payFine(Long fineId, String paymentMode, String paidByUserId) {
        Fine fine = fineRepository.findById(fineId)
                .orElseThrow(() -> new BookFlowException("Fine not found: " + fineId));

        if (fine.isPaid() || fine.isWaived()) {
            throw new BookFlowException("This fine has already been settled");
        }

        BigDecimal processingCharge = new BigDecimal(processingChargeStr);

        fine.setProcessingCharge(processingCharge);
        fine.setPaid(true);
        fine.setPaymentDate(LocalDate.now());
        fine.setPaymentMode(paymentMode);
        fine.setReceiptNumber(generateReceiptNumber(fine));

        fineRepository.save(fine);

        auditLogService.log(paidByUserId, AuditLog.AuditAction.FINE_PAID,
                "Fine #" + fineId + " (Rs. " + fine.getTotalAmount() + ") paid by " + fine.getMember().getSystemId());

        return fine;
    }

    /** Admin waives a fine — reason is mandatory and logged in the audit trail. */
    @Transactional
    public Fine waiveFine(Long fineId, String reason, String waivedByAdminId) {
        if (reason == null || reason.isBlank()) {
            throw new BookFlowException("A reason is required to waive a fine");
        }

        Fine fine = fineRepository.findById(fineId)
                .orElseThrow(() -> new BookFlowException("Fine not found: " + fineId));

        if (fine.isPaid() || fine.isWaived()) {
            throw new BookFlowException("This fine has already been settled");
        }

        fine.setWaived(true);
        fine.setWaiverReason(reason);
        fine.setWaivedBy(waivedByAdminId);
        fineRepository.save(fine);

        auditLogService.log(waivedByAdminId, AuditLog.AuditAction.FINE_WAIVED,
                "Fine #" + fineId + " waived for " + fine.getMember().getSystemId() + " — reason: " + reason);

        return fine;
    }

    /** Generates the PDF receipt bytes for a paid fine. */
    @Transactional(readOnly = true)
    public byte[] generateReceiptPdf(Long fineId) {
        Fine fine = fineRepository.findById(fineId)
                .orElseThrow(() -> new BookFlowException("Fine not found: " + fineId));

        if (!fine.isPaid()) {
            throw new BookFlowException("Cannot generate receipt — fine has not been paid yet");
        }

        return pdfReceiptGenerator.generateFineReceipt(fine);
    }

    @Transactional(readOnly = true)
    public List<Fine> getOutstandingForMember(User member) {
        return fineRepository.findByMemberAndPaidFalseAndWaivedFalse(member);
    }

    @Transactional(readOnly = true)
    public List<Fine> getHistoryForMember(User member) {
        return fineRepository.findByMemberOrderByCreatedAtDesc(member);
    }

    @Transactional(readOnly = true)
    public BigDecimal getTotalOutstanding(User member) {
        return fineRepository.getTotalOutstandingByMember(member);
    }

    @Transactional(readOnly = true)
    public BigDecimal getTotalCollected() {
        return fineRepository.getTotalCollected();
    }

    @Transactional(readOnly = true)
    public Optional<Fine> findByTransaction(Long txnId) {
        return fineRepository.findByTransactionTxnId(txnId);
    }

    private String generateReceiptNumber(Fine fine) {
        return "RCPT-" + fine.getMember().getSystemId() + "-" + System.currentTimeMillis();
    }
}