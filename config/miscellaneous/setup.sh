#!/usr/bin/env bash

# ideavim
# gnome keybindings
# inotify
# vm.max_map_count

config_inotify() {
    local target="/etc/sysctl.d/10-inotify.conf"
    if [[ -f "$target"  ]]; then
        echo "$target exists"
        return 0
    fi
    sudo cp -i "$dir/inotify.conf" $target \
        && sudo sysctl -p --system \
        && colorful::success "$target have been set up"
}

config_vm_max_map_count() {
    local target="/etc/sysctl.d/10-vm_max_map_count.conf"
    if [[ -f "$target"  ]]; then
        echo "$target exists"
        return 0
    fi
    sudo cp -i "$dir/vm_max_map_count.conf" $target \
        && sudo sysctl -p --system \
        && colorful::success "$target have been set up"
}

config_ideavim() {
    local target='ideavim'
    colorful::primary "I am trying to configure $target..."
    ln -s -i "$dir/ideavimrc" "$HOME/.ideavimrc" \
        && colorful::success ".ideavimrc have been set up"
}

load_keybinding() {
    local target="$dir/keybindings.dconf"
    dconf load /org/gnome/desktop/wm/keybindings/ < $target
}

dump_keybinding() {
    local target="$dir/keybindings.dconf"
    dconf dump /org/gnome/desktop/wm/keybindings/ > $target
}

main() {
    local dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local parent_dir=$(dirname ${dir})

    source "$parent_dir/utils.sh"
    source "$parent_dir/colorful.sh"
    source "$parent_dir/terminal/functions.sh"

    local fn="$1"
    ${fn}
}

main "$@"
