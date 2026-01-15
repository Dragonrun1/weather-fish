function __wttr_left_wrap
    functions -q __fish_prompt_orig; and return
    functions -c fish_prompt __fish_prompt_orig

    function fish_prompt
        __wttr_dir_enabled; and begin
            set -l w (wttr)
            test -n "$w"; and echo -n "$w "
        end
        __fish_prompt_orig
    end
end
