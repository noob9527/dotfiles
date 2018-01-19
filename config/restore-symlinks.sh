#!/usr/bin/env bash

restore_symbol_links() {
  for arg in "$@"; do
      cp --remove-destination "$(readlink "$arg")" "$arg"
  done
}

main() {
    local arr=(
        "$HOME/.ssh/config"
        "$HOME/.tmux.conf"
        "$HOME/.exports"
        "$HOME/.gitconfig"
        "$HOME/.gitignore"
        "$HOME/.ideavimrc"
        "$HOME/.tern-config"
        "$HOME/.vimrc"
        "$HOME/.zshrc"
    )
    restore_symbol_links ${arr[@]}
}

