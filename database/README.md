# Database Notes

Threadline Marketplace uses MySQL as the primary runtime database.

- Schema migrations live in `backend/src/main/resources/db/migration`.
- The app seeds a demo admin and customer accounts automatically on first startup.
- Demo admin: `admin@threadline.dev` / `AdminPass123`
- Demo customers: `maya@threadline.dev` and `jordan@threadline.dev` / `ClosetPass123`
