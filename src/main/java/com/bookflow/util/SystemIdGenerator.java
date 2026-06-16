package com.bookflow.util;

import com.bookflow.model.User;
import com.bookflow.repository.UserRepository;
import org.springframework.stereotype.Component;

import java.security.SecureRandom;

/**
 * Generates unique System IDs for new user accounts.
 *
 * Format: FIRSTNAME + 6DIGITS + ROLECODE
 * Examples:
 *   MAYANK481920ADM
 *   PRIYA095312STU
 *   RAHUL273641LIB
 *
 * Uses SecureRandom for the 6-digit segment.
 * Retries on collision (extremely rare but handled).
 */
@Component
public class SystemIdGenerator {

    private static final SecureRandom RANDOM = new SecureRandom();
    private static final int MAX_RETRIES = 10;

    private final UserRepository userRepository;

    public SystemIdGenerator(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    /**
     * Generates a unique System ID for the given user.
     *
     * @param firstName the user's first name (any case — uppercased internally)
     * @param role      the user's role (ADM / LIB / STU)
     * @return unique system ID string
     * @throws IllegalStateException if a unique ID cannot be generated after MAX_RETRIES
     */
    public String generate(String firstName, User.Role role) {
        String nameSegment = sanitize(firstName);
        String roleCode    = role.getRoleCode();

        for (int attempt = 0; attempt < MAX_RETRIES; attempt++) {
            String digits   = generateSixDigits();
            String systemId = nameSegment + digits + roleCode;

            if (!userRepository.existsById(systemId)) {
                return systemId;
            }
        }

        throw new IllegalStateException(
                "Could not generate a unique System ID for: " + firstName + " after " + MAX_RETRIES + " attempts"
        );
    }

    // ---- Private helpers ----

    /**
     * Strips non-alpha chars and uppercases the first name.
     * Max 15 characters to keep the full ID under 25 chars.
     */
    private String sanitize(String firstName) {
        return firstName
                .toUpperCase()
                .replaceAll("[^A-Z]", "")
                .substring(0, Math.min(firstName.replaceAll("[^A-Za-z]", "").length(), 15));
    }

    /** Generates a 6-digit zero-padded string: 000000 – 999999 */
    private String generateSixDigits() {
        int n = RANDOM.nextInt(1_000_000);
        return String.format("%06d", n);
    }
}