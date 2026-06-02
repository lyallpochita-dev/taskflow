#!/bin/bash
# ─────────────────────────────────────────────────────────────────────────────
# TaskFlow — Full Repo Setup Script
# Run this from inside your empty Git repo root:
#   git clone https://github.com/your-org/taskflow.git
#   cd taskflow
#   bash setup.sh
# ─────────────────────────────────────────────────────────────────────────────
set -e
echo ""
echo "════════════════════════════════════════════════"
echo "  TaskFlow — Repo Setup"
echo "  Protocol: Codex MCP Azure Rulebook v1.3"
echo "════════════════════════════════════════════════"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# 1. DIRECTORY STRUCTURE
# ─────────────────────────────────────────────────────────────────────────────
echo "[ 1/6 ] Creating directory structure..."

mkdir -p apps/taskflow-api/src/{auth,projects,tasks,teams,dashboard,middleware,config,startup}
mkdir -p apps/taskflow-api/tests
mkdir -p apps/taskflow-web/src/{pages,components,features,hooks,styles}
mkdir -p apps/taskflow-web/tests

mkdir -p packages/taskflow-contracts
mkdir -p packages/shared-auth
mkdir -p packages/shared-config
mkdir -p packages/shared-observability

mkdir -p infra/bicep/modules
mkdir -p infra/bicep/environments/{dev,test,prod}

mkdir -p tests/{contract,integration,e2e,security,performance}

mkdir -p tools/{traceability,scripts}

mkdir -p .github/{workflows,ISSUE_TEMPLATE}

mkdir -p .codex/{context,playbooks,templates,prompts}
mkdir -p .codex/specs/{requirements,designs,components,tests,fixes}
mkdir -p .codex/traceability

echo "    ✓ Directory structure created"

# ─────────────────────────────────────────────────────────────────────────────
# 2. ROOT AGENTS.md
# ─────────────────────────────────────────────────────────────────────────────
echo "[ 2/6 ] Writing AGENTS.md files..."

cat > AGENTS.md << 'EOF'
# TaskFlow — AGENTS.md
# Root-level rules. Read this before every session.
# Codex and Claude Code load this automatically.

## Project
Name: TaskFlow
Type: Dummy POC project for validating team development protocol
Stack: Node.js + Express (API), React (Web), PostgreSQL, Azure Container Apps

## The golden rule
Plan before you code.
Every change must answer five questions before a PR is opened:
  1. What requirement is this for?      → REQ-AREA-NUMBER
  2. What design does it follow?        → DES-AREA-NUMBER
  3. What component changed?            → CMP-AREA-NAME
  4. What tests prove it works?         → TEST-AREA-TYPE-NUMBER
  5. Where is it mapped in traceability? → .codex/traceability/traceability-matrix.yaml

## Read these before starting any work
- .codex/context/project.md        ← stable project memory
- .codex/context/conventions.md    ← coding standards
- .codex/context/azure.md          ← Azure environment details
- .codex/traceability/traceability-matrix.yaml ← what is built and what is not

## Rules Codex must follow
- Never write code without a REQ-ID
- Never change files outside the declared component ownership
- Never update .codex/context to justify code already written
- Always update traceability-matrix.yaml when creating or closing a REQ
- Always include contract tests when changing an API endpoint
- Always include a FIX-ID when correcting wrong development
- If a dependency task is not marked done — flag it, do not guess

## Branch naming
feature/REQ-{AREA}-{NUMBER}-{short-description}
fix/FIX-{AREA}-{NUMBER}-{short-description}
infra/REQ-INFRA-{NUMBER}-{short-description}
docs/REQ-DOCS-{NUMBER}-{short-description}

## PR title format
REQ-AUTH-0001: Add JWT authentication

## Codex response format
Every Codex response must end with:
  Requirement : REQ-AREA-NUMBER
  Design      : DES-AREA-NUMBER
  Component   : CMP-AREA-NAME
  Tests       : TEST-AREA-TYPE-NUMBER
  Files changed: list
  Checks run  : list
