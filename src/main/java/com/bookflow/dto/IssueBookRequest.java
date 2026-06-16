package com.bookflow.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class IssueBookRequest {

    @NotBlank(message = "Member ID is required")
    private String memberId;

    @NotBlank(message = "Book ISBN is required")
    private String isbn;
}