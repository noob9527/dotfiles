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

    local source_file="$dir/Zeal.conf"
    local target_file="$target_dir/Zeal.conf"
    cp -i "$source_file" "$target_file"

    local docset="$HOME/.local/share/Zeal/Zeal/docsets"
    mkdir -p $docset
    sed -i "s|path=|path=$docset|g" "$target_file"
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
