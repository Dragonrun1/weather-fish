# Enable left prompt wrapping
__wttr_left_wrap

# Update weather opportunistically
function __wttr_prompt_hook --on-event fish_prompt
    __wttr_fetch
end
