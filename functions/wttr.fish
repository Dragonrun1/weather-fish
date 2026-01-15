# SPDX-FileCopyrightText: 2026 Michael Cummings
# SPDX-License-Identifier: MIT

function wttr --description "Print cached weather"
    set -l file (set -q XDG_CACHE_HOME; and echo $XDG_CACHE_HOME; or echo ~/.cache)/wttr/data
    test -f $file; or return

    set -l data (cat $file)

    if set -q WTTR_COLOR
        set_color cyan
        echo -n $data
        set_color normal
    else
        echo -n $data
    end
end

