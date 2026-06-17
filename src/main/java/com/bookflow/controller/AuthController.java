package com.bookflow.controller;

import com.bookflow.dto.RegistrationRequest;
import com.bookflow.exception.BookFlowException;
import com.bookflow.model.PasswordResetToken;
import com.bookflow.model.User;
import com.bookflow.service.PasswordResetService;
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
    private final PasswordResetService passwordResetService;

    public AuthController(UserService userService, PasswordResetService passwordResetService) {
        this.userService = userService;
        this.passwordResetService = passwordResetService;
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
            String firstError = bindingResult.getAllErrors().get(0).getDefaultMessage();
            model.addAttribute("errorMessage", firstError);
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

    // ---- Forgot Password (request a reset link) ----

    @GetMapping("/forgot-password")
    public String forgotPasswordPage() {
        return "auth/forgot-password";
    }

    @PostMapping("/forgot-password")
    public String forgotPasswordSubmit(@RequestParam String email, Model model) {
        // Always show the same confirmation, whether or not the email exists,
        // to avoid revealing which emails have accounts.
        passwordResetService.requestReset(email);
        model.addAttribute("submitted", true);
        model.addAttribute("submittedEmail", email);
        return "auth/forgot-password";
    }

    // ---- Reset Password (set a new password via emailed link) ----

    @GetMapping("/reset-password")
    public String resetPasswordPage(@RequestParam String token, Model model) {
        try {
            PasswordResetToken resetToken = passwordResetService.validateToken(token);
            model.addAttribute("token", token);
            model.addAttribute("userFirstName", resetToken.getUser().getFirstName());
            return "auth/reset-password";
        } catch (BookFlowException ex) {
            model.addAttribute("errorMessage", ex.getMessage());
            model.addAttribute("invalidToken", true);
            return "auth/reset-password";
        }
    }

    @PostMapping("/reset-password")
    public String resetPasswordSubmit(@RequestParam String token,
                                      @RequestParam String password,
                                      @RequestParam String confirmPassword,
                                      Model model) {
        try {
            passwordResetService.completeReset(token, password, confirmPassword);
            model.addAttribute("successMessage", "Your password has been reset. Please log in with your new password.");
            return "auth/login";
        } catch (BookFlowException ex) {
            model.addAttribute("errorMessage", ex.getMessage());
            model.addAttribute("token", token);
            return "auth/reset-password";
        }
    }
}