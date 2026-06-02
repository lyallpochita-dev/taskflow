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
