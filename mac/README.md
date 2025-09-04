# macOS Development Environment Setup

A comprehensive setup script for configuring a complete development environment on a new macOS system. This script automates the installation and configuration of essential development tools, terminal enhancements, and productivity utilities.

## What Gets Installed

### Core Components
- **🍺 Homebrew** - Package manager for macOS
- **👻 Ghostty** - Fast, GPU-accelerated terminal emulator
- **🐚 Zsh + Oh My Zsh** - Enhanced shell with framework
- **⚡ Powerlevel10k** - Beautiful and fast prompt theme
- **🛠 Essential Tools** - Development utilities

### Detailed Package List

| Category | Package | Description |
|----------|---------|-------------|
| **Package Manager** | Homebrew | macOS package manager |
| **Terminal** | Ghostty | GPU-accelerated terminal emulator |
| **Shell** | Zsh | Advanced shell (macOS default) |
| **Shell Framework** | Oh My Zsh | Community-driven Zsh framework |
| **Shell Plugins** | zsh-autosuggestions | Fish-like autosuggestions |
| | zsh-syntax-highlighting | Syntax highlighting for commands |
| **Theme** | Powerlevel10k | Fast and customizable prompt |
| **Fonts** | Hack Nerd Font | Programming font with icons |
| **Container** | OrbStack | Fast Docker alternative for macOS |
| **Utilities** | fzf | Command-line fuzzy finder |
| | tree | Display directory structures |
| | uv | Fast Python package installer |
| | fastfetch | System information display |

## 🚀 Installation Methods

### Method 1: Global Command Installation (Recommended)

Install the setup script as a global command:

```bash
# Navigate to the Mac directory
cd ~/dotfiles/Mac

# Copy script to global bin directory and make executable
sudo cp mac-setup.sh /usr/local/bin/mac-setup
sudo chmod +x /usr/local/bin/mac-setup
```

Now you can run the setup from anywhere:
```bash
mac-setup
```

### Method 2: Direct Execution

Run directly from the script location:
```bash
# Make the script executable
chmod +x mac-setup.sh

# Run the script
./mac-setup.sh
```

## 📋 Menu Options

### 1. 🚀 Complete Setup (Recommended for new Macs)
Installs everything in the correct order:
1. Homebrew package manager
2. Ghostty terminal emulator  
3. Zsh shell setup with Oh My Zsh and plugins
4. Powerlevel10k theme with Nerd Fonts
5. Essential development tools

**⏱ Estimated time:** 10-15 minutes

### 2. 🍺 Install Homebrew
Installs the Homebrew package manager - **required for all other installations**.

**Commands executed:**
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 3. 👻 Install Ghostty Terminal
Installs Ghostty, a modern GPU-accelerated terminal emulator.

**Commands executed:**
```bash
brew install --cask ghostty
```

### 4. 🐚 Setup Zsh + Oh My Zsh + Plugins
Complete shell setup including:
- Zsh installation and configuration as default shell
- Oh My Zsh framework installation
- Essential plugins: `zsh-autosuggestions` and `zsh-syntax-highlighting`
- Automatic plugin configuration in `~/.zshrc`

