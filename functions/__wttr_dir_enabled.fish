# SPDX-FileCopyrightText: 2026 Michael Cummings
# SPDX-License-Identifier: MIT

function __wttr_dir_enabled --description "Return success if weather enabled here"
#Examples:
#    > set -l tmpdir (mktemp -d)
#    > cd $tmpdir
#    > __wttr_dir_enabled; and echo yes; or echo no
#    yes
#    > touch .weather-fish-disable
#    > __wttr_dir_enabled; and echo yes; or echo no
#    no
#    > mkdir sub
#    > cd sub
#    > __wttr_dir_enabled; and echo yes; or echo no
#    no
#    > cd $tmpdir
#    > rm -rf $tmpdir
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

