starship init fish | source
zoxide init fish | source

set -Ux EDITOR nvim
set -Ux XDG_CONFIG_HOME $HOME/.config

fish_add_path $HOME/.local/bin
source /opt/homebrew/opt/asdf/libexec/asdf.fish

alias nv="nvim"
alias lg="lazygit"
alias python="python3"

if status is-interactive
    # Commands to run in interactive sessions can go here
end

