package com.auction.marketplace.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;

import com.auction.marketplace.model.Auction;
import com.auction.marketplace.model.Bid;
import com.auction.marketplace.model.UserAccount;

public interface BidRepository extends JpaRepository<Bid, Long> {
    @EntityGraph(attributePaths = {"bidder"})
    List<Bid> findByAuctionOrderByAmountDescCreatedAtDesc(Auction auction);

    @EntityGraph(attributePaths = {"auction", "auction.listing", "bidder"})
    List<Bid> findByBidderOrderByCreatedAtDesc(UserAccount bidder);

    Optional<Bid> findTopByAuctionOrderByAmountDescCreatedAtDesc(Auction auction);

    long countByAuction(Auction auction);

    long countByBidder(UserAccount bidder);
}
