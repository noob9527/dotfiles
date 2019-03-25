#!/usr/bin/env bash

config() {
    colorful::primary "I am trying to configure bash..."
    ln -s -i "$dir/bash_profile" "$HOME/.bash_profile" && \
        colorful::success ".bash_profile have been set up"
}

main() {
    local dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local parent_dir=$(dirname ${dir})

    source "$parent_dir/utils.sh"
    source "$parent_dir/colorful.sh"

    config
}

main $@
