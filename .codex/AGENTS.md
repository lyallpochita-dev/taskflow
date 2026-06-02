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
