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
