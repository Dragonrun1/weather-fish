# SPDX-FileCopyrightText: 2026 Michael Cummings
# SPDX-License-Identifier: MIT

function __wttr_render_core --description "Render weather text (plain)"
    set -l location $WTTR_DEFAULT_LOCATION
    set -l fmt $WTTR_FORMAT

    __wttr_fetch_if_needed; or return

    if test -f $WTTR_CACHE_FILE
        cat $WTTR_CACHE_FILE
    end
end
