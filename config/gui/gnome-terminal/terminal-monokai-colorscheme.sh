#!/usr/bin/env bash

# ====================CONFIG THIS =============================== #
PROFILE_NAME="monokai"
PROFILE_SLUG="monokai"
COLOR_01="#75715e"           # HOST
COLOR_02="#f92672"           # SYNTAX_STRING
COLOR_03="#a6e22e"           # COMMAND
COLOR_04="#f4bf75"           # COMMAND_COLOR2
COLOR_05="#66d9ef"           # PATH
COLOR_06="#ae81ff"           # SYNTAX_VAR
COLOR_07="#2AA198"           # PROMP
COLOR_08="#f9f8f5"           #

COLOR_09="#5f5f5f"           #
COLOR_10="#f92672"           # COMMAND_ERROR
COLOR_11="#a6e22e"           # EXEC
COLOR_12="#f4bf75"           #
COLOR_13="#66d9ef"           # FOLDER
COLOR_14="#ae81ff"           #
COLOR_15="#2AA198"           #
COLOR_16="#f8f8f2"           #

BACKGROUND_COLOR="#121212"   # Background Color
FOREGROUND_COLOR="#f8f8f2"   # Text
CURSOR_COLOR="$FOREGROUND_COLOR" # Cursor
# =============================================================== #

main() {
    local dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local parent_dir=$(dirname ${dir})

    source "$parent_dir/../utils.sh"
    source "$parent_dir/../colorful.sh"

    source "$dir/apply-colors.sh"
}

main $@