EOF

# App-level AGENTS.md
cat > apps/taskflow-api/AGENTS.md << 'EOF'
# TaskFlow API — AGENTS.md
# Inherits root AGENTS.md. These rules are specific to the API app.

## Owned by
This app is the backend. It owns all files under apps/taskflow-api/

## Structure
src/auth/         → authentication handlers (REQ-AUTH-*)
src/projects/     → project CRUD (REQ-PROJ-*)
src/tasks/        → task management (REQ-TASK-*)
src/teams/        → team management (REQ-TEAM-*)
src/dashboard/    → dashboard aggregation (REQ-DASH-*)
src/middleware/   → shared middleware (auth guard, error handler)
src/config/       → environment config loading
src/startup/      → server bootstrap

## API response shape (must follow in every endpoint)
{
  data: <payload or null>,
  error: <string or null>,
  statusCode: <number>
}

## Rules specific to this app
- Amounts always in integers (paise/cents) — never floats
- All auth routes must use the shared-auth package
- Every new endpoint must have a contract test in tests/contract/
- Never import directly from another app — use packages/ only
EOF

cat > apps/taskflow-web/AGENTS.md << 'EOF'
# TaskFlow Web — AGENTS.md
# Inherits root AGENTS.md. These rules are specific to the web app.

## Owned by
This app is the frontend. It owns all files under apps/taskflow-web/

## Structure
src/pages/        → page-level components (one per route)
src/features/     → feature modules (auth, projects, tasks, teams)
src/components/   → shared UI components (Button, Card, Modal, etc.)
src/hooks/        → shared React hooks
src/styles/       → global styles

## Rules specific to this app
- Never fetch directly — use hooks from src/hooks/
- Never define API response types locally — import from packages/taskflow-contracts
- Component props must match taskflow-contracts definitions
- No two page components may share the same feature folder
EOF

cat > infra/AGENTS.md << 'EOF'
# TaskFlow Infra — AGENTS.md
# Inherits root AGENTS.md. These rules are specific to infrastructure.

## Owned by
Infrastructure team. Owns all files under infra/

## Azure resources
- Azure Container Apps (API and Web)
- Azure Database for PostgreSQL Flexible Server
- Azure Key Vault (secrets — never in repo)
- Azure Container Registry

## Rules
- Never hard-code secrets — use Key Vault references
- Every infra change needs a REQ-INFRA-ID
- Run bicep what-if before raising a PR
- Never mix dev/test/prod in the same bicep file
EOF

cat > .codex/AGENTS.md << 'EOF'
# .codex — AGENTS.md
# This folder is for rules, context, specs, and traceability only.
# Project code does NOT go here.

## What each folder contains
context/          → stable project memory (read before every session)
specs/requirements → REQ-ID files — one per accepted work item
specs/designs/    → DES-ID files — how each requirement will be solved
specs/components/ → CMP-ID files — what each component owns
specs/tests/      → TEST-ID files — what must be proven per requirement
specs/fixes/      → FIX-ID files — wrong development corrections
traceability/     → central maps between all IDs
playbooks/        → how to plan, develop, review, and recover
templates/        → starter formats for new records
prompts/          → reusable Codex prompts

## Golden rule
.codex explains what and why.
apps, packages, infra, tests, and tools contain how it is built.
EOF

echo "    ✓ AGENTS.md files written"

# ─────────────────────────────────────────────────────────────────────────────
# 3. .codex/context/
# ─────────────────────────────────────────────────────────────────────────────
echo "[ 3/6 ] Writing .codex/context files..."

cat > .codex/context/project.md << 'EOF'
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
EOF

cat > .codex/context/conventions.md << 'EOF'
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
EOF

cat > .codex/context/azure.md << 'EOF'
# TaskFlow — Azure Environment Context

## Resource groups
dev  : rg-taskflow-dev
test : rg-taskflow-test
prod : rg-taskflow-prod

