# SPDX-FileCopyrightText: 2026 Michael Cummings
# SPDX-License-Identifier: MIT

function wttr-fetch --description "Force a weather fetch and display the result"
    argparse v/verbose -- $argv
    or return

    set -l root (set -q XDG_CACHE_HOME; and echo $XDG_CACHE_HOME; or echo ~/.cache)
    set -l meta $root/wttr/meta

    # Reload configuration to pick up any changes
    __wttr_load_config

    if set -q _flag_verbose
        echo "Removing metadata: $meta"
    end

    # Force bypass by removing metadata
    rm -f $meta

    # Perform the fetch
    if set -q _flag_verbose
        __wttr_fetch --verbose
    else
        __wttr_fetch
    end

    # Display the result
    wttr
    echo "" # Add newline for interactive use
end
