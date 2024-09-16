#!/bin/bash

# Create plugins directory if it doesn't exist
PLUGIN_DIR="$HOME/.zsh/plugins"

# Check if ~/.zsh is a file (not a directory) and handle that case
if [ -f "$HOME/.zsh" ]; then
  echo "Error: ~/.zsh exists as a file. Please remove or rename it."
  exit 1
fi

# Ensure ~/.zsh and ~/.zsh/plugins directories are created
mkdir -p $PLUGIN_DIR

# Zsh plugins
plugins=(
  "https://github.com/zsh-users/zsh-autosuggestions.git"
  "https://github.com/marlonrichert/zsh-autocomplete.git"
  "https://github.com/zsh-users/zsh-syntax-highlighting.git"
)

# Clone or update plugins
for plugin_url in "${plugins[@]}"; do
  plugin_name=$(basename "$plugin_url" .git)
  if [ -d "$PLUGIN_DIR/$plugin_name" ]; then
    echo "Updating $plugin_name..."
    git -C "$PLUGIN_DIR/$plugin_name" pull
  else
    echo "Cloning $plugin_name..."
    git clone "$plugin_url" "$PLUGIN_DIR/$plugin_name"
  fi
done
