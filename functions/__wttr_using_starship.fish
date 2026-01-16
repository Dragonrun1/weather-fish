# SPDX-FileCopyrightText: 2026 Michael Cummings
# SPDX-License-Identifier: MIT

function __wttr_using_starship
    set -q STARSHIP_SHELL; or return 1
    command -sq starship; or return 1
end
