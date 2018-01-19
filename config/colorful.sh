#!/usr/bin/env bash

COLOR_RESET='\033[0m'
COLOR_BLUE='\033[94m'
COLOR_GREEN='\033[92m'
COLOR_YELLOW='\033[93m'
COLOR_MAGENTA='\033[95m'
COLOR_RED='\033[91m'

#$1: msg
#$2: color
colorful::print() {
  local msg="$1"
  local color=${2-${COLOR_RESET}}
  echo -e "${color}$msg${COLOR_RESET}"
}

#$1: msg
colorful::default() {
  colorful::print "$1" ${COLOR_RESET}
}

#$1: msg
colorful::primary() {
  colorful::print "$1" ${COLOR_BLUE}
}

#$1: msg
colorful::success() {
  colorful::print "$1" ${COLOR_GREEN}
}

#$1: msg
colorful::warning() {
  colorful::print "$1" ${COLOR_YELLOW}
}

#$1: msg
colorful::error() {
  colorful::print "$1" ${COLOR_RED}
}

