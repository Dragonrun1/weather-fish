# SPDX-FileCopyrightText: 2026 Michael Cummings
# SPDX-License-Identifier: MIT

function __wttr_render_fish --description "Render weather for Fish prompt"
    set -l text (__wttr_render_core)
    test -n "$text"; or return

    set -l color normal
    if set -q WTTR_COLOR; and test "$WTTR_COLOR" != 1
        if set_color -c $WTTR_COLOR >/dev/null 2>&1
            set color $WTTR_COLOR
        end
    end

    set_color $color
    printf "%s" $text
    set_color normal
end
