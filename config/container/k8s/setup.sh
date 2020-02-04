#!/usr/bin/env bash

install_kubectl() {
    local target='kubectl'
    if has_cmd ${target}; then
        colorful::default "$target has already been installed"
        return 0
    fi

    colorful::primary "I am trying to install $target..."

    if ! has_cmd apt-get; then
        err "I have not known how to install $target yet, you have to install it manually!"
        return 1
    fi

    if  confirm_install "$target" 'snap'; then
        sudo snap install kubectl --classic
    else
        err "Installation has been cancelled"
        return 0
    fi

    # if  confirm_install "$target" 'apt-get'; then
    #     # install kubectl in linux
    #     curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
    #     echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
    #     sudo apt update && sudo apt install -y kubectl
    # else
    #     err "Installation has been cancelled"
    #     return 0
    # fi

}

install_virtualbox() {
    local target='virtualbox'
    if has_cmd ${target}; then
        colorful::default "$target has already been installed"
        return 0
    fi

    colorful::primary "I am trying to install $target..."

    if has_cmd 'apt-get'; then
        # maybe we also want virtualbox-ext-pack here
        package_manager_install ${target} 'apt-get'
        return $?
    else
        err "I have not known how to install $target yet, you have to install it manually!"
        return 1
    fi
}

install_minikube() {
    local target='minikube'
    if has_cmd ${target}; then
        colorful::default "$target has already been installed"
        return 0
    fi

    colorful::primary "I am trying to install $target..."

    if ! is_linux; then
        err "I have not known how to install $target yet, you have to install it manually!"
        return 1
    fi

    if ! confirm_install "$target" 'curl'; then
        err "Installation has been cancelled"
        return 0
    fi

    local tmp="$(mktemp)"

    curl -Lo $tmp https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
        && sudo install $tmp /usr/local/bin/$target
}

main() {
    local dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local parent_dir=$(dirname ${dir})
    local config_root=$(dirname ${parent_dir})

    source "$config_root/utils.sh"
    source "$config_root/colorful.sh"
    source "$config_root/terminal/functions.sh"

    install_kubectl \
        && install_virtualbox \
        && install_minikube
}

main $@
