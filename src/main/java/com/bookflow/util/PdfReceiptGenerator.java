package com.bookflow.util;

import com.bookflow.model.Fine;
import com.bookflow.model.Transaction;
import com.itextpdf.kernel.colors.ColorConstants;
import com.itextpdf.kernel.geom.PageSize;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.borders.SolidBorder;
import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;
import com.itextpdf.layout.properties.TextAlignment;
import com.itextpdf.layout.properties.UnitValue;
import org.springframework.stereotype.Component;

import java.io.ByteArrayOutputStream;
import java.time.format.DateTimeFormatter;

@Component
public class PdfReceiptGenerator {

    private static final DateTimeFormatter DATE_FMT = DateTimeFormatter.ofPattern("dd MMM yyyy");

    /** Generates a fine payment receipt PDF. */
    public byte[] generateFineReceipt(Fine fine) {
        try (ByteArrayOutputStream baos = new ByteArrayOutputStream()) {
            PdfDocument pdfDoc = new PdfDocument(new PdfWriter(baos));
            Document doc = new Document(pdfDoc, PageSize.A4);
            doc.setMargins(40, 40, 40, 40);

            // Header
            doc.add(new Paragraph("BookFlow")
                    .setFontSize(22)
                    .setBold()
                    .setFontColor(ColorConstants.BLUE));
            doc.add(new Paragraph("Online Library Management System")
                    .setFontSize(10)
                    .setFontColor(ColorConstants.GRAY)
                    .setMarginBottom(10));

            doc.add(new Paragraph("Fine Payment Receipt")
                    .setFontSize(16)
                    .setBold()
                    .setMarginTop(10)
                    .setMarginBottom(15));

            Transaction txn = fine.getTransaction();

            Table table = new Table(UnitValue.createPercentArray(new float[]{1, 1}))
                    .useAllAvailableWidth();

            addRow(table, "Receipt Number", nullSafe(fine.getReceiptNumber()));
            addRow(table, "Member ID", fine.getMember().getSystemId());
            addRow(table, "Member Name", fine.getMember().getFullName());
            addRow(table, "Book Title", txn != null ? txn.getBook().getTitle() : "—");
            addRow(table, "Due Date", txn != null ? txn.getDueDate().format(DATE_FMT) : "—");
            addRow(table, "Return Date", (txn != null && txn.getReturnDate() != null)
                    ? txn.getReturnDate().format(DATE_FMT) : "—");
            addRow(table, "Overdue Days", String.valueOf(fine.getOverdueDays()));
            addRow(table, "Daily Rate", "Rs. " + fine.getDailyRate());
            addRow(table, "Fine Amount", "Rs. " + fine.getAmount());
            addRow(table, "Processing Charge", "Rs. " + fine.getProcessingCharge());
            addRow(table, "Total Paid", "Rs. " + fine.getTotalAmount());
            addRow(table, "Payment Date", fine.getPaymentDate() != null
                    ? fine.getPaymentDate().format(DATE_FMT) : "—");
            addRow(table, "Payment Mode", nullSafe(fine.getPaymentMode()));

            doc.add(table);

            doc.add(new Paragraph("This is a system-generated receipt.")
                    .setFontSize(9)
                    .setFontColor(ColorConstants.GRAY)
                    .setTextAlignment(TextAlignment.CENTER)
                    .setMarginTop(30));

            doc.close();
            return baos.toByteArray();

        } catch (Exception e) {
            throw new RuntimeException("Failed to generate fine receipt PDF", e);
        }
    }

    /** Generates a borrowing history PDF for a student. */
    public byte[] generateBorrowHistory(String memberName, String memberId,
                                        java.util.List<Transaction> transactions) {
        try (ByteArrayOutputStream baos = new ByteArrayOutputStream()) {
            PdfDocument pdfDoc = new PdfDocument(new PdfWriter(baos));
            Document doc = new Document(pdfDoc, PageSize.A4);
            doc.setMargins(40, 40, 40, 40);

            doc.add(new Paragraph("BookFlow — Borrowing History")
                    .setFontSize(18).setBold());
            doc.add(new Paragraph(memberName + " (" + memberId + ")")
                    .setFontSize(11).setFontColor(ColorConstants.GRAY).setMarginBottom(15));

            Table table = new Table(UnitValue.createPercentArray(new float[]{3, 2, 2, 2, 1.5f}))
                    .useAllAvailableWidth();

            for (String header : new String[]{"Book Title", "Issue Date", "Due Date", "Return Date", "Status"}) {
                table.addHeaderCell(
                        new Cell().add(new Paragraph(header).setBold())
                                .setBackgroundColor(ColorConstants.LIGHT_GRAY)
                );
            }

            for (Transaction t : transactions) {
                table.addCell(t.getBook().getTitle());
                table.addCell(t.getIssueDate().format(DATE_FMT));
                table.addCell(t.getDueDate().format(DATE_FMT));
                table.addCell(t.getReturnDate() != null ? t.getReturnDate().format(DATE_FMT) : "—");
                table.addCell(t.getStatus().name());
            }

            doc.add(table);
            doc.close();
            return baos.toByteArray();

        } catch (Exception e) {
            throw new RuntimeException("Failed to generate borrow history PDF", e);
        }
    }

    private void addRow(Table table, String label, String value) {
        table.addCell(new Cell().add(new Paragraph(label).setBold())
                .setBorder(new SolidBorder(ColorConstants.LIGHT_GRAY, 0.5f)));
        table.addCell(new Cell().add(new Paragraph(value))
                .setBorder(new SolidBorder(ColorConstants.LIGHT_GRAY, 0.5f)));
    }

    private String nullSafe(String s) {
        return (s == null || s.isBlank()) ? "—" : s;
    }
}