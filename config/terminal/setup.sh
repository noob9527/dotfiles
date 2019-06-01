#!/usr/bin/env bash

# ssh
# ssh-key
# env
# shell-functions
# bash

config_ssh() {
    local target='ssh'
    colorful::primary "I am trying to configure $target..."
    mkdir -p $HOME/.ssh
    ln -s -i "$dir/ssh_config" "$HOME/.ssh/config" \
        && colorful::success ".ssh/config have been set up"
}

config_ssh-key() {
    local target='ssh-key'

    colorful::primary "I am trying to configure $target..."
    mkdir -p $HOME/.ssh

    if [[ -f "$HOME/.ssh/id_rsa.pub" ]]; then
        colorful::default "$target has already been generated"
        return 0
    fi

    ssh-keygen
}

config_env() {
    local target='env'
    colorful::primary "I am trying to configure $target..."
    ln -s -i "$dir/exports" "$HOME/.exports" \
        && colorful::success ".exports have been set up"
}

config_shell-functions() {
    local target='shell_functions'
    colorful::primary "I am trying to configure $target..."
    ln -s -i "$dir/functions.sh" "$HOME/.functions.sh" \
        && colorful::success ".functions.sh have been set up"
}

config_bash() {
    colorful::primary "I am trying to configure bash..."
    ln -s -i "$dir/bash_profile" "$HOME/.bash_profile" && \
        colorful::success ".bash_profile have been set up"
}

main() {
    local dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local parent_dir=$(dirname ${dir})

    source "$parent_dir/utils.sh"
    source "$parent_dir/colorful.sh"

    local fn="config_$1"
    ${fn}
}

main "$@"
