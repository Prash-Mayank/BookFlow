package com.bookflow.exception;

/**
 * Thrown when business-rule validation fails
 * (e.g. weak password, duplicate email, borrow limit exceeded).
 */
public class BookFlowException extends RuntimeException {

    public BookFlowException(String message) {
        super(message);
    }

    public BookFlowException(String message, Throwable cause) {
        super(message, cause);
    }
}