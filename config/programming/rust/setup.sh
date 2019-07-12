#!/usr/bin/env bash

install() {
    local target='rust'
    if ! confirm_install "$target" 'curl'; then
        colorful::default "Installation has been cancelled"
        return 0
    fi

    # plz manually choose the option which do not change path env variable
    curl https://sh.rustup.rs -sSf | sh
}

config() {
    colorful::primary "I am trying to config cargo mirror..."
    sudo ln -s -i "$dir/config" "$HOME/.cargo/config"
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
