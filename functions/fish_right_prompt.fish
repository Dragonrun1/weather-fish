# SPDX-FileCopyrightText: 2026 Michael Cummings
# SPDX-License-Identifier: MIT

function fish_right_prompt
    if test "$WTTR_DISABLE_STARSHIP" = 0; and type -q starship
        return
    else if test "$WTTR_DISABLE_TIDE" = 0; and type -q tide
        return
    end

    if type -q starship
        __wttr_dir_enabled; or return
        wttr
    else if type -q tide
        # Only use right prompt fallback if wttr is not in tide items
        if not contains wttr $tide_left_prompt_items; and not contains wttr $tide_right_prompt_items
            __wttr_dir_enabled; or return
            wttr
        end
    end
end
