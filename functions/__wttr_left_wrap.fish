# SPDX-FileCopyrightText: 2026 Michael Cummings
# SPDX-License-Identifier: MIT

function __wttr_left_wrap
    # skip transient prompt re‑rendering
    if test "$fish_transient_prompt" = "1"
        return
    end

    functions -q __fish_prompt_orig; and return
    functions -c fish_prompt __fish_prompt_orig

    function fish_prompt
        if test "$fish_transient_prompt" = "1"
            __fish_prompt_orig
            return
        end

        __wttr_dir_enabled; and begin
            set -l w (wttr)
            test -n "$w"; and echo -n "$w"
        end
        __fish_prompt_orig
    end
end
