# Threadline Marketplace

Threadline Marketplace is a modern full stack auction marketplace for clothing items. It replaces the original JSP/Tomcat coursework app with a Spring Boot backend, React frontend, and MySQL database.

The legacy project is still kept under `legacy/`, but the app you should run is the new one in `backend/` and `frontend/`.

## What This App Does

- Lets users register and log in
- Lets sellers create clothing auction listings
- Lets buyers browse auctions and place bids
- Enforces bid increment and reserve-price rules
- Shows dashboards for listings, bids, and wins
- Includes an admin view for user and auction moderation

## Tech Stack

- Backend: Spring Boot, Spring Security, JPA, Flyway, JWT
- Frontend: React, React Router, Vite
- Database: MySQL
- Tooling: Gradle wrapper, Docker Compose

## Before You Start

Make sure you have these installed:

- Java 17+
- Node.js 20+
- npm
- Docker Desktop

## Project Structure

```text
backend/    Spring Boot REST API
frontend/   React app
database/   Database notes
docs/       Audit and architecture notes
legacy/     Original repo contents
scripts/    Helper scripts
```

## Fastest Way To Run It

This is the simplest local setup.

### 1. Start MySQL

From the project root:

```bash
docker compose up -d mysql
```

This starts a MySQL container on port `3306`.

### 2. Start the backend

Open a second terminal:

```bash
cd backend
./gradlew bootRun
```

What happens here:

- Spring Boot starts on `http://localhost:8080`
- Flyway creates the schema automatically
- Demo accounts and demo auctions are seeded on first run

You can confirm it is working by opening:

- `http://localhost:8080/api/health`

You should get a JSON response with `"status":"ok"`.

### 3. Start the frontend

Open a third terminal:

```bash
cd frontend
npm install
npm run dev
```

Vite will start the frontend on:

- `http://localhost:5173`

Open that URL in your browser.

## Exact First-Time Usage Flow

Once the app is running:

### Option A: log in with a demo account

Admin:

- Email: `admin@threadline.dev`
- Password: `AdminPass123`

Customer:

- Email: `maya@threadline.dev`
- Password: `ClosetPass123`

Customer:

- Email: `jordan@threadline.dev`
- Password: `ClosetPass123`

### Option B: create your own account

1. Open `http://localhost:5173`
2. Click `Create account`
3. Fill in first name, last name, email, and password
4. Submit the form
5. You will be logged in and sent to the dashboard

## How To Use The App

### Browse auctions

1. Open the homepage or click `Marketplace`
2. Use the search/filter inputs to narrow listings
3. Click `View auction` on any item

### Place a bid

1. Log in with a customer account
2. Open an auction detail page
3. Enter a bid amount
4. Submit the bid

Rules:

- Your first bid must be at least the starting price
- Later bids must be at least `current price + bid increment`
- You cannot bid on your own listing
- Closed or flagged auctions cannot be bid on

### Create a listing

1. Log in
2. Click `Sell`
3. Fill in the form:
   - title
   - brand
   - category
   - size
   - condition
   - color
   - description
   - image URL
   - starting price
   - bid increment
   - optional reserve price
   - auction end date/time
4. Click `Publish auction`

After that, the app creates:

- a listing
- an auction attached to that listing

### Use the dashboard

After logging in, go to `Dashboard`.

You can see:

- your listings
- your recent bids
- auctions you have won

### Use the admin dashboard

Log in as the admin user and open:

- `http://localhost:5173/admin`

Admin features currently include:

- viewing marketplace overview stats
- viewing users
- viewing auctions
- flagging active auctions for review

## Environment Variables

You usually do not need to change anything for local development, but these files are included if you want to customize setup.

Backend example:

```bash
cp backend/.env.example backend/.env
```

Frontend example:

```bash
cp frontend/.env.example frontend/.env
```

Important backend variables:

- `DB_URL`
- `DB_USERNAME`
- `DB_PASSWORD`
- `JWT_SECRET`
- `CORS_ALLOWED_ORIGINS`
- `SERVER_PORT`

Important frontend variables:

- `VITE_API_BASE_URL`

## API Endpoints

Main backend routes:

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

## Optional: Run With Docker Compose

If you want to try the full containerized setup:

```bash
docker compose up --build
```

Expected services:

- Frontend: `http://localhost:4173`
- Backend: `http://localhost:8080`
- MySQL: `localhost:3306`

Note:

- For normal development, I recommend the mixed setup instead:
  - Docker for MySQL
  - `./gradlew bootRun` for backend
  - `npm run dev` for frontend

That gives faster iteration and clearer debugging.

## How To Stop Everything

If you started the backend with `./gradlew bootRun`, stop it with:

- `Ctrl + C`

If you started the frontend with `npm run dev`, stop it with:

- `Ctrl + C`

To stop MySQL:

```bash
docker compose down
```

## Common Problems

### Port 3306 already in use

You already have MySQL running locally. Stop it, or change the Docker port mapping in `docker-compose.yml`.

### Port 8080 already in use

Another backend app is already running. Stop it, or change `SERVER_PORT`.

### Port 5173 already in use

Another Vite app is already running. Stop it, or run Vite on a different port.

### Frontend loads but API calls fail

Check:

- backend is running
- MySQL is running
- `VITE_API_BASE_URL` points to `http://localhost:8080/api`
- CORS is allowing `http://localhost:5173`

### Login fails for demo users

The demo accounts are seeded only when the database is empty on first backend startup.

If needed, reset the MySQL volume and restart:

```bash
docker compose down -v
docker compose up -d mysql
cd backend
./gradlew bootRun
```

## Verification I Actually Ran

I verified these during the rebuild:

- `cd backend && ./gradlew test`
- `cd frontend && npm install`
- `cd frontend && npm run build`
- backend startup against Dockerized MySQL
- `GET /api/health`
- `GET /api/auctions/featured`
- `POST /api/auth/login`
- `POST /api/auctions/{id}/bids`

## Good Demo Walkthrough For Interviews

If you want to demo this project quickly:

1. Open the landing page
2. Show the marketplace grid
3. Open one auction
4. Log in as a customer
5. Place a bid
6. Open the dashboard
7. Log in as admin
8. Show the admin overview and auction moderation
