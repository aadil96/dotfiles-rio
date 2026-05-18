# Project Layer

This directory contains project-level context, stack documentation, and
reusable workflows for this repository.

## Contents

| File / Directory | Purpose |
|------------------|---------|
| `project.md` | Project identity — purpose, goals, constraints, priorities, success metrics, non-goals |
| `stack.md` | Technology stack — backend, frontend, database, infrastructure, CI/CD, observability, and architecture decision records |
| `workflows/` | Executable process definitions — feature development, bug fixes, deployment, architecture review, incident response |
| `skills/` | Project-specific skills (loaded via `skills.paths` in `opencode.json` when populated) |

## Project vs Global Scope

| Scope | Path | Managed By | Contains |
|-------|------|------------|----------|
| **Global organization** | `~/.config/opencode/agents/` | chezmoi | Organizational agents: ceo, cto, pm, finance, security, qa, devops |
| **Global organization skills** | `~/.config/opencode/skills/` | chezmoi | Decision frameworks: org-routing, org-governance, architecture-principles, security-policies, cost-optimization, decision-framework |
| **Project (this directory)** | `.opencode/` | Local git | Project context, stack, workflows, and project-specific skills |

Workflows in this directory reference organization agents, execution agents, or project-local agents by name. They do not redefine agent behavior — they define how work flows *through* agents.

## How to Use

1. **`project.md`** — Fill in the sections during project setup or pivot
2. **`stack.md`** — Document the technology stack and log architecture decisions as ADRs
3. **`workflows/*`** — Follow the applicable workflow when starting feature work, fixing bugs, deploying, reviewing architecture, or responding to incidents
4. **`skills/*`** — Add project-specific skills here when shared standards need local overrides
