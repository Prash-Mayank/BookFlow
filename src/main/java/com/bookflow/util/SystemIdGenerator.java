package com.bookflow.util;

import com.bookflow.model.User;
import com.bookflow.repository.UserRepository;
import org.springframework.stereotype.Component;

import java.security.SecureRandom;

@Component
public class SystemIdGenerator {

    private static final SecureRandom RANDOM = new SecureRandom();
    private static final int MAX_RETRIES = 10;

    private final UserRepository userRepository;

    public SystemIdGenerator(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

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

    private String sanitize(String firstName) {
        String lettersOnly = firstName.replaceAll("[^A-Za-z]", "").toUpperCase();
        return lettersOnly.substring(0, Math.min(lettersOnly.length(), 15));
    }

    private String generateSixDigits() {
        int n = RANDOM.nextInt(1_000_000);
        return String.format("%06d", n);
    }
}