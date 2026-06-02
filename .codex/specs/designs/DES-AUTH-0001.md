# DES-AUTH-0001: JWT authentication design
Requirement: REQ-AUTH-0001
Status: approved
Created: 2026-06-02

## Design Summary
Use stateless JWT authentication. Access token (15min) returned on
login/register. Refresh token (7d) stored in the database for rotation.
JWT secret loaded from Azure Key Vault via environment variable at startup.

## Components
- CMP-AUTH-REGISTER-HANDLER
- CMP-AUTH-LOGIN-HANDLER
- CMP-AUTH-TOKEN-VALIDATOR
- CMP-AUTH-REFRESH-HANDLER

## API Changes
POST /auth/register  → { email, password } → { data: { accessToken, refreshToken, user }, error, statusCode }
POST /auth/login     → { email, password } → { data: { accessToken, refreshToken, user }, error, statusCode }
POST /auth/refresh   → { refreshToken }    → { data: { accessToken }, error, statusCode }

## Database Changes
Table: users (id uuid, email, password_hash, created_at)
Table: refresh_tokens (id uuid, user_id, token_hash, expires_at, created_at)

## Risks
- JWT secret rotation: mitigated by Key Vault versioning
- Refresh token theft: mitigated by token rotation on each refresh

## Test Approach
- TEST-AUTH-UNIT-0001 (unit: token generation and validation)
- TEST-AUTH-CONTRACT-0001 (contract: register and login endpoints)
- TEST-AUTH-SECURITY-0001 (security: invalid tokens, expired tokens)
