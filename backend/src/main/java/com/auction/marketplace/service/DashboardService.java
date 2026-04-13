package com.auction.marketplace.service;

import org.springframework.stereotype.Service;

import com.auction.marketplace.dto.AuctionDtos.DashboardResponse;
import com.auction.marketplace.model.UserAccount;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class DashboardService {

    private final AuctionService auctionService;

    public DashboardResponse getDashboard(UserAccount user) {
        return new DashboardResponse(
                auctionService.getUserListings(user),
                auctionService.getUserBids(user),
                auctionService.getWinningAuctions(user)
        );
    }
}
