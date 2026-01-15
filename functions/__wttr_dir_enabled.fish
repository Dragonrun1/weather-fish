function __wttr_dir_enabled --description "Return success if weather enabled here"
    set -l dir (pwd)

    while test "$dir" != /
        if test -f "$dir/.weather-fish-disable"
            return 1
        end
        set dir (path dirname $dir)
    end

    return 0
end

