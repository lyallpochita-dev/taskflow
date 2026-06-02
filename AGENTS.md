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

## Definition of Done
A task is done when ALL four conditions are true:
  1. PR is merged to main
  2. All tests pass (unit + contract)
  3. GitHub Issue is closed
  4. Lead has approved and merged the PR

Codex must not declare a task complete until all four are satisfied.
If any condition is not met, flag it — do not proceed.
