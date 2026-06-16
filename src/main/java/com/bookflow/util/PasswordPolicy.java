package com.bookflow.util;

import com.bookflow.model.User;
import com.bookflow.exception.BookFlowException;

import java.util.regex.Pattern;

/**
 * Validates passwords according to role-specific complexity rules
 * defined in the Implementation Plan:
 *
 *   Admin (ADM)     : 8+ chars, 1 uppercase, 1 special char (!@#$%...)
 *   Librarian (LIB) : 8+ chars, 1 uppercase, 1 number
 *   Student (STU)   : 6+ chars, at least 1 number
 */
public final class PasswordPolicy {

    private static final Pattern UPPERCASE = Pattern.compile("[A-Z]");
    private static final Pattern DIGIT     = Pattern.compile("[0-9]");
    private static final Pattern SPECIAL   = Pattern.compile("[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>/?]");

    private PasswordPolicy() {}

    /**
     * Validates the password against the rule for the given role.
     * Throws BookFlowException with a user-friendly message if invalid.
     */
    public static void validate(String password, User.Role role) {
        if (password == null) {
            throw new BookFlowException("Password is required");
        }

        switch (role) {
            case ADM -> {
                if (password.length() < 8)
                    throw new BookFlowException("Admin password must be at least 8 characters long");
                if (!UPPERCASE.matcher(password).find())
                    throw new BookFlowException("Admin password must contain at least 1 uppercase letter");
                if (!SPECIAL.matcher(password).find())
                    throw new BookFlowException("Admin password must contain at least 1 special character (!@#$%...)");
            }
            case LIB -> {
                if (password.length() < 8)
                    throw new BookFlowException("Librarian password must be at least 8 characters long");
                if (!UPPERCASE.matcher(password).find())
                    throw new BookFlowException("Librarian password must contain at least 1 uppercase letter");
                if (!DIGIT.matcher(password).find())
                    throw new BookFlowException("Librarian password must contain at least 1 number");
            }
            case STU -> {
                if (password.length() < 6)
                    throw new BookFlowException("Student password must be at least 6 characters long");
                if (!DIGIT.matcher(password).find())
                    throw new BookFlowException("Student password must contain at least 1 number");
            }
        }
    }

    /** Returns the BCrypt strength to use for a given role, per spec. */
    public static int bcryptStrengthFor(User.Role role) {
        return switch (role) {
            case ADM, LIB -> 12;
            case STU -> 10;
        };
    }

    /** Returns a human-readable rule description, used for UI hints. */
    public static String ruleDescriptionFor(User.Role role) {
        return switch (role) {
            case ADM -> "Min 8 characters, 1 uppercase letter, 1 special character";
            case LIB -> "Min 8 characters, 1 uppercase letter, 1 number";
            case STU -> "Min 6 characters, at least 1 number";
        };
    }
}