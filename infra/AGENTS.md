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
