#!/usr/bin/env bash

# xclip
# autojump
# ag
# powerline
# hub

install_xclip() {
    local target='xclip'
    if has_cmd ${target}; then
        colorful::default "$target has already been installed"
        return 0
    fi
    colorful::primary "I am trying to install $target..."
    package_manager_install ${target}
}

install_autojump() {
    local target='autojump'
    if has_cmd ${target}; then
        colorful::default "$target has already been installed"
        return 0
    fi
    colorful::primary "I am trying to install $target..."
    package_manager_install ${target}
}

install_ag() {
    local target='ag'
    if has_cmd ${target}; then
        colorful::default "$target has already been installed"
        return 0
    fi
    colorful::primary "I am trying to install $target..."
    if has_cmd 'apt-get'; then
        package_manager_install 'silversearcher-ag' 'apt-get'
        return $?
    elif has_cmd 'brew'; then
        package_manager_install 'the_silver_searcher' 'brew'
        return $?
    else
        err "I have not known how to install $target yet, you have to install it manually!"
        return 1
    fi
}

install_powerline() {
    local target='powerline'
    if has_cmd ${target}; then
        colorful::default "$target has already been installed"
        return 0
    fi
    colorful::primary "I am trying to install $target..."

    if has_cmd 'apt-get'; then
        package_manager_install 'powerline' 'apt-get'
        return $?
    elif has_cmd 'pip'; then
        confirm_install 'powerline-status' 'pip' \
            && pip install powerline-status
        return $?
    else
        err 'powerline will not be install since pip is not available'
    fi
}

install_hub() {
    local target='hub'
    if has_cmd ${target}; then
        colorful::default "$target has already been installed"
        return 0
    fi

    colorful::primary "I am trying to install $target..."

    sudo snap install ${target} --classic
}

install_translate_shell() {
    local target='trans'

    if has_cmd ${target}; then
        colorful::default "$target has already been installed"
        return 0
    fi

    colorful::primary "I am trying to install $target..."

    confirm_install $target 'wget' \
        && sudo wget -O /usr/local/bin/trans git.io/trans \
        && sudo chmod +x /usr/local/bin/trans
}

main() {
    local dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local parent_dir=$(dirname ${dir})
    local config_root=$parent_dir

    source "$config_root/utils.sh"
    source "$config_root/colorful.sh"
    source "$config_root/terminal/functions.sh"

    local fn="install_$1"
    ${fn}
}

main "$@"
