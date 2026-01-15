# SPDX-FileCopyrightText: 2026 Michael Cummings
# SPDX-License-Identifier: MIT

function __wttr_cache_dir --description "Get weather-fish cache directory"
    set -l root (set -q XDG_CACHE_HOME; and echo $XDG_CACHE_HOME; or echo ~/.cache)
    echo $root/wttr
end
