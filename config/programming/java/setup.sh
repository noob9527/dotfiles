#!/usr/bin/env bash

install() {
    local target='jdk'
    if has_cmd 'javac'; then
        colorful::default "$target has already been installed"
        return 0
    fi

    colorful::primary "I am trying to install $target..."

    if ! has_cmd 'apt-get'; then
        err "I have not known how to install $target yet, you have to install it manually!"
        return 1
    fi

    if ! confirm_install 'default-jdk' 'apt-get'; then
        err "Installation has been cancelled"
        return 0
    fi

    sudo apt-get install 'default-jdk' 'openjdk-8-source'
    return $?
}

config_java_home() {
    local target='JAVA_HOME'

    if [[ -n $JAVA_HOME ]]; then
        colorful::default "$target has already been configured"
        return 0
    fi

    if ! confirm "$(colorful::primary "Are you going to configure $target?")"; then
        err "configure has been cancelled"
        return 0
    fi

    if ! has_cmd 'jrunscript'; then
        err "I don't know how to find current $target"
        return 1
    fi

    local jre_dir=$(jrunscript -e 'java.lang.System.out.println(java.lang.System.getProperty("java.home"));')

    if [[ $? != 0 ]] ; then
        err "fail to find the current $target"
        return 1
    fi
    if [[ -z $jre_dir ]]; then
        err "fail to find the current $target"
        return 1
    fi

    # local java_dir=$(dirname ${jre_dir})
    local java_dir=$jre_dir

    echo "export JAVA_HOME=$java_dir" | sudo tee /etc/profile.d/java.sh
}

main() {
    local dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local parent_dir=$(dirname ${dir})
    local config_root=$(dirname ${parent_dir})

    source "$config_root/utils.sh"
    source "$config_root/colorful.sh"
    source "$config_root/terminal/functions.sh"

    install && config_java_home
}

main $@
