starship init fish | source
zoxide init fish | source

set -Ux EDITOR nvim
set -Ux FZF_DEFAULT_COMMAND "rg --files --hidden --follow --glob '!.git'"
set -Ux XDG_CONFIG_HOME $HOME/.config

fish_add_path $HOME/.local/bin
source /opt/homebrew/opt/asdf/libexec/asdf.fish

# add love to path if it exists
if test -d /Applications/love.app/Contents/MacOS
    fish_add_path /Applications/love.app/Contents/MacOS
end

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

alias lg="lazygit"
alias nv="nvim"
alias python="python3"


function sd -d "Select directory"
  command fd . $argv[1] -t d | fzf --query="$argv[2]"
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end

