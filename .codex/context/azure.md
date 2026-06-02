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
