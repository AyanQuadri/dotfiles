# 👻 Ghostty Terminal Setup

Ghostty is a fast, feature-rich, and cross-platform terminal emulator that uses platform-native UI and GPU acceleration.

## 📦 Installation

### Install via Homebrew
```bash
brew install --cask ghostty
```

### Verify Installation
```bash
ghostty --version
```

## 🔧 Configuration

The `config` file in this directory contains Ghostty configuration settings. 

### Apply Configuration
```bash
# Create Ghostty config directory if it doesn't exist
mkdir -p ~/.config/ghostty

# Copy the configuration file
cp config ~/.config/ghostty/config

# Or create a symlink (recommended for dotfiles management)
ln -sf ~/dotfiles/ghostty/config ~/.config/ghostty/config
```

## 🎛 Useful Ghostty Commands

### Configuration Commands
```bash
# Show current configuration
ghostty +show-config

# Show configuration file locations
ghostty +show-config-files

# Validate configuration file
ghostty +validate-config

# List all available configuration options
ghostty +list-config-options
```

### Application Commands
```bash
# Launch with specific configuration
ghostty --config-file=/path/to/config

# Launch in fullscreen mode
ghostty --fullscreen

# Launch with specific working directory
ghostty --working-directory=/path/to/directory

# Launch with custom window title
ghostty --title="My Terminal"

# Launch with specific window size
ghostty --window-width=1200 --window-height=800
```

### Debug Commands
```bash
# Show debug information
ghostty +show-debug

# Show font information
ghostty +show-fonts

# Show renderer information
ghostty +show-renderer
```

## ⚙️ Key Configuration Options

Common configuration options you might want to customize in your `config` file:

```bash
# Font settings
font-family = "JetBrains Mono"
font-size = 14

# Theme/Colors
theme = "catppuccin-macchiato"
background-opacity = 0.9

# Window settings
window-decoration = true
window-padding-x = 10
window-padding-y = 10

# Terminal behavior
scrollback-limit = 10000
confirm-close-surface = false

# Keybindings
keybind = cmd+t=new_tab
keybind = cmd+w=close_surface
```

## 🎨 Themes

Ghostty supports various built-in themes:

```bash
# List available themes
ghostty +list-themes

# Some popular themes:
# - catppuccin-macchiato
# - dracula
# - gruvbox-dark
# - nord
# - solarized-dark
# - tokyo-night
```

## 🔧 Troubleshooting

### Configuration Issues
```bash
# Check configuration syntax
ghostty +validate-config

# Reset to default configuration
mv ~/.config/ghostty/config ~/.config/ghostty/config.backup
```

### Font Issues
```bash
# List available fonts
ghostty +show-fonts

# Common font recommendations:
# - JetBrains Mono (install: brew install --cask font-jetbrains-mono)
# - Fira Code (install: brew install --cask font-fira-code)
# - Hack Nerd Font (install: brew install --cask font-hack-nerd-font)
```

### Performance Issues
```bash
# Check renderer information
ghostty +show-renderer

# Try different renderer in config file:
renderer = metal    # macOS GPU acceleration (default)
renderer = opengl   # Fallback option
```

## 📚 Additional Resources

- [Official Ghostty Documentation](https://ghostty.org/docs)
- [Ghostty GitHub Repository](https://github.com/mitchellh/ghostty)
- [Configuration Reference](https://ghostty.org/docs/config)

## 💡 Tips

1. **Use Nerd Fonts** for better icon support in terminal applications
2. **Enable GPU acceleration** for smoother scrolling and better performance  
3. **Configure custom keybindings** for improved workflow
4. **Use symlinks** for configuration files to keep them in version control
5. **Backup your config** before making major changes

---
