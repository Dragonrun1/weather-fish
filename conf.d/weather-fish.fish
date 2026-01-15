# SPDX-FileCopyrightText: 2026 Michael Cummings
# SPDX-License-Identifier: MIT

# Load configuration from file first
__wttr_load_config

# ---- defaults -------------------------------------------------------------
set -q WTTR_DISABLE_SSH;        or set -g WTTR_DISABLE_SSH 1
set -q WTTR_DISABLE_STARSHIP;  or set -g WTTR_DISABLE_STARSHIP 0
set -q WTTR_DISABLE_TIDE;       or set -g WTTR_DISABLE_TIDE 0

# caching and timeouts
set -q WTTR_CACHE_TTL;          or set -g WTTR_CACHE_TTL 900
set -q WTTR_BACKOFF;            or set -g WTTR_BACKOFF 1800
set -q WTTR_TIMEOUT;            or set -g WTTR_TIMEOUT 30

# prompt side (left or right)
set -q WTTR_PROMPT_SIDE;        or set -g WTTR_PROMPT_SIDE left

# left/right prompt wrap (except for Tide which has its own integration)
if not type -q tide
    set -l enabled 1
    if type -q starship; and test "$WTTR_DISABLE_STARSHIP" = 1
        set enabled 0
    end

    if test "$enabled" = 1
        switch $WTTR_PROMPT_SIDE
            case right
                __wttr_right_wrap
            case '*'
                __wttr_left_wrap
        end
    end
end

# Tide integration
if type -q tide
    if not contains wttr $tide_left_prompt_items; and not contains wttr $tide_right_prompt_items
        switch $WTTR_PROMPT_SIDE
            case right
                set -gp tide_right_prompt_items wttr
            case '*'
                set -gp tide_left_prompt_items wttr
        end
    end
end

# Update weather opportunistically after prompt render
function __weather_fish_prompt_hook --on-event fish_prompt
    __wttr_fetch
end
