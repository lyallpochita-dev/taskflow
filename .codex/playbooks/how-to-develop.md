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
