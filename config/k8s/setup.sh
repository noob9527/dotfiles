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

    if ! confirm_install "$target" 'apt-get'; then
        err "Installation has been cancelled"
        return 2
    fi

    # install kubectl in linux
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
    sudo apt update && sudo apt install -y kubectl
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
        return 2
    fi

    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
        && sudo install minikube-linux-amd64 /usr/local/bin/minikube
}

main() {
    local dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local parent_dir=$(dirname ${dir})

    source "$parent_dir/utils.sh"
    source "$parent_dir/colorful.sh"
    source "$parent_dir/shells/functions.sh"

    install_kubectl && install_minikube
}

main $@
