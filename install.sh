
## Install Brew
if test -x /opt/homebrew/bin/brew ; then
  echo "Brew Installed — skipping"
else
  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
fi

brew bundle --file homebrew/BREWFILE

if ! test -d $HOME/.oh-my-zsh; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" " " --unattended --keep-zshrc
fi

## Install dotfiles
stow fzf --adopt
stow nvim --adopt
stow kitty --adopt
stow starship --adopt
stow homebrew --adopt


install_plugins () {
  echo "Instaling plugins"
  # plugins=(
  install_plugin zsh-autosuggestions https://github.com/zsh-users/zsh-autosuggestions
  install_plugin zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting.git
  install_plugin zsh-completions https://github.com/zsh-users/zsh-completions
  # )
}

install_plugin () {
  name=$1
  source=$2
  dir=$HOME/.oh-my-zsh/custom/plugins/$name
  if [[ ! -d $dir ]]; then
    git clone $source $dir
  fi
}

install_plugins
