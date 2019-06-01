#!/usr/bin/env bash

proxy_snap() {
    if ! has_cmd 'snap'; then
        err "snap doesn't in the path variable, cannot set snap proxy"
        return 1
    fi

    if ! confirm "$(colorful::primary "Are you going to set snap proxy variable")"; then
        colorful::default "configure has been cancelled"
        return 0
    fi

    local http_proxy='socks5://127.0.0.1:1080'

    sudo snap set system proxy.http="$http_proxy" \
        && sudo snap set system proxy.https="$http_proxy"

    if [[ $? -eq 0 ]]; then
        colorful::success "snap proxy has been set to $http_proxy"
        colorful::default "you can verify it by type: sudo snap get system proxy"
    fi
}

main() {
    local dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local parent_dir=$(dirname ${dir})

    source "$parent_dir/utils.sh"
    source "$parent_dir/colorful.sh"
    source "$parent_dir/terminal/functions.sh"

    local fn=$1
    ${fn}
}

main "$@"
