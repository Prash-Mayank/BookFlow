package com.bookflow.controller;

import com.bookflow.dto.BookRequest;
import com.bookflow.exception.BookFlowException;
import com.bookflow.model.Book;
import com.bookflow.model.User;
import com.bookflow.security.BookFlowUserDetails;
import com.bookflow.service.*;
import jakarta.validation.Valid;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminController {

    private final ReportService reportService;
    private final BookService bookService;
    private final UserService userService;
    private final FineService fineService;

    public AdminController(ReportService reportService,
                            BookService bookService,
                            UserService userService,
                            FineService fineService) {
        this.reportService = reportService;
        this.bookService = bookService;
        this.userService = userService;
        this.fineService = fineService;
    }

    // ---- Dashboard ----

    @GetMapping("/dashboard")
    public String dashboard(@AuthenticationPrincipal BookFlowUserDetails principal, Model model) {
        Map<String, Object> stats = reportService.getAdminDashboardStats();
        model.addAttribute("stats", stats);
        model.addAttribute("user", principal.getUser());
        model.addAttribute("overdueBooks", reportService.getOverdueBooks());
        model.addAttribute("librarianCount", userService.getAllByRole(User.Role.LIB).size());
        model.addAttribute("studentCount", userService.getAllByRole(User.Role.STU).size());
        model.addAttribute("availableBookCount", bookService.getAvailableBookCount());
        return "admin/dashboard";
    }

    /** AJAX endpoint — stat cards auto-refresh every 30s. */
    @GetMapping("/dashboard/stats")
    @ResponseBody
    public Map<String, Object> dashboardStats() {
        return reportService.getAdminDashboardStats();
    }

    // ---- Book Catalogue Management ----

    @GetMapping("/books")
    public String listBooks(Model model) {
        model.addAttribute("books", bookService.getAll());
        model.addAttribute("categories", Book.BookCategory.values());
        return "admin/books";
    }

    @PostMapping("/books")
    public String addBook(@Valid @ModelAttribute BookRequest request,
                           BindingResult bindingResult,
                           @RequestParam(required = false) MultipartFile coverImage,
                           @AuthenticationPrincipal BookFlowUserDetails principal,
                           Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("books", bookService.getAll());
            model.addAttribute("categories", Book.BookCategory.values());
            return "admin/books";
        }
        try {
            bookService.addBook(request, coverImage, principal.getUser().getSystemId());
            return "redirect:/admin/books";
        } catch (BookFlowException ex) {
            model.addAttribute("errorMessage", ex.getMessage());
            model.addAttribute("books", bookService.getAll());
            model.addAttribute("categories", Book.BookCategory.values());
            return "admin/books";
        }
    }

    @PostMapping("/books/{isbn}/edit")
    public String editBook(@PathVariable String isbn,
                            @Valid @ModelAttribute BookRequest request,
                            @RequestParam(required = false) MultipartFile coverImage,
                            @AuthenticationPrincipal BookFlowUserDetails principal) {
        bookService.updateBook(isbn, request, coverImage, principal.getUser().getSystemId());
        return "redirect:/admin/books";
    }

    @PostMapping("/books/{isbn}/delete")
    public String deleteBook(@PathVariable String isbn,
                              @AuthenticationPrincipal BookFlowUserDetails principal) {
        bookService.deleteBook(isbn, principal.getUser().getSystemId());
        return "redirect:/admin/books";
    }

    // ---- User Management ----

    @GetMapping("/users")
    public String listUsers(Model model) {
        model.addAttribute("students", userService.getAllByRole(User.Role.STU));
        model.addAttribute("librarians", userService.getAllByRole(User.Role.LIB));
        model.addAttribute("admins", userService.getAllByRole(User.Role.ADM));
        return "admin/users";
    }

    @PostMapping("/users/{systemId}/reset-password")
    public String resetPassword(@PathVariable String systemId,
                                 @RequestParam String newPassword,
                                 @AuthenticationPrincipal BookFlowUserDetails principal,
                                 Model model) {
        try {
            userService.resetPassword(systemId, newPassword, principal.getUser().getSystemId());
        } catch (BookFlowException ex) {
            model.addAttribute("errorMessage", ex.getMessage());
        }
        return "redirect:/admin/users";
    }

    @PostMapping("/users/{systemId}/delete")
    public String deleteUser(@PathVariable String systemId,
                              @AuthenticationPrincipal BookFlowUserDetails principal,
                              org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes) {
        try {
            userService.deleteUser(systemId, principal.getUser().getSystemId());
        } catch (BookFlowException ex) {
            redirectAttributes.addFlashAttribute("errorMessage", ex.getMessage());
        } catch (org.springframework.dao.DataIntegrityViolationException ex) {
            redirectAttributes.addFlashAttribute("errorMessage",
                "Cannot delete this account — it has existing borrow/fine history. Lock the account instead.");
        }
        return "redirect:/admin/users";
    }

    @PostMapping("/users/{systemId}/toggle-lock")
    public String toggleLock(@PathVariable String systemId,
                              @AuthenticationPrincipal BookFlowUserDetails principal) {
        userService.toggleLock(systemId, principal.getUser().getSystemId());
        return "redirect:/admin/users";
    }

    // ---- Fine Waiver ----

    @PostMapping("/fines/{fineId}/waive")
    public String waiveFine(@PathVariable Long fineId,
                             @RequestParam String reason,
                             @AuthenticationPrincipal BookFlowUserDetails principal) {
        fineService.waiveFine(fineId, reason, principal.getUser().getSystemId());
        return "redirect:/admin/dashboard";
    }

    // ---- Reports & Export ----

    @GetMapping("/reports/export/pdf")
    public ResponseEntity<ByteArrayResource> exportOverduePdf(
            @AuthenticationPrincipal BookFlowUserDetails principal) {
        byte[] pdf = reportService.exportOverdueReportPdf();
        reportService.logExport(principal.getUser().getSystemId(), "Overdue Report (PDF)");
        return buildFileResponse(pdf, "overdue-report.pdf", MediaType.APPLICATION_PDF);
    }

    @GetMapping("/reports/export/csv")
    public ResponseEntity<ByteArrayResource> exportCsv(
            @RequestParam(defaultValue = "books") String type,
            @AuthenticationPrincipal BookFlowUserDetails principal) {

        byte[] csv = switch (type) {
            case "transactions" -> reportService.exportTransactionsCsv();
            case "users" -> reportService.exportUsersCsv();
            default -> reportService.exportBooksCsv();
        };

        reportService.logExport(principal.getUser().getSystemId(), type + " (CSV)");
        return buildFileResponse(csv, type + "-report.csv", MediaType.parseMediaType("text/csv"));
    }

    private ResponseEntity<ByteArrayResource> buildFileResponse(byte[] data, String filename, MediaType type) {
        return ResponseEntity.ok()
            .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + filename + "\"")
            .contentType(type)
            .contentLength(data.length)
            .body(new ByteArrayResource(data));
    }
}
