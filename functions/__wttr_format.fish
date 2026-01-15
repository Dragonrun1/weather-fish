function __wttr_format --description "Resolve wttr.in format"
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

