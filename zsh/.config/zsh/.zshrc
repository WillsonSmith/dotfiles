autoload -U compinit; compinit
_comp_options+=(globdots) # With hidden files


# User configuration

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(zoxide init zsh)"

eval "$(fnm env --use-on-cd --shell zsh)"

## FZF and fuzzie completions
source <(fzf --zsh)
FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"

. "$ZDOTDIR/functions/git.zsh"
PROMPT="%F{green}%n%f@%F{blue}%m%f:%F{yellow}%~%f$(git_prompt_info) → "


# Editor
alias nv="nvim"
alias nvn="/Users/willsonsmith/Downloads/nvim-macos-arm64/bin/nvim"

export EDITOR="/Users/willsonsmith/Downloads/nvim-macos-arm64/bin/nvim"

# Tools
alias lg="lazygit"

alias mv-ss="~/Developer/command-line/mv-ss/.build/release/mv-ss"
alias gen="$HOME/Developer/Generators/gen/.build/debug/gen"

# PATH
export PATH="/Users/willsonsmith/.bun/bin:$PATH"
# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/willsonsmith/.lmstudio/bin"
# End of LM Studio CLI section

bindkey -v
export KEYTIMEOUT=1
