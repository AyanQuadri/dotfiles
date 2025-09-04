#!/bin/bash

# macOS Development Environment Setup Script
# Author: Your Name
# Description: Complete setup script for new macOS development environment

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to print colored output
print_color() {
    printf "${1}${2}${NC}\n"
}

# Function to get user confirmation
confirm() {
    while true; do
        read -p "$1 (y/N): " yn
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* | "" ) return 1;;
            * ) echo "Please answer yes (y) or no (n).";;
        esac
    done
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install Homebrew
install_homebrew() {
    print_color $BLUE "=== Installing Homebrew ==="
    
    if command_exists brew; then
        print_color $YELLOW "Homebrew is already installed."
        brew --version
        return 0
    fi
    
    print_color $YELLOW "This will install Homebrew package manager for macOS."
    print_color $CYAN "Homebrew allows you to install and manage software packages easily."
    print_color $CYAN "Command: /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    
    if confirm "Do you want to install Homebrew?"; then
        print_color $GREEN "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        if command_exists brew; then
            print_color $GREEN "✅ Homebrew installed successfully!"
            
            # Add Homebrew to PATH for Apple Silicon Macs
            if [[ $(uname -m) == "arm64" ]]; then
                print_color $YELLOW "Adding Homebrew to PATH for Apple Silicon Mac..."
                echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
                eval "$(/opt/homebrew/bin/brew shellenv)"
            fi
            
            brew --version
        else
            print_color $RED "❌ Failed to install Homebrew."
            return 1
        fi
    else
        print_color $YELLOW "Homebrew installation cancelled."
        return 1
    fi
}

# Function to install Ghostty
install_ghostty() {
    print_color $BLUE "=== Installing Ghostty Terminal ==="
    
    if ! command_exists brew; then
        print_color $RED "Error: Homebrew is required to install Ghostty."
        print_color $YELLOW "Please install Homebrew first (Option 2)."
        return 1
    fi
    
    print_color $YELLOW "This will install Ghostty - a fast, GPU-accelerated terminal emulator."
    print_color $CYAN "Command: brew install --cask ghostty"
    
    if confirm "Do you want to install Ghostty?"; then
        print_color $GREEN "Installing Ghostty..."
        if brew install --cask ghostty; then
            print_color $GREEN "✅ Ghostty installed successfully!"
            print_color $CYAN "You can now launch Ghostty from Applications or use: open -a Ghostty"
        else
            print_color $RED "❌ Failed to install Ghostty."
            return 1
        fi
    else
        print_color $YELLOW "Ghostty installation cancelled."
        return 1
    fi
}

