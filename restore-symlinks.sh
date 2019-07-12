#!/usr/bin/env bash

restore_symbol_links() {
  for arg in "$@"; do
      cp --remove-destination "$(readlink "$arg")" "$arg"
  done
}

main() {
    local arr=(
        "$HOME/.gitignore"
        "$HOME/.ssh/config"
        "$HOME/.tmux.conf"
        "$HOME/.exports"
        "$HOME/.ideavimrc"
        "$HOME/.vimrc"
        "$HOME/.zshrc"
        "$HOME/.profile"
        "$HOME/.bash_profile"
        "$HOME/.functions.sh"
        "$HOME/.cargo/config"
    )
    restore_symbol_links ${arr[@]}
}

main "$@"
