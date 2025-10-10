# 🐚 Zsh Configuration

A customized Zsh configuration featuring both **Powerlevel10k** and **Oh My Posh** theme engines with dynamic theme switching capabilities and essential productivity plugins.

## 🎨 Features

### Dual Theme Engine Support
- **🔋 Powerlevel10k** - Fast, customizable prompt (commented out)
- **⚡ Oh My Posh** - Cross-platform prompt with dynamic theme switching
- **✨ Starship** - Minimal, fast, and customizable prompt
- **🔄 Easy Switching** - Toggle between theme engines as needed

### Essential Plugins
- **📝 zsh-autosuggestions** - Fish-like autosuggestions for commands
- **🎨 zsh-syntax-highlighting** - Real-time syntax highlighting
- **🔧 git** - Git integration and shortcuts
- **🚀 zoxide** - Smarter cd command with directory jumping

### Custom Functions
- **🎭 `setposh <theme>`** - Dynamically switch Oh My Posh themes
- **📋 `listposh`** - List all available Oh My Posh themes
- **🔍 fzf Integration** - Use with `setposh $(listposh | fzf)` for interactive selection

## 🚀 Installation

### Method 1: Symlink (Recommended for Dotfiles Management)

```bash
# Navigate to your dotfiles directory
cd ~/dotfiles/zsh

# Backup existing .zshrc (if any)
cp ~/.zshrc ~/.zshrc.backup.$(date +%Y%m%d_%H%M%S) 2>/dev/null || true

# Create symlink to your dotfiles .zshrc
ln -sf ~/dotfiles/zsh/.zshrc ~/.zshrc

# Reload configuration
source ~/.zshrc
```

### Method 2: Direct Copy

```bash
# Copy configuration to home directory
cp ~/dotfiles/zsh/.zshrc ~/.zshrc

# Reload configuration
source ~/.zshrc
```

## 📋 Prerequisites

Before using this configuration, ensure you have:

### Required Installations
```bash
# Oh My Zsh framework
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Oh My Posh
brew install jandedobbeleer/oh-my-posh/oh-my-posh

# Starship (alternative prompt)
brew install starship

# zoxide (smarter cd)
brew install zoxide

# Essential plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Optional: fzf for interactive theme selection
brew install fzf
```

### Required Directories
```bash
# Create Oh My Posh config directory
mkdir -p ~/.config/oh-my-posh

# Create Starship config directory
mkdir -p ~/.config
```

## 🎭 Theme Management

### Oh My Posh Theme Functions

#### List Available Themes
```bash
# Show all available themes
listposh

# Use with fzf for interactive selection
listposh | fzf
```

#### Switch Themes
```bash
# Switch to a specific theme
setposh catppuccin

# Interactive theme selection with fzf
setposh $(listposh | fzf)

# Some popular themes to try:
setposh jandedobbeleer
setposh powerline
setposh tokyo
setposh dracula
setposh gruvbox
```

### Theme Engine Switching

#### Enable Oh My Posh (Default)
The configuration uses Oh My Posh by default with the current setup.

#### Switch to Starship
To use Starship instead:

1. **Comment out Oh My Posh line:**
   ```bash
   # eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/config.omp.json)"
   ```

2. **Add Starship initialization:**
   ```bash
   eval "$(starship init zsh)"
   ```

3. **Configure Starship (optional):**
   ```bash
   # Create/edit Starship config
   nvim ~/.config/starship.toml
   ```

4. **Reload configuration:**
   ```bash
   source ~/.zshrc
   ```

#### Switch to Powerlevel10k
To use Powerlevel10k instead:

1. **Comment out Oh My Posh lines:**
   ```bash
   # eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/config.omp.json)"
   ```

2. **Uncomment Powerlevel10k lines:**
   ```bash
   ZSH_THEME="powerlevel10k/powerlevel10k"
   [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
   ```

3. **Reload configuration:**
   ```bash
   source ~/.zshrc
   p10k configure  # Configure Powerlevel10k
   ```

## 🚀 Zoxide Usage

### Basic Commands
```bash
# Use 'z' to jump to a directory you've visited before
z myproject        # Jumps to ~/Documents/code/myproject

# Quick navigation
z -                # Jump to previous directory
z ..               # Same as cd ..

# Interactive fuzzy search
zi                 # Shows interactive list of directories
zi blog            # Search for directories matching "blog"
```

### Advanced Features
```bash
# Manually add current directory to zoxide
zoxide add .

# Query zoxide database
zoxide query              # Shows most used directories
zoxide query blog         # Find best match for "blog"
zoxide query -l -s        # Show all history with scores

# Remove directory from database
zoxide remove /path/to/dir
```

## ⚙️ Configuration Details

### Key Components

#### Instant Prompt (Powerlevel10k)
```bash
# Enables fast prompt initialization
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
```

#### Plugin Configuration
```bash
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
```

#### Oh My Posh Initialization
```bash
eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/config.omp.json)"
```

#### Zoxide Initialization
```bash
eval "$(zoxide init zsh)"
```

#### Starship Initialization (Alternative)
```bash
eval "$(starship init zsh)"
```

### Custom Function Details

#### `setposh` Function
- **Purpose:** Switch Oh My Posh themes dynamically
- **Usage:** `setposh <theme-name>`
- **Features:**
  - Validates theme existence
  - Copies theme config to `~/.config/oh-my-posh/config.omp.json`
  - Re-initializes Oh My Posh with new theme
  - Provides user feedback

