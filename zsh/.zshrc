# Enable persistent history
HISTFILE=~/.zsh_history        # Where history is stored
HISTSIZE=10000                 # How many lines of history to keep in memory
SAVEHIST=10000                 # How many lines of history to save to the file

# Share history across sessions
setopt SHARE_HISTORY            # Share history between sessions
setopt INC_APPEND_HISTORY       # Append to history file immediately
setopt HIST_IGNORE_DUPS         # Ignore duplicated commands in history
setopt HIST_REDUCE_BLANKS       # Remove unnecessary blanks
setopt HIST_VERIFY              # Require verification before running risky history expansions
setopt HIST_SAVE_NO_DUPS        # Don't save duplicate commands in history

autoload -Uz compinit
compinit

# Add Homebrew to PATH
if [ -d "/home/linuxbrew/.linuxbrew/bin" ]; then
  export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
elif [ -d "$HOME/.linuxbrew/bin" ]; then
  export PATH="$HOME/.linuxbrew/bin:$PATH"
elif [ -d "$HOME/.local/opt/brew/bin" ]; then
  export PATH="$HOME/.local/opt/brew/bin:$PATH"
fi

# Add ~/.local/bin to PATH
if [ -d "$HOME/.local/bin" ]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

# Enhanced tab completion options
zstyle ':completion:*' menu select          # Use menu-based selection when multiple options are available
zstyle ':completion:*:descriptions' format '%U%B%d%b%u' # Highlight descriptions
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'

# Enable case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'


# Source all plugins from ~/.zsh/plugins
for plugin in ~/.zsh/plugins/*; do
  if [ -f "$plugin/${plugin##*/}.plugin.zsh" ]; then
    source "$plugin/${plugin##*/}.plugin.zsh"
  elif [ -f "$plugin/${plugin##*/}.zsh" ]; then
    source "$plugin/${plugin##*/}.zsh"
  fi
done

# Initialize oh-my-posh with custom theme
eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/catppuccin_mocha.omp.json)"

# Initialize zoxide
eval "$(zoxide init zsh)"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
