#!/usr/bin/env bash

install_nvm() {
    local target='nvm'
    if [[ -d "$HOME/.$target" ]]; then
        colorful::default "$target has already been installed"
        return 0
    fi
    colorful::primary "I am trying to install $target..."
    confirm_install "$target" 'curl' \
        && curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh \
        | NVM_DIR="$HOME/.nvm" bash
    if [[ $? -eq 0 ]]; then
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    fi
}

install_node() {
    local target='node'
    if has_cmd ${target}; then
        colorful::default "$target has already been installed"
        return 0
    fi

    colorful::primary "I am trying to install $target..."

    if confirm_install "$target" 'nvm'; then
        nvm install node && nvm use node
        return $?
    fi
    return 0
}

install_node_global_package() {
    local pkgs=(
    'js-beautify' \
        'eslint' \
        'babel-eslint' \
        'eslint-plugin-flowtype' \
        'eslint-plugin-react' \
        'eslint-plugin-jsx-a11y' \
        'eslint-plugin-import' \
        'eslint-config-airbnb-base' \
        'eslint-config-airbnb' \
        'typescript' \
        'typescript-formatter' \
        'tslint' \
        )
    # TODO find elegant way
    to_multi_line() {
        (IFS=$'\n'; echo "$*")
    }
    # a tricky way to add LF
    # https://stackoverflow.com/questions/4296108/how-do-i-add-a-line-break-for-read-command
    local cr=$(echo $'\n.')
    cr=${cr%.}
    if confirm "$(colorful::primary "Are you going to install(global) following pacakges:${cr}$(to_multi_line ${pkgs[*]})${cr}")"; then
        npm install -g ${pkgs[@]}
        return $?
    fi
    return 0
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

main $@
