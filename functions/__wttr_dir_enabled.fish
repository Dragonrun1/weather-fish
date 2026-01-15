# SPDX-FileCopyrightText: 2026 Michael Cummings
# SPDX-License-Identifier: MIT

function __wttr_dir_enabled --description "Return success if weather enabled here"
    set -l dir $PWD

    while test -n "$dir"
        if test -f "$dir/.weather-fish-disable"
            return 1
        end
        test "$dir" = "/"; and break
        set dir (path dirname $dir)
    end

    return 0
end

