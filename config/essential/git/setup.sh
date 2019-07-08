#!/usr/bin/env bash

install() {
    local target='git'
    if has_cmd ${target}; then
        colorful::default "$target has already been installed"
        return 0
    fi

    colorful::primary "I am trying to install $target..."

    if has_cmd apt-get; then
        confirm_install "$target" 'apt-get' && sudo apt-get install -y "$target"
        return $?
    elif has_cmd brew; then
        confirm_install "$target" 'brew' && brew install "$target"
        return $?
    else
        err "I have not known how to install $target yet, you have to install it manually!"
        return 1
    fi
}

config() {
    colorful::primary "I am trying to configure git..."
    ln -s -i "$dir/gitignore" "$HOME/.gitignore"
    cp -i "$dir/gitconfig" "$HOME/.gitconfig"
    colorful::success ".gitignore .gitconfig have been set up"
}

config_user_info() {
    if ! confirm "$(colorful::primary "Are you going to configure git user info now?")"; then
        colorful::default "configure has been cancelled"
        return 0
    fi

    username=$(git config --global user.name)
    email=$(git config --global user.email)
    if [[ -z ${username} ]]; then
        read -p "type your git username:" username
        git config --global user.name "$username"
    fi
    if [[ -z $email ]]; then
        read -p "type your git email:" email
        git config --global user.email "$email"
    fi
}

main() {
    local dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local parent_dir=$(dirname ${dir})
    local config_root=$(dirname ${parent_dir})

    source "$config_root/utils.sh"
    source "$config_root/colorful.sh"
    source "$config_root/terminal/functions.sh"

    install && config && config_user_info
}

main $@
