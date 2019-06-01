#!/usr/bin/env bash

# pip2
# pip3

install_pip2() {
    local target='python-pip'
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

install_pip3() {
    local target='python3-pip'
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

    upgrade_pip3
}

upgrade_pip3() {
    if ! confirm "$(colorful::primary "Are you goint to upgrade pip3(experimental)?")"; then
        colorful::default "configure has been cancelled"
        return 0
    fi

    sudo -H pip3 install --upgrade pip
}

config() {
    if ! confirm "$(colorful::primary "Are you goint to configure pip to use aliyun mirror?")"; then
        colorful::default "configure has been cancelled"
        return 0
    fi

    mkdir -p "$HOME/.pip"
    cp -i "$dir/pip.conf" "$HOME/.pip/pip.conf"
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
