git_prompt_info() {
    git branch &>/dev/null || return  # Ensure we're in a git repository
    local branch=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null)
    local git_status=$(git status --porcelain --branch 2>/dev/null | grep -E "ahead|behind" | awk -F',' '{print $2}' | awk '{print $1}')
    if [[ -n $git_status ]]; then
        case $git_status in
            ahead)
                echo " [$branch|%F{yellow}↑%f]"
                ;;
            behind)
                echo " [$branch|%F{red}↓%f]"
                ;;
            diverged)
                echo " [$branch|%F{blue}↹%f]"
                ;;
            *)
                echo " [$branch|%F{cyan}$git_status%f]"
                ;;
        esac
    else
        echo " [$branch|%F{green}●%f]"
    fi
}
