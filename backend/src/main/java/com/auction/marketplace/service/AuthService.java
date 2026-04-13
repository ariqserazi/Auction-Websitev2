package com.auction.marketplace.service;

import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.auction.marketplace.config.JwtService;
import com.auction.marketplace.dto.AuthDtos.AuthResponse;
import com.auction.marketplace.dto.AuthDtos.LoginRequest;
import com.auction.marketplace.dto.AuthDtos.RegisterRequest;
import com.auction.marketplace.dto.AuthDtos.UserSummary;
import com.auction.marketplace.exception.BadRequestException;
import com.auction.marketplace.model.Role;
import com.auction.marketplace.model.UserAccount;
import com.auction.marketplace.repository.UserRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AuthService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final AuthenticationManager authenticationManager;
    private final JwtService jwtService;

    public AuthResponse register(RegisterRequest request) {
        if (userRepository.existsByEmailIgnoreCase(request.email())) {
            throw new BadRequestException("An account with that email already exists");
        }

        UserAccount user = new UserAccount();
        user.setFirstName(request.firstName().trim());
        user.setLastName(request.lastName().trim());
        user.setEmail(request.email().trim().toLowerCase());
        user.setPasswordHash(passwordEncoder.encode(request.password()));
        user.setRole(Role.ROLE_CUSTOMER);

        UserAccount savedUser = userRepository.save(user);
        return buildAuthResponse(savedUser);
    }

    public AuthResponse login(LoginRequest request) {
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(request.email().trim().toLowerCase(), request.password())
        );

        UserAccount user = userRepository.findByEmailIgnoreCase(request.email())
                .orElseThrow(() -> new BadRequestException("Invalid credentials"));

        return buildAuthResponse(user);
    }

    public UserSummary currentUser(UserAccount user) {
        return toUserSummary(user);
    }

    private AuthResponse buildAuthResponse(UserAccount user) {
        return new AuthResponse(jwtService.generateToken(user), toUserSummary(user));
    }

    private UserSummary toUserSummary(UserAccount user) {
        return new UserSummary(
                user.getId(),
                user.getFirstName(),
                user.getLastName(),
                user.getEmail(),
                user.getRole()
        );
    }
}
