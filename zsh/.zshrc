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

source ~/.zsh/private/api_keys.zsh

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
alias nv="nvim"
alias nvn="/Users/willsonsmith/Downloads/nvim-macos-arm64/bin/nvim"

export EDITOR="/Users/willsonsmith/Downloads/nvim-macos-arm64/bin/nvim"

alias lg="lazygit"

# Tools
alias mv-ss="~/Developer/command-line/mv-ss/.build/release/mv-ss"

alias picodev="cd ~/Library/Application\ Support/pico-8; nv ."

alias gen="$HOME/Developer/Generators/gen/.build/debug/gen"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/willsonsmith/.lmstudio/bin"
# End of LM Studio CLI section

