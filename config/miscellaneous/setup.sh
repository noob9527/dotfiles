#!/usr/bin/env bash

# ideavim
# ssh
# ssh_key

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

config_ssh_key() {
    local target='ssh_key'

    colorful::primary "I am trying to configure $target..."
    mkdir -p $HOME/.ssh

    if [[ -f "$HOME/.ssh/id_rsa.pub" ]]; then
        colorful::default "$target has already been generated"
        return 0
    fi

    ssh-keygen
}

config_terminal_profile() {
    local target='terminal_profile'

    if ! is_linux; then
        err "I have not known how to configure $target yet, you have to configure it manually!"
        return 1
    fi

    if ! confirm "$(colorful::primary "Are you going to add terminal profile?")"; then
        err "configure has been cancelled"
        return 1
    fi

    colorful::primary "I am trying to configure $target..."

    source "$dir/terminal/terminal-monokai-colorscheme.sh" \
        && colorful::success "monokai profile has been added"
}

main() {
    local dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local parent_dir=$(dirname ${dir})

    source "$parent_dir/utils.sh"
    source "$parent_dir/colorful.sh"
    source "$parent_dir/shells/functions.sh"

    for fn in config_ideavim \
                config_terminal_profile \
                config_ssh \
                config_ssh_key ; do
        ${fn}
        if [[ $? -eq 0 ]]; then
            colorful::success "$fn executed successful"
        else
            colorful::error "$fn executed failure"
        fi
    done
}

main "$@"