# Function to install Zsh, Oh My Zsh and plugins
install_zsh_setup() {
    print_color $BLUE "=== Setting up Zsh and Oh My Zsh ==="
    
    if ! command_exists brew; then
        print_color $RED "Error: Homebrew is required."
        print_color $YELLOW "Please install Homebrew first (Option 2)."
        return 1
    fi
    
    print_color $YELLOW "This will:"
    print_color $CYAN "  1. Install Zsh (if not already installed)"
    print_color $CYAN "  2. Set Zsh as default shell"
    print_color $CYAN "  3. Install Oh My Zsh framework"
    print_color $CYAN "  4. Install zsh-autosuggestions plugin"
    print_color $CYAN "  5. Install zsh-syntax-highlighting plugin"
    print_color $CYAN "  6. Configure plugins in ~/.zshrc"
    
    if confirm "Do you want to proceed with Zsh setup?"; then
        # Install Zsh
        print_color $GREEN "Installing Zsh..."
        if brew install zsh; then
            print_color $GREEN "✅ Zsh installed successfully!"
        else
            print_color $YELLOW "⚠️  Zsh might already be installed or failed to install."
        fi
        
        # Set Zsh as default shell
        print_color $GREEN "Setting Zsh as default shell..."
        if ! grep -q "$(which zsh)" /etc/shells; then
            echo "$(which zsh)" | sudo tee -a /etc/shells
        fi
        
        if [[ "$SHELL" != "$(which zsh)" ]]; then
            chsh -s "$(which zsh)"
            print_color $GREEN "✅ Zsh set as default shell!"
            print_color $YELLOW "⚠️  You may need to restart your terminal for changes to take effect."
        else
            print_color $YELLOW "Zsh is already the default shell."
        fi
        
        # Install Oh My Zsh
        if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
            print_color $GREEN "Installing Oh My Zsh..."
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
            print_color $GREEN "✅ Oh My Zsh installed successfully!"
        else
            print_color $YELLOW "Oh My Zsh is already installed."
        fi
        
        # Install zsh-autosuggestions
        if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]]; then
            print_color $GREEN "Installing zsh-autosuggestions plugin..."
            git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
            print_color $GREEN "✅ zsh-autosuggestions installed successfully!"
        else
            print_color $YELLOW "zsh-autosuggestions is already installed."
        fi
        
        # Install zsh-syntax-highlighting
        if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]]; then
            print_color $GREEN "Installing zsh-syntax-highlighting plugin..."
            git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
            print_color $GREEN "✅ zsh-syntax-highlighting installed successfully!"
        else
            print_color $YELLOW "zsh-syntax-highlighting is already installed."
        fi
        
        # Configure plugins in .zshrc
        local zshrc="$HOME/.zshrc"
        if [[ -f "$zshrc" ]]; then
            print_color $GREEN "Configuring plugins in ~/.zshrc..."
            
            # Backup .zshrc if requested
            if confirm "Create backup of ~/.zshrc before modifying plugins?"; then
                cp "$zshrc" "${zshrc}.backup.$(date +%Y%m%d_%H%M%S)"
                print_color $GREEN "✅ Created backup of ~/.zshrc"
            fi
            
            # Update plugins line
            if grep -q "plugins=(" "$zshrc"; then
                # Replace existing plugins line
                if [[ "$OSTYPE" == "darwin"* ]]; then
                    sed -i '' 's/plugins=([^)]*/plugins=(git zsh-autosuggestions zsh-syntax-highlighting/' "$zshrc"
                else
                    sed -i 's/plugins=([^)]*/plugins=(git zsh-autosuggestions zsh-syntax-highlighting/' "$zshrc"
                fi
                print_color $GREEN "✅ Updated plugins configuration in ~/.zshrc"
            else
                # Add plugins line if not found
                echo "plugins=(git zsh-autosuggestions zsh-syntax-highlighting)" >> "$zshrc"
                print_color $GREEN "✅ Added plugins configuration to ~/.zshrc"
            fi
        else
            print_color $YELLOW "⚠️  ~/.zshrc not found. Please run Oh My Zsh setup manually."
        fi
        
        print_color $GREEN "🎉 Zsh setup completed!"
        print_color $CYAN "Please restart your terminal or run: source ~/.zshrc"
        
    else
        print_color $YELLOW "Zsh setup cancelled."
        return 1
    fi
}

