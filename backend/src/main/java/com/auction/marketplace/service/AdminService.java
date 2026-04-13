package com.auction.marketplace.service;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.auction.marketplace.dto.AdminDtos.AdminAuctionResponse;
import com.auction.marketplace.dto.AdminDtos.AdminAuctionUpdateRequest;
import com.auction.marketplace.dto.AdminDtos.AdminOverviewResponse;
import com.auction.marketplace.dto.AdminDtos.AdminUserResponse;
import com.auction.marketplace.dto.AdminDtos.AdminUserUpdateRequest;
import com.auction.marketplace.exception.BadRequestException;
import com.auction.marketplace.exception.ResourceNotFoundException;
import com.auction.marketplace.model.Auction;
import com.auction.marketplace.model.AuctionStatus;
import com.auction.marketplace.model.Bid;
import com.auction.marketplace.model.ListingStatus;
import com.auction.marketplace.model.UserAccount;
import com.auction.marketplace.repository.AuctionRepository;
import com.auction.marketplace.repository.BidRepository;
import com.auction.marketplace.repository.ListingRepository;
import com.auction.marketplace.repository.UserRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminService {

    private final UserRepository userRepository;
    private final AuctionRepository auctionRepository;
    private final ListingRepository listingRepository;
    private final BidRepository bidRepository;

    @Transactional(readOnly = true)
    public AdminOverviewResponse getOverview() {
        BigDecimal grossBidVolume = bidRepository.findAll()
                .stream()
                .map(Bid::getAmount)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        return new AdminOverviewResponse(
                userRepository.countByEnabledTrue(),
                auctionRepository.countByAuctionStatus(AuctionStatus.ACTIVE),
                auctionRepository.countByAuctionStatus(AuctionStatus.CLOSED),
                listingRepository.countByStatus(ListingStatus.ACTIVE),
                grossBidVolume,
                List.of(
                        "Flagged listings are hidden from bidding immediately.",
                        "Closed auctions compute reserve outcomes automatically.",
                        "Admin role changes take effect on the next authenticated request."
                )
        );
    }

    @Transactional(readOnly = true)
    public List<AdminUserResponse> getUsers() {
        return userRepository.findAll()
                .stream()
                .map(user -> new AdminUserResponse(
                        user.getId(),
                        user.getFirstName() + " " + user.getLastName(),
                        user.getEmail(),
                        user.getRole(),
                        user.isEnabled()
                ))
                .toList();
    }

    @Transactional
    public AdminUserResponse updateUser(Long userId, AdminUserUpdateRequest request) {
        UserAccount user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));

        if (request.role() != null) {
            user.setRole(request.role());
        }
        if (request.enabled() != null) {
            user.setEnabled(request.enabled());
        }

        UserAccount saved = userRepository.save(user);
        return new AdminUserResponse(
                saved.getId(),
                saved.getFirstName() + " " + saved.getLastName(),
                saved.getEmail(),
                saved.getRole(),
                saved.isEnabled()
        );
    }

    @Transactional(readOnly = true)
    public List<AdminAuctionResponse> getAuctions() {
        return auctionRepository.findAll()
                .stream()
                .map(auction -> new AdminAuctionResponse(
                        auction.getId(),
                        auction.getListing().getTitle(),
                        auction.getSeller().getFirstName() + " " + auction.getSeller().getLastName(),
                        auction.getStatus(),
                        auction.getListing().getStatus()
                ))
                .toList();
    }

    @Transactional
    public AdminAuctionResponse updateAuction(Long auctionId, AdminAuctionUpdateRequest request) {
        Auction auction = auctionRepository.findById(auctionId)
                .orElseThrow(() -> new ResourceNotFoundException("Auction not found"));

        ListingStatus targetStatus;
        try {
            targetStatus = ListingStatus.valueOf(request.listingStatus().trim().toUpperCase());
        } catch (IllegalArgumentException exception) {
            throw new BadRequestException("listingStatus must be ACTIVE, FLAGGED, or REMOVED");
        }

        auction.getListing().setStatus(targetStatus);
        if (request.closingNote() != null && !request.closingNote().isBlank()) {
            auction.setClosingNote(request.closingNote().trim());
        }
        if (targetStatus != ListingStatus.ACTIVE && auction.getStatus() == AuctionStatus.ACTIVE) {
            auction.setStatus(AuctionStatus.CLOSED);
        }

        Auction saved = auctionRepository.save(auction);
        return new AdminAuctionResponse(
                saved.getId(),
                saved.getListing().getTitle(),
                saved.getSeller().getFirstName() + " " + saved.getSeller().getLastName(),
                saved.getStatus(),
                saved.getListing().getStatus()
        );
    }
}
