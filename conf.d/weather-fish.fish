# SPDX-FileCopyrightText: 2026 Michael Cummings
# SPDX-License-Identifier: MIT

# ---- defaults -------------------------------------------------------------
set -q WTTR_DISABLE_SSH;        or set -g WTTR_DISABLE_SSH 1
set -q WTTR_DISABLE_STARSHIP;  or set -g WTTR_DISABLE_STARSHIP 1
set -q WTTR_DISABLE_TIDE;       or set -g WTTR_DISABLE_TIDE 1

# left prompt only if safe
if not type -q starship; and not set -q _tide_prompt_version
    __wttr_left_wrap
end

# Update weather opportunistically after prompt render
function __weather_fish_prompt_hook --on-event fish_prompt
    __wttr_fetch
end
