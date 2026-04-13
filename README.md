# Threadline Marketplace

Threadline Marketplace is a rebuilt full stack auction platform for clothing items. It replaces the original JSP/Tomcat coursework-style implementation with a modern Spring Boot backend, a React frontend, MySQL persistence, JWT authentication, admin moderation tools, and a cleaner developer setup.

## Why This Was Rebuilt

The original project had a few reusable ideas but not a safe or scalable implementation:

- Reusable concepts: clothing-focused marketplace, auctions, bids, admin/customer roles, FAQ/support direction.
- Replaced entirely: JSP-based rendering, SQL in views, hardcoded credentials, plaintext passwords, raw SQL concatenation, and outdated UI.
- Recommendation after audit: rebuild instead of refactor-in-place.

The legacy coursework version is preserved under `legacy/` for reference.

## Tech Stack

- Backend: Spring Boot, Spring Security, Spring Data JPA, Flyway, JWT, BCrypt
- Frontend: React, React Router, Vite
- Database: MySQL
- Dev tooling: Gradle wrapper, Docker Compose, environment-based config

## Product Features

- Customer registration and login
- JWT-based authenticated API access
- Role-based access control for customers and admins
- Create clothing listings and launch auctions
- Browse, search, and filter active auctions
- Auction detail pages with bid history
- Reserve price support and bid increment validation
- Automatic winner settlement when auctions expire
- User dashboard for listings, bids, and wins
- Admin dashboard for user review, listing moderation, and marketplace stats

## Project Structure

```text
backend/    Spring Boot REST API
frontend/   React client
database/   Database notes and demo access info
docs/       Audit and architecture notes
legacy/     Original repo contents kept for reference
scripts/    Local startup helper scripts
```

## Local Setup

### 1. Start MySQL

Use Docker:

```bash
docker compose up -d mysql
```

Or run your own local MySQL and create/update credentials in environment variables.

### 2. Configure Environment

Backend example:

```bash
cp backend/.env.example backend/.env
```

Frontend example:

```bash
cp frontend/.env.example frontend/.env
```

The Spring app reads environment variables directly, so you can export them in your shell or load them from your preferred tool.

### 3. Run Backend

```bash
cd backend
./gradlew bootRun
```

API base URL: `http://localhost:8080/api`

### 4. Run Frontend

```bash
cd frontend
npm install
npm run dev
```

Frontend URL: `http://localhost:5173`

## Demo Accounts

- Admin: `admin@threadline.dev` / `AdminPass123`
- Customer: `maya@threadline.dev` / `ClosetPass123`
- Customer: `jordan@threadline.dev` / `ClosetPass123`

## Docker Compose

You can also run the whole stack with:

```bash
docker compose up --build
```

Services:

- Frontend: `http://localhost:4173`
- Backend: `http://localhost:8080/api`
- MySQL: `localhost:3306`

## Backend API Overview

- `POST /api/auth/register`
- `POST /api/auth/login`
- `GET /api/auth/me`
- `GET /api/auctions`
- `GET /api/auctions/featured`
- `GET /api/auctions/{auctionId}`
- `POST /api/auctions`
- `POST /api/auctions/{auctionId}/bids`
- `GET /api/dashboard`
- `GET /api/admin/overview`
- `GET /api/admin/users`
- `PATCH /api/admin/users/{userId}`
- `GET /api/admin/auctions`
- `PATCH /api/admin/auctions/{auctionId}`

## Verification

Backend verification completed:

- `cd backend && ./gradlew test`

Frontend verification should be run after installing dependencies:

- `cd frontend && npm install && npm run build`

## Interview Talking Points

- Replaced a monolithic JSP/JDBC project with a layered REST architecture
- Removed plaintext credentials and direct SQL string concatenation
- Introduced Flyway migrations, BCrypt hashing, and JWT auth
- Built marketplace flows for sellers, bidders, and admins
- Added Docker and env-driven setup for smoother onboarding
