#!/usr/bin/env bash

show_ret_value() {
    echo "$?"
}

echo_err() {
    echo "$@" >&2
}

has_cmd() {
    local command=$1
    hash "$command" 2>/dev/null
}

get_os() {
    case "$OSTYPE" in
      solaris*) echo "SOLARIS" ;;
      darwin*)  echo "OSX" ;;
      linux*)   echo "LINUX" ;;
      bsd*)     echo "BSD" ;;
      msys*)    echo "WINDOWS" ;;
      *)        echo "unknown: $OSTYPE" ;;
    esac
}

is_linux() {
    [[ $(get_os) = 'LINUX' ]]
}

is_osx() {
    [[ $(get_os) = 'OSX' ]]
}

if is_linux; then
    apt_status() {
        dpkg -s $1
    }

    apt_has_installed() {
        dpkg -s $1 &>/dev/null
    }

    apt_search_name() {
        apt search --names-only $1
    }

    apt_search_name_begin() {
        apt_search_name ^$1
    }
fi

get_external_ip() {
    echo $(dig +short myip.opendns.com @resolver1.opendns.com)
}

get_github_latest_release_version() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}

#######################################
# TODO: support more package manager other than apt
# Arguments:
#   $1: package name
# Returns:
#   0: package has already installed
#   1: package has not installed
#   else: result is unknown
#######################################
has_installed() {
    if is_linux; then
        apt_has_installed $1
        return $?
    else
        echo_err "failed to detect package manager"
        return 2
    fi
}
