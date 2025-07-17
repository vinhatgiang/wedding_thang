#!/bin/bash

# Script to install Git hook: always use pre-commit-warning

# Display header
echo "====================================="
echo "Git Hook Installer"
echo "====================================="
echo

# Check if we're in a Git repository
if [ ! -d ".git" ]; then
    echo "Error: This script must be run from the root of a Git repository."
    echo "Current directory does not appear to be a Git repository (no .git directory found)."
    exit 1
fi

SOURCE="pre-commit-warning"
echo "Installing warning-only hook..."

# Check if pre-commit hook already exists
if [ -f ".git/hooks/pre-commit" ]; then
    echo "A pre-commit hook already exists in this repository."
    read -p "Do you want to overwrite it? (y/n): " overwrite
    if [ "$overwrite" != "y" ] && [ "$overwrite" != "Y" ]; then
        echo "Installation cancelled."
        exit 0
    fi
fi

# Copy the selected hook to the .git/hooks directory
cp "$SOURCE" .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit

echo
echo "Hook installed successfully!"
echo "The hook will now run automatically on every commit."
echo
echo "To test it, try to commit while on the develop branch."
echo "To bypass the hook in emergency situations, use: git commit --no-verify"
