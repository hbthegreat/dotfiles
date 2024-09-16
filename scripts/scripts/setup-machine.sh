#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Install necessary system packages as root
echo "Installing stow, git, unzip, build-essential, procps, file, and other essential packages"
sudo apt install stow git unzip build-essential procps file p7zip-full jq poppler-utils imagemagick subversion ffmpegthumbnailer -y

# Install webi as the regular user
echo "Installing webi"
curl -sS https://webi.sh/webi | sh
export PATH=$HOME/.local/bin:$PATH  # Add webi to the PATH

# Verify webi installation
if ! command -v webi &> /dev/null; then
    echo "webi could not be installed. Exiting."
    exit 1
fi

# Install Bun using webi (as a regular user)
echo "Installing Bun"
webi bun

# Install Homebrew (as a regular user) via webi
echo "Installing Homebrew"
webi brew

# Verify Homebrew installation
if ! command -v brew &> /dev/null; then
    echo "Homebrew could not be installed. Exiting."
    exit 1
fi

# Install Zsh (can be done as root)
echo "Installing Zsh"
sudo apt install zsh -y

# Verify Zsh installation
if ! command -v zsh &> /dev/null; then
    echo "Zsh could not be installed. Exiting."
    exit 1
fi

# Install oh-my-posh (as a regular user via brew)
echo "Installing oh-my-posh"
brew install jandedobbeleer/oh-my-posh/oh-my-posh

# Verify oh-my-posh installation
if ! command -v oh-my-posh &> /dev/null; then
    echo "oh-my-posh could not be installed. Exiting."
    exit 1
fi

# Install aliasman using webi (as a regular user)
echo "Installing aliasman"
webi aliasman

# Verify aliasman installation
if ! command -v aliasman &> /dev/null; then
    echo "aliasman could not be installed. Exiting."
    exit 1
fi

# Install fd and ripgrep using webi
echo "Installing fd and ripgrep"
webi fd rg

# Install yazi using cargo (Rust package manager)
if ! command -v yazi &> /dev/null; then
    echo "Installing yazi via cargo"
    if ! command -v cargo &> /dev/null; then
        echo "Installing Rust (cargo)"
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
        source $HOME/.cargo/env  # Ensure cargo is in the path
    fi
    cargo install yazi
fi

# Verify essential tools
for tool in lsd bat fd rg fzf zoxide; do
  if ! command -v $tool &> /dev/null; then
      echo "$tool could not be installed. Exiting."
      exit 1
  fi
done

# Setting Aliases using aliasman
echo "Setting Aliases"
aliasman ga 'git add'
aliasman gc 'git commit -m'
aliasman gri 'git rebase -i'
aliasman la 'lsd -AF'
aliasman ll 'lsd -lAhF'
aliasman ls 'lsd -F'
aliasman rgi 'rg -i'
aliasman tree 'lsd -F --tree --group-dirs=last'
aliasman cat 'bat'

# Change shell to Zsh (as the regular user)
echo "Changing shell to Zsh"
chsh -s $(which zsh)

# Inform the user they may need to log out and back in for the shell change
echo "Shell changed to Zsh. Please log out and back in for the changes to take effect."

# Install Zsh plugins
echo "Installing Zsh plugins"
if [ -f ~/dotfiles/zsh/plugins-install.sh ]; then
    chmod +x ~/dotfiles/zsh/plugins-install.sh
    ~/dotfiles/zsh/plugins-install.sh
else
    echo "Plugins installation script not found!"
    exit 1
fi

# Ensure the correct path for dotfiles and use stow (as the regular user)
cd ~/dotfiles

echo "Stowing ssh"
stow ssh

echo "Stowing zsh"
stow zsh

echo "Stowing scripts"
stow scripts

# Notify that the setup is complete
echo "Setup completed successfully!"
