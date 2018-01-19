#!/usr/bin/env bash

# ideavim
# ssh

config_ideavim() {
    local target='ideavim'
    colorful::primary "I am trying to configure $target..."
    ln -s -i "$dir/ideavimrc" "$HOME/.ideavimrc" \
        && colorful::success ".ideavimrc have been set up"
}

config_ssh() {
    local target='ssh'
    colorful::primary "I am trying to configure $target..."
    mkdir -p $HOME/.ssh
    ln -s -i "$dir/ssh_config" "$HOME/.ssh/config" \
        && colorful::success ".ssh/config have been set up"
}

main() {
    local dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local parent_dir=$(dirname ${dir})

    source "$parent_dir/utils.sh"
    source "$parent_dir/colorful.sh"

    for fn in config_ideavim \
                config_ssh ; do
        ${fn}
        if [[ $? -eq 0 ]]; then
            colorful::success "$fn executed successful"
        else
            colorful::error "$fn executed failure"
        fi
    done
}

main "$@"
