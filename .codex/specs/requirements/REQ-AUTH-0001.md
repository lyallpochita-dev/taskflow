# REQ-AUTH-0001: User authentication with JWT
Status: approved
Owner: developer-1
Created: 2026-06-02

## Problem
Users need to register and log in to TaskFlow securely.
Sessions must work across API calls without server-side session storage
since the app runs as a stateless Azure Container App.

## Expected Behavior
- A new user can register with email and password
- A registered user can log in and receive a JWT access token (15min)
  and a refresh token (7 days)
- Protected routes reject requests without a valid token
- Expired access tokens can be refreshed using the refresh token

## Acceptance Criteria
- [ ] POST /auth/register creates a user and returns tokens
- [ ] POST /auth/login returns tokens for valid credentials
- [ ] POST /auth/refresh returns a new access token
- [ ] Protected routes return 401 without a valid token
- [ ] Passwords are hashed with bcrypt (min rounds: 12)
- [ ] Tokens are signed with secret from Azure Key Vault

## Out of Scope
- OAuth / social login
- Multi-factor authentication
- Password reset flow (separate requirement)

## Dependencies
None — this is the first requirement.
