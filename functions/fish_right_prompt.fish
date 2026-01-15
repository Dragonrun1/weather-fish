# SPDX-FileCopyrightText: 2026 Michael Cummings
# SPDX-License-Identifier: MIT

function fish_right_prompt
    # Early return if explicitly handled by integration
    if test "$WTTR_DISABLE_STARSHIP" = 0; and type -q starship
        return
    else if test "$WTTR_DISABLE_TIDE" = 0; and type -q tide
        return
    end

    # Early return if already wrapped (for plain Fish or enabled Starship)
    if functions -q __fish_prompt_orig; or functions -q __fish_right_prompt_orig
        return
    end

    # Only display if enabled in this directory
    __wttr_dir_enabled; or return

    if type -q tide
        # Only use right prompt fallback if wttr is not in tide items
        if not contains wttr $tide_left_prompt_items; and not contains wttr $tide_right_prompt_items
            wttr
        end
        return
    end

    # Fallback for Fish and Starship
    wttr
end
