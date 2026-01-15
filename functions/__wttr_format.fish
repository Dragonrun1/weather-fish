# SPDX-FileCopyrightText: 2026 Michael Cummings
# SPDX-License-Identifier: MIT

function __wttr_format --description "Resolve wttr.in format"
#Examples:
#    > set -e WTTR_PRESET
#    > set -e WTTR_FORMAT
#    > __wttr_format
#    %c%t
#
#    > set -g WTTR_PRESET compact
#    > __wttr_format
#    %c %t
#
#    > set -g WTTR_PRESET full
#    > __wttr_format
#    %l: %c %t %h %w
#
#    > set -e WTTR_PRESET
#    > set -g WTTR_FORMAT "%t"
#    > __wttr_format
#    %t
    if set -q WTTR_PRESET
        switch $WTTR_PRESET
            case compact
                echo "%c %t"
            case icon
                echo "%c"
            case temp
                echo "%t"
            case full
                echo "%l: %c %t %h %w"
            case '*'
                echo "%c%t"
        end
        return
    end

    set -q WTTR_FORMAT; and echo $WTTR_FORMAT; or echo "%c%t"
end

