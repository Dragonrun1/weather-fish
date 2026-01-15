function wttr --description "Print cached weather"
    set -l file (set -q XDG_CACHE_HOME; and echo $XDG_CACHE_HOME; or echo ~/.cache)/wttr/data
    test -f $file; and cat $file
end
