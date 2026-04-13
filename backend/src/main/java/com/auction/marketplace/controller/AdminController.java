package com.auction.marketplace.controller;

import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.auction.marketplace.dto.AdminDtos.AdminAuctionResponse;
import com.auction.marketplace.dto.AdminDtos.AdminAuctionUpdateRequest;
import com.auction.marketplace.dto.AdminDtos.AdminOverviewResponse;
import com.auction.marketplace.dto.AdminDtos.AdminUserResponse;
import com.auction.marketplace.dto.AdminDtos.AdminUserUpdateRequest;
import com.auction.marketplace.service.AdminService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/admin")
@PreAuthorize("hasRole('ADMIN')")
@RequiredArgsConstructor
public class AdminController {

    private final AdminService adminService;

    @GetMapping("/overview")
    public AdminOverviewResponse getOverview() {
        return adminService.getOverview();
    }

    @GetMapping("/users")
    public List<AdminUserResponse> getUsers() {
        return adminService.getUsers();
    }

    @PatchMapping("/users/{userId}")
    public AdminUserResponse updateUser(@PathVariable Long userId, @RequestBody AdminUserUpdateRequest request) {
        return adminService.updateUser(userId, request);
    }

    @GetMapping("/auctions")
    public List<AdminAuctionResponse> getAuctions() {
        return adminService.getAuctions();
    }

    @PatchMapping("/auctions/{auctionId}")
    public AdminAuctionResponse updateAuction(
            @PathVariable Long auctionId,
            @Valid @RequestBody AdminAuctionUpdateRequest request
    ) {
        return adminService.updateAuction(auctionId, request);
    }
}
