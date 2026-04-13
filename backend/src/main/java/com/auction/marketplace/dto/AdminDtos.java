package com.auction.marketplace.dto;

import java.math.BigDecimal;
import java.util.List;

import com.auction.marketplace.model.AuctionStatus;
import com.auction.marketplace.model.ListingStatus;
import com.auction.marketplace.model.Role;

import jakarta.validation.constraints.NotBlank;

public final class AdminDtos {

    private AdminDtos() {
    }

    public record AdminOverviewResponse(
            long totalUsers,
            long activeAuctions,
            long closedAuctions,
            long activeListings,
            BigDecimal grossBidVolume,
            List<String> spotlightMetrics
    ) {
    }

    public record AdminUserResponse(
            Long id,
            String fullName,
            String email,
            Role role,
            boolean enabled
    ) {
    }

    public record AdminUserUpdateRequest(
            Role role,
            Boolean enabled
    ) {
    }

    public record AdminAuctionResponse(
            Long auctionId,
            String title,
            String sellerName,
            AuctionStatus status,
            ListingStatus listingStatus
    ) {
    }

    public record AdminAuctionUpdateRequest(
            @NotBlank String listingStatus,
            String closingNote
    ) {
    }
}
