#!/usr/bin/env bash

install() {
    local target='proxychains'

    if has_installed ${target}; then
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

    sudo apt-get install proxychains

    return $?
}

fix() {
    colorful::primary "I am trying to replace proxychains entry script(fix a bug in the script)"
    sudo cp -i "$dir/proxychains.sh" "$(which proxychains)"
}

config() {
    colorful::primary "I am trying to configure proxychains..."
    mkdir -p "$HOME/.proxychains"

    cp -i "$dir/proxychains.conf" "$HOME/.proxychains/proxychains.conf"
    colorful::success "proxychains.conf has been set up"
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

main $@
