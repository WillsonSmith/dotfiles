# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Plugins
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
ZSH_AUTOSUGGEST_USE_ASYNC="true"
plugins=(
  git
  zsh-completions
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"

# User configuration
eval "$(starship init zsh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(fnm env --use-on-cd --shell zsh)"


alias lg="lazygit"
alias nv="nvim"

export PATH="/Users/willsonsmith/.bun/bin:$PATH"
if test -d /Applications/love.app/Contents/MacOS ; then
  path+=('/Applications/love.app/Contents/MacOS')
fi

# Editor
export EDITOR="nvim"

eval "$(zoxide init zsh)"
