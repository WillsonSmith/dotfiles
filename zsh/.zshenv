export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export PATH="$HOME/.local/bin:$PATH"

export PATH="/Users/willsonsmith/.config/local/share/../bin:$PATH"

. "$HOME/.swiftly/env.sh"
. "$HOME/.cargo/env"
. "$ZDOTDIR/private/api_keys.zsh"