# Function to install Powerlevel10k
install_powerlevel10k() {
    print_color $BLUE "=== Installing Powerlevel10k Theme ==="
    
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        print_color $RED "Error: Oh My Zsh is required for Powerlevel10k."
        print_color $YELLOW "Please install Zsh setup first (Option 4)."
        return 1
    fi
    
    if ! command_exists brew; then
        print_color $RED "Error: Homebrew is required to install Nerd Fonts."
        print_color $YELLOW "Please install Homebrew first (Option 2)."
        return 1
    fi
    
    print_color $YELLOW "This will:"
    print_color $CYAN "  1. Install Hack Nerd Font (required for proper display)"
    print_color $CYAN "  2. Install Powerlevel10k theme"
    print_color $CYAN "  3. Configure Powerlevel10k in ~/.zshrc"
    print_color $RED "⚠️  IMPORTANT: You must install Hack Nerd Font first!"
    
    if confirm "Do you want to proceed with Powerlevel10k installation?"; then
        # Install Hack Nerd Font
        print_color $GREEN "Installing Hack Nerd Font..."
        if brew install --cask font-hack-nerd-font; then
            print_color $GREEN "✅ Hack Nerd Font installed successfully!"
            print_color $YELLOW "📝 Remember to set your terminal font to 'Hack Nerd Font' in terminal settings"
        else
            print_color $RED "❌ Failed to install Hack Nerd Font."
            if ! confirm "Continue with Powerlevel10k installation anyway?"; then
                return 1
            fi
        fi
        
        # Install Powerlevel10k
        local p10k_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
        if [[ ! -d "$p10k_dir" ]]; then
            # Check if git is available for cloning
            if ! command_exists git; then
                print_color $YELLOW "Git is required to install Powerlevel10k. Installing git first..."
                if brew install git; then
                    print_color $GREEN "✅ Git installed successfully!"
                else
                    print_color $RED "❌ Failed to install git. Cannot install Powerlevel10k."
                    return 1
                fi
            fi
            
            print_color $GREEN "Installing Powerlevel10k theme..."
            git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$p10k_dir"
            print_color $GREEN "✅ Powerlevel10k installed successfully!"
        else
            print_color $YELLOW "Powerlevel10k is already installed."
        fi
        
        # Configure Powerlevel10k in .zshrc
        local zshrc="$HOME/.zshrc"
        if [[ -f "$zshrc" ]]; then
            print_color $GREEN "Configuring Powerlevel10k in ~/.zshrc..."
            
            # Backup .zshrc if requested
            if confirm "Create backup of ~/.zshrc before modifying theme?"; then
                cp "$zshrc" "${zshrc}.backup.$(date +%Y%m%d_%H%M%S)"
                print_color $GREEN "✅ Created backup of ~/.zshrc"
            fi
            
            # Update theme line
            if grep -q 'ZSH_THEME=' "$zshrc"; then
                # Comment out existing theme line and add new one
                if [[ "$OSTYPE" == "darwin"* ]]; then
                    sed -i '' 's/^ZSH_THEME=/# ZSH_THEME=/' "$zshrc"
                else
                    sed -i 's/^ZSH_THEME=/# ZSH_THEME=/' "$zshrc"
                fi
                echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> "$zshrc"
                print_color $GREEN "✅ Commented out old theme and set Powerlevel10k as active theme"
            else
                # Add theme line if not found
                echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> "$zshrc"
                print_color $GREEN "✅ Added Powerlevel10k theme to ~/.zshrc"
            fi
        else
            print_color $RED "❌ ~/.zshrc not found."
            return 1
        fi
        
        print_color $GREEN "🎉 Powerlevel10k installation completed!"
        print_color $CYAN "Next steps:"
        print_color $CYAN "  1. Restart your terminal"
        print_color $CYAN "  2. Set terminal font to 'Hack Nerd Font'"
        print_color $CYAN "  3. Run: p10k configure (to customize your prompt)"
        
    else
        print_color $YELLOW "Powerlevel10k installation cancelled."
        return 1
    fi
}

