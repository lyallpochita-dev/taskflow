# CMP-AUTH-TOKEN-VALIDATOR
Design: DES-AUTH-0001
Owner: developer-1
Created: 2026-06-02

## Responsibility
Validates JWT access tokens on every protected route.
Attaches the decoded user payload to the request object.
Rejects requests with missing, expired, or invalid tokens.

## Files and Modules
- apps/taskflow-api/src/middleware/auth-guard.ts
- packages/shared-auth/src/token-validator.ts

## Interfaces
Input  : Authorization header (Bearer <token>)
Output : req.user = { id, email, role } or 401 response

## Tests
- TEST-AUTH-UNIT-0001
- TEST-AUTH-SECURITY-0001
