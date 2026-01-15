# SPDX-FileCopyrightText: 2026 Michael Cummings
# SPDX-License-Identifier: MIT

function fish_right_prompt
    set -q WTTR_DISABLE_STARSHIP; and type -q starship; or \
    set -q WTTR_DISABLE_TIDE; and set -q _tide_prompt_version; or return

    __wttr_dir_enabled; or return
    wttr
end
