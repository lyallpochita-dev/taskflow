# REQ-TASK-0001: Task CRUD
Status: approved
Owner: developer-2
Created: 2026-06-02

## Problem
Users need to create, read, update, and delete tasks within a project.
Tasks must have a title, description, assignee, status, and due date.

## Expected Behavior
- Project members can create tasks inside a project
- Tasks can be assigned to any project member
- Task status: todo → in_progress → done
- Tasks can be updated and deleted by their creator or project owner

## Acceptance Criteria
- [ ] POST /projects/:id/tasks creates a task
- [ ] GET /projects/:id/tasks returns all tasks for a project
- [ ] GET /projects/:id/tasks/:taskId returns one task
- [ ] PATCH /projects/:id/tasks/:taskId updates task
- [ ] DELETE /projects/:id/tasks/:taskId deletes task
- [ ] Status transitions are validated (no skipping states)

## Out of Scope
- Task comments
- Task attachments
- Sub-tasks

## Dependencies
- REQ-AUTH-0001
- REQ-PROJ-0001
