package com.auction.marketplace.service;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.Comparator;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.auction.marketplace.dto.AuctionDtos.AuctionCardResponse;
import com.auction.marketplace.dto.AuctionDtos.AuctionDetailResponse;
import com.auction.marketplace.dto.AuctionDtos.BidHistoryResponse;
import com.auction.marketplace.dto.AuctionDtos.CreateAuctionRequest;
import com.auction.marketplace.dto.AuctionDtos.DashboardAuctionResponse;
import com.auction.marketplace.dto.AuctionDtos.DashboardBidResponse;
import com.auction.marketplace.dto.AuctionDtos.PlaceBidRequest;
import com.auction.marketplace.exception.BadRequestException;
import com.auction.marketplace.exception.ForbiddenOperationException;
import com.auction.marketplace.exception.ResourceNotFoundException;
import com.auction.marketplace.model.Auction;
import com.auction.marketplace.model.AuctionStatus;
import com.auction.marketplace.model.Bid;
import com.auction.marketplace.model.Listing;
import com.auction.marketplace.model.ListingStatus;
import com.auction.marketplace.model.UserAccount;
import com.auction.marketplace.repository.AuctionRepository;
import com.auction.marketplace.repository.BidRepository;
import com.auction.marketplace.repository.ListingRepository;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AuctionService {

    private final AuctionRepository auctionRepository;
    private final ListingRepository listingRepository;
    private final BidRepository bidRepository;

    public List<AuctionCardResponse> getFeaturedAuctions() {
        settleExpiredAuctions();
        return auctionRepository.findTop4ByStatusOrderByEndTimeAsc(AuctionStatus.ACTIVE)
                .stream()
                .map(this::toAuctionCard)
                .toList();
    }

    public List<AuctionCardResponse> searchAuctions(String query, String category, String size, String condition) {
        settleExpiredAuctions();
        return auctionRepository.searchActiveAuctions(normalize(query), normalize(category), normalize(size), normalize(condition))
                .stream()
                .map(this::toAuctionCard)
                .toList();
    }

    public AuctionDetailResponse getAuctionDetail(Long auctionId) {
        settleExpiredAuctions();
        Auction auction = auctionRepository.findById(auctionId)
                .orElseThrow(() -> new ResourceNotFoundException("Auction not found"));
        List<Bid> bids = bidRepository.findByAuctionOrderByAmountDescCreatedAtDesc(auction);
        return toAuctionDetail(auction, bids);
    }

    @Transactional
    public AuctionDetailResponse createAuction(CreateAuctionRequest request, UserAccount seller) {
        Listing listing = new Listing();
        listing.setTitle(request.title().trim());
        listing.setBrand(request.brand().trim());
        listing.setCategory(request.category().trim());
        listing.setSizeLabel(request.size().trim());
        listing.setConditionLabel(request.condition().trim());
        listing.setColor(request.color().trim());
        listing.setDescription(request.description().trim());
        listing.setImageUrl(request.imageUrl().trim());
        listing.setSeller(seller);
        listing.setStatus(ListingStatus.ACTIVE);

        Listing savedListing = listingRepository.save(listing);

        Auction auction = new Auction();
        auction.setListing(savedListing);
        auction.setSeller(seller);
        auction.setStatus(AuctionStatus.ACTIVE);
        auction.setStartingPrice(request.startingPrice());
        auction.setBidIncrement(request.bidIncrement());
        auction.setReservePrice(request.reservePrice());
        auction.setHighestBidAmount(null);
        auction.setStartTime(Instant.now());
        auction.setEndTime(request.endTime());
        auction.setClosingNote("Auction is live.");

        Auction savedAuction = auctionRepository.save(auction);
        return toAuctionDetail(savedAuction, List.of());
    }

    @Transactional
    public AuctionDetailResponse placeBid(Long auctionId, PlaceBidRequest request, UserAccount bidder) {
        Auction auction = auctionRepository.findById(auctionId)
                .orElseThrow(() -> new ResourceNotFoundException("Auction not found"));

        if (auction.getStatus() != AuctionStatus.ACTIVE || auction.getEndTime().isBefore(Instant.now())) {
            settleAuction(auction);
            throw new BadRequestException("This auction is no longer accepting bids");
        }

        if (auction.getListing().getStatus() != ListingStatus.ACTIVE) {
            throw new ForbiddenOperationException("This listing is not available for bidding");
        }

        if (auction.getSeller().getId().equals(bidder.getId())) {
            throw new ForbiddenOperationException("You cannot bid on your own listing");
        }

        BigDecimal minimumAllowedBid = computeMinimumAllowedBid(auction);
        if (request.amount().compareTo(minimumAllowedBid) < 0) {
            throw new BadRequestException("Bid must be at least $" + minimumAllowedBid);
        }

        Bid bid = new Bid();
        bid.setAuction(auction);
        bid.setBidder(bidder);
        bid.setAmount(request.amount());
        bidRepository.save(bid);

        auction.setHighestBidAmount(request.amount());
        auction.setClosingNote("Auction is live.");
        Auction updatedAuction = auctionRepository.save(auction);

        return toAuctionDetail(updatedAuction, bidRepository.findByAuctionOrderByAmountDescCreatedAtDesc(updatedAuction));
    }

    @Transactional
    public void settleExpiredAuctions() {
        auctionRepository.findExpiredActiveAuctions(Instant.now()).forEach(this::settleAuction);
    }

    @Transactional
    public Auction settleAuction(Auction auction) {
        if (auction.getStatus() == AuctionStatus.CLOSED) {
            return auction;
        }

        List<Bid> bids = bidRepository.findByAuctionOrderByAmountDescCreatedAtDesc(auction);
        Bid topBid = bids.stream()
                .max(Comparator.comparing(Bid::getAmount).thenComparing(Bid::getCreatedAt))
                .orElse(null);

        auction.setStatus(AuctionStatus.CLOSED);
        if (topBid == null) {
            auction.setWinner(null);
            auction.setHighestBidAmount(auction.getStartingPrice());
            auction.setClosingNote("Auction closed without bids.");
            return auctionRepository.save(auction);
        }

        auction.setHighestBidAmount(topBid.getAmount());
        boolean reserveMet = auction.getReservePrice() == null || topBid.getAmount().compareTo(auction.getReservePrice()) >= 0;
        if (reserveMet) {
            auction.setWinner(topBid.getBidder());
            auction.setClosingNote("Auction closed with a winning bidder.");
        } else {
            auction.setWinner(null);
            auction.setClosingNote("Auction closed below reserve.");
        }
        return auctionRepository.save(auction);
    }

    public List<DashboardAuctionResponse> getUserListings(UserAccount seller) {
        settleExpiredAuctions();
        return auctionRepository.findBySellerOrderByCreatedAtDesc(seller)
                .stream()
                .map(this::toDashboardAuction)
                .toList();
    }

    public List<DashboardAuctionResponse> getWinningAuctions(UserAccount winner) {
        settleExpiredAuctions();
        return auctionRepository.findByWinnerOrderByUpdatedAtDesc(winner)
                .stream()
                .map(this::toDashboardAuction)
                .toList();
    }

    public List<DashboardBidResponse> getUserBids(UserAccount bidder) {
        settleExpiredAuctions();
        return bidRepository.findByBidderOrderByCreatedAtDesc(bidder)
                .stream()
                .map(bid -> new DashboardBidResponse(
                        bid.getId(),
                        bid.getAuction().getId(),
                        bid.getAuction().getListing().getTitle(),
                        bid.getAmount(),
                        bid.getCreatedAt(),
                        bid.getAuction().getWinner() != null && bid.getAuction().getWinner().getId().equals(bidder.getId())
                ))
                .toList();
    }

    private AuctionCardResponse toAuctionCard(Auction auction) {
        Listing listing = auction.getListing();
        return new AuctionCardResponse(
                auction.getId(),
                listing.getTitle(),
                listing.getBrand(),
                listing.getCategory(),
                listing.getSizeLabel(),
                listing.getConditionLabel(),
                listing.getColor(),
                listing.getImageUrl(),
                currentPrice(auction),
                auction.getBidIncrement(),
                auction.getReservePrice(),
                auction.getEndTime(),
                auction.getSeller().getFirstName() + " " + auction.getSeller().getLastName(),
                auction.getStatus()
        );
    }

    private AuctionDetailResponse toAuctionDetail(Auction auction, List<Bid> bids) {
        Listing listing = auction.getListing();
        List<BidHistoryResponse> bidHistory = bids.stream()
                .map(bid -> new BidHistoryResponse(
                        bid.getId(),
                        bid.getAmount(),
                        bid.getCreatedAt(),
                        bid.getBidder().getId(),
                        bid.getBidder().getFirstName() + " " + bid.getBidder().getLastName(),
                        auction.getWinner() != null && auction.getWinner().getId().equals(bid.getBidder().getId())
                                && bid.getAmount().compareTo(currentPrice(auction)) == 0
                ))
                .toList();

        return new AuctionDetailResponse(
                auction.getId(),
                auction.getStatus(),
                listing.getId(),
                listing.getTitle(),
                listing.getBrand(),
                listing.getCategory(),
                listing.getSizeLabel(),
                listing.getConditionLabel(),
                listing.getColor(),
                listing.getDescription(),
                listing.getImageUrl(),
                auction.getStartingPrice(),
                currentPrice(auction),
                auction.getReservePrice(),
                auction.getBidIncrement(),
                auction.getStartTime(),
                auction.getEndTime(),
                auction.getSeller().getFirstName() + " " + auction.getSeller().getLastName(),
                auction.getSeller().getId(),
                listing.getStatus(),
                auction.getWinner() == null ? null : auction.getWinner().getFirstName() + " " + auction.getWinner().getLastName(),
                auction.getClosingNote(),
                bidHistory
        );
    }

    private DashboardAuctionResponse toDashboardAuction(Auction auction) {
        return new DashboardAuctionResponse(
                auction.getId(),
                auction.getListing().getTitle(),
                auction.getListing().getImageUrl(),
                auction.getStatus(),
                currentPrice(auction),
                auction.getEndTime()
        );
    }

    private BigDecimal currentPrice(Auction auction) {
        return auction.getHighestBidAmount() == null ? auction.getStartingPrice() : auction.getHighestBidAmount();
    }

    private BigDecimal computeMinimumAllowedBid(Auction auction) {
        if (auction.getHighestBidAmount() == null) {
            return auction.getStartingPrice();
        }
        return auction.getHighestBidAmount().add(auction.getBidIncrement());
    }

    private String normalize(String value) {
        return value == null || value.isBlank() ? null : value.trim();
    }
}
