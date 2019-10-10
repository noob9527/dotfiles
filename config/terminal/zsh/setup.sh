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

install_zsh_autosuggestions() {
    local target='zsh-autosuggestions'
    local target_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/$target"

    if [[ -d "$target_dir" ]]; then
        colorful::default "$target has already been installed"
        return 0
    fi
    colorful::primary "I am trying to install $target..."
    git clone https://github.com/zsh-users/zsh-autosuggestions $target_dir
    return 0
}

install_you_should_use() {
    local target='you-should-use'
    local target_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/$target"

    if [[ -d "$target_dir" ]]; then
        colorful::default "$target has already been installed"
        return 0
    fi
    colorful::primary "I am trying to install $target..."
    git clone https://github.com/MichaelAquilina/zsh-you-should-use.git $target_dir
    return 0
}

config() {
    colorful::primary "I am trying to configure zsh..."

    ln -s -i "$dir/zshrc" "$HOME/.zshrc" \
        && colorful::success ".zshrc have been set up"

    local zsh=$(which zsh)

    if [[ $SHELL = $zsh ]]; then
        colorful::default "$target is already the default shell"
        return 0
    fi

    # Actually change the default shell to zsh
    if ! chsh -s "$zsh"; then
        err "chsh command unsuccessful. Change your default shell manually."
    else
        export SHELL="$zsh"
        colorful::success "Shell successfully changed to '$zsh'.${RESET}"
    fi

    return $?
}

main() {
    local dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local parent_dir=$(dirname ${dir})
    local config_root=$(dirname ${parent_dir})

    source "$config_root/utils.sh"
    source "$config_root/colorful.sh"
    source "$config_root/terminal/functions.sh"

    local fn=$1
    ${fn}
}

main $@
