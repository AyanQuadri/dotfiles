# 🎨 Oh My Posh Setup

A powerful, cross-platform prompt theme engine that brings beautiful and informative prompts to any shell.

## 📦 Installation Methods

### Method 1: Global Command Installation (Recommended)

Install the setup script as a global command that can be run from anywhere:

```bash
# Navigate to the oh-my-posh directory
cd ~/dotfiles/oh-my-posh

# Copy script to global bin directory and make executable
sudo cp omp-setup.sh /usr/local/bin/omp-setup
sudo chmod +x /usr/local/bin/omp-setup
```

Now you can run the setup from anywhere:
```bash
omp-setup
```

### Method 2: Direct Execution

If you prefer to run it directly:
```bash
# Make the script executable
chmod +x omp-setup.sh

# Run the script
./omp-setup.sh
```

## 🚀 Usage

Once installed globally, simply run:
```bash
omp-setup
```

You'll see an interactive menu with three options:

### 1. 🔤 Install Nerd Fonts
- Installs **Hack Nerd Font** via Homebrew
- Includes confirmation prompt to prevent accidental installation
- Required for proper icon display in themes

**Command executed:** `brew install --cask font-hack-nerd-font`

### 2. ⚡ Install Oh My Posh
- Installs Oh My Posh from the official Homebrew tap
- Includes confirmation prompt
- Validates Homebrew installation

**Command executed:** `brew install jandedobbeleer/oh-my-posh/oh-my-posh`

### 3. 🎨 Set Theme
- **Browse all available themes** with search functionality
- **Interactive theme selection** with preview names
- **Smart ~/.zshrc management** with automatic backups

## 🔒 Safety Features

### Automatic Backups
Before modifying your `.zshrc` file, the script automatically creates a timestamped backup:

```bash
# Backup location: ~/.zshrc.backup.YYYYMMDD_HHMMSS
# Example: ~/.zshrc.backup.20241215_143045
```

**View all backups:**
```bash
ls -la ~/.zshrc.backup.*
```

**Restore from backup:**
```bash
cp ~/.zshrc.backup.20241215_143045 ~/.zshrc
source ~/.zshrc
```

### Smart Configuration Management
- **Creates ~/.zshrc** if it doesn't exist
- **Removes old Oh My Posh configs** before adding new ones
- **Prevents duplicate entries** in your shell configuration
- **Uses exact format** for maximum compatibility

### Generated Configuration Format
```bash
eval "$(oh-my-posh init zsh --config $(brew --prefix jandedobbeleer/oh-my-posh/oh-my-posh)/themes/THEME_NAME.omp.json)"
```

## 🎨 Theme Management

### Theme Search & Selection
1. **Search themes** by typing part of the theme name
2. **Browse all themes** by pressing Enter without search term
3. **Select theme** by typing the exact name
4. **Confirm selection** before applying changes

### Favourite Themes
My Favourite Oh My Posh themes:
- `bubblesextra`
- `catppuccin` 
- `chips`
- `cloud-native-azure`
- `craver`
- `dracula`
- `json`
- `powerlevel10k_modern`
- `easy-term`
- `gruvbox`
- `thecyberden`

### Apply Changes
After setting a theme, apply changes by either:
1. **Restart your terminal**, or
2. **Reload configuration:** `source ~/.zshrc`

## 🛠 Prerequisites

- **macOS** (Darwin-based system)
- **Homebrew** package manager
- **Zsh shell** (default on macOS Catalina+)

### Install Prerequisites
```bash
# Install Homebrew (if not installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Verify Zsh (should be default)
echo $SHELL
# Should output: /bin/zsh
```

## 🔧 Troubleshooting

### Command Not Found
If `omp-setup` command is not found after global installation:

```bash
# Check if /usr/local/bin is in PATH
echo $PATH | grep "/usr/local/bin"

# If missing, add to ~/.zshrc
echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### Homebrew Issues
```bash
# Check Homebrew installation
brew --version

# Update Homebrew
brew update

# Check Homebrew health
brew doctor
```

### Theme Not Displaying Correctly
1. **Install Nerd Fonts** (Option 1 in the script)
2. **Set terminal font** to a Nerd Font (e.g., "Hack Nerd Font")
3. **Restart terminal** after font installation

### Oh My Posh Issues
```bash
# Check Oh My Posh installation
oh-my-posh --version

# List available themes manually
ls $(brew --prefix oh-my-posh)/themes/

# Test theme directly
oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/jandedobbeleer.omp.json
```

## 📚 Advanced Usage

### Manual Theme Switching
You can manually edit `~/.zshrc` to change themes:

```bash
# Find the Oh My Posh line and change the theme name
eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/NEW_THEME.omp.json)"
```

### Custom Themes
Place custom `.omp.json` files in the themes directory:
```bash
# Themes directory
$(brew --prefix oh-my-posh)/themes/
```

### Export Configuration
```bash
# Export current Oh My Posh config
oh-my-posh config export --output my-theme.omp.json
```

## 🎯 Features Summary

- ✅ **Interactive menu system**
- ✅ **Confirmation prompts** for all installations
- ✅ **Automatic backups** of configuration files
- ✅ **Theme search functionality**
- ✅ **Smart duplicate handling**
- ✅ **Error checking and validation**
- ✅ **Colored output** for better UX
- ✅ **macOS optimized**

## 📖 Additional Resources

- [Oh My Posh Documentation](https://ohmyposh.dev/)
- [Theme Gallery](https://ohmyposh.dev/docs/themes)
- [Nerd Fonts](https://www.nerdfonts.com/)

---
