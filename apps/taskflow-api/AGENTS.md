# TaskFlow API — AGENTS.md
# Inherits root AGENTS.md. These rules are specific to the API app.

## Owned by
This app is the backend. It owns all files under apps/taskflow-api/

## Structure
src/auth/         → authentication handlers (REQ-AUTH-*)
src/projects/     → project CRUD (REQ-PROJ-*)
src/tasks/        → task management (REQ-TASK-*)
src/teams/        → team management (REQ-TEAM-*)
src/dashboard/    → dashboard aggregation (REQ-DASH-*)
src/middleware/   → shared middleware (auth guard, error handler)
src/config/       → environment config loading
src/startup/      → server bootstrap

## API response shape (must follow in every endpoint)
{
  data: <payload or null>,
  error: <string or null>,
  statusCode: <number>
}

## Rules specific to this app
- Amounts always in integers (paise/cents) — never floats
- All auth routes must use the shared-auth package
- Every new endpoint must have a contract test in tests/contract/
- Never import directly from another app — use packages/ only
