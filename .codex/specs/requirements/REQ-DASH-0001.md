# REQ-DASH-0001: Dashboard summary API
Status: approved
Owner: developer-2
Created: 2026-06-02

## Problem
Users need a summary view of their tasks across all projects.
The dashboard shows task counts by status.

## Expected Behavior
- Authenticated user sees counts of all their tasks grouped by status
- Data is scoped to the requesting user

## Acceptance Criteria
- [ ] GET /dashboard returns { todo, in_progress, done, total } counts
- [ ] Counts only include tasks assigned to the requesting user
- [ ] Response follows { data, error, statusCode } shape

## Out of Scope
- Per-project breakdown (separate requirement)
- Charts or visualisations (frontend concern)

## Dependencies
- REQ-AUTH-0001
- REQ-TASK-0001
