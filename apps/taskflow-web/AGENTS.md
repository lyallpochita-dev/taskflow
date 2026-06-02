# TaskFlow Web — AGENTS.md
# Inherits root AGENTS.md. These rules are specific to the web app.

## Owned by
This app is the frontend. It owns all files under apps/taskflow-web/

## Structure
src/pages/        → page-level components (one per route)
src/features/     → feature modules (auth, projects, tasks, teams)
src/components/   → shared UI components (Button, Card, Modal, etc.)
src/hooks/        → shared React hooks
src/styles/       → global styles

## Rules specific to this app
- Never fetch directly — use hooks from src/hooks/
- Never define API response types locally — import from packages/taskflow-contracts
- Component props must match taskflow-contracts definitions
- No two page components may share the same feature folder
