# Troubleshooting

## Common issues with this dotfiles repo

### chezmoi apply does nothing
- Make sure you're in the correct source directory (`~/.local/share/chezmoi`)
- Run `chezmoi status` to see what would change before applying

### Template variables missing
- Check `.chezmoi.toml.tmpl` for available variables
- Use `{{ if ... }}{{ end }}` guards to handle missing values gracefully

### Private files not appearing
- Files prefixed `private_` are excluded from git — they only exist in this repo
- Do NOT copy private_* files to other machines

### Shell scripts failing on new machine
- Run `./setup` first — it bootstraps chezmoi and applies all dotfiles
- Verify `set -euo pipefail` is set in any new shell scripts you add
