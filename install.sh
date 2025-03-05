#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_URL=$(git -C "$SCRIPT_DIR" config --get remote.origin.url)
SHARED_URL=$(git -C "$SCRIPT_DIR" config --file "$SCRIPT_DIR/.gitmodules" --get "submodule.shared.url")

# Make sure shared submodule path is correct
if [ "$SHARED_URL" != "$REPO_URL" ]; then
  echo "Updating submodule 'shared' ORIGIN from $SHARED_URL to $REPO_URL..."
  git -C "$SCRIPT_DIR" config --file "$SCRIPT_DIR/.gitmodules" "submodule.shared.url" "$REPO_URL"
  git -C "$SCRIPT_DIR" submodule sync --recursive
  git -C "$SCRIPT_DIR" add .gitmodules
  git -C "$SCRIPT_DIR" commit -m "Update submodule 'shared' ORIGIN"
fi

# Update update submodules and install shellsmith
if git -C "$SCRIPT_DIR" submodule update --init --recursive; then
  if [ -f "$SCRIPT_DIR/.shellsmith/install.sh" ]; then
    sudo bash "$SCRIPT_DIR/.shellsmith/install.sh"
  else
    echo "Install script not found." >&2
    exit 1
  fi
else
  echo "Failed to update submodule 'shared'." >&2
  exit 1
fi
