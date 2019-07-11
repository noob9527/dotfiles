#!/usr/bin/env bash

install() {
    local target='zeal'

    if has_cmd ${target}; then
        colorful::default "$target has already been installed"
        return 0
    fi

    colorful::primary "I am trying to install $target..."

    if ! has_cmd apt-get; then
        err "I have not known how to install $target yet, you have to install it manually!"
        return 1
    fi

    if ! confirm_install "$target" 'apt-get'; then
        colorful::default "Installation has been cancelled"
        return 0
    fi

    sudo apt install zeal
}

config() {
    local target_dir="$HOME/.config/Zeal"
    mkdir -p $target_dir

    ln -s -i "$dir/Zeal.conf" "$target_dir/Zeal.conf"
}

main() {
    local dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local parent_dir=$(dirname ${dir})
    local config_root=$(dirname ${parent_dir})

    source "$config_root/utils.sh"
    source "$config_root/colorful.sh"
    source "$config_root/terminal/functions.sh"

    local fn=$1
    ${fn}
}

main "$@"
