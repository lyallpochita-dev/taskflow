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
