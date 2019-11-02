#!/usr/bin/env bash

# curl
# build-essential
# make
# cmake
# net-tools

install_curl() {
    local target='curl'
    if has_cmd ${target}; then
        colorful::default "$target has already been installed"
        return 0
    fi
    colorful::primary "I am trying to install $target..."
    package_manager_install ${target}
}

install_build-essential() {
    local target='build-essential'
    if has_installed ${target}; then
        colorful::default "$target has already been installed"
        return 0
    fi
    colorful::primary "I am trying to install $target..."
    if has_cmd 'apt-get'; then
        package_manager_install ${target} 'apt-get'
        return $?
    else
        err "I have not known how to install $target yet, you have to install it manually!"
        return 1
    fi
}

install_net-tools() {
    local target='net-tools'
    if has_installed ${target}; then
        colorful::default "$target has already been installed"
        return 0
    fi
    colorful::primary "I am trying to install $target..."
    if has_cmd 'apt-get'; then
        package_manager_install ${target} 'apt-get'
        return $?
    else
        err "I have not known how to install $target yet, you have to install it manually!"
        return 1
    fi
}

install_make() {
    local target='make'
    if has_cmd ${target}; then
        colorful::default "$target has already been installed"
        return 0
    fi
    colorful::primary "I am trying to install $target..."
    package_manager_install ${target}
}

install_cmake() {
    local target='cmake'
    if has_cmd ${target}; then
        colorful::default "$target has already been installed"
        return 0
    fi
    colorful::primary "I am trying to install $target..."
    package_manager_install ${target}
}

install_rtun() {
    local target='reattach-to-user-namespace'
    if has_cmd 'brew'; then
        package_manager_install ${target} 'brew'
        return $?
    fi
}

config_keyboard() {
    setxkbmap -option caps:ctrl_modifier -option ctrl:swap_rwin_rctl
    sudo cp -i "$dir/keyboard" '/etc/default/keyboard'
}

main() {
    local dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local parent_dir=$(dirname ${dir})

    source "$parent_dir/utils.sh"
    source "$parent_dir/colorful.sh"
    source "$parent_dir/terminal/functions.sh"

    local fn="$1"
    ${fn}
}

main "$@"
