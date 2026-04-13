# Threadline Marketplace Architecture

## Audit Summary

The original repo contained a JSP/Tomcat app with direct JDBC access inside views, hardcoded MySQL credentials, plaintext passwords, and dynamic SQL string concatenation. Those patterns were useful only for extracting domain concepts like users, clothing items, auctions, bids, FAQs, and admin workflows.

## Reuse Decision

- Reused: product concept, clothing marketplace focus, high-level entity ideas (`account`, `item`, `auction`, `bid`, `admin`).
- Replaced: server architecture, authentication, data access, UI, project structure, configuration, developer setup.
- Final approach: clean rebuild with Spring Boot REST API, React frontend, MySQL persistence, Flyway migrations, and role-based security.

## Backend

- Layered Spring Boot architecture with controller, service, repository, model, and DTO packages.
- JWT authentication with BCrypt password hashing.
- Scheduled auction settlement to close expired auctions and determine winners.
- Admin moderation and user management endpoints.

## Frontend

- React SPA with route-based pages for landing, marketplace, auth, listing creation, dashboard, and admin tools.
- Shared API client and auth context.
- Responsive custom styling focused on a modern portfolio presentation.
