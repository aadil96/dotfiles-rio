# dotfiles — chezmoi-managed personal configuration

## What this repo is

Personal dotfiles for a zsh/bash + Neovim + mise setup. Managed by [chezmoi](https://chezmoi.io/). No build step — only configuration files and templates.

## Verified commands

```sh
./setup                              # Bootstrap: install chezmoi, apply dotfiles
chezmoi apply                        # Apply all dotfiles to $HOME
chezmoi update                        # Pull latest changes and re-apply
mise exec -- chezmoi apply            # Run via mise if chezmoi not on PATH
```

## Repo structure

```
dot_*              → becomes $HOME/.filename (chezmoi auto-symlinks)
dot_config/        → becomes $HOME/.config/
private_dot_*      → private files; never tracked in git
.chezmoiexternals/ # External resources (mise, devpod, fonts)
.chezmoiscripts/   # Hook scripts run by chezmoi
.devcontainer/     # VS Code Dev Container config
setup              # Bootstrap script
```

## How chezmoi works here

- `dot_*` files become `$HOME/.filename`
- `.tmpl` extension = chezmoi Go template (supports `{{ .chezmoi.os }}`, `{{ lookPath "cmd" }}`, etc.)
- Templates must not fail on missing vars — use `{{ if ... }}{{ end }}` guards
- `.chezmoiignore` excludes: `.oh-my-zsh/cache/*`, `**/*.zwc`, `setup`, `README.md`, `dot_config/zsh/local.zsh`, `dot_config/opencode/bun.lockb`, `dot_config/opencode/package-lock.json`

## Shell script standards

- Shebang: `#!/bin/bash` or `#!/usr/bin/env bash`
- Required flags: `set -euo pipefail`
- No bare `cd` — use `cd ... || exit` or pushd/popd
- Functions welcome; keep small and single-purpose

## Security boundaries

- Never commit secrets; use `private_*` prefix for any file containing credentials
- `.chezmoiignore` does NOT redact secrets — only gitignore semantics apply
- GPG config lives in `private_dot_gnupg/` (not tracked)
- If a file should never leave this machine, prefix it `private_`

## Read these first

| For this... | Read that... |
|---|---|
| chezmoi config + template variables | `.chezmoi.toml.tmpl` |
| Tool versions and tool management | `dot_config/mise/mise.toml` |
| OpenCode profiles and settings | `dot_config/opencode/ocx.jsonc` + `profiles/` |
| Shell config | `dot_bashrc.tmpl`, `dot_zshrc.tmpl` |
| Bootstrap logic | `setup` |

## Git and branch safety rules

### Protected branches

- `main` and `master` are protected — never commit, push, merge, or rebase directly onto them

### Feature branch workflow (mandatory)

1. Before any change: `git switch -c <branch-name>` (or `git checkout -b`)
2. Work on the feature branch
3. Commit freely on the feature branch
4. Push with `git push --set-upstream origin <branch-name>` (non-force)
5. When ready: open a PR or merge locally to main/master via a merge commit (no fast-forward)

### Branch naming

- Use format: `feat/<short-description>`, `fix/<short-description>`, `chore/<short-description>`
- Examples: `feat/zsh-history`, `fix/mise-version`, `chore/update-starship`

### Pre-change verification

Before running `git checkout` or `git switch`:

1. Run `git status` — confirm no uncommitted work will be lost
2. Run `git branch` — confirm you're on the intended branch

### Force and destructive operations — ALWAYS DENIED

- `git push --force` / `git force-push` — never, under any circumstances
- `git rebase` onto a protected branch — denied
- `git reset --hard` on main/master — denied
- `git reflog expire`, `git filter-branch` — denied
- `rm -rf` with a broad path — denied
- `sudo`, `dd`, `chmod -R` — denied on system paths

### Safe operation whitelist (allowed without asking)

- `git status`, `git diff`, `git log --oneline`, `git show`, `git branch -a`
- `chezmoi apply`, `chezmoi update`, `chezmoi status`
- `mise exec`, `ls`, `cat`, `grep`, `find`, `pwd`

### Ask before doing

- `git add`, `git commit`, non-protected `git push`, `git checkout` to existing branches
- `terraform apply`, `kubectl delete`, `docker system prune`
- Editing any `.env`, `kubeconfig`, or `terraform.tfstate` file

## Safety and permission philosophy

Permission rules in `opencode.json` are intentional guardrails, not suggestions.

- `deny` means the operation is blocked — a blocked operation will not execute
- `ask` means the agent must confirm intent before proceeding
- `allow` means the operation proceeds without prompting

If a task seems to require a denied operation, stop and report back. Do not work around permission rules by splitting commands or using alternatives.

Destructive commands (`rm -rf`, `sudo`, `dd`) are always denied. When work requires clearing space or resetting state, use safe alternatives (e.g., `mv` to a trash directory) or ask.

Protected branch enforcement is implemented in `opencode.json` permission rules. Even if an agent is given raw bash access, these rules apply at the session level.

**Branch-switching safety:**
If a task requires switching branches or checking out code, always:

- Verify the current branch first
- Ensure no uncommitted changes exist or stash them
- Never switch to main/master for direct work
- Return to the feature branch after inspection

**Why these rules exist:**

- Prevent accidental commits or pushes to protected branches
- Avoid destructive operations that cannot be easily undone
- Protect secrets, state files, and production config
- Ensure all work goes through proper review workflow

## Documentation maintenance

Docs are living context — update them when your work changes behavior, commands, setup, architecture, deployment, rollback, troubleshooting, or operational constraints.

- Update only the docs directly affected by your change
- Never leave a doc that contradicts the actual code or commands
- When you discover a failure mode or fix, add it to `docs/troubleshooting.md`
- In your final task summary, state whether docs were updated and which ones, or explicitly say "no docs updated" with the reason

Do not create new docs unless genuinely useful for future agents. A stub is justified if the repo has operational complexity (infra, multi-service, deployment concerns).

## What not to do

- Do not run `make`, `npm install`, or any build commands in this repo
- Do not modify `setup` — it must remain runnable on any vanilla Linux/macOS machine
- Do not add hardcoded paths (use `$HOME`, `$XDG_CONFIG_HOME`, or chezmoi template vars instead)

