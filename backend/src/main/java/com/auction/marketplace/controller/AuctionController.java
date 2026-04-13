package com.auction.marketplace.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import com.auction.marketplace.dto.AuctionDtos.AuctionCardResponse;
import com.auction.marketplace.dto.AuctionDtos.AuctionDetailResponse;
import com.auction.marketplace.dto.AuctionDtos.CreateAuctionRequest;
import com.auction.marketplace.dto.AuctionDtos.PlaceBidRequest;
import com.auction.marketplace.model.UserAccount;
import com.auction.marketplace.service.AuctionService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/auctions")
@RequiredArgsConstructor
public class AuctionController {

    private final AuctionService auctionService;

    @GetMapping
    public List<AuctionCardResponse> getAuctions(
            @RequestParam(required = false) String query,
            @RequestParam(required = false) String category,
            @RequestParam(required = false) String size,
            @RequestParam(required = false) String condition
    ) {
        return auctionService.searchAuctions(query, category, size, condition);
    }

    @GetMapping("/featured")
    public List<AuctionCardResponse> getFeaturedAuctions() {
        return auctionService.getFeaturedAuctions();
    }

    @GetMapping("/{auctionId}")
    public AuctionDetailResponse getAuction(@PathVariable Long auctionId) {
        return auctionService.getAuctionDetail(auctionId);
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public AuctionDetailResponse createAuction(
            @Valid @RequestBody CreateAuctionRequest request,
            @AuthenticationPrincipal UserAccount user
    ) {
        return auctionService.createAuction(request, user);
    }

    @PostMapping("/{auctionId}/bids")
    public AuctionDetailResponse placeBid(
            @PathVariable Long auctionId,
            @Valid @RequestBody PlaceBidRequest request,
            @AuthenticationPrincipal UserAccount user
    ) {
        return auctionService.placeBid(auctionId, request, user);
    }
}
