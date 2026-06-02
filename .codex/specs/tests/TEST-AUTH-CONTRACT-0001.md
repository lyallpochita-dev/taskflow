# TEST-AUTH-CONTRACT-0001: Auth endpoint contract tests
Requirement: REQ-AUTH-0001
Component: CMP-AUTH-REGISTER-HANDLER, CMP-AUTH-LOGIN-HANDLER
Type: contract
Created: 2026-06-02

## What must be proven
Register and login endpoints return the agreed response shape
under both success and failure conditions.

## Success scenarios
- [ ] POST /auth/register with valid email+password returns 201
      with { data: { accessToken, refreshToken, user }, error: null, statusCode: 201 }
- [ ] POST /auth/login with valid credentials returns 200
      with { data: { accessToken, refreshToken, user }, error: null, statusCode: 200 }
- [ ] POST /auth/refresh with valid refresh token returns 200
      with { data: { accessToken }, error: null, statusCode: 200 }

## Failure scenarios
- [ ] Register with duplicate email returns 400
- [ ] Login with wrong password returns 401
- [ ] Refresh with expired token returns 401
- [ ] Any auth endpoint with malformed body returns 400

## Evidence
  npm run test:contract -- --grep "auth"
