#!/usr/bin/env bash

config_env() {
    local target='env'
    colorful::primary "I am trying to configure $target..."
    ln -s -i "$dir/exports" "$HOME/.exports" \
        && colorful::success ".exports have been set up"
}

config_shell_functions() {
    local target='shell_functions'
    colorful::primary "I am trying to configure $target..."
    ln -s -i "$dir/functions.sh" "$HOME/.functions.sh" \
        && colorful::success ".functions.sh have been set up"
}

main() {
    local dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local parent_dir=$(dirname ${dir})

    source "$parent_dir/utils.sh"
    source "$parent_dir/colorful.sh"

    config_env
    config_shell_functions
    return 0
}

main "$@"
