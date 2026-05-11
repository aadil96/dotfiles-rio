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