## Services per environment
Container App (API) : ca-taskflow-api-{env}
Container App (Web) : ca-taskflow-web-{env}
PostgreSQL          : psql-taskflow-{env}
Key Vault           : kv-taskflow-{env}
Container Registry  : crtaskflow (shared)

## Secrets location
All secrets live in Azure Key Vault.
Never commit secrets to the repo.
Never hardcode connection strings.
Reference secrets via Key Vault references in Container App config.

## Infra approach
Bicep modules in infra/bicep/modules/
Environment overrides in infra/bicep/environments/{dev,test,prod}/
Run bicep what-if before every infra PR.
EOF

echo "    ✓ Context files written"

# ─────────────────────────────────────────────────────────────────────────────
# 4. TEMPLATES + FIRST REQUIREMENTS
# ─────────────────────────────────────────────────────────────────────────────
echo "[ 4/6 ] Writing templates and first REQ/DES/CMP/TEST files..."

# ── Templates ──────────────────────────────────────────────
cat > .codex/templates/requirement.template.md << 'EOF'
# REQ-AREA-NUMBER: Title
Status: draft
Owner: team-member-name
Created: YYYY-MM-DD

## Problem
What problem are we solving?

## Expected Behavior
What should happen when this is implemented?

## Acceptance Criteria
- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

## Out of Scope
What is explicitly not included in this requirement?

## Dependencies
- REQ-AREA-NUMBER (if any)
EOF

cat > .codex/templates/design.template.md << 'EOF'
# DES-AREA-NUMBER: Title
Requirement: REQ-AREA-NUMBER
Status: draft
Created: YYYY-MM-DD

## Design Summary
How will this requirement be implemented?

## Components
- CMP-AREA-NAME

## API Changes (if any)
Endpoint, method, request shape, response shape.

## Database Changes (if any)
Tables, columns, migrations.

## Risks
- Risk 1 and mitigation

## Test Approach
- TEST-AREA-TYPE-NUMBER
EOF

cat > .codex/templates/component.template.md << 'EOF'
# CMP-AREA-NAME
Design: DES-AREA-NUMBER
Owner: team-member-name
Created: YYYY-MM-DD

## Responsibility
What does this component own and nothing else?

## Files and Modules
- apps/taskflow-api/src/...

## Interfaces (inputs and outputs)
What does it consume and what does it produce?

## Tests
- TEST-AREA-TYPE-NUMBER
EOF

cat > .codex/templates/test-plan.template.md << 'EOF'
# TEST-AREA-TYPE-NUMBER: Title
Requirement: REQ-AREA-NUMBER
Component: CMP-AREA-NAME
Type: unit | contract | integration | e2e | security | performance
Created: YYYY-MM-DD

## What must be proven
One sentence: what behavior does this test plan prove?

## Success scenarios
- [ ] Scenario 1
- [ ] Scenario 2

## Failure scenarios
- [ ] Bad input returns 400
- [ ] Unauthenticated returns 401

## Evidence
Command that proves these tests ran:
  npm run test:contract
  npm run test:unit
EOF

cat > .codex/templates/fix.template.md << 'EOF'
# FIX-AREA-NUMBER: Title
Affected Requirement: REQ-AREA-NUMBER
Affected Component: CMP-AREA-NAME
Created: YYYY-MM-DD

## What went wrong
Describe the wrong development or wrong test.

## Root cause
Why did this happen?

## Correction
What was changed and how?

## Regression tests added
- TEST-AREA-TYPE-NUMBER
EOF

# ── REQ-AUTH-0001 ──────────────────────────────────────────
cat > .codex/specs/requirements/REQ-AUTH-0001.md << 'EOF'
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
EOF

# ── REQ-PROJ-0001 ──────────────────────────────────────────
cat > .codex/specs/requirements/REQ-PROJ-0001.md << 'EOF'
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
EOF

