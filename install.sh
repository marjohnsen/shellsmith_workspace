#!/usr/bin/env bash

if git submodule update --init --recursive; then
  if [ -f .shellsmith/install.sh ]; then
    bash .shellsmith/install.sh
  else
    echo "Install script not found." >&2
    exit 1
  fi
else
  echo "Failed to update submodules." >&2
  exit 1
fi