**Commands executed:**
```bash
brew install zsh
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### 5. ⚡ Install Powerlevel10k Theme
Installs the fast and beautiful Powerlevel10k prompt theme:
- **Hack Nerd Font** installation (required for proper display)
- Powerlevel10k theme installation
- Automatic theme configuration in `~/.zshrc`

**Commands executed:**
```bash
brew install --cask font-hack-nerd-font
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
```

### 6. 🛠 Install Essential Tools
Installs productivity and development tools:

**Commands executed:**
```bash
brew install --cask orbstack
brew install fzf tree uv fastfetch
$(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc
```

## 🔒 Safety Features

### Confirmation Prompts
Every installation step requires explicit user confirmation to prevent accidental installations.

### Automatic Backups
- **~/.zshrc backup** before modifications (optional, user-prompted)
- Timestamped backups: `~/.zshrc.backup.YYYYMMDD_HHMMSS`

### Smart Detection
- Detects existing installations to avoid duplicates
- Validates prerequisites before proceeding
- Handles Apple Silicon vs Intel Mac differences

### Error Handling
- Comprehensive error checking at each step
- Clear error messages with suggested solutions
- Graceful failure handling

## 📝 Post-Installation Steps

After running the complete setup:

### 1. 🔄 Restart Terminal
Close and reopen your terminal application to load all changes.

### 2. 🔤 Configure Terminal Font
Set your terminal font to **"Hack Nerd Font"** in your terminal preferences:
- **Terminal.app**: Preferences → Profiles → Font
- **iTerm2**: Preferences → Profiles → Text → Font
- **Ghostty**: Configure in `~/.config/ghostty/config`

### 3. 🎨 Configure Powerlevel10k
Run the Powerlevel10k configuration wizard:
```bash
p10k configure
```

This will guide you through customizing your prompt appearance.

### 4. 🧪 Test Your Setup
```bash
# Test Oh My Zsh plugins
# Type a command and press Tab for autosuggestions
# Commands should have syntax highlighting

# Test fzf key bindings
# Ctrl+R - Search command history
# Ctrl+T - Search files
# Alt+C - Search directories

# Test system info
fastfetch

# Test other tools
tree
uv --version
```

## 🛠 Troubleshooting

### Command Not Found After Global Installation
```bash
# Check if /usr/local/bin is in PATH
echo $PATH | grep "/usr/local/bin"

# If missing, add to ~/.zshrc
echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### Homebrew Issues
```bash
# Update Homebrew
brew update

# Check Homebrew health
brew doctor

# Fix permissions (if needed)
sudo chown -R $(whoami) $(brew --prefix)/*
```

### Shell Not Changed to Zsh
```bash
# Check current shell
echo $SHELL

# Manually change shell
chsh -s /bin/zsh

# Or if Homebrew zsh
chsh -s $(brew --prefix)/bin/zsh
```

### Powerlevel10k Not Displaying Correctly
1. **Verify Nerd Font installation:**
   ```bash
   ls /System/Library/Fonts/ | grep -i hack
   ```

2. **Check terminal font setting** - must be set to "Hack Nerd Font"

3. **Reconfigure Powerlevel10k:**
   ```bash
   p10k configure
   ```

### Plugin Not Working
```bash
# Check plugin installation
ls ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/

# Check ~/.zshrc configuration
grep "plugins=" ~/.zshrc

# Reload configuration
source ~/.zshrc
```

## 🔧 Manual Configuration Files

### ~/.zshrc Key Lines Added
```bash
# Oh My Zsh plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

# Powerlevel10k theme
ZSH_THEME="powerlevel10k/powerlevel10k"
```

### Recommended ~/.zshrc Additions
```bash
# Aliases for productivity
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'

# Development shortcuts
alias gs='git status'
alias gp='git push'
alias gl='git pull'
alias gc='git commit'

# Tool shortcuts
alias ff='fastfetch'
alias t='tree'
```

## 📚 Additional Resources

- [Homebrew Documentation](https://docs.brew.sh/)
- [Ghostty Documentation](https://ghostty.org/docs)
- [Oh My Zsh Documentation](https://ohmyz.sh/)
- [Powerlevel10k Documentation](https://github.com/romkatv/powerlevel10k)
- [Nerd Fonts](https://www.nerdfonts.com/)

## 🎯 Features Summary

- ✅ **Complete automation** of development environment setup
- ✅ **Interactive menu system** with clear options
- ✅ **Confirmation prompts** for all installations
- ✅ **Automatic backups** of configuration files
- ✅ **Smart duplicate detection** and error handling
- ✅ **Colored output** for better user experience
- ✅ **Prerequisites validation** before each step
- ✅ **Apple Silicon compatibility**
- ✅ **Comprehensive troubleshooting guide**

## 🆕 For New Mac Users

If you're setting up a brand new Mac:

1. **Run Complete Setup** (Option 1) - this installs everything you need
2. **Follow post-installation steps** above
3. **Customize your environment** based on your preferences
4. **Explore the tools** - each has extensive documentation

