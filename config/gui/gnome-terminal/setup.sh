#!/usr/bin/env bash

config_terminal_profile() {
    local terminal='gnome-terminal'
    local target='terminal_profile'

    if ! is_linux; then
        err "I have not known how to configure $target yet, you have to configure it manually!"
        return 1
    fi

    if ! confirm "$(colorful::primary "Are you going to add terminal profile?")"; then
        colorful::default "configure has been cancelled"
        return 0
    fi

    colorful::primary "I am trying to configure $target..."

    TERMINAL="gnome-terminal" && source "$dir/terminal-monokai-colorscheme.sh" \
        && colorful::success "monokai profile has been added"
}

main() {
    local dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local parent_dir=$(dirname ${dir})
    local config_root=$(dirname ${parent_dir})

    source "$config_root/utils.sh"
    source "$config_root/colorful.sh"
    source "$config_root/terminal/functions.sh"

    config_terminal_profile
}

main "$@"
