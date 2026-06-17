package com.bookflow.controller;

import com.bookflow.dto.RegistrationRequest;
import com.bookflow.exception.BookFlowException;
import com.bookflow.model.User;
import com.bookflow.service.UserService;
import jakarta.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/auth")
public class AuthController {

    private final UserService userService;

    public AuthController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/login")
    public String loginPage(@RequestParam(value = "error", required = false) String error,
                            @RequestParam(value = "logout", required = false) String logout,
                            @RequestParam(value = "expired", required = false) String expired,
                            Model model) {
        if (error != null) {
            model.addAttribute("errorMessage", "Invalid System ID or password.");
        }
        if (logout != null) {
            model.addAttribute("infoMessage", "You have been logged out successfully.");
        }
        if (expired != null) {
            model.addAttribute("infoMessage", "Your session has expired. Please log in again.");
        }
        return "auth/login";
    }

    @GetMapping("/register")
    public String registerPage(Model model) {
        model.addAttribute("registrationRequest", new RegistrationRequest());
        model.addAttribute("roles", User.Role.values());
        return "auth/register";
    }

    @PostMapping("/register")
    public String register(@Valid @ModelAttribute("registrationRequest") RegistrationRequest request,
                           BindingResult bindingResult,
                           Model model) {

        if (bindingResult.hasErrors()) {
            model.addAttribute("roles", User.Role.values());
            return "auth/register";
        }

        try {
            User newUser = userService.register(request);
            model.addAttribute("successMessage",
                    "Account created! Your System ID is: " + newUser.getSystemId() + ". Please log in.");
            return "auth/login";
        } catch (BookFlowException ex) {
            model.addAttribute("errorMessage", ex.getMessage());
            model.addAttribute("roles", User.Role.values());
            return "auth/register";
        }
    }

    @GetMapping("/test")
    @ResponseBody
    public String testEndpoint() {
        return "Auth controller is reachable, no JSP involved.";
    }
    @GetMapping("/bare")
    public String barePage() {
        return "auth/bare";
    }
    @GetMapping("/forgot-password")
    public String forgotPasswordPage() {
        return "auth/forgot-password";
    }
}
