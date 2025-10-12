# Fish Shell Configuration 🐠

My personal Fish shell configuration with Starship prompt, useful aliases, and productivity plugins.

## Features

- **Starship Prompt**: Fast, customizable, and minimal prompt
- **Vi Mode**: Vi keybindings for efficient shell navigation
- **Smart Aliases**: Enhanced `ls`, `ll`, and `cd` commands
- **Zoxide Integration**: Smarter directory jumping
- **Custom Colors**: Improved autosuggestion visibility
- **Transient Prompt**: Cleaner terminal history

## Prerequisites

- [Fish Shell](https://fishshell.com/)
- [Starship](https://starship.rs/)
- [Eza](https://github.com/eza-community/eza) (modern ls replacement)
- [Zoxide](https://github.com/ajeetdsouza/zoxide) (smart cd)
- [Neovim](https://neovim.io/)

## Installation

1. Install Fish shell:
```bash
# macOS
brew install fish

# Ubuntu/Debian
sudo apt install fish
```

2. Install dependencies:
```bash
# Install Starship
curl -sS https://starship.rs/install.sh | sh

# Install other tools
brew install eza zoxide neovim
# or
cargo install eza zoxide
```

3. Clone this configuration:
```bash
# Backup existing config if any
mv ~/.config/fish ~/.config/fish.backup

# Clone dotfiles
git clone https://github.com/AyanQuadri/dotfiles.git ~/.dotfiles

# Symlink fish config
ln -s ~/dotfiles/fish ~/.config/fish
```

4. Install Fisher plugin manager:
```bash
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
```

5. Install plugins:
```bash
fisher update
```

## Configuration Details

### Aliases

| Alias | Command | Description |
|-------|---------|-------------|
| `ls` | `eza --color=always --long --git --icons=always --no-user --no-permissions --no-time --no-filesize` | Enhanced ls with icons and git status |
| `ll` | `eza ... -a` | Same as ls but shows hidden files |
| `cd` | `z` | Zoxide smart directory jumping |

### Key Bindings

- `jj` in insert mode: Exit to normal mode
- `jk` in visual mode: Exit visual mode
- Full vi-mode keybindings for shell navigation

### Plugins

- **[Fisher](https://github.com/jorgebucaran/fisher)**: Plugin manager
- **[Z](https://github.com/jethrokuan/z)**: Directory jumping
- **[FZF](https://github.com/patrickf1/fzf.fish)**: Fuzzy finder integration
- **[Tide](https://github.com/IlanCosman/tide)**: Alternative prompt (v6)

## Customization

- Starship config location: `~/.config/starship/starship.toml`
- Default editor: Neovim
- Autosuggestion color: Pink (#F5BDE6)
- Fish greeting: Disabled

## File Structure

```
fish/
├── config.fish     # Main configuration file
└── fish_plugins    # Plugin list for Fisher
```

## Troubleshooting

If Starship prompt doesn't load:
```bash
# Ensure Starship is in PATH
which starship

# Manually source it
starship init fish | source
```

If icons don't display correctly, install a Nerd Font from [nerdfonts.com](https://www.nerdfonts.com/).
