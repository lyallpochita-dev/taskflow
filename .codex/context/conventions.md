# TaskFlow — Coding Conventions
# These are the rules Codex must follow in every session.

## TypeScript
- Strict mode enabled
- No any types without explicit comment explaining why
- All API response types imported from packages/taskflow-contracts

## Naming
- Files     : kebab-case (user-controller.ts)
- Classes   : PascalCase
- Functions : camelCase
- Constants : UPPER_SNAKE_CASE
- REQ IDs   : REQ-AREA-NUMBER (e.g. REQ-AUTH-0001)
- DES IDs   : DES-AREA-NUMBER (e.g. DES-AUTH-0001)
- CMP IDs   : CMP-AREA-NAME   (e.g. CMP-AUTH-TOKEN-VALIDATOR)
- TEST IDs  : TEST-AREA-TYPE-NUMBER (e.g. TEST-AUTH-UNIT-0001)
- FIX IDs   : FIX-AREA-NUMBER (e.g. FIX-AUTH-0001)

## API conventions
- Every response: { data, error, statusCode }
- HTTP 200 for success, 201 for created, 400 for bad input,
  401 for unauthenticated, 403 for forbidden, 404 for not found
- Never expose stack traces in error responses
- All timestamps in ISO 8601 UTC

## Database
- UUID primary keys
- snake_case column names
- Migrations in apps/taskflow-api/src/config/migrations/
- Never raw SQL in controllers — use query builder

## Testing
- Unit tests alongside source files (*.test.ts)
- Contract tests in tests/contract/
- Integration tests in tests/integration/
- Minimum coverage: 80% per component

## Git
- Commits: conventional commits (feat:, fix:, chore:, docs:)
- Never commit secrets, .env files, or node_modules
- Always run tests before pushing
