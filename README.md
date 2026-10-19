# dotfiles

Personal configuration files for macOS (and some Linux/NixOS bits). Clone this repo as `~/.config`.

## What's in here

| Tool | Purpose |
|------|---------|
| **nvim** | Neovim config (Lua, lazy.nvim) |
| **tmux** | Terminal multiplexer |
| **aerospace** | macOS tiling window manager |
| **yabai + skhd** | Alternative tiling WM + hotkey daemon |
| **sketchybar** | Custom macOS menu bar |
| **alacritty / kitty** | Terminal emulators |
| **starship** | Shell prompt |
| **fish / zsh** | Shell configs |
| **karabiner** | Keyboard remapping |
| **git / gh** | Git and GitHub CLI config |
| **btop** | System monitor |
| **waybar / hypr / wofi / mako** | Wayland/Hyprland desktop stack |

## Setup (macOS)

> TODO: automate with Ansible or a bootstrap script

1. **Homebrew** — [brew.sh](https://brew.sh)
2. **Core tools**
   ```bash
   brew install neovim tmux ripgrep fd git gh starship fish
   ```
3. **Neovim deps** — `ripgrep` (Telescope live grep) and `fd` (file finding) are required.
4. **Window management**
   ```bash
   brew install --cask aerospace
   # or: brew install koekeishiya/formulae/yabai koekeishiya/formulae/skhd
   ```
5. **Terminal**
   ```bash
   brew install --cask alacritty   # or kitty
   ```
6. **Shell**
   ```bash
   brew install oh-my-zsh   # or use fish
   ```
7. **Extras**
   ```bash
   brew install --cask docker
   brew install kubectl
   ```

## Clone

```bash
git clone git@github.com:jds0295/config.git ~/.config
```

