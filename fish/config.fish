if status is-interactive
    # Commands to run in interactive sessions can go here
    function starship_transient_prompt_func
        starship module character
    end
    starship init fish | source
    enable_transience

    set -U fish_greeting # universal variable, done once
    set -U fish_color_autosuggestion F5BDE6

    set -gx EDITOR nvim

    # For using vi keymaps in the shell itself
    function fish_user_key_bindings
        fish_vi_key_bindings

        bind -M insert -m default jj backward-char force-repaint
        bind -M visual -m default jk force-repaint
    end

    zoxide init fish | source

    # Aliases
    alias ll="eza --color=always --long --git --icons=always --no-user --no-permissions --no-time --no-filesize -a"
    alias cd="z"
    alias ls="eza --color=always --long --git --icons=always --no-user --no-permissions --no-time --no-filesize" 

    set -x STARSHIP_CONFIG ~/.config/starship/starship.toml
    starship init fish | source
    set -gx PATH $HOME/.cargo/bin $PATH
end
