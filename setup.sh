#!/usr/bin/env bash
set -e

echo "Setting up dotfiles..."

# 1. Install zoxide if not present
if ! command -v zoxide &> /dev/null; then
    echo "Installing zoxide..."
    if command -v brew &> /dev/null; then
        brew install zoxide
    else
        curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
    fi
else
    echo "zoxide is already installed."
fi

# 2. Stow or link configurations
echo "Linking dotfiles..."
# Assuming GNU stow is used or creating symlinks
cd "$(dirname "$0")"
for dir in ghostty neovim tmux zsh; do
    if [ -d "$dir" ]; then
        echo "Stowing $dir..."
        stow -R "$dir" || echo "Stow failed for $dir, manual linking may be needed."
    fi
done

echo "Setup complete!"
