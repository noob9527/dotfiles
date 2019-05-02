#!/usr/bin/env bash

# install several tools
# pip2
# pip3
# curl
# build-essential
# cmake
# ag
# autojump
# powerline
# reattach-to-user-namespace(mac)

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
}

install_curl() {
    local target='curl'
    if has_cmd ${target}; then
        colorful::default "$target has already been installed"
        return 0
    fi
    colorful::primary "I am trying to install $target..."
    package_manager_install ${target}
}

install_build_essential() {
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

install_cmake() {
    local target='cmake'
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

install_autojump() {
    local target='autojump'
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

    source "$parent_dir/utils.sh"
    source "$parent_dir/colorful.sh"
    source "$parent_dir/shells/functions.sh"

    for fn in install_pip2 \
        install_pip3 \
        install_curl \
        install_build_essential \
        install_cmake \
        install_ag \
        install_powerline \
        install_rtun \
        install_translate_shell \
        install_autojump; do
    ${fn}
    if [[ $? -eq 0 ]]; then
        colorful::success "$fn executed successful"
    else
        colorful::error "$fn executed failure"
    fi
done
}

main "$@"
