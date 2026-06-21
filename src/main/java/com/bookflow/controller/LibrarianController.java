package com.bookflow.controller;

import com.bookflow.dto.IssueBookRequest;
import com.bookflow.exception.BookFlowException;
import com.bookflow.model.Book;
import com.bookflow.model.Reservation;
import com.bookflow.model.Transaction;
import com.bookflow.security.BookFlowUserDetails;
import com.bookflow.service.*;
import jakarta.validation.Valid;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/librarian")
public class LibrarianController {

    private final IssueReturnService issueReturnService;
    private final BookService bookService;
    private final FineService fineService;
    private final ReservationService reservationService;

    public LibrarianController(IssueReturnService issueReturnService,
                                BookService bookService,
                                FineService fineService,
                                ReservationService reservationService) {
        this.issueReturnService = issueReturnService;
        this.bookService = bookService;
        this.fineService = fineService;
        this.reservationService = reservationService;
    }

    // ---- Dashboard ----

    @GetMapping("/dashboard")
    public String dashboard(@AuthenticationPrincipal BookFlowUserDetails principal, Model model) {
        model.addAttribute("user", principal.getUser());
        model.addAttribute("currentlyIssued", issueReturnService.getAllCurrentlyIssued());
        model.addAttribute("overdue", issueReturnService.getAllOverdue());
        model.addAttribute("pendingReservations", reservationService.getAllPending());
        model.addAttribute("issuedToday", issueReturnService.countIssuedToday());
        return "librarian/dashboard";
    }

    // ---- Issue Book Form ----

    @PostMapping("/issue")
    public String issueBook(@Valid @ModelAttribute IssueBookRequest request,
                             BindingResult bindingResult,
                             @AuthenticationPrincipal BookFlowUserDetails principal,
                             Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("errorMessage", "Please provide both Member ID and ISBN");
            return "redirect:/librarian/dashboard";
        }
        try {
            issueReturnService.issueBook(request, principal.getUser().getSystemId());
            return "redirect:/librarian/dashboard?issued=true";
        } catch (BookFlowException ex) {
            model.addAttribute("errorMessage", ex.getMessage());
            return "librarian/dashboard";
        }
    }

    /** AJAX — checks availability/limit/fines before confirming issue. */
    @GetMapping("/issue/precheck")
    @ResponseBody
    public Map<String, Object> precheckIssue(@RequestParam String memberId, @RequestParam String isbn) {
        try {
            Book book = bookService.getByIsbn(isbn);
            return Map.of(
                "available", book.hasAvailableCopies(),
                "bookTitle", book.getTitle(),
                "copiesLeft", book.getAvailable()
            );
        } catch (BookFlowException ex) {
            return Map.of("error", ex.getMessage());
        }
    }

    // ---- Return Book Form ----

    @PostMapping("/return")
    public String returnBook(@RequestParam Long txnId,
                              @AuthenticationPrincipal BookFlowUserDetails principal,
                              Model model) {
        try {
            issueReturnService.returnBook(txnId, principal.getUser().getSystemId());
            return "redirect:/librarian/dashboard?returned=true";
        } catch (BookFlowException ex) {
            model.addAttribute("errorMessage", ex.getMessage());
            return "librarian/dashboard";
        }
    }

    /** Fine Calculator Widget — preview overdue days/fine before confirming return. */
    @GetMapping("/return/preview")
    @ResponseBody
    public Map<String, Object> previewReturn(@RequestParam Long txnId) {
        long overdueDays = issueReturnService.previewOverdueDays(txnId);
        return Map.of("overdueDays", overdueDays);
    }

    // ---- Book Search Panel ----

    @GetMapping("/books/search")
    @ResponseBody
    public Page<Book> searchBooks(@RequestParam(required = false) String q,
                                   @RequestParam(defaultValue = "0") int page,
                                   @RequestParam(defaultValue = "10") int size) {
        return bookService.search(q, PageRequest.of(page, size));
    }

    // ---- Reservation Panel ----

    @PostMapping("/reservations/{rsvId}/fulfill")
    public String fulfillReservation(@PathVariable Long rsvId,
                                      @AuthenticationPrincipal BookFlowUserDetails principal) {
        reservationService.fulfillReservation(rsvId, principal.getUser().getSystemId());
        return "redirect:/librarian/dashboard";
    }

    // ---- Payment Receipt Panel ----

    @PostMapping("/fines/{fineId}/pay")
    public String payFine(@PathVariable Long fineId,
                           @RequestParam String paymentMode,
                           @AuthenticationPrincipal BookFlowUserDetails principal) {
        fineService.payFine(fineId, paymentMode, principal.getUser().getSystemId());
        return "redirect:/librarian/dashboard?finePaid=true";
    }

    @GetMapping("/fines/{fineId}/receipt")
    public ResponseEntity<ByteArrayResource> downloadReceipt(@PathVariable Long fineId) {
        byte[] pdf = fineService.generateReceiptPdf(fineId);
        return ResponseEntity.ok()
            .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"receipt-" + fineId + ".pdf\"")
            .contentType(MediaType.APPLICATION_PDF)
            .contentLength(pdf.length)
            .body(new ByteArrayResource(pdf));
    }

    // ---- Daily Activity Log ----

    @GetMapping("/activity")
    public String dailyActivity(Model model) {
        model.addAttribute("currentlyIssued", issueReturnService.getAllCurrentlyIssued());
        return "librarian/activity";
    }
}
