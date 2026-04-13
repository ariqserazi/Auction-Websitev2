package com.auction.marketplace.exception;

public class ApiException extends RuntimeException {

    public ApiException(String message) {
        super(message);
    }
}