# ── REQ-TASK-0001 ──────────────────────────────────────────
cat > .codex/specs/requirements/REQ-TASK-0001.md << 'EOF'
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
EOF

# ── REQ-TEAM-0001 ──────────────────────────────────────────
cat > .codex/specs/requirements/REQ-TEAM-0001.md << 'EOF'
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
EOF

# ── REQ-DASH-0001 ──────────────────────────────────────────
cat > .codex/specs/requirements/REQ-DASH-0001.md << 'EOF'
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
EOF

# ── DES-AUTH-0001 ──────────────────────────────────────────
cat > .codex/specs/designs/DES-AUTH-0001.md << 'EOF'
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
EOF

# ── CMP-AUTH-TOKEN-VALIDATOR ───────────────────────────────
cat > .codex/specs/components/CMP-AUTH-TOKEN-VALIDATOR.md << 'EOF'
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
EOF

# ── TEST-AUTH-CONTRACT-0001 ────────────────────────────────
cat > .codex/specs/tests/TEST-AUTH-CONTRACT-0001.md << 'EOF'
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
EOF

# ── TRACEABILITY MATRIX ─────────────────────────────────────
cat > .codex/traceability/traceability-matrix.yaml << 'EOF'
# TaskFlow — Traceability Matrix
# Every work item must appear here.
# Updated automatically by GitHub Actions on every merge.
# Manual updates: only to add new IDs or change status.

REQ-AUTH-0001:
  title: User authentication with JWT
  status: in-progress
  owner: developer-1
  designs:
    - DES-AUTH-0001
  components:
    - CMP-AUTH-REGISTER-HANDLER
    - CMP-AUTH-LOGIN-HANDLER
    - CMP-AUTH-TOKEN-VALIDATOR
    - CMP-AUTH-REFRESH-HANDLER
  tests:
    - TEST-AUTH-UNIT-0001
    - TEST-AUTH-CONTRACT-0001
    - TEST-AUTH-SECURITY-0001

REQ-PROJ-0001:
  title: Project creation and management
  status: approved
  owner: developer-1
  designs: []
  components: []
  tests: []

REQ-TASK-0001:
  title: Task CRUD
  status: approved
  owner: developer-2
  designs: []
  components: []
  tests: []

REQ-TEAM-0001:
  title: Team member management
  status: approved
  owner: developer-2
  designs: []
  components: []
  tests: []

REQ-DASH-0001:
  title: Dashboard summary API
  status: approved
  owner: developer-2
  designs: []
  components: []
  tests: []
EOF

cat > .codex/traceability/requirement-map.yaml << 'EOF'
# Requirement ID registry — next number per area
# Update this when creating a new REQ

AUTH: 0001   # next: REQ-AUTH-0002
PROJ: 0001   # next: REQ-PROJ-0002
TASK: 0001   # next: REQ-TASK-0002
TEAM: 0001   # next: REQ-TEAM-0002
DASH: 0001   # next: REQ-DASH-0002
INFRA: 0000  # next: REQ-INFRA-0001
DOCS: 0000   # next: REQ-DOCS-0001
EOF

cat > .codex/traceability/component-map.yaml << 'EOF'
# Component ownership registry
# One owner per component during active development

CMP-AUTH-REGISTER-HANDLER:
  owner: developer-1
  files: [apps/taskflow-api/src/auth/register.ts]
  status: in-progress

CMP-AUTH-LOGIN-HANDLER:
  owner: developer-1
  files: [apps/taskflow-api/src/auth/login.ts]
  status: in-progress

CMP-AUTH-TOKEN-VALIDATOR:
  owner: developer-1
  files:
    - apps/taskflow-api/src/middleware/auth-guard.ts
    - packages/shared-auth/src/token-validator.ts
  status: in-progress

CMP-AUTH-REFRESH-HANDLER:
  owner: developer-1
  files: [apps/taskflow-api/src/auth/refresh.ts]
  status: in-progress
EOF

cat > .codex/traceability/test-map.yaml << 'EOF'
# Test ID registry — next number per area and type

