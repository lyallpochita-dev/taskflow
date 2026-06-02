# REQ-TEAM-0001: Team member management
Status: approved
Owner: developer-2
Created: 2026-06-02

## Problem
Project owners need to invite developers to their project.
Members need roles: owner, member.

## Expected Behavior
- Project owner can invite a user by email
- Invited user receives a project membership
- Owner can remove members
- Member roles control what actions are allowed

## Acceptance Criteria
- [ ] POST /projects/:id/members adds a member (owner only)
- [ ] DELETE /projects/:id/members/:userId removes a member (owner only)
- [ ] GET /projects/:id/members returns all members
- [ ] Non-owners cannot invite or remove members
- [ ] Cannot remove the last owner

## Out of Scope
- Email invitation flow (direct add by email for POC)
- Permission levels beyond owner/member

## Dependencies
- REQ-AUTH-0001
- REQ-PROJ-0001
