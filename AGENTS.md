# AGENTS.md - Dotfiles Repository

## Repository Type
This is a **chezmoi-managed dotfiles repository** - a collection of config files, not a software project. No build/lint/test commands exist.

## Commands

### Apply Dotfiles
```sh
chezmoi apply          # Apply all dotfiles
chezmoi update        # Pull latest and apply
chezmoi edit <file>   # Edit a dotfile in source
chezmoi add <file>   # Add existing file to management
```

### Testing Templates
```sh
chezmoi cat ~/.zshrc                    # View rendered output
chezmoi diff                            # Show pending changes
chezmoi execute-template --help         # Test template rendering
```

## Code Style

### General Guidelines
- Use **chezmoi templates** (`.tmpl` extension) for user-specific customizations
- All user data stored in `~/.config/chezmoi/chezmoi.toml`, not in source
- Use conditional templates for OS/environment differences: `{{ if eq .chezmoi.os "linux" }}`
- Never hardcode personal info (names, emails, keys) - use template variables

### Template Variables
| Variable | Description |
|----------|-------------|
| `git_user_name` | Git user name |
| `git_user_email` | Git user email |
| `git_signingKey` | GPG signing key |
| `ssh_key_path` | SSH identity file |

### File Conventions
- `dot_*` files map to `~/.*` (e.g., `dot_zshrc.tmpl` → `~/.zshrc`)
- `dot_config/*` files map to `~/.config/*`
- Use `.tmpl` extension for templates,`.sh.tmpl` for scripts

### Error Handling
- Use `{{ .variable | default "value" }}` for optional template values
- Check with `chezmoi cat` before applying to catch template errors
