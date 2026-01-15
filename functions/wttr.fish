# SPDX-FileCopyrightText: 2026 Michael Cummings
# SPDX-License-Identifier: MIT

function wttr --description "Print cached weather"
    set -l file (set -q XDG_CACHE_HOME; and echo $XDG_CACHE_HOME; or echo ~/.cache)/wttr/data
    test -f $file; or return

    set -l data (cat $file)

    if set -q WTTR_COLOR
        # If WTTR_COLOR is a valid color, use it. Otherwise default to cyan.
        set -l color cyan
        if test -n "$WTTR_COLOR"; and not test "$WTTR_COLOR" = 1
            set color $WTTR_COLOR
        end

        set_color (string split " " -- $color)
        echo -n $data
        set_color normal
    else
        echo -n $data
    end
end

