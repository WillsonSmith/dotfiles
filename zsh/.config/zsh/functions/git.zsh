git_prompt_info() {
  # bail if not in a git worktree
  git rev-parse --is-inside-work-tree &>/dev/null || return

  # branch / ref: branch → exact tag → short SHA
  local ref
  ref=$(git symbolic-ref --quiet --short HEAD 2>/dev/null) \
    || ref=$(git describe --tags --exact-match 2>/dev/null) \
    || ref=$(git rev-parse --short HEAD 2>/dev/null)

  # first status line
  local line
  line=$(git status --porcelain --branch 2>/dev/null | head -n1)

  # ahead/behind flags
  local ahead behind
  [[ $line == *ahead*  ]] && ahead=1
  [[ $line == *behind* ]] && behind=1

  # detect staged and unstaged changes
  local staged unstaged
  git diff --cached --quiet 2>/dev/null || staged=1
  git diff --quiet 2>/dev/null || unstaged=1

  # build dirty marker
  local dirty=""
  if [[ -n $staged ]]; then
    dirty+="%F{yellow}±%f"
  fi
  if [[ -n $unstaged ]]; then
    dirty+="%F{red}±%f"
  fi

  # pick sync marker
  local sync
  if [[ -n $ahead && -n $behind ]]; then
    sync="%F{blue}↹%f"
  elif [[ -n $ahead ]]; then
    sync="%F{yellow}↑%f"
  elif [[ -n $behind ]]; then
    sync="%F{red}↓%f"
  else
    sync="%F{green}●%f"
  fi

  # if dirty exists and sync is just the green dot, replace dot with dirty
  if [[ -n $dirty && $sync == *"●"* ]]; then
    sync="$dirty"
    dirty=""
  fi

  echo " [$ref|$sync$dirty]"
}