AUTH:
  UNIT:     0001   # next: TEST-AUTH-UNIT-0002
  CONTRACT: 0001   # next: TEST-AUTH-CONTRACT-0002
  SECURITY: 0001   # next: TEST-AUTH-SECURITY-0002
PROJ:
  UNIT:     0000   # next: TEST-PROJ-UNIT-0001
  CONTRACT: 0000
TASK:
  UNIT:     0000
  CONTRACT: 0000
TEAM:
  UNIT:     0000
  CONTRACT: 0000
DASH:
  UNIT:     0000
  CONTRACT: 0000
EOF

echo "    ✓ Templates and REQ/DES/CMP/TEST files written"

# ─────────────────────────────────────────────────────────────────────────────
# 5. PR TEMPLATE + PLAYBOOKS + PROMPTS
# ─────────────────────────────────────────────────────────────────────────────
echo "[ 5/6 ] Writing PR template, playbooks, and prompts..."

cat > .github/pull_request_template.md << 'EOF'
## Traceability evidence
<!-- Every PR must complete this block. No exceptions. -->

Requirement : <!-- REQ-AREA-NUMBER -->
Design      : <!-- DES-AREA-NUMBER -->
Component   : <!-- CMP-AREA-NAME -->
Tests       : <!-- TEST-AREA-TYPE-NUMBER -->
Files changed: <!-- list every file you touched -->

## What this PR does
<!-- One paragraph. What changed and why. -->

## How to verify
<!-- Steps a reviewer can follow to confirm this works. -->

## Checklist
- [ ] Requirement ID exists in .codex/specs/requirements/
- [ ] Design ID exists in .codex/specs/designs/
- [ ] Component ID exists in .codex/specs/components/
- [ ] Test ID exists in .codex/specs/tests/
- [ ] traceability-matrix.yaml updated
- [ ] Tests cover success scenarios
- [ ] Tests cover failure scenarios
- [ ] Contract tests added/updated if endpoint changed
- [ ] No files changed outside declared component ownership
- [ ] AGENTS.md rules followed throughout
EOF

cat > .codex/playbooks/how-to-plan.md << 'EOF'
# Playbook: How to plan new work

1. Check .codex/traceability/requirement-map.yaml for the next REQ number
2. Copy .codex/templates/requirement.template.md
3. Create .codex/specs/requirements/REQ-AREA-NUMBER.md
4. Fill in: problem, expected behavior, acceptance criteria, out of scope
5. Add to traceability-matrix.yaml with status: draft
6. Update requirement-map.yaml with next number
7. Create a GitHub Issue with title: REQ-AREA-NUMBER: Title
8. Assign the issue to the owner
9. Only then — create a design file (DES)
10. Only then — create component files (CMP)
11. Only then — create test plan files (TEST)
12. Set status to approved when team confirms
13. Start development only after approved
EOF

cat > .codex/playbooks/how-to-develop.md << 'EOF'
# Playbook: How to develop a task

1. git pull origin main
2. Check GitHub Issues — find an approved unassigned REQ
3. Assign yourself on GitHub Issues
4. git checkout -b feature/REQ-AREA-NUMBER-short-description
5. Open VS Code — Codex reads AGENTS.md automatically
6. Use the implementation prompt from .codex/prompts/
7. Build only inside the declared component file ownership
8. Write or update tests as you go
9. git add + git commit -m "feat: REQ-AREA-NUMBER description"
10. Before PR: git pull origin main + git merge main
11. Resolve any conflicts
12. Open PR using the PR template — fill every field
13. Wait for lead review + merge
EOF

cat > .codex/playbooks/how-to-recover.md << 'EOF'
# Playbook: How to recover from wrong development

Wrong development means:
- Code built without a REQ-ID
- Code does not match the design
- Component ownership ignored
- Tests pass but prove wrong behavior

