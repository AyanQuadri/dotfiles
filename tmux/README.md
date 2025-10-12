# Tmux Configuration 

My personal tmux configuration with vim-style keybindings, catppuccin theme, and productivity plugins.

## Features

- **Vim-style Navigation**: hjkl for pane navigation
- **Catppuccin Theme**: Modern, aesthetic color scheme
- **Session Manager**: SessionX with fzf integration
- **Floating Windows**: Floax plugin for temporary terminals
- **Smart Copy Mode**: Tmux-yank and tmux-thumbs for clipboard
- **URL Launcher**: Quick URL opening with fzf
- **Session Persistence**: Auto-restore sessions with continuum

## Prerequisites

- [Tmux](https://github.com/tmux/tmux) (v3.2+)
- [TPM](https://github.com/tmux-plugins/tpm) (Tmux Plugin Manager)
- [fzf](https://github.com/junegunn/fzf)
- [zoxide](https://github.com/ajeetdsouza/zoxide)

## Installation

1. Install tmux:
```bash
# macOS
brew install tmux

# Ubuntu/Debian
sudo apt install tmux
```

2. Install TPM:
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

3. Clone and symlink config:
```bash
# Backup existing config
mv ~/.config/tmux ~/.config/tmux.backup

# Symlink from dotfiles
ln -s ~/dotfiles/tmux ~/.config/tmux
```

4. Install plugins:
```bash
# Start tmux
tmux

# Press prefix + I (capital i) to install plugins
# Default prefix: Ctrl+a
```

## Key Bindings

### Prefix
- Prefix changed from `Ctrl+b` to `Ctrl+a`

### Window Management
| Key | Action |
|-----|--------|
| `Ctrl+a c` | Kill current pane |
| `Ctrl+a s` | Split horizontally |
| `Ctrl+a v` | Split vertically |
| `Ctrl+a H` | Previous window |
| `Ctrl+a L` | Next window |
| `Ctrl+a r` | Rename window |

### Pane Navigation
| Key | Action |
|-----|--------|
| `Ctrl+a h/j/k/l` | Navigate left/down/up/right |
| `Ctrl+a z` | Toggle pane zoom |
| `Ctrl+a ,` | Resize pane left |
| `Ctrl+a .` | Resize pane right |
| `Ctrl+a -` | Resize pane down |
| `Ctrl+a =` | Resize pane up |

### Session Management
| Key | Action |
|-----|--------|
| `Ctrl+a o` | Open SessionX (session manager) |
| `Ctrl+a S` | Choose session |
| `Ctrl+a d` | Detach from session |

### Special Features
| Key | Action |
|-----|--------|
| `Ctrl+a p` | Toggle floating window (Floax) |
| `Ctrl+a u` | Open URL with fzf |
| `Ctrl+a K` | Clear pane |
| `Ctrl+a R` | Reload config |
| `Ctrl+a *` | Synchronize panes |

### Copy Mode (vi-style)
- Enter copy mode: `Ctrl+a [`
- Start selection: `v`
- Copy selection: `y`
- Paste: `Ctrl+a ]`

## Plugins

- **[TPM](https://github.com/tmux-plugins/tpm)**: Plugin manager
- **[tmux-sensible](https://github.com/tmux-plugins/tmux-sensible)**: Sensible defaults
- **[tmux-yank](https://github.com/tmux-plugins/tmux-yank)**: Copy to system clipboard
- **[tmux-thumbs](https://github.com/fcsonline/tmux-thumbs)**: Fast text copying
- **[tmux-fzf](https://github.com/sainnhe/tmux-fzf)**: Fzf integration
- **[tmux-fzf-url](https://github.com/wfxr/tmux-fzf-url)**: URL launcher
- **[catppuccin-tmux](https://github.com/catppuccin/tmux)**: Theme
- **[tmux-sessionx](https://github.com/omerxx/tmux-sessionx)**: Session manager
- **[tmux-floax](https://github.com/omerxx/tmux-floax)**: Floating windows

## Configuration Details

### General Settings
- Base index starts at 1
- Auto-renumber windows
- 1M line scrollback history
- Vi-mode in copy mode
- Status bar at top
- System clipboard integration

### Theme
- Catppuccin color scheme
- Status modules: session, directory, time
- Custom window separators

## File Structure

```
tmux/
├── tmux.conf           # Main configuration
└── tmux.reset.conf     # Keybinding resets
```

## Troubleshooting

**Plugins not installing:**
```bash
# Ensure TPM is installed
ls ~/.tmux/plugins/tpm

# Reinstall if needed
rm -rf ~/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

**Colors not working:**
```bash
# Check TERM variable
echo $TERM

# Should be screen-256color or tmux-256color inside tmux
```

**Clipboard not working:**
```bash
# Install xclip or xsel
sudo apt install xclip  # or xsel
```

## Credits


> Configuration inspired by the tmux community and tutorials, notably [Omerxx’s YouTube channel](https://www.youtube.com/@devopstoolbox) and [dotfiles](https://github.com/omerxx/dotfiles).

