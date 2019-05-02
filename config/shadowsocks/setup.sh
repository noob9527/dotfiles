#!/usr/bin/env bash

install_ss_qt5() {
    local target='ss-qt5'

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
        err "Installation has been cancelled"
        return 2
    fi

    sudo add-apt-repository ppa:hzwhuang/ss-qt5 \
      && sudo apt-get update \
      && sudo apt-get install shadowsocks-qt5
}

install_shadowsocks_client() {
    local target='shadowsocks-client'

    if is_linux; then
        install_ss_qt5
        return $?
    else
        err "I have not known how to install $target yet, you have to install it manually!"
        return 1
    fi
}


main() {
    local dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local parent_dir=$(dirname ${dir})

    source "$parent_dir/utils.sh"
    source "$parent_dir/colorful.sh"
    source "$parent_dir/shells/functions.sh"

    install_shadowsocks_client
}

main $@
