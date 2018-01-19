#!/usr/bin/env bash

config_env() {
    local target='env'
    colorful::primary "I am trying to configure $target..."
    ln -s -i "$dir/exports" "$HOME/.exports" \
        && colorful::success ".exports have been set up"
}

main() {
    local dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local parent_dir=$(dirname ${dir})

    source "$parent_dir/utils.sh"
    source "$parent_dir/colorful.sh"

    config_env
    if [[ $? -eq 0 ]]; then
        colorful::success 'configure env successful'
        return 0
    else
        colorful::error 'configure env failure'
        return 1
    fi
}

main "$@"
