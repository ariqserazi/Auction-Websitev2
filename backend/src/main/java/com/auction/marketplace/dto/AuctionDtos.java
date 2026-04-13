package com.auction.marketplace.dto;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.List;

import com.auction.marketplace.model.AuctionStatus;
import com.auction.marketplace.model.ListingStatus;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Future;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

public final class AuctionDtos {

    private AuctionDtos() {
    }

    public record CreateAuctionRequest(
            @NotBlank @Size(max = 120) String title,
            @NotBlank @Size(max = 80) String brand,
            @NotBlank @Size(max = 60) String category,
            @NotBlank @Size(max = 20) String size,
            @NotBlank @Size(max = 30) String condition,
            @NotBlank @Size(max = 40) String color,
            @NotBlank @Size(max = 2000) String description,
            @NotBlank @Size(max = 500) String imageUrl,
            @NotNull @DecimalMin(value = "1.00") BigDecimal startingPrice,
            @NotNull @DecimalMin(value = "1.00") BigDecimal bidIncrement,
            @DecimalMin(value = "0.00") BigDecimal reservePrice,
            @NotNull @Future Instant endTime
    ) {
    }

    public record PlaceBidRequest(
            @NotNull @DecimalMin(value = "1.00") BigDecimal amount
    ) {
    }

    public record AuctionCardResponse(
            Long auctionId,
            String title,
            String brand,
            String category,
            String size,
            String condition,
            String color,
            String imageUrl,
            BigDecimal currentPrice,
            BigDecimal bidIncrement,
            BigDecimal reservePrice,
            Instant endTime,
            String sellerName,
            AuctionStatus status
    ) {
    }

    public record BidHistoryResponse(
            Long bidId,
            BigDecimal amount,
            Instant createdAt,
            Long bidderId,
            String bidderName,
            boolean winningBid
    ) {
    }

    public record AuctionDetailResponse(
            Long auctionId,
            AuctionStatus status,
            Long listingId,
            String title,
            String brand,
            String category,
            String size,
            String condition,
            String color,
            String description,
            String imageUrl,
            BigDecimal startingPrice,
            BigDecimal currentPrice,
            BigDecimal reservePrice,
            BigDecimal bidIncrement,
            Instant startTime,
            Instant endTime,
            String sellerName,
            Long sellerId,
            ListingStatus listingStatus,
            String winnerName,
            String closingNote,
            List<BidHistoryResponse> bidHistory
    ) {
    }

    public record DashboardAuctionResponse(
            Long auctionId,
            String title,
            String imageUrl,
            AuctionStatus status,
            BigDecimal currentPrice,
            Instant endTime
    ) {
    }

    public record DashboardBidResponse(
            Long bidId,
            Long auctionId,
            String title,
            BigDecimal amount,
            Instant createdAt,
            boolean winningBid
    ) {
    }

    public record DashboardResponse(
            List<DashboardAuctionResponse> myListings,
            List<DashboardBidResponse> recentBids,
            List<DashboardAuctionResponse> wins
    ) {
    }
}
