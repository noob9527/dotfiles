#!/usr/bin/env bash

# install docker
# install docker-compose
# config docker to use alibaba mirror

install() {
    local target='docker'
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

    # install docker-ce in linux
    sudo apt-get remove docker docker-engine docker.io containerd runc &&\
    sudo apt-get install -y \
        apt-transport-https \
        ca-certificates \
        gnupg-agent \
        software-properties-common &&\
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - &&\
    sudo add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) \
       stable" &&\
    sudo apt-get update &&\
    sudo apt-get install docker-ce docker-ce-cli containerd.io -y &&\
    sudo docker run hello-world &&\
    sudo usermod -aG docker $USER
}

install_docker_compose() {
    local target='docker-compose'
    if has_cmd ${target}; then
        colorful::default "$target has already been installed"
        return 0
    fi

    colorful::primary "I am trying to install $target..."

    local latest_version=$(get_github_latest_release_version docker/compose)
    if [[ -z latest_version ]]; then
        err "Unable to get the latest version of $target"
        return 1
    fi

    sudo curl -L "https://github.com/docker/compose/releases/download/${latest_version}/docker-compose-$(uname -s)-$(uname -m)" \
        -o /usr/local/bin/docker-compose \
        && sudo chmod +x /usr/local/bin/docker-compose
}

config_daemon_json() {
    colorful::primary "I am trying to overwrite daemon.json(to use alibaba mirror)..."
    sudo ln -s -i "$dir/daemon.json" "/etc/docker/daemon.json"
}

main() {
    local dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local parent_dir=$(dirname ${dir})
    local config_root=$(dirname ${parent_dir})

    source "$config_root/utils.sh"
    source "$config_root/colorful.sh"
    source "$config_root/terminal/functions.sh"

    install && config_daemon_json && install_docker_compose
}

main $@
