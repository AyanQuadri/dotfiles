# My Dotfiles

A curated collection of configuration files and setup scripts for development environment.

## Components

### [Ghostty Terminal](./ghostty/)
Modern GPU-accelerated terminal emulator with excellent performance and customization options.

### [Oh My Posh](./oh-my-posh/)
Cross-platform prompt theme engine with beautiful themes and extensive customization.

### [macOS Setup Script](./mac/)  
A comprehensive automated setup script for configuring a complete macOS development environment, including terminal, shell, themes, and essential tools.

### [zshrc config file](./zsh/)
Custom `.zshrc` file containing shell settings, plugins, and theme configuration for an optimized terminal experience.


## Quick Start

1. **Clone this repository**
   ```bash
   git clone https://github.com/AyanQuadri/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. **Install Homebrew** (if not already installed)
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

3. **Setup each component**
   - Follow the [Ghostty setup guide](./ghostty/README.md)
   - Follow the [Oh My Posh setup guide](./oh-my-posh/README.md)
   - Follow the [Mac os setup guide](./Mac/README.md)
   - Apply the [Zsh Configuration](./zsh/.zshrc)

## 📋 Prerequisites

- macOS (tested on macOS 11+)
- [Homebrew](https://brew.sh/) package manager
- Terminal or Terminal emulator

## 🔧 Maintenance

Each component includes its own README with specific installation, configuration, and maintenance instructions. Check the individual directories for detailed guides.

## 📝 Notes

- All scripts include confirmation prompts to prevent accidental installations
- Backup files are created by your choice before modifying existing configurations
- Scripts are designed to be safe to run multiple times
