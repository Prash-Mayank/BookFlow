package com.bookflow.util;

import com.bookflow.model.Book;
import com.bookflow.model.Transaction;
import com.bookflow.model.User;
import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVPrinter;
import org.springframework.stereotype.Component;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.nio.charset.StandardCharsets;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Component
public class CsvExporter {

    private static final DateTimeFormatter DATE_FMT = DateTimeFormatter.ofPattern("yyyy-MM-dd");

    public byte[] exportBooks(List<Book> books) {
        return write(
                new String[]{"ISBN", "Title", "Author", "Category", "Publisher", "Year", "Total Copies", "Available", "Status"},
                books,
                (b, printer) -> printer.printRecord(
                        b.getIsbn(), b.getTitle(), b.getAuthor(), b.getCategory(),
                        b.getPublisher(), b.getYear(), b.getTotalCopies(), b.getAvailable(), b.getStatus()
                )
        );
    }

    /** Exports transaction (issue/return) history as CSV. */
    public byte[] exportTransactions(List<Transaction> transactions) {
        return write(
                new String[]{"Txn ID", "Member ID", "Member Name", "Book Title", "ISBN", "Issue Date", "Due Date", "Return Date", "Status"},
                transactions,
                (t, printer) -> printer.printRecord(
                        t.getTxnId(),
                        t.getMember().getSystemId(),
                        t.getMember().getFullName(),
                        t.getBook().getTitle(),
                        t.getBook().getIsbn(),
                        t.getIssueDate().format(DATE_FMT),
                        t.getDueDate().format(DATE_FMT),
                        t.getReturnDate() != null ? t.getReturnDate().format(DATE_FMT) : "",
                        t.getStatus()
                )
        );
    }

    /** Exports member (user) list as CSV. */
    public byte[] exportUsers(List<User> users) {
        return write(
                new String[]{"System ID", "Name", "Role", "Email", "Phone", "Status"},
                users,
                (u, printer) -> printer.printRecord(
                        u.getSystemId(), u.getFullName(), u.getRole(), u.getEmail(), u.getPhone(), u.getStatus()
                )
        );
    }

    // ---- Generic write helper ----

    @FunctionalInterface
    private interface RowWriter<T> {
        void write(T item, CSVPrinter printer) throws IOException;
    }

    private <T> byte[] write(String[] headers, List<T> items, RowWriter<T> rowWriter) {
        try (ByteArrayOutputStream baos = new ByteArrayOutputStream();
             Writer writer = new OutputStreamWriter(baos, StandardCharsets.UTF_8);
             CSVPrinter printer = new CSVPrinter(
                     writer, CSVFormat.DEFAULT.builder().setHeader(headers).build())) {

            for (T item : items) {
                rowWriter.write(item, printer);
            }
            printer.flush();
            return baos.toByteArray();

        } catch (IOException e) {
            throw new RuntimeException("Failed to generate CSV export", e);
        }
    }
}