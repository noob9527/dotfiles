#!/usr/bin/env bash

install_ss_qt5_legacy() {
    local target='shadowsocks-qt5'

    if has_installed ${target}; then
        colorful::default "$target has already been installed"
        return 0
    fi

    colorful::primary "I am trying to install $target..."

    if ! has_cmd apt-get; then
        err "I have not known how to install $target yet, you have to install it manually!"
        return 1
    fi

    if ! confirm_install "$target" 'apt-get'; then
        colorful::default "Installation has been cancelled"
        return 0
    fi

    sudo add-apt-repository ppa:hzwhuang/ss-qt5 \
      && sudo apt-get update \
      && sudo apt-get install shadowsocks-qt5

    return $?
}

install_ss_qt5() {
    local target='ss-qt5'

    if has_cmd ${target}; then
        colorful::default "$target has already been installed"
        return 0
    fi

    if ! confirm_install "$target" 'curl'; then
        colorful::default "Installation has been cancelled"
        return 0
    fi

    colorful::primary "I am trying to install $target..."

    local tmp="$(mktemp)"
    local RELEASE_ASSERTS_URL="$(wget -qO- -T10 --tries=10 --retry-connrefused https://api.github.com/repos/shadowsocks/shadowsocks-qt5/releases/latest | grep browser_download_url | cut -d '"' -f 4)"

    echo "start to download AppImage from: ${RELEASE_ASSERTS_URL}, please waiting..."

    curl -Lo $tmp ${RELEASE_ASSERTS_URL} \
        && sudo install $tmp /usr/bin/$target
    return $?
}

install_shadowsocks_client() {
    local target='shadowsocks-client'

    if is_linux; then
        install_ss_qt5
        return $?
    else
        err "I have not known how to install $target yet, you have to install it manually!"
        return 1
    fi
}

add_desktop_entry() {
    if [[ -e '/usr/share/applications/shadowsocks-qt5.desktop' ]]; then
        colorful::default 'desktop entry has already existed'
        return 0
    fi

    colorful::primary "I am trying to add a shadowsocks desktop entry..."
    sudo cp -i "$dir/shadowsocks-qt5.desktop" "/usr/share/applications/shadowsocks-qt5.desktop"
}

autostart() {
    if [[ -e "$HOME/.config/autostart/shadowsocks-qt5.desktop" ]]; then
        colorful::default 'autostart entry has already existed'
        return 0
    fi

    colorful::primary "I am trying to autostart ss-qt5..."
    mkdir -p "$HOME/.config/autostart/"
    cp -i "$dir/autostart-shadowsocks-qt5.desktop" "$HOME/.config/autostart/shadowsocks-qt5.desktop"
}

main() {
    local dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local parent_dir=$(dirname ${dir})
    local config_root=$(dirname ${parent_dir})

    source "$config_root/utils.sh"
    source "$config_root/colorful.sh"
    source "$config_root/terminal/functions.sh"

    # as the new version doesn't show icon correctly
    # we use the legacy version for the time being
    install_ss_qt5_legacy
    # sudo gedit /etc/apt/sources.list.d/hzwhuang-ubuntu-ss-qt5-bionic.list
    # 
    # 修改後內容為：
    # 
    # deb http://ppa.launchpad.net/hzwhuang/ss-qt5/ubuntu xenial main
    # # deb-src http://ppa.launchpad.net/hzwhuang/ss-qt5/ubuntu xenial main


    # install_shadowsocks_client \
    #     && add_desktop_entry \
    #     && autostart
}

main $@
