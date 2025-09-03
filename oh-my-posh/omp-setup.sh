#!/bin/bash

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

# Function to install Nerd Fonts
install_nerd_fonts() {
    print_color $BLUE "=== Installing Nerd Fonts ==="
    
    if ! command_exists brew; then
        print_color $RED "Error: Homebrew is not installed. Please install Homebrew first."
        echo "Visit: https://brew.sh/"
        return 1
    fi
    
    print_color $YELLOW "This will install Hack Nerd Font using Homebrew."
    print_color $YELLOW "Command: brew install --cask font-hack-nerd-font"
    
    if confirm "Do you want to proceed with installing Nerd Fonts?"; then
        print_color $GREEN "Installing Hack Nerd Font..."
        if brew install --cask font-hack-nerd-font; then
            print_color $GREEN "✅ Hack Nerd Font installed successfully!"
        else
            print_color $RED "❌ Failed to install Hack Nerd Font."
            return 1
        fi
    else
        print_color $YELLOW "Nerd Fonts installation cancelled."
        return 1
    fi
}

# Function to install Oh My Posh
install_oh_my_posh() {
    print_color $BLUE "=== Installing Oh My Posh ==="
    
    if ! command_exists brew; then
        print_color $RED "Error: Homebrew is not installed. Please install Homebrew first."
        echo "Visit: https://brew.sh/"
        return 1
    fi
    
    print_color $YELLOW "This will install Oh My Posh using Homebrew."
    print_color $YELLOW "Command: brew install jandedobbeleer/oh-my-posh/oh-my-posh"
    
    if confirm "Do you want to proceed with installing Oh My Posh?"; then
        print_color $GREEN "Installing Oh My Posh..."
        if brew install jandedobbeleer/oh-my-posh/oh-my-posh; then
            print_color $GREEN "✅ Oh My Posh installed successfully!"
        else
            print_color $RED "❌ Failed to install Oh My Posh."
            return 1
        fi
    else
        print_color $YELLOW "Oh My Posh installation cancelled."
        return 1
    fi
}

# Function to get available themes
get_themes() {
    local themes_dir="$(brew --prefix jandedobbeleer/oh-my-posh/oh-my-posh)/themes"
    if [[ -d "$themes_dir" ]]; then
        find "$themes_dir" -name "*.omp.json" -exec basename {} .omp.json \; | sort
    else
        print_color $RED "Oh My Posh themes directory not found. Make sure Oh My Posh is installed."
        return 1
    fi
}

# Function to search themes
search_themes() {
    local search_term="$1"
    local themes=($(get_themes))
    
    if [[ -z "$search_term" ]]; then
        printf '%s\n' "${themes[@]}"
    else
        printf '%s\n' "${themes[@]}" | grep -i "$search_term"
    fi
}

# Function to set theme
set_theme() {
    print_color $BLUE "=== Setting Oh My Posh Theme ==="
    
    # Check if Oh My Posh is installed
    if ! command_exists oh-my-posh; then
        print_color $RED "Oh My Posh is not installed. Please install it first."
        return 1
    fi
    
    local zshrc="$HOME/.zshrc"
    local themes=($(get_themes))
    
    if [[ ${#themes[@]} -eq 0 ]]; then
        print_color $RED "No themes found. Make sure Oh My Posh is properly installed."
        return 1
    fi
    
    print_color $GREEN "Available themes (${#themes[@]} total):"
    print_color $CYAN "You can search by typing part of the theme name, or press Enter to see all themes."
    
    while true; do
        echo
        read -p "Search themes (or press Enter to see all): " search_term
        
        local filtered_themes=($(search_themes "$search_term"))
        
        if [[ ${#filtered_themes[@]} -eq 0 ]]; then
            print_color $YELLOW "No themes found matching '$search_term'. Try a different search term."
            continue
        fi
        
        print_color $CYAN "Matching themes:"
        local count=1
        for theme in "${filtered_themes[@]}"; do
            printf "%3d. %s\n" $count "$theme"
            ((count++))
        done
        
        echo
        read -p "Enter theme name (or 'back' to search again, 'quit' to exit): " selected_theme
        
        case "$selected_theme" in
            "back"|"b") continue ;;
            "quit"|"q"|"exit") 
                print_color $YELLOW "Theme selection cancelled."
                return 1 ;;
            "")
                print_color $YELLOW "Please enter a theme name."
                continue ;;
        esac
        
        # Check if the selected theme exists
        local theme_found=false
        for theme in "${themes[@]}"; do
            if [[ "$theme" == "$selected_theme" ]]; then
                theme_found=true
                break
            fi
        done
        
        if [[ "$theme_found" == false ]]; then
            print_color $RED "Theme '$selected_theme' not found. Please select from the available themes."
            continue
        fi
        
        # Confirm theme selection
        print_color $YELLOW "Selected theme: $selected_theme"
        if confirm "Do you want to set this theme?"; then
            break
        fi
    done
    
    # Create .zshrc if it doesn't exist
    if [[ ! -f "$zshrc" ]]; then
        touch "$zshrc"
        print_color $GREEN "Created ~/.zshrc file."
    fi
    
    # Create backup of .zshrc
    cp "$zshrc" "${zshrc}.backup.$(date +%Y%m%d_%H%M%S)"
    print_color $GREEN "Created backup of ~/.zshrc"
    
    # New Oh My Posh configuration line
    local new_config="eval \"\$(oh-my-posh init zsh --config \$(brew --prefix jandedobbeleer/oh-my-posh/oh-my-posh)/themes/${selected_theme}.omp.json)\""
    
    # Check if Oh My Posh config already exists
    if grep -q "oh-my-posh init zsh" "$zshrc"; then
        # Replace existing configuration
        if [[ "$OSTYPE" == "darwin"* ]]; then
            # macOS sed
            sed -i '' '/oh-my-posh init zsh/d' "$zshrc"
        else
            # GNU sed
            sed -i '/oh-my-posh init zsh/d' "$zshrc"
        fi
        print_color $GREEN "Removed existing Oh My Posh configuration."
    fi
    
    # Add new configuration
    echo "$new_config" >> "$zshrc"
    
    print_color $GREEN "✅ Theme '$selected_theme' has been set in ~/.zshrc"
    print_color $CYAN "To apply the changes, either:"
    print_color $CYAN "  1. Restart your terminal, or"
    print_color $CYAN "  2. Run: source ~/.zshrc"
}

# Function to show main menu
show_menu() {
    print_color $PURPLE "=================================="
    print_color $PURPLE "   MacBook Oh My Posh Setup"
    print_color $PURPLE "=================================="
    echo "1. Install Nerd Fonts (Hack)"
    echo "2. Install Oh My Posh"
    echo "3. Set Oh My Posh Theme"
    echo "4. Exit"
    print_color $PURPLE "=================================="
}

# Main script
main() {
    print_color $GREEN "Welcome to the MacBook Oh My Posh Setup Script!"
    print_color $YELLOW "This script will help you install and configure Oh My Posh with themes."
    echo
    
    while true; do
        show_menu
        read -p "Please select an option (1-4): " choice
        
        case $choice in
            1)
                install_nerd_fonts
                ;;
            2)
                install_oh_my_posh
                ;;
            3)
                set_theme
                ;;
            4)
                print_color $GREEN "Thanks for using the Oh My Posh Setup Script!"
                exit 0
                ;;
            *)
                print_color $RED "Invalid option. Please select 1, 2, 3, or 4."
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