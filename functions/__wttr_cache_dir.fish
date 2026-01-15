# SPDX-FileCopyrightText: 2026 Michael Cummings
# SPDX-License-Identifier: MIT

function __wttr_cache_dir --description "Get weather-fish cache directory"
#Examples:
#    > set -e XDG_CACHE_HOME
#    > set -l home_orig $HOME
#    > set -g HOME /tmp/fakehome
#    > __wttr_cache_dir
#    /tmp/fakehome/.cache/wttr
#    > set -g HOME $home_orig
#
#    > set -g XDG_CACHE_HOME /tmp/xdg
#    > __wttr_cache_dir
#    /tmp/xdg/wttr
#    > set -e XDG_CACHE_HOME
    set -l root (set -q XDG_CACHE_HOME; and echo $XDG_CACHE_HOME; or echo ~/.cache)
    echo $root/wttr
end
