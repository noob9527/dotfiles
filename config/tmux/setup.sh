#!/usr/bin/env bash

install() {
    local target='tmux'
    if has_cmd ${target}; then
        colorful::default "$target has already been installed"
        return 0
    fi

    colorful::primary "I am trying to install $target..."
    package_manager_install ${target}
}

install_tpm() {
    local target='tpm'
    if [[ -d "$HOME/.tmux/plugins/tpm" ]]; then
        colorful::default "$target has already been installed"
        return 0
    fi
    colorful::primary "I am trying to install $target..."
    confirm_install "$target" 'git' \
        && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

config() {
    colorful::primary "I am trying to configure tmux..."
    local os=$(get_os)
    if [[ ${os} = 'LINUX' ]]; then
        ln -s -i "$dir/tmux-linux.conf" "$HOME/.tmux.conf"
    elif [[ ${os} = 'OSX' ]]; then
        ln -s -i "$dir/tmux-mac.conf" "$HOME/.tmux.conf"
    else
        err 'unknown os type, I have no idea how to configure it'
        return 1
    fi
    [[ $? -eq 0 ]] && colorful::success ".tmux.conf have been set up"
}

main() {
    local dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local parent_dir=$(dirname ${dir})

    source "$parent_dir/utils.sh"
    source "$parent_dir/colorful.sh"

    install && install_tpm && config
}

main $@