Steps:
1. Do NOT silently patch — mark it first
2. Create FIX-AREA-NUMBER in .codex/specs/fixes/
3. Copy .codex/templates/fix.template.md
4. Link the broken REQ, DES, and CMP IDs
5. Add regression tests (new TEST-ID if needed)
6. Update traceability-matrix.yaml
7. Open a PR with FIX-ID in the title
8. Get lead review before merge

For code already merged to main:
  git log --oneline            # find the bad commit
  git revert <hash>            # undo safely — never git reset --hard
  git push origin main
  # then follow the FIX-ID steps above
EOF

cat > .codex/prompts/planning.md << 'EOF'
# Prompt: Planning

Use the project rulebook in AGENTS.md.
Plan REQ-[AREA]-[NUMBER].
Read AGENTS.md and .codex/context/ first.
Do not implement anything.
Return:
  - Requirement file content
  - Design file content
  - Component file(s) content
  - Test plan file content
  - Traceability matrix entry
EOF

cat > .codex/prompts/implementation.md << 'EOF'
# Prompt: Implementation

Use the project rulebook in AGENTS.md.
Implement REQ-[AREA]-[NUMBER] using DES-[AREA]-[NUMBER] and CMP-[AREA]-[NAME].
Read .codex/context/ before starting.
Add or update TEST-[AREA]-[TYPE]-[NUMBER].
Update traceability-matrix.yaml.
Do not change files outside declared component ownership.
End your response with the standard Codex response format.
EOF

cat > .codex/prompts/review.md << 'EOF'
# Prompt: Review

Review this PR using the project rulebook in AGENTS.md.
Check:
  - Requirement, design, component, test, and traceability mapping
  - Code matches the design
  - Tests prove the requirement
  - No files changed outside component ownership
  - Shared files handled correctly
Focus on: bugs, missing tests, wrong assumptions, scope violations.
EOF

echo "    ✓ PR template, playbooks, and prompts written"

# ─────────────────────────────────────────────────────────────────────────────
# 6. GITHUB ACTIONS WORKFLOWS
# ─────────────────────────────────────────────────────────────────────────────
echo "[ 6/6 ] Writing GitHub Actions workflows..."

cat > .github/workflows/traceability-check.yml << 'EOF'
name: Traceability Check

on:
  pull_request:
    branches: [main]

