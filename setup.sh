#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$HOME/work/git/dotfiles"

if [ ! -d "$DOTFILES_DIR" ]; then
  mkdir -p "$HOME/work/git"
  git clone https://github.com/lukasweber/dotfiles.git "$DOTFILES_DIR"
fi

cd "$DOTFILES_DIR"

if ! xcode-select -p &>/dev/null; then
  xcode-select --install
  until xcode-select -p &>/dev/null; do sleep 5; done
fi

if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi

brew trust --tap nikitabobko/tap
brew bundle --file="$DOTFILES_DIR/Brewfile"

mkdir -p "$HOME/.config/mise"
if [ ! -e "$HOME/.config/mise/config.toml" ]; then
  ln -sf "$DOTFILES_DIR/mise.toml" "$HOME/.config/mise/config.toml"
fi

mise trust "$HOME/.config/mise/config.toml" 2>/dev/null || true
mise bootstrap --force-dotfiles --yes
