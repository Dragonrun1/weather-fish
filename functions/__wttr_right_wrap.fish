# SPDX-FileCopyrightText: 2026 Michael Cummings
# SPDX-License-Identifier: MIT

function __wttr_right_wrap
    # skip transient prompt re‑rendering
    if test "$fish_transient_prompt" = "1"
        return
    end

    functions -q __fish_right_prompt_orig; and return

    if functions -q fish_right_prompt
        functions -c fish_right_prompt __fish_right_prompt_orig
    else
        function __fish_right_prompt_orig
            # no-op
        end
    end

    function fish_right_prompt
        __fish_right_prompt_orig
        __wttr_dir_enabled; and begin
            set -l w (wttr)
            test -n "$w"; and echo -n "$w"
        end
    end
end