# Function to install essential tools
install_essential_tools() {
    print_color $BLUE "=== Installing Essential Development Tools ==="
    
    if ! command_exists brew; then
        print_color $RED "Error: Homebrew is required to install tools."
        print_color $YELLOW "Please install Homebrew first (Option 2)."
        return 1
    fi
    
    print_color $YELLOW "This will install the following essential tools:"
    print_color $CYAN "  • OrbStack     - Fast Docker alternative for macOS"
    print_color $CYAN "  • fzf          - Command-line fuzzy finder"
    print_color $CYAN "  • tree         - Display directories as trees"
    print_color $CYAN "  • uv           - Fast Python package installer"
    print_color $CYAN "  • fastfetch    - System information tool"
    
    if confirm "Do you want to install these essential tools?"; then
        local tools=("orbstack" "fzf" "tree" "uv" "fastfetch")
        local cask_tools=("orbstack")
        
        for tool in "${tools[@]}"; do
            print_color $GREEN "Installing $tool..."
            
            if [[ " ${cask_tools[@]} " =~ " ${tool} " ]]; then
                # Install as cask
                if brew install --cask "$tool"; then
                    print_color $GREEN "✅ $tool installed successfully!"
                else
                    print_color $RED "❌ Failed to install $tool."
                fi
            else
                # Install as regular formula
                if brew install "$tool"; then
                    print_color $GREEN "✅ $tool installed successfully!"
                else
                    print_color $RED "❌ Failed to install $tool."
                fi
            fi
        done
        
        # Setup fzf key bindings and fuzzy completion
        if command_exists fzf; then
            print_color $GREEN "Setting up fzf key bindings and completion..."
            if confirm "Install fzf key bindings and fuzzy completion?"; then
                $(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc
                print_color $GREEN "✅ fzf key bindings and completion installed!"
                print_color $CYAN "Key bindings: Ctrl+R (history), Ctrl+T (files), Alt+C (directories)"
            fi
        fi
        
        print_color $GREEN "🎉 Essential tools installation completed!"
        print_color $CYAN "Restart your terminal to use all the new tools."
        
    else
        print_color $YELLOW "Essential tools installation cancelled."
        return 1
    fi
}

# Function to run complete setup
complete_setup() {
    print_color $BLUE "=== Complete macOS Development Setup ==="
    
    print_color $YELLOW "This will install and configure everything for a complete development environment:"
    print_color $CYAN "  1. Homebrew package manager"
    print_color $CYAN "  2. Ghostty terminal emulator"
    print_color $CYAN "  3. Zsh shell with Oh My Zsh and plugins"
    print_color $CYAN "  4. Powerlevel10k theme with Nerd Fonts"
    print_color $CYAN "  5. Essential development tools"
    
    print_color $RED "⚠️  This process may take 10-15 minutes depending on your internet connection."
    
    if confirm "Do you want to proceed with the complete setup?"; then
        print_color $GREEN "🚀 Starting complete setup process..."
        echo
        
        # Run all installation functions
        install_homebrew && \
        install_ghostty && \
        install_zsh_setup && \
        install_powerlevel10k && \
        install_essential_tools
        
        if [[ $? -eq 0 ]]; then
            print_color $GREEN "🎉🎉🎉 COMPLETE SETUP FINISHED! 🎉🎉🎉"
            print_color $CYAN "Final steps:"
            print_color $CYAN "  1. Restart your terminal"
            print_color $CYAN "  2. Set terminal font to 'Hack Nerd Font'"
            print_color $CYAN "  3. Run: p10k configure (to customize your prompt)"
            print_color $CYAN "  4. Enjoy your new development environment!"
        else
            print_color $RED "❌ Some components failed to install. Check the output above."
        fi
    else
        print_color $YELLOW "Complete setup cancelled."
        return 1
    fi
}

# Function to show main menu
show_menu() {
    print_color $PURPLE "=================================================="
    print_color $PURPLE "       macOS Development Environment Setup"
    print_color $PURPLE "=================================================="
    echo "1. 🚀 Complete Setup (Install Everything)"
    echo "2. 🍺 Install Homebrew"
    echo "3. 👻 Install Ghostty Terminal"
    echo "4. 🐚 Setup Zsh + Oh My Zsh + Plugins"
    echo "5. ⚡ Install Powerlevel10k Theme"
    echo "6. 🛠  Install Essential Tools"
    echo "7. ❌ Exit"
    print_color $PURPLE "=================================================="
}

# Main script
main() {
    print_color $GREEN "Welcome to the macOS Development Environment Setup!"
    print_color $YELLOW "This script will help you set up a complete development environment."
    echo
    
    while true; do
        show_menu
        read -p "Please select an option (1-7): " choice
        
        case $choice in
            1)
                complete_setup
                ;;
            2)
                install_homebrew
                ;;
            3)
                install_ghostty
                ;;
            4)
                install_zsh_setup
                ;;
            5)
                install_powerlevel10k
                ;;
            6)
                install_essential_tools
                ;;
            7)
                print_color $GREEN "Thanks for using the macOS Development Setup Script!"
                print_color $CYAN "Happy coding! 🚀"
                exit 0
                ;;
            *)
                print_color $RED "Invalid option. Please select 1-7."
                ;;
        esac
        
        echo
        read -p "Press Enter to continue..."
        echo
    done
}

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    print_color $RED "This script is designed for macOS only."
    exit 1
fi

# Run the main function
main