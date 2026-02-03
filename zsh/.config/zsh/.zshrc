autoload -U compinit; compinit
_comp_options+=(globdots) # With hidden files

# User configuration

# History
HISTFILE="$ZDOTDIR/.zsh_history"
HISTSIZE=1000000
SAVEHIST=1000000
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt APPEND_HISTORY            # Append history to the history file (no overwriting)
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write duplicate entries in the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.

eval "$(/opt/homebrew/bin/brew shellenv)"
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

eval "$(zoxide init zsh)"
eval "$(fnm env --use-on-cd --shell zsh)"

## FZF and fuzzie completions
source <(fzf --zsh)
FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"

. "$ZDOTDIR/functions/completions.zsh"
. "$ZDOTDIR/functions/git.zsh"

setopt PROMPT_SUBST         # important: enables $(...) in PROMPT
PROMPT='%F{green}%n%f@%F{blue}%m%f:%F{yellow}%~%f$(git_prompt_info) → '

# Editor
alias nv="nvim"
alias nvn="/Users/willsonsmith/Downloads/nvim-macos-arm64/bin/nvim"

export EDITOR="/Users/willsonsmith/Downloads/nvim-macos-arm64/bin/nvim"

# Tools
alias lg="lazygit"
alias gen="$HOME/Developer/Generators/gen/.build/debug/gen"
alias mv-ss="~/Developer/command-line/mv-ss/.build/release/mv-ss"

# PATH
export PATH="/Users/willsonsmith/.bun/bin:$PATH"
# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/willsonsmith/.lmstudio/bin"
# End of LM Studio CLI section
export PATH="/Users/willsonsmith/.config/cache/.bun/bin:$PATH"

bindkey -v
export KEYTIMEOUT=1
