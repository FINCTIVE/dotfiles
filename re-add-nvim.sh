#!/bin/bash

# Remove the existing nvim configuration from chezmoi if it exists
chezmoi forget ~/.config/nvim

# Use find to get all files except .git directory, then add them to chezmoi
find ~/.config/nvim -type f -not -path "*/\.git/*" -print0 | xargs -0 chezmoi add

echo "Neovim configuration has been re-added to chezmoi"
