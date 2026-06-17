package com.bookflow.controller;

import com.bookflow.exception.BookFlowException;
import com.bookflow.model.Book;
import com.bookflow.model.Fine;
import com.bookflow.model.Transaction;
import com.bookflow.model.User;
import com.bookflow.security.BookFlowUserDetails;
import com.bookflow.service.*;
import com.fasterxml.jackson.databind.JsonNode;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;

@Controller
@RequestMapping("/student")
public class StudentController {

    private final IssueReturnService issueReturnService;
    private final FineService fineService;
    private final BookService bookService;
    private final ReservationService reservationService;
    private final GeminiService geminiService;
    private final com.bookflow.util.PdfReceiptGenerator pdfReceiptGenerator;

    public StudentController(IssueReturnService issueReturnService,
                             FineService fineService,
                             BookService bookService,
                             ReservationService reservationService,
                             GeminiService geminiService,
                             com.bookflow.util.PdfReceiptGenerator pdfReceiptGenerator) {
        this.issueReturnService = issueReturnService;
        this.fineService = fineService;
        this.bookService = bookService;
        this.reservationService = reservationService;
        this.geminiService = geminiService;
        this.pdfReceiptGenerator = pdfReceiptGenerator;
    }

    // ---- Dashboard ----

    @GetMapping("/dashboard")
    public String dashboard(@AuthenticationPrincipal BookFlowUserDetails principal, Model model) {
        User student = principal.getUser();

        List<Transaction> borrowed = issueReturnService.getActiveTransactionsForMember(student.getSystemId());
        BigDecimal fineBalance = fineService.getTotalOutstanding(student);
        JsonNode recommendations = geminiService.getRecommendations(student);

        model.addAttribute("user", student);
        model.addAttribute("borrowedBooks", borrowed);
        model.addAttribute("fineBalance", fineBalance);
        model.addAttribute("recommendations", recommendations);
        model.addAttribute("dueSoonCount", borrowed.stream().filter(Transaction::isDueSoon).count());

        return "student/dashboard";
    }

    /** AI Recommendations widget — lazy-loaded via AJAX if preferred. */
    @GetMapping("/recommendations")
    @ResponseBody
    public JsonNode recommendations(@AuthenticationPrincipal BookFlowUserDetails principal) {
        return geminiService.getRecommendations(principal.getUser());
    }

    // ---- Book Catalogue Browser ----

    @GetMapping("/books")
    public String browseCatalogue(@RequestParam(required = false) String q,
                                  @RequestParam(defaultValue = "0") int page,
                                  Model model) {
        Page<Book> books = bookService.search(q, PageRequest.of(page, 12));
        model.addAttribute("books", books);
        model.addAttribute("query", q);
        return "student/catalogue";
    }

    // ---- Borrow History ----

    @GetMapping("/history")
    public String borrowHistory(@AuthenticationPrincipal BookFlowUserDetails principal, Model model) {
        model.addAttribute("history", issueReturnService.getHistoryForMember(principal.getUser().getSystemId()));
        return "student/history";
    }

    // ---- Fine Balance & History ----

    @GetMapping("/fines")
    public String fines(@AuthenticationPrincipal BookFlowUserDetails principal, Model model) {
        User student = principal.getUser();
        model.addAttribute("outstanding", fineService.getOutstandingForMember(student));
        model.addAttribute("history", fineService.getHistoryForMember(student));
        model.addAttribute("totalOutstanding", fineService.getTotalOutstanding(student));
        return "student/fines";
    }

    @GetMapping("/fines/{fineId}/receipt")
    public ResponseEntity<ByteArrayResource> downloadFineReceipt(@PathVariable Long fineId) {
        byte[] pdf = fineService.generateReceiptPdf(fineId);
        return buildPdfResponse(pdf, "fine-receipt-" + fineId + ".pdf");
    }

    // ---- Reserve a Book ----

    @PostMapping("/reserve")
    public String reserveBook(@RequestParam String isbn,
                              @AuthenticationPrincipal BookFlowUserDetails principal,
                              Model model) {
        try {
            reservationService.reserveBook(principal.getUser(), isbn);
            return "redirect:/student/books?reserved=true";
        } catch (BookFlowException ex) {
            model.addAttribute("errorMessage", ex.getMessage());
            return "redirect:/student/books?error=" + ex.getMessage();
        }
    }

    @GetMapping("/reservations")
    public String myReservations(@AuthenticationPrincipal BookFlowUserDetails principal, Model model) {
        model.addAttribute("reservations", reservationService.getForMember(principal.getUser()));
        return "student/reservations";
    }

    // ---- Profile ----

    @GetMapping("/profile")
    public String profile(@AuthenticationPrincipal BookFlowUserDetails principal, Model model) {
        model.addAttribute("user", principal.getUser());
        return "student/profile";
    }

    @GetMapping("/download-receipt")
    public ResponseEntity<ByteArrayResource> downloadBorrowReceipt(
            @AuthenticationPrincipal BookFlowUserDetails principal) {
        User student = principal.getUser();
        List<Transaction> history = issueReturnService.getHistoryForMember(student.getSystemId());

        byte[] pdf = pdfReceiptGenerator.generateBorrowHistory(student.getFullName(), student.getSystemId(), history);

        return buildPdfResponse(pdf, "borrow-history-" + student.getSystemId() + ".pdf");
    }

    private ResponseEntity<ByteArrayResource> buildPdfResponse(byte[] data, String filename) {
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + filename + "\"")
                .contentType(MediaType.APPLICATION_PDF)
                .contentLength(data.length)
                .body(new ByteArrayResource(data));
    }
}