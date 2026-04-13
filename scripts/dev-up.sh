#!/usr/bin/env bash
set -euo pipefail

echo "Starting MySQL with Docker Compose..."
docker compose up -d mysql

echo "Backend: copy backend/.env.example to backend/.env if you want custom values."
echo "Frontend: copy frontend/.env.example to frontend/.env if you want custom values."
echo "Run the backend with: (cd backend && ./gradlew bootRun)"
echo "Run the frontend with: (cd frontend && npm install && npm run dev)"
