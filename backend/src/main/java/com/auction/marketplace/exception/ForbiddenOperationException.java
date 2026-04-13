package com.auction.marketplace.exception;

public class ForbiddenOperationException extends ApiException {

    public ForbiddenOperationException(String message) {
        super(message);
    }
}
