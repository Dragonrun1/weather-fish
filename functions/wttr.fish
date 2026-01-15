# SPDX-FileCopyrightText: 2026 Michael Cummings
# SPDX-License-Identifier: MIT

function wttr --description "Print cached weather"
    set -l dir (__wttr_cache_dir)
    set -l file $dir/data
    test -f $file; or return

    set -l data (cat $file)

    if set -q WTTR_COLOR; and test "$WTTR_COLOR" != 0
        # If WTTR_COLOR is a valid color, use it. Otherwise default to cyan.
        set -l color cyan
        if test -n "$WTTR_COLOR" -a "$WTTR_COLOR" != 1
            set color $WTTR_COLOR
        end

        set_color (string split " " -- $color)
        echo -n $data
        set_color normal
    else
        echo -n $data
    end
end

