package com.bookflow.controller;

import com.bookflow.security.BookFlowUserDetails;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DashboardController {

    @GetMapping("/dashboard")
    public String routeToDashboard(@AuthenticationPrincipal BookFlowUserDetails principal) {
        return switch (principal.getUser().getRole()) {
            case ADM -> "redirect:/admin/dashboard";
            case LIB -> "redirect:/librarian/dashboard";
            case STU -> "redirect:/student/dashboard";
        };
    }

    @GetMapping("/")
    public String home() {
        return "common/home";
    }
}