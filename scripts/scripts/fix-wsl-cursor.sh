#!/usr/bin/env bash

# Function to backup a file if it exists
backup_file() {
    local file_path=$1
    if [ -e "$file_path" ]; then
        mv "$file_path" "$file_path.bak"
    fi
}

# Function to safely copy a file and create a backup if it doesn't exist
safe_copy_with_backup() {
    local src=$1
    local dest=$2
    cp "$src" "$dest"
    if [ ! -e "$dest.bak" ]; then
        cp "$dest" "$dest.bak"
    fi
}

# Function to perform the sed replacements
perform_replacements() {
    local file_path=$1
    local bin_path=$2

    sed -i 's|APP_NAME="code"|APP_NAME="cursor"|' "$file_path"
    if [ -n "$bin_path" ]; then
        local commit
        commit=$(basename "$bin_path")
        sed -i "s|COMMIT=\"[^\"]*\"|COMMIT=\"$commit\"|" "$file_path"
    fi
    sed -i 's|NAME="Code"|NAME="Cursor"|' "$file_path"
    sed -i 's|SERVERDATAFOLDER=".vscode-server"|SERVERDATAFOLDER=".cursor-server"|' "$file_path"
    sed -i -E 's|VSCODE_PATH=".+"|VSCODE_PATH="$(dirname "$(dirname "$(dirname "$(dirname "$(realpath "$0")")")")")"|' "$file_path"
    sed -i -E 's|WSL_EXT_WLOC=(.+)|WSL_EXT_WLOC=$(tail -1 /tmp/remote-wsl-loc.txt)|' "$file_path"
}

# Main script execution
CODE_PATH=$(which code)
if [[ "$CODE_PATH" == *"cursor"* ]]; then
    backup_file "$CODE_PATH"
fi

CODE_WIN_PATH=$(which code)
CURSOR_WIN_PATH=$(which cursor)
BIN_PATH=$(ls -d ~/.cursor-server/bin/*/ 2>/dev/null | head -n 1)

safe_copy_with_backup "$CODE_WIN_PATH" "$CURSOR_WIN_PATH"
perform_replacements "$CURSOR_WIN_PATH" "$BIN_PATH"
