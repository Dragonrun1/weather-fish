# SPDX-FileCopyrightText: 2026 Michael Cummings
# SPDX-License-Identifier: MIT

function _tide_item_wttr --description "Tide weather item"
    # Call the weather-fish command to get the cached weather string
    set -l weather (wttr)

    # Only display if we actually have weather data
    if test -n "$weather"
        _tide_print_item wttr " $weather "
    end
end
