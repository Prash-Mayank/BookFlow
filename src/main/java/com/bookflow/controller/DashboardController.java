package com.bookflow.controller;

import com.bookflow.security.BookFlowUserDetails;
import com.bookflow.service.ReportService;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.Map;
@Controller
public class DashboardController {

    private final ReportService reportService;

    public DashboardController(ReportService reportService) {
        this.reportService = reportService;
    }

    @GetMapping("/dashboard")
    public String routeToDashboard(@AuthenticationPrincipal BookFlowUserDetails principal) {
        return switch (principal.getUser().getRole()) {
            case ADM -> "redirect:/admin/dashboard";
            case LIB -> "redirect:/librarian/dashboard";
            case STU -> "redirect:/student/dashboard";
        };
    }

    @GetMapping("/")
    public String home(Model model) {
        Map<String, Object> stats = reportService.getAdminDashboardStats();
        model.addAttribute("totalBooks", stats.get("totalBooks"));
        model.addAttribute("totalMembers", stats.get("totalMembers"));
        model.addAttribute("booksIssuedToday", stats.get("booksIssuedToday"));
        model.addAttribute("totalFinesCollected", stats.get("totalFinesCollected"));
        return "common/home";
    }
}