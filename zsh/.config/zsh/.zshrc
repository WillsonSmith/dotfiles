autoload -U compinit; compinit
_comp_options+=(globdots) # With hidden files


# User configuration

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(zoxide init zsh)"

eval "$(fnm env --use-on-cd --shell zsh)"

## FZF and fuzzie completions
source <(fzf --zsh)
FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"

export PATH="/Users/willsonsmith/.bun/bin:$PATH"

git_prompt_info() {
    git branch &>/dev/null || return  # Ensure we're in a git repository
    local branch=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null)
    local git_status=$(git status --porcelain --branch 2>/dev/null | grep -E "ahead|behind" | awk -F',' '{print $2}' | awk '{print $1}')
    if [[ -n $git_status ]]; then
        case $git_status in
            ahead)
                echo " [$branch|%F{yellow}$git_status%f]"
                ;;
            behind)
                echo " [$branch|%F{red}$git_status%f]"
                ;;
            diverged)
                echo " [$branch|%F{blue}$git_status%f]"
                ;;
            *)
                echo " [$branch|%F{cyan}$git_status%f]"
                ;;
        esac
    else
        echo " [$branch|%F{green}up-to-date%f]"
    fi
}

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
