package com.bookflow.dto;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class ReturnBookRequest {

    @NotNull(message = "Transaction ID is required")
    private Long txnId;
}