jobs:
  check-traceability:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Check PR has required fields
        run: |
          PR_BODY="${{ github.event.pull_request.body }}"
          MISSING=()
          echo "$PR_BODY" | grep -q "Requirement.*REQ-" || MISSING+=("Requirement ID")
          echo "$PR_BODY" | grep -q "Design.*DES-"      || MISSING+=("Design ID")
          echo "$PR_BODY" | grep -q "Component.*CMP-"   || MISSING+=("Component ID")
          echo "$PR_BODY" | grep -q "Tests.*TEST-"       || MISSING+=("Test ID")
          if [ ${#MISSING[@]} -gt 0 ]; then
            echo "❌ PR is missing traceability fields: ${MISSING[*]}"
            echo "Every PR must include Requirement, Design, Component, and Test IDs."
            exit 1
          fi
          echo "✓ All traceability fields present"

      - name: Check REQ exists in specs
        run: |
          REQ=$(echo "${{ github.event.pull_request.body }}" \
            | grep "Requirement" | grep -oP "REQ-[A-Z]+-[0-9]+")
          if [ -z "$REQ" ]; then
            echo "❌ Could not parse REQ ID from PR body"
            exit 1
          fi
          FILE=".codex/specs/requirements/${REQ}.md"
          if [ ! -f "$FILE" ]; then
            echo "❌ Requirement file not found: $FILE"
            exit 1
          fi
          echo "✓ Requirement file exists: $FILE"
EOF

cat > .github/workflows/rebuild-context.yml << 'EOF'
name: Rebuild Context on Merge

on:
  push:
    branches: [main]

jobs:
  rebuild-context:
    runs-on: ubuntu-latest
    permissions:
      contents: write
    steps:
      - uses: actions/checkout@v4
        with:
          token: ${{ secrets.GITHUB_TOKEN }}

      - name: Update traceability matrix from closed issues
        run: |
          echo "# Auto-updated: $(date -u +%Y-%m-%dT%H:%M:%SZ)" \
            >> .codex/traceability/traceability-matrix.yaml
          echo "✓ Traceability matrix timestamp updated"

      - name: Commit updated context
        run: |
          git config user.name  "github-actions[bot]"
          git config user.email "github-actions[bot]@users.noreply.github.com"
          git add .codex/traceability/traceability-matrix.yaml
          git diff --staged --quiet || \
            git commit -m "chore: auto-rebuild context after merge [skip ci]"
          git push
EOF

cat > .github/workflows/ci.yml << 'EOF'
name: CI

on:
  pull_request:
    branches: [main]
  push:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'

      - name: Install dependencies
        run: npm install

      - name: Type check
        run: npm run typecheck --if-present

      - name: Unit tests
        run: npm run test:unit --if-present

      - name: Contract tests
        run: npm run test:contract --if-present
EOF

# ─────────────────────────────────────────────────────────────────────────────
# 7. ROOT FILES
# ─────────────────────────────────────────────────────────────────────────────

cat > .gitignore << 'EOF'
node_modules/
dist/
.env
.env.*
*.local
coverage/
.DS_Store
*.log
EOF

cat > README.md << 'EOF'
# TaskFlow

POC project for validating the team development protocol.
Built using the Codex MCP Azure Rulebook v1.3.

## Quick start for developers

1. Clone the repo and pull main
2. Read `AGENTS.md` — this is what Codex reads every session
3. Read `.codex/context/` — stable project memory
4. Check `.codex/traceability/traceability-matrix.yaml` — see what is built
5. Check GitHub Issues — pick an approved unassigned task
6. Follow `.codex/playbooks/how-to-develop.md`

## Protocol documentation
- Playbooks    → .codex/playbooks/
- Templates    → .codex/templates/
- Prompts      → .codex/prompts/
- Requirements → .codex/specs/requirements/
- Traceability → .codex/traceability/

## The five questions before any PR
1. What requirement is this for?       REQ-AREA-NUMBER
2. What design does it follow?         DES-AREA-NUMBER
3. What component changed?             CMP-AREA-NAME
4. What tests prove it?                TEST-AREA-TYPE-NUMBER
5. Where is it in the traceability?    .codex/traceability/traceability-matrix.yaml
EOF

# ─────────────────────────────────────────────────────────────────────────────
# DONE
# ─────────────────────────────────────────────────────────────────────────────
echo ""
echo "════════════════════════════════════════════════"
echo "  ✓ TaskFlow repo setup complete"
echo "════════════════════════════════════════════════"
echo ""
echo "What was created:"
echo "  AGENTS.md (root, apps, infra, .codex)"
echo "  .codex/context/    (project, conventions, azure)"
echo "  .codex/specs/      (5 REQs, 1 DES, 1 CMP, 1 TEST)"
echo "  .codex/traceability/ (matrix, requirement-map, component-map, test-map)"
echo "  .codex/templates/  (requirement, design, component, test, fix)"
echo "  .codex/playbooks/  (plan, develop, recover)"
echo "  .codex/prompts/    (planning, implementation, review)"
echo "  .github/           (PR template, 3 workflows)"
echo "  README.md + .gitignore"
echo ""
echo "Next steps:"
echo "  1. git add ."
echo "  2. git commit -m 'chore: initial repo setup with TaskFlow protocol'"
echo "  3. git push origin main"
echo "  4. Enable branch protection on GitHub:"
echo "     Settings → Branches → Add rule → main"
echo "     ✓ Require pull request before merging"
echo "     ✓ Require status checks (traceability-check, ci)"
echo "  5. Team pulls and reads AGENTS.md"
echo "  6. First developer claims REQ-AUTH-0001 on GitHub Issues"
echo ""