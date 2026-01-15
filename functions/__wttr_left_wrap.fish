function __wttr_left_wrap
    if functions -q __fish_prompt_orig
        return
    end

    functions -c fish_prompt __fish_prompt_orig

    function fish_prompt
        set -l weather (wttr)
        if test -n "$weather"
            echo -n "$weather "
        end
        __fish_prompt_orig
    end
end
