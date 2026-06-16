package com.bookflow.exception;

public class BookFlowException extends RuntimeException {

    public BookFlowException(String message) {
        super(message);
    }

    public BookFlowException(String message, Throwable cause) {
        super(message, cause);
    }
}