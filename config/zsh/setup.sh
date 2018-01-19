#!/usr/bin/env bash

install() {
    local target='zsh'
    if has_cmd ${target}; then
        colorful::default "$target has already been installed"
        return 0
    fi

    colorful::primary "I am trying to install $target..."
    package_manager_install ${target}
}

install_ohmyzsh() {
    local target='oh-my-zsh'
    if [[ -d "$HOME/.$target" ]]; then
        colorful::default "$target has already been installed"
        return 0
    fi
    colorful::primary "I am trying to install $target..."
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	return 0
}

config() {
    colorful::primary "I am trying to configure zsh..."
    ln -s -i "$dir/zshrc" "$HOME/.zshrc" && \
        colorful::success ".zshrc have been set up"
}

main() {
    local dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local parent_dir=$(dirname ${dir})

    source "$parent_dir/utils.sh"
    source "$parent_dir/colorful.sh"

    install && install_ohmyzsh && config
}

main $@
