#!/usr/bin/env bash

install() {
    local target='go'
    if ! confirm_install "$target" 'snap'; then
        colorful::default "Installation has been cancelled"
        return 0
    fi

    sudo snap install go --classic
}

main() {
    local dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local parent_dir=$(dirname ${dir})
    local config_root=$(dirname ${parent_dir})

    source "$config_root/utils.sh"
    source "$config_root/colorful.sh"
    source "$config_root/terminal/functions.sh"

    local fn="$1"
    ${fn}
}

main "$@"
