package com.bookflow.dto;

import com.bookflow.model.Book;
import jakarta.validation.constraints.*;
import lombok.Data;

@Data
public class BookRequest {

    @NotBlank(message = "ISBN is required")
    @Size(min = 10, max = 13, message = "ISBN must be 10-13 characters")
    private String isbn;

    @NotBlank(message = "Title is required")
    private String title;

    @NotBlank(message = "Author is required")
    private String author;

    @NotNull(message = "Category is required")
    private Book.BookCategory category;

    private String publisher;

    private Integer year;

    private String description;

    private String language;

    private Integer pages;

    @Min(value = 1, message = "Total copies must be at least 1")
    private int totalCopies = 1;
}