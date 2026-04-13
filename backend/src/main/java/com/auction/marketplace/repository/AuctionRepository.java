package com.auction.marketplace.repository;

import java.time.Instant;
import java.util.List;

import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.auction.marketplace.model.Auction;
import com.auction.marketplace.model.AuctionStatus;
import com.auction.marketplace.model.UserAccount;

public interface AuctionRepository extends JpaRepository<Auction, Long> {

    @EntityGraph(attributePaths = {"listing", "seller", "winner"})
    @Query("""
        select a from Auction a
        where a.status = com.auction.marketplace.model.AuctionStatus.ACTIVE
        and a.listing.status = com.auction.marketplace.model.ListingStatus.ACTIVE
        and (
            :query is null
            or lower(a.listing.title) like lower(concat('%', :query, '%'))
            or lower(a.listing.brand) like lower(concat('%', :query, '%'))
            or lower(a.listing.category) like lower(concat('%', :query, '%'))
        )
        and (:category is null or lower(a.listing.category) = lower(:category))
        and (:size is null or lower(a.listing.sizeLabel) = lower(:size))
        and (:condition is null or lower(a.listing.conditionLabel) = lower(:condition))
        order by a.endTime asc
        """)
    List<Auction> searchActiveAuctions(
            @Param("query") String query,
            @Param("category") String category,
            @Param("size") String size,
            @Param("condition") String condition
    );

    @EntityGraph(attributePaths = {"listing", "seller", "winner"})
    List<Auction> findTop4ByStatusOrderByEndTimeAsc(AuctionStatus status);

    @EntityGraph(attributePaths = {"listing", "seller", "winner"})
    List<Auction> findBySellerOrderByCreatedAtDesc(UserAccount seller);

    @EntityGraph(attributePaths = {"listing", "seller", "winner"})
    List<Auction> findByWinnerOrderByUpdatedAtDesc(UserAccount winner);

    @EntityGraph(attributePaths = {"listing", "seller", "winner"})
    List<Auction> findByStatusOrderByEndTimeDesc(AuctionStatus status);

    @Query("""
        select a from Auction a
        where a.status = com.auction.marketplace.model.AuctionStatus.ACTIVE
        and a.endTime <= :cutoff
        """)
    List<Auction> findExpiredActiveAuctions(@Param("cutoff") Instant cutoff);

    @Query("""
        select count(a) from Auction a
        where a.status = :status
        """)
    long countByAuctionStatus(@Param("status") AuctionStatus status);
}
