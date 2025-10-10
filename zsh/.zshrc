# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
# ZSH_THEME="miloshadzic"
# ZSH_THEME="powerlevel10k/powerlevel10k"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# eval "$(oh-my-posh init zsh --config $(brew --prefix jandedobbeleer/oh-my-posh/oh-my-posh)/themes/catppuccin.omp.json)"

# -----------------------------
# Oh My Posh Theme Switcher (mkdir -p ~/.config/oh-my-posh)
# -----------------------------
function setposh() {
  local theme=$1
  local theme_dir="$(brew --prefix jandedobbeleer/oh-my-posh/oh-my-posh)/themes"

  if [ -z "$theme" ]; then
    echo "\nUsage: setposh <theme-name>\n" # setposh $(listposh | fzf)
    # echo "Available themes are in: $(brew --prefix jandedobbeleer/oh-my-posh/oh-my-posh)/themes/"
    return 1
  fi

  # Check if theme exists
  if [[ ! -f "$theme_dir/$theme.omp.json" ]]; then
    echo "\n❌ Theme '$theme' not found in $theme_dir/"
    return 1
  fi

  cp "$theme_dir/$theme.omp.json" ~/.config/oh-my-posh/config.omp.json
  echo "\n🔄 Switched to $theme theme.\n"

  # source ~/.zshrc
  # Re-initialize oh-my-posh
  eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/config.omp.json)"
}

function listposh() {
  local theme_dir="$(brew --prefix jandedobbeleer/oh-my-posh/oh-my-posh)/themes"
  
  if [[ -d "$theme_dir" ]]; then
    themes=(${theme_dir}/*.omp.json(:t:r:r))
    echo "\n📂 Found ${#themes} oh-my-posh themes:\n"
    # for i in {1..$#themes}; do
    #   printf "%-3d %s\n" $i $themes[i]
    # done | column -t
    # Output ONLY theme names (one per line)
    print -l ${theme_dir}/*.omp.json(:t:r:r)
  else
    echo "❌ oh-my-posh themes directory not found: $theme_dir"
    return 1
  fi
}

# Init Oh My Posh (loads whatever config is in ~/.config/oh-my-posh/config.omp.json)
# eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/config.omp.json)"

alias posh-pick="setposh \$(listposh | fzf)"

eval "$(zoxide init zsh)"
alias cd="z"

export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init zsh)"

export PATH="$HOME/.cargo/bin:$PATH"

alias ll="eza --color=always --long --git --icons=always --no-user --no-permissions --no-time --no-filesize -a"
alias ls="eza --color=always --long --git --icons=always --no-user --no-permissions --no-time --no-filesize" 
