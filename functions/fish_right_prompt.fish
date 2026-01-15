# SPDX-FileCopyrightText: 2026 Michael Cummings
# SPDX-License-Identifier: MIT

function fish_right_prompt
    if test "$WTTR_DISABLE_STARSHIP" = 0; and type -q starship
        return
    else if test "$WTTR_DISABLE_TIDE" = 0; and type -q tide
        return
    end

    if type -q starship; or type -q tide
        __wttr_dir_enabled; or return
        wttr
    end
end
