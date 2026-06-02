# REQ-PROJ-0001: Project creation and management
Status: approved
Owner: developer-1
Created: 2026-06-02

## Problem
Users need to create projects to group tasks under a shared context.
A project has a name, description, and a set of members.

## Expected Behavior
- Authenticated users can create a project
- Project creator becomes the project owner
- Owner can update and delete the project
- Any project member can view the project

## Acceptance Criteria
- [ ] POST /projects creates a project (auth required)
- [ ] GET /projects returns all projects the user belongs to
- [ ] GET /projects/:id returns one project
- [ ] PATCH /projects/:id updates project (owner only)
- [ ] DELETE /projects/:id deletes project (owner only)
- [ ] Response follows { data, error, statusCode } shape

## Out of Scope
- Project templates
- Project archiving

## Dependencies
- REQ-AUTH-0001 (user must be authenticated)
