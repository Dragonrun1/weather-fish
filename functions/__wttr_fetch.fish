function __wttr_fetch --description "Fetch wttr.in with TTL + backoff"
    set -l ttl 900
    set -l backoff 1800
    set -l now (date +%s)

    set -l cache_dir (set -q XDG_CACHE_HOME; and echo $XDG_CACHE_HOME; or echo ~/.cache)/wttr
    set -l data_file $cache_dir/data
    set -l meta_file $cache_dir/meta

    mkdir -p $cache_dir

    if test -f $meta_file
        read -l last_fetch slow_until < $meta_file
        if test $now -lt $slow_until
            return
        end
        if test (math $now - $last_fetch) -lt $ttl
            return
        end
    end

    set -l url "https://wttr.in?format=%c%t"
    set -q WTTR_DEFAULT_LOCATION; and \
        set url "https://wttr.in/$WTTR_DEFAULT_LOCATION?format=%c%t"

    if not type -q curl
        return
    end

    set -l result (curl -fsS --max-time 2 $url ^/dev/null)
    if test $status -ne 0 -o -z "$result"
        echo "$last_fetch"(printf " %s" (math $now + $backoff)) > $meta_file
        return
    end

    echo $result > $data_file
    echo "$now 0" > $meta_file
end