#### `listposh` Function  
- **Purpose:** List all available Oh My Posh themes
- **Usage:** `listposh`
- **Features:**
  - Scans Oh My Posh themes directory
  - Outputs clean theme names (one per line)
  - Perfect for piping to fzf: `setposh $(listposh | fzf)`

## 🔧 Customization

### Add Your Own Aliases
Add custom aliases to the end of `.zshrc`:

```bash
# Custom aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'

# Git shortcuts
alias gs='git status'
alias gp='git push'
alias gl='git pull'
alias gc='git commit'
alias gd='git diff'

# Development shortcuts
alias code='code .'
alias serve='python3 -m http.server'
alias myip='curl ipinfo.io/ip'
```

### Environment Variables
Add custom environment variables:

```bash
# Custom environment variables
export EDITOR="code"
export PATH="$HOME/bin:$PATH"

# Development paths
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"
```

### Custom Functions
Add your own functions:

```bash
# Create directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Quick git commit with message
qcommit() {
    git add . && git commit -m "$1"
}
```

## 🎯 Usage Examples

### Theme Switching Workflow
```bash
# 1. List available themes
listposh

# 2. Interactive selection with fzf
setposh $(listposh | fzf)

# 3. Or directly set a theme
setposh catppuccin

# 4. Current theme is now active in ~/.config/oh-my-posh/config.omp.json
```

### Plugin Features
```bash
# zsh-autosuggestions: Type partial command, press → to accept
$ git sta[→] → git status

# zsh-syntax-highlighting: Commands are colored as you type
$ ls     # Green if command exists
$ lss    # Red if command doesn't exist

# zoxide: Smart directory jumping
$ z docs  # Jumps to ~/Documents if you've been there before
```

## 🛠 Troubleshooting

### Oh My Posh Not Working
```bash
# Check Oh My Posh installation
oh-my-posh --version

# Check config directory
ls -la ~/.config/oh-my-posh/

# Manually initialize
eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/config.omp.json)"
```

### Starship Not Working
```bash
# Check Starship installation
starship --version

# Check config
cat ~/.config/starship.toml

# Manually initialize
eval "$(starship init zsh)"
```

### Zoxide Not Working
```bash
# Check zoxide installation
zoxide --version

# Manually initialize
eval "$(zoxide init zsh)"

# Check database
zoxide query -l
```

### Themes Not Displaying Correctly
```bash
# Install Nerd Fonts for proper icon display
brew install --cask font-hack-nerd-font

# Set terminal font to "Hack Nerd Font"
# Check terminal preferences
```

### Functions Not Working
```bash
# Check function definition
type setposh
type listposh

# Reload configuration
source ~/.zshrc

# Check Oh My Posh themes directory
ls "$(brew --prefix jandedobbeleer/oh-my-posh/oh-my-posh)/themes/" | head -5
```

### Plugin Issues
```bash
# Check plugin directories
ls ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/

# Reinstall plugins if needed
rm -rf ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

## 📚 Advanced Features

### Theme Persistence
- Current theme is stored in `~/.config/oh-my-posh/config.omp.json`
- Survives terminal restarts and system reboots
- Can be version controlled separately from main config

### Integration with Other Tools
```bash
# Use with fzf for fuzzy theme selection
setposh $(listposh | fzf --preview 'echo "Theme: {}"')

# Create theme favorites
alias mythemes='echo "catppuccin\njandedobbeleer\ntokyo" | fzf | xargs setposh'

# Quick theme switching shortcuts
alias dark='setposh dracula'
alias light='setposh catppuccin'
```

### Backup and Sync
```bash
# Backup current theme config
cp ~/.config/oh-my-posh/config.omp.json ~/dotfiles/zsh/current-theme.omp.json

# Sync theme across machines
ln -sf ~/dotfiles/zsh/current-theme.omp.json ~/.config/oh-my-posh/config.omp.json
```

## 🎨 Popular Theme Recommendations

### Dark Themes
- **dracula** - Dark theme with vibrant colors
- **gruvbox** - Retro groove dark theme  
- **tokyo** - Night theme inspired by Tokyo

### Light Themes
- **catppuccin** - Soothing pastel theme
- **clean-detailed** - Minimal light theme

### Powerline Style
- **jandedobbeleer** - Classic powerline style
- **powerline** - Traditional powerline theme

## 📖 Resources

- [Oh My Zsh Documentation](https://ohmyz.sh/)
- [Oh My Posh Themes Gallery](https://ohmyposh.dev/docs/themes)
- [Powerlevel10k Documentation](https://github.com/romkatv/powerlevel10k)
- [Starship Documentation](https://starship.rs/)
- [Zoxide Documentation](https://github.com/ajeetdsouza/zoxide)
- [Zsh Plugin List](https://github.com/unixorn/awesome-zsh-plugins)

## 🎯 Features Summary

- ✅ **Triple theme engine support** (Powerlevel10k + Oh My Posh + Starship)
- ✅ **Dynamic theme switching** with custom functions
- ✅ **Essential productivity plugins**
- ✅ **Smart directory navigation** with zoxide
- ✅ **Interactive theme selection** with fzf integration
- ✅ **Easy customization** and extension
- ✅ **Proper error handling** and validation
- ✅ **Clean, organized configuration**
- ✅ **Version control friendly**
