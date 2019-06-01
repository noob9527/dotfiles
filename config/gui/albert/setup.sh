#!/usr/bin/env bash

install() {
    local target='albert'

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

    curl https://build.opensuse.org/projects/home:manuelschneid3r/public_key | sudo apt-key add - \
        && sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_18.04/ /' > /etc/apt/sources.list.d/home:manuelschneid3r.list" \
        && sudo apt-get update \
        && sudo apt-get install albert

    return $?
}

autostart() {
    if [[ -e "$HOME/.config/autostart/albert.desktop" ]]; then
        colorful::default 'autostart entry has already existed'
        return 0
    fi

    colorful::primary "I am trying to autostart albert..."
    cp -i "$dir/autostart-albert.desktop" "$HOME/.config/autostart/albert.desktop"
}

config() {
    local source_dir="$dir/config"
    local target_dir="$HOME/.config/albert"
    mkdir -p $target_dir

    cp -i -r "$source_dir/org.albert.extension.websearch" "$target_dir/org.albert.extension.websearch"
    ln -s -i "$source_dir/albert.conf" "$target_dir/albert.conf"
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
