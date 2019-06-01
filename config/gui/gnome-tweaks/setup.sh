#!/usr/bin/env bash

install_gnome_tweaks() {
    local target='gnome-tweaks'

    if has_installed $target; then
        colorful::default "$target has already been installed"
        return 0
    fi

    package_manager_install ${target}
}

main() {
    local dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local parent_dir=$(dirname ${dir})
    local config_root=$(dirname ${parent_dir})

    source "$config_root/utils.sh"
    source "$config_root/colorful.sh"
    source "$config_root/terminal/functions.sh"

    install_gnome_tweaks
}

main "$@"
