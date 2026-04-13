package com.auction.marketplace.service;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class AuctionSettlementScheduler {

    private final AuctionService auctionService;

    @Scheduled(fixedDelay = 60000)
    public void settleAuctions() {
        auctionService.settleExpiredAuctions();
    }
}
