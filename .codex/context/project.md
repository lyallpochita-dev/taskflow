# TaskFlow — Project Context
# Stable memory. Update only when the project fundamentally changes.
# Last updated: 2026-06-02

## What is TaskFlow
TaskFlow is a task management API and web application built as a POC
to validate the team development protocol using Codex, Git, and GitHub.

## Team
- Lead         : reviews all PRs, owns .codex/, owns infra/
- Developer 1  : backend API — auth and projects
- Developer 2  : backend API — tasks and dashboard
- Developer 3  : frontend — pages and features
- Developer 4  : frontend — components and hooks
- Developer 5  : infra and shared packages

## Tech stack
Backend  : Node.js 20 + Express 4
Frontend : React 18 + Vite
Database : PostgreSQL 15 (Azure Database for PostgreSQL)
Auth     : JWT (access token 15min, refresh token 7d)
Infra    : Azure Container Apps, Azure Key Vault, Azure Container Registry
CI/CD    : GitHub Actions
Language : TypeScript throughout

## Environments
dev   → feature branches and PRs
test  → staging, auto-deployed from main
prod  → manual promotion from test (lead approval required)

## Status
Active POC. First sprint in progress.
