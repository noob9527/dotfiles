#!/usr/bin/env bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$DIR/colorful.sh"

join_by() {
    local IFS="$1";
    shift;
    echo "$*";
}

err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
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

confirm() {
    local prompt="$1"
    local input

    read -p "$prompt [y/n]: " input
    case ${input} in
        [yY]*)
            return 0
        ;;
        [nN]*)
            return 1
        ;;
        *)
            return 2
        ;;
    esac
}

# $1: package
# $2: package_manager
confirm_install() {
    local package=$1
    local pm=$2
    confirm "$(colorful::primary "Are you going to install '$package'${pm+" via '$pm'"}?")"
}

#######################################
# Arguments:
#   $1: package
#   $2: package_manager (if not present, use apt or brew)
# Returns:
#   0: install successful
#   1: install failure
#   2: install cancelled
#   else: install fail or not perform install action
#######################################
package_manager_install() {
    local package=$1
    local pm=$2

    if [[ -n ${pm} ]]; then
        # if use apt-get, add -y paramter
        if [[ pm = 'apt-get' ]]; then
            if confirm_install ${package} ${pm}; then
                sudo ${pm} install ${package} -y
                return $?
            else
                return 2
            fi
        else
            if confirm_install ${package} ${pm}; then
                sudo ${pm} install ${package}
                return $?
            else
                return 2
            fi
        fi
    fi

    if has_cmd 'apt-get'; then
        package_manager_install "$package" 'apt-get'
        return $?
    elif has_cmd 'brew'; then
        package_manager_install "$package" 'brew'
        return $?
    else
        err "I have not known how to install $package yet, seems like you have to install it manually!"
        return 1
    fi
}

