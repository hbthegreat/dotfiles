# Enable persistent history
HISTFILE=~/.zsh_history        # Where history is stored
HISTSIZE=10000                 # How many lines of history to keep in memory
SAVEHIST=10000                 # How many lines of history to save to the file

# Share history across sessions
setopt SHARE_HISTORY            # Share history between sessions
setopt INC_APPEND_HISTORY       # Append to history file immediately
setopt APPEND_HISTORY           # Append session history to the file on exit
setopt HIST_IGNORE_DUPS         # Ignore duplicated commands in history
setopt HIST_REDUCE_BLANKS       # Remove unnecessary blanks
setopt HIST_VERIFY              # Require verification before running risky history expansions
setopt HIST_SAVE_NO_DUPS        # Don't save duplicate commands in history

# Initialize zoxide (no modification needed)
eval "$(zoxide init zsh)"

autoload -Uz compinit
compinit

# Set default editor
export EDITOR="nvim"

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
zstyle ':completion:*' file-sort name       # Sort files by name

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
eval "$(oh-my-posh init zsh --config ~/my-theme.json)"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

co() {
  cursor $(fd --type d | fzf --query="$1")
}

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

export PATH="$HOME/hbthegreat/.bun/bin:$PATH"

# Load Angular CLI autocompletion.
# source <(ng completion script)

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/hbthegreat/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/hbthegreat/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/hbthegreat/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/hbthegreat/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
export NPM_TOKEN=$(cat ~/.npmrc | grep _authToken | cut -d'=' -f2)
