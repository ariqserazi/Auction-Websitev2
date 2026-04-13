package com.auction.marketplace.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.auction.marketplace.model.Listing;
import com.auction.marketplace.model.ListingStatus;
import com.auction.marketplace.model.UserAccount;

public interface ListingRepository extends JpaRepository<Listing, Long> {
    List<Listing> findBySellerOrderByCreatedAtDesc(UserAccount seller);
    long countByStatus(ListingStatus status);
}
