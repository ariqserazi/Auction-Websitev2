package com.auction.marketplace.service;

import java.math.BigDecimal;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.List;

import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import com.auction.marketplace.model.Auction;
import com.auction.marketplace.model.AuctionStatus;
import com.auction.marketplace.model.Listing;
import com.auction.marketplace.model.ListingStatus;
import com.auction.marketplace.model.Role;
import com.auction.marketplace.model.UserAccount;
import com.auction.marketplace.repository.AuctionRepository;
import com.auction.marketplace.repository.ListingRepository;
import com.auction.marketplace.repository.UserRepository;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class SeedDataLoader implements CommandLineRunner {

    private final UserRepository userRepository;
    private final ListingRepository listingRepository;
    private final AuctionRepository auctionRepository;
    private final PasswordEncoder passwordEncoder;

    @Override
    public void run(String... args) {
        if (userRepository.count() > 0) {
            return;
        }

        UserAccount admin = buildUser("Admin", "Demo", "admin@threadline.dev", "AdminPass123", Role.ROLE_ADMIN);
        UserAccount maya = buildUser("Maya", "Cole", "maya@threadline.dev", "ClosetPass123", Role.ROLE_CUSTOMER);
        UserAccount jordan = buildUser("Jordan", "Lee", "jordan@threadline.dev", "ClosetPass123", Role.ROLE_CUSTOMER);
        userRepository.saveAll(List.of(admin, maya, jordan));

        createAuction(
                maya,
                "Vintage Leather Bomber",
                "Aurelian",
                "Outerwear",
                "M",
                "Excellent",
                "Espresso",
                "Supple leather jacket with oversized drop shoulders and warm satin lining.",
                "https://images.unsplash.com/photo-1523398002811-999ca8dec234?auto=format&fit=crop&w=1200&q=80",
                new BigDecimal("120.00"),
                new BigDecimal("10.00"),
                new BigDecimal("180.00"),
                Instant.now().plus(2, ChronoUnit.DAYS)
        );

        createAuction(
                jordan,
                "Minimal Wool Overcoat",
                "Northline",
                "Coats",
                "L",
                "Very Good",
                "Charcoal",
                "Structured wool coat with clean hidden placket and sharp tailoring through the shoulder.",
                "https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?auto=format&fit=crop&w=1200&q=80",
                new BigDecimal("95.00"),
                new BigDecimal("8.00"),
                new BigDecimal("140.00"),
                Instant.now().plus(30, ChronoUnit.HOURS)
        );

        createAuction(
                maya,
                "Selvedge Utility Denim",
                "Threadline Studio",
                "Denim",
                "32",
                "Excellent",
                "Indigo",
                "Crisp heavyweight denim with straight leg fit and a subtle workwear wash.",
                "https://images.unsplash.com/photo-1542272604-787c3835535d?auto=format&fit=crop&w=1200&q=80",
                new BigDecimal("60.00"),
                new BigDecimal("5.00"),
                new BigDecimal("90.00"),
                Instant.now().plus(18, ChronoUnit.HOURS)
        );
    }

    private UserAccount buildUser(String firstName, String lastName, String email, String password, Role role) {
        UserAccount user = new UserAccount();
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setEmail(email);
        user.setPasswordHash(passwordEncoder.encode(password));
        user.setRole(role);
        user.setEnabled(true);
        return user;
    }

    private void createAuction(
            UserAccount seller,
            String title,
            String brand,
            String category,
            String size,
            String condition,
            String color,
            String description,
            String imageUrl,
            BigDecimal startingPrice,
            BigDecimal bidIncrement,
            BigDecimal reservePrice,
            Instant endTime
    ) {
        Listing listing = new Listing();
        listing.setSeller(seller);
        listing.setTitle(title);
        listing.setBrand(brand);
        listing.setCategory(category);
        listing.setSizeLabel(size);
        listing.setConditionLabel(condition);
        listing.setColor(color);
        listing.setDescription(description);
        listing.setImageUrl(imageUrl);
        listing.setStatus(ListingStatus.ACTIVE);
        Listing savedListing = listingRepository.save(listing);

        Auction auction = new Auction();
        auction.setListing(savedListing);
        auction.setSeller(seller);
        auction.setStatus(AuctionStatus.ACTIVE);
        auction.setStartingPrice(startingPrice);
        auction.setBidIncrement(bidIncrement);
        auction.setReservePrice(reservePrice);
        auction.setHighestBidAmount(null);
        auction.setStartTime(Instant.now());
        auction.setEndTime(endTime);
        auction.setClosingNote("Seeded demo auction.");
        auctionRepository.save(auction);
    }
}
