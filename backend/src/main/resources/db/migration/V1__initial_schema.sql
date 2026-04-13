CREATE TABLE users (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(80) NOT NULL,
    last_name VARCHAR(80) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL,
    enabled BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE listings (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    seller_id BIGINT NOT NULL,
    title VARCHAR(120) NOT NULL,
    brand VARCHAR(80) NOT NULL,
    category VARCHAR(60) NOT NULL,
    size_label VARCHAR(20) NOT NULL,
    condition_label VARCHAR(30) NOT NULL,
    color VARCHAR(40) NOT NULL,
    description VARCHAR(2000) NOT NULL,
    image_url VARCHAR(500) NOT NULL,
    status VARCHAR(20) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_listing_seller FOREIGN KEY (seller_id) REFERENCES users(id)
);

CREATE TABLE auctions (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    listing_id BIGINT NOT NULL UNIQUE,
    seller_id BIGINT NOT NULL,
    winner_id BIGINT NULL,
    status VARCHAR(20) NOT NULL,
    starting_price DECIMAL(10, 2) NOT NULL,
    bid_increment DECIMAL(10, 2) NOT NULL,
    reserve_price DECIMAL(10, 2) NULL,
    highest_bid_amount DECIMAL(10, 2) NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    closing_note VARCHAR(300) NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_auction_listing FOREIGN KEY (listing_id) REFERENCES listings(id),
    CONSTRAINT fk_auction_seller FOREIGN KEY (seller_id) REFERENCES users(id),
    CONSTRAINT fk_auction_winner FOREIGN KEY (winner_id) REFERENCES users(id)
);

CREATE TABLE bids (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    auction_id BIGINT NOT NULL,
    bidder_id BIGINT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_bid_auction FOREIGN KEY (auction_id) REFERENCES auctions(id),
    CONSTRAINT fk_bid_bidder FOREIGN KEY (bidder_id) REFERENCES users(id)
);

CREATE INDEX idx_auction_status_end_time ON auctions(status, end_time);
CREATE INDEX idx_listing_status_category ON listings(status, category);
CREATE INDEX idx_bid_auction_amount ON bids(auction_id, amount);
