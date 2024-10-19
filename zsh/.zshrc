# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# Plugins
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
ZSH_AUTOSUGGEST_USE_ASYNC="true"
plugins=(
  git
  zsh-completions
  zsh-autosuggestions
  zsh-syntax-highlighting
)


# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"

# User configuration
eval "$(zoxide init zsh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(fnm env --use-on-cd --shell zsh)"


export PATH="/Users/willsonsmith/.bun/bin:$PATH"
if test -d /Applications/love.app/Contents/MacOS ; then
  path+=('/Applications/love.app/Contents/MacOS')
fi


# Prompt
PROMPT='%{$fg_bold[cyan]%}%c%{$reset_color%}$(git_prompt_info)%{$fg[green]%}'
PROMPT+="%(?:%{$fg_bold[green]%}:%{$fg_bold[red]%}) → %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}(%{$fg_bold[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"


# Editor
export EDITOR="nvim"

alias lg="lazygit"
alias nv="nvim"

