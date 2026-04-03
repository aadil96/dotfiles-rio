# dotfiles

Dotfiles managed with [chezmoi](https://www.chezmoi.io/), designed for seamless use across local, containerized, and cloud development environments.

---

## Quick Start

```sh
# Clone and setup
git clone https://github.com/youruser/dotfiles-rio.git ~/.dotfiles
cd ~/.dotfiles
./setup
```

Or with chezmoi directly:

```sh
chezmoi init https://github.com/youruser/dotfiles-rio
```

---

## Configuration

Copy `chezmoi.toml.example` to `~/.config/chezmoi/chezmoi.toml` and customize:

```toml
git_user_name = "Your Name"
git_user_email = "your@email.com"
# git_signingKey = ""  # GPG key for commit signing (optional)
# ssh_key_path = "~/.ssh/id_ed25519"
```

### Available Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `git_user_name` | "Your Name" | Git user name |
| `git_user_email` | "your@email.com" | Git user email |
| `git_signingKey` | "" | GPG key for commit signing (empty = disabled) |
| `ssh_key_path` | "~/.ssh/id_ed25519" | SSH identity file path |

---

## Repository Structure

```
.
├── .chezmoi.toml.tmpl      # chezmoi configuration (templated)
├── .chezmoiexternals/      # External resources (tools, fonts)
├── .chezmoiscripts/        # Hook scripts
├── .devcontainer/         # Dev Container config
├── dot_*                  # Dotfiles (bashrc, gitconfig, zshrc, etc.)
├── dot_config/            # XDG config files
│   ├── mise/              # mise tool versions
│   ├── nvim/              # Neovim/LazyVim config
│   ├── starship.toml      # starship prompt config
│   └── ...
├── setup                  # Bootstrap script
└── chezmoi.toml.example   # Config template
```

---

## Supported Environments

- **Local**: macOS, Linux, WSL
- **Remote**: SSH environments
- **Containers**: Dev Containers, GitHub Codespaces
- **DevPod**: Integrated

---

## Usage

### Update Dotfiles

```sh
chezmoi update
chezmoi apply
```

### Edit Dotfiles

```sh
chezmoi edit ~/.zshrc
```

### Add New Dotfiles

```sh
chezmoi add ~/.someconfig
```

---

## Tools Included

- **Shell**: zsh, bash
- **Prompt**: starship
- **Editor**: Neovim (LazyVim)
- **Terminal**: WezTerm, Alacritty
- **Multiplexers**: tmux, zellij
- **Tools**: mise (version manager), fzf, zoxide, bat, lsd

---

## License

MIT - Use at your own risk.
