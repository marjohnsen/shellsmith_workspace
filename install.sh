#!/usr/bin/env bash

set -e

SHELLSMITH_LAUNCH="$HOME/.local/bin/smith"
SHELLSMITH_REPO="https://github.com/marjohnsen/shellsmith.git"
SHELLSMITH_WORKSPACE="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
SHELLSMITH_DOTFILES="$SHELLSMITH_WORKSPACE/dotfiles"
SHELLSMITH_ROOT="$SHELLSMITH_WORKSPACE/.shellsmith"
SHELLSMITH_APPS="$SHELLSMITH_WORKSPACE/apps"
SHELLSMITH_MISC="$SHELLSMITH_WORKSPACE/misc"
SHELLSMITH_UTILS="$SHELLSMITH_ROOT/utils"

rollback() {
  echo -e "\nRolling back installation..."
  [ -e "$SHELLSMITH_ROOT" ] && echo "Removing $SHELLSMITH_ROOT..." && rm -rf "$SHELLSMITH_ROOT"
  [ -e "$SHELLSMITH_LAUNCH" ] && echo "Removing $SHELLSMITH_LAUNCH..." && rm -f "$SHELLSMITH_LAUNCH"
  echo -e "Rollback complete.\n"
}

clone_repo() {
  git clone "$SHELLSMITH_REPO" "$SHELLSMITH_ROOT"
}

create_launch_script() {
  echo -e "\nCreating launch script..."
  {
    echo '#!/usr/bin/env bash'
    echo "export SHELLSMITH_WORKSPACE=\"$SHELLSMITH_WORKSPACE\""
    echo "export SHELLSMITH_DOTFILES=\"$SHELLSMITH_DOTFILES\""
    echo "export SHELLSMITH_APPS=\"$SHELLSMITH_APPS\""
    echo "export SHELLSMITH_MISC=\"$SHELLSMITH_MISC\""
    echo "export SHELLSMITH_UTILS=\"$SHELLSMITH_UTILS\""
    echo "\"$SHELLSMITH_ROOT/cli.sh\" \"\$@\""
  } >"$SHELLSMITH_LAUNCH"

  chmod +x "$SHELLSMITH_LAUNCH"
  echo "Launch script added to $SHELLSMITH_LAUNCH"
}

main() {
  { [ -e "$SHELLSMITH_ROOT" ] || [ -e "$SHELLSMITH_LAUNCH" ]; } && rollback
  clone_repo
  create_launch_script

  echo -e "\nSuccessfully installed ShellSmith to $SHELLSMITH_ROOT."
  echo -e "\nRun 'smith help' to get started and explore available commands.\n"
}

trap rollback ERR
main
