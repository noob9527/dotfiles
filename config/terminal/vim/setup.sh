#!/usr/bin/env bash

install() {
    local target='vim'
    if has_cmd ${target}; then
        colorful::default "$target has already been installed"
        if ! confirm "$(colorful::primary 'Are you going to overwrite?')"; then
            return 0
        fi
    fi

    colorful::primary "I am trying to install $target..."

    if has_cmd apt-get; then
        confirm_install "$target" apt-get && \
            sudo apt-get remove -y vim vim-runtime gvim vim-tiny vim-common && \
            sudo apt-get install -y vim-gtk
    elif has_cmd brew; then
        confirm_install "$target" 'brew' && \
            sudo brew install vim \
            --with-lua \
            --with-python3 \
            --with-override-system-vi
    else
        err "I have not known how to install $target yet, you have to install it manually!"
        return 1
    fi
}

install_vundle() {
    local target='vundle'
    if [[ -d "$HOME/.vim/bundle/Vundle.vim" ]]; then
        colorful::default "$target has already been installed"
        return 0
    fi
    colorful::primary "I am trying to install $target..."
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    return $?
}

config() {
    colorful::primary "I am trying to configure vim..."
    mkdir -p "$HOME/.vim/.undo_history"
    ln -s -i "$dir/vimrc" "$HOME/.vimrc"
    cp -i "$dir/tern-config" "$HOME/.tern-config"
    colorful::success ".vimrc .tern-config have been set up"
}

install_plugin() {
    if confirm "$(colorful::primary 'Are you going to install vim plugin now?')"; then
        vim +PluginInstall +qall
        return $?
    fi
    return 0
}

build_ycm() {
    local target='YouCompleteMe'

    if ! confirm "$(colorful::primary 'Are you going to build YouCompleteMe now?')"; then
        colorful::default "build ycm task has been cancelled"
        return 0
    fi

    colorful::primary "I am trying to compile $target..."
    $HOME/.vim/bundle/YouCompleteMe/install.py \
        --clang-completer \
        --js-completer
}

main() {
    local dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local parent_dir=$(dirname ${dir})
    local config_root=$(dirname ${parent_dir})

    source "$config_root/utils.sh"
    source "$config_root/colorful.sh"
    source "$config_root/terminal/functions.sh"

    install \
        && install_vundle \
        && config \
        && install_plugin \
        && build_ycm
}

main $@
