#!/bin/sh
#
# This script installs all custom Git hooks from the local `hooks` directory
# into the project's .git/hooks directory.

# --- Configuration ---
# The directory where your hook scripts are located.
HOOK_SOURCE_DIR="$(dirname "$0")/hooks"

# The directory where Git expects hooks to be.
HOOK_DEST_DIR=""
if [ -d ".git" ]; then
    HOOK_DEST_DIR=".git/hooks"
elif [ -d "../.git" ]; then
    HOOK_DEST_DIR="../.git/hooks"
else
    # Attempt to find the .git directory at the top level of the repository
    GIT_TOP_LEVEL=$(git rev-parse --show-toplevel 2>/dev/null)
    if [ -n "$GIT_TOP_LEVEL" ]; then
        HOOK_DEST_DIR="$GIT_TOP_LEVEL/.git/hooks"
    else
        echo "\033[31mError: Could not find the .git/hooks directory. Please run this script from the root of your Git repository.\033[0m"
        exit 1
    fi
fi

# List of hooks to install.
HOOK_FILES="pre-commit commit-msg pre-push pre-rebase"

# --- Installation Logic ---
echo "Starting Git hooks installation..."

# Ensure the destination directory exists.
mkdir -p "$HOOK_DEST_DIR"

for hook in $HOOK_FILES; do
    SOURCE_FILE="$HOOK_SOURCE_DIR/$hook"
    DEST_FILE="$HOOK_DEST_DIR/$hook"

    if [ -f "$SOURCE_FILE" ]; then
        echo "Installing '$hook' hook..."
        # Copy the hook file
        cp "$SOURCE_FILE" "$DEST_FILE"
        # Make it executable
        chmod +x "$DEST_FILE"
    else
        echo "\033[33mWarning: Source file for '$hook' hook not found at '$SOURCE_FILE'. Skipping.\033[0m"
    fi
done

echo "\n\033[32mInstallation complete! Your new Git hooks are active.\033[0m"
exit 0 