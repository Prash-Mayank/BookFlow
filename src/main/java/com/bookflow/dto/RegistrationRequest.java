package com.bookflow.dto;

import com.bookflow.model.User;
import jakarta.validation.constraints.*;
import lombok.Data;

/**
 * Captures registration form input.
 * Password complexity rules are enforced separately per role
 * in UserService, since they differ by role:
 *   Admin:     8+ chars, 1 uppercase, 1 special char
 *   Librarian: 8+ chars, 1 uppercase, 1 number
 *   Student:   6+ chars, 1 number
 */
@Data
public class RegistrationRequest {

    @NotBlank(message = "First name is required")
    private String firstName;

    @NotBlank(message = "Last name is required")
    private String lastName;

    @NotBlank(message = "Email is required")
    @Email(message = "Enter a valid email address")
    private String email;

    @NotBlank(message = "Phone number is required")
    @Pattern(regexp = "^[6-9]\\d{9}$", message = "Enter a valid 10-digit phone number")
    private String phone;

    @NotBlank(message = "Password is required")
    private String password;

    @NotBlank(message = "Please confirm your password")
    private String confirmPassword;

    @NotNull(message = "Please select a role")
    private User.Role role;

    private boolean agreedToTerms;

    public boolean passwordsMatch() {
        return password != null && password.equals(confirmPassword);
    }
}