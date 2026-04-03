# Troubleshooting

## Common Issues

### chezmoi: template has no entry for key

**Error:**
```
chezmoi: template: file.tmpl:2:11: executing "file.tmpl" at <.variable>: map has no entry for key "variable"
```

**Cause:** The variable is not defined in your `~/.config/chezmoi/chezmoi.toml`.

**Fix:** Add the variable to your config file:
```toml
[data]
  git_user_name = "Your Name"
  git_user_email = "your@email.com"
```

---

### chezmoi: config file template has changed

**Error:**
```
chezmoi: warning: config file template has changed, run chezmoi init to regenerate config file
```

**Fix:** 
```sh
rm ~/.config/chezmoi/chezmoi.toml
chezmoi init
```

---

### Git config not applying

**Symptom:** Running `chezmoi apply` doesn't update `~/.gitconfig` with your values.

**Fix:** Ensure your `~/.config/chezmoi/chezmoi.toml` has the `[data]` section:
```toml
[data]
  git_user_name = "Your Name"
  git_user_email = "your@email.com"
```

Then run:
```sh
chezmoi apply
```

---

### SSH config not using my key

**Symptom:** SSH is looking for wrong identity file.

**Fix:** Set `ssh_key_path` in your config:
```toml
[data]
  ssh_key_path = "~/.ssh/your-key"
```

---

### GPG signing not working

**Symptom:** Commits aren't being signed even with `git_signingKey` set.

**Fix:** Ensure your GPG key is set up correctly:
```sh
# Check your key
gpg --list-secret-keys

# Set in config
[data]
  git_signingKey = "YOUR_KEY_ID"
```

Note: Leave `git_signingKey` empty to disable signing entirely.

---

### Windows/WSL paths in zshrc

**Symptom:** Windows-specific paths appearing in Linux config.

**Fix:** These are managed via `~/.config/zsh/local.zsh` which is excluded from chezmoi. Manually create if needed:
```sh
mkdir -p ~/.config/zsh
# Add your Windows paths to ~/.config/zsh/local.zsh
```

---

### Tools not found after apply

**Symptom:** Commands like `starship`, `mise`, `fzf` not found.

**Fix:** Install tools via mise (defined in `dot_config/mise/mise.toml`):
```sh
mise install
```

Or add to your shell profile:
```sh
# For zsh
eval "$(mise activate zsh)"
```

---

### Auto-commit not working

**Symptom:** Changes aren't being auto-committed.

**Fix:** Ensure your `chezmoi.toml` has:
```toml
[git]
  autoCommit = true
  autoPush = true
```

---

## Getting Help

- [chezmoi docs](https://chezmoi.io/)
- [chezmoi discussions](https://github.com/twpayne/chezmoi/discussions)
