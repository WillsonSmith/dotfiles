### Instructions

#### Manual

1. Clone the repo to ~/.dotfiles

```sh
git clone https://github.com/WillsonSmith/dotfiles.git ~/.dotfiles
```

2. Install Brew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

3. Install Stow

```sh
brew install stow
```

4. Restore dotfiles

```sh
cd ~/.dotfiles
stow bash
stow fish
stow fzf
stow homebrew
stow kitty
stow nvim
stow starship
```

5. Do things, tell people.

#### Install Script

coming soon...

### Special thanks

[GNU Stow](https://www.gnu.org/software/stow/)
