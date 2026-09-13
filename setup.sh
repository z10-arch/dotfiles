#!/usr/bin/env bash
# Bootstrap the packages used by these dotfiles on Debian/Ubuntu systems.

set -Eeuo pipefail

if ! command -v apt-get >/dev/null 2>&1; then
  echo "Error: setup.sh currently supports Debian/Ubuntu systems with APT." >&2
  exit 1
fi

if ! command -v sudo >/dev/null 2>&1; then
  echo "Error: sudo is required to install system packages." >&2
  exit 1
fi

export DEBIAN_FRONTEND=noninteractive

echo "Updating installed packages..."
sudo apt-get update
sudo apt-get upgrade --yes

# Needed to add the Yazi repository securely.
echo "Installing repository prerequisites..."
sudo apt-get install --yes ca-certificates curl gpg

echo "Adding the Yazi APT repository..."
curl -fsSL https://yazi-rs.github.io/builds/yazi-keyring.gpg \
  | sudo tee /usr/share/keyrings/yazi-keyring.gpg >/dev/null
echo 'deb [signed-by=/usr/share/keyrings/yazi-keyring.gpg] https://yazi-rs.github.io/builds/ stable main' \
  | sudo tee /etc/apt/sources.list.d/yazi.list >/dev/null

sudo apt-get update

# Shell, Stow, terminal workflow, and Yazi preview/search dependencies.
packages=(
  bat
  eza
  fd-find
  file
  ffmpegthumbnailer
  fzf
  git
  imagemagick
  jq
  poppler-utils
  ripgrep
  stow
  tmux
  unar
  yazi
  zoxide
  zsh
  zsh-autosuggestions
  zsh-syntax-highlighting
)

echo "Installing dotfiles dependencies..."
sudo apt-get install --yes "${packages[@]}"

echo
echo "Done. Create the configuration links with:"
echo "  stow --target=\"\$HOME\" tmux yazi zsh"
echo
echo "Optional: make Zsh your login shell with:"
echo "  chsh -s \"\$(command -v zsh)\""
