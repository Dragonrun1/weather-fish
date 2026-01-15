# Initialize prompt integration
__wttr_left_wrap

# Update weather opportunistically after prompt render
function __weather_fish_prompt_hook --on-event fish_prompt
    __wttr_fetch
end
