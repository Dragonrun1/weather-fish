# SPDX-FileCopyrightText: 2026 Michael Cummings
# SPDX-License-Identifier: MIT

function __wttr_load_config --description "Load configuration from file"
    set -l __wttr_config_file (set -q XDG_CONFIG_HOME; and echo $XDG_CONFIG_HOME; or echo ~/.config)/weather-fish/config.fish
    if test -f "$__wttr_config_file"
        source "$__wttr_config_file"
    end
end
