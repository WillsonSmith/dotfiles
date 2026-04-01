# Minimal, fast Zsh completions + optional subdued inline preview

# -----------------------------
# 0) Paths & directories
# -----------------------------
# Site functions (for your custom completions like _kubectl, _docker, etc.)
typeset -ga fpath
fpath=("$HOME/.zsh/site-functions" $fpath)
[[ -d "$HOME/.zsh/site-functions" ]] || mkdir -p "$HOME/.zsh/site-functions"

# Completion cache
: "${ZSH_COMPLETION_CACHE:=$HOME/.cache/zsh/.zcompcache}"
[[ -d "$ZSH_COMPLETION_CACHE" ]] || mkdir -p "$ZSH_COMPLETION_CACHE"

# -----------------------------
# 1) Core completion setup
# -----------------------------
autoload -Uz compinit bashcompinit

# If the dump file is fresh (touched in the last day), use -C to skip checks
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit -C
else
  compinit
fi

# Enable bash completions for tools that only ship bash scripts
bashcompinit

# Keep completions fast with a cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$ZSH_COMPLETION_CACHE"

# Nice defaults
setopt AUTO_MENU          # enter menu after 2nd Tab
setopt MENU_COMPLETE      # cycle matches
setopt AUTO_PARAM_SLASH   # add / after dir completes
setopt COMPLETE_IN_WORD   # complete in the middle of a word
setopt ALWAYS_TO_END      # move cursor to end after accept

# Colors & UI
zmodload zsh/complist
# Use your LS_COLORS for file-type coloring (fallback if empty)
if [[ -n "$LS_COLORS" ]]; then
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
else
  zstyle ':completion:*' list-colors 'di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
fi
zstyle ':completion:*' group-name ''
zstyle ':completion:*' format $'\n%F{blue}%d%f'
zstyle ':completion:*:descriptions' format '%F{yellow}%B%d%b%f'
zstyle ':completion:*' menu select=2     # show selection UI on 2nd Tab
zstyle ':completion:*:warnings'   format '%F{red}%BNo matches%f%b'
zstyle ':completion:*:messages'   format '%F{cyan}%d%f'

# Smart matching (case-insensitive, dashed/underscore flex)
zstyle ':completion:*' matcher-list \
  'm:{a-z}={A-Z}' \
  'r:|[._-]=* r:|=*' \
  'l:|=* r:|=*'

# Choose completers & allow small typos
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:approximate:*' max-errors 2 numeric
zstyle ':completion:*:match:*' original only

# -----------------------------
# 2) Keybindings
# -----------------------------
# Emacs mode by default (switch to -v if you prefer vim keys)
bindkey -e
bindkey '^I'   expand-or-complete         # Tab
bindkey '^[[Z' reverse-menu-complete      # Shift-Tab (most terms)
bindkey '^X^M' menu-complete              # C-x C-m to jump into menu

# -----------------------------
# 3) Optional subdued inline preview (ghost text)
#    Strategy: prefer "completion", fall back to "history".
#    Requires a single vendored file:
#    $HOME/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# -----------------------------
_ZAS="$HOME/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
if [[ -r "$_ZAS" ]]; then
  source "$_ZAS"

  # Subdued/ghost style (tweak to taste: 8=gray, 244=lighter gray)
  : "${ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE:=fg=8}"
  ZSH_AUTOSUGGEST_STRATEGY=(completion history)

  # Keys: Right-arrow to accept, Alt-s to accept suggestion word-by-word
  # (zsh-autosuggestions already binds right-arrow; add a convenience key)
  bindkey '^[s' autosuggest-accept

else
  # No autosuggestion file found: remain minimal & quiet.
  # If you want history-based predictions (not true completion previews),
  # uncomment below. Note: 'predict-on' inserts text rather than ghost it.
  #
  # autoload -Uz predict-on predict-off
  # zle-line-init() { predict-on; }
  # zle-line-finish() { predict-off; }
  # zle -N zle-line-init
  # zle -N zle-line-finish
  #
  # One-time hint (printed once per session)
  if [[ -z "$_ZAS_HINT_PRINTED" ]]; then
    typeset -g _ZAS_HINT_PRINTED=1
    print -r -- "%F{8}[completions]%f Inline preview is disabled. Vendor zsh-autosuggestions to enable:"
    print -r -- "%F{8}  mkdir -p ~/.zsh/plugins/zsh-autosuggestions && \\"
    print -r -- "%F{8}  curl -fsSL https://raw.githubusercontent.com/zsh-users/zsh-autosuggestions/master/zsh-autosuggestions.zsh \\"
    print -r -- "%F{8}    -o ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh%f"
  fi
fi

# -----------------------------
# 4) Helper: register completions for common tools (run once)
#    Use: compgen-kube; compgen-docker
# -----------------------------
compgen-kube() {
  if command -v kubectl >/dev/null 2>&1; then
    kubectl completion zsh >| "$HOME/.zsh/site-functions/_kubectl" && \
      print -r -- "%F{green}Installed:_kubectl%f"
  else
    print -r -- "%F{red}kubectl not found%f"
  fi
}
compgen-docker() {
  if command -v docker >/dev/null 2>&1; then
    docker completion zsh >| "$HOME/.zsh/site-functions/_docker" && \
      print -r -- "%F{green}Installed:_docker%f"
  else
    print -r -- "%F{red}docker not found%f"
  fi
}

# -----------------------------
# 5) Security hardening (once)
#    Uncomment & run interactively if compaudit warns about perms.
# -----------------------------
# compfix() {
#   chmod -R go-w "$HOME" "$ZDOTDIR" 2>/dev/null || true
#   for d in /usr/local/share/zsh /usr/local/share/zsh/site-functions; do
#     [[ -d "$d" ]] && chmod -R go-w "$d"
#   done
#   print -r -- "%F{green}Permissions tightened. Restart shell.%f"
# }

# Done.
