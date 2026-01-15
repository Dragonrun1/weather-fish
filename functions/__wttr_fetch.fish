# SPDX-FileCopyrightText: 2026 Michael Cummings
# SPDX-License-Identifier: MIT

function __wttr_fetch --description "Fetch wttr.in with TTL, guards, presets"
    argparse v/verbose -- $argv
    or return

    # ---- guards ------------------------------------------------------------
    if test "$WTTR_DISABLE_SSH" = 1; and set -q SSH_CONNECTION
        set -q _flag_verbose; and echo "WTTR disabled due to SSH"
        return
    end
    if test "$WTTR_DISABLE_STARSHIP" = 1; and type -q starship
        set -q _flag_verbose; and echo "WTTR disabled due to starship"
        return
    end
    if test "$WTTR_DISABLE_TIDE" = 1; and type -q tide
        set -q _flag_verbose; and echo "WTTR disabled due to tide"
        return
    end

    if not __wttr_dir_enabled
        set -q _flag_verbose; and echo "WTTR disabled in this directory"
        return
    end
    if not type -q curl
        set -q _flag_verbose; and echo "curl not found"
        return
    end

    # ---- constants ---------------------------------------------------------
    set -l ttl $WTTR_CACHE_TTL
    set -l backoff $WTTR_BACKOFF
    set -l timeout $WTTR_TIMEOUT
    set -l now (date +%s)

    if set -q _flag_verbose
        echo "__wttr_fetch called"
    end

    # ---- cache -------------------------------------------------------------
    set -l root (set -q XDG_CACHE_HOME; and echo $XDG_CACHE_HOME; or echo ~/.cache)
    set -l dir $root/wttr
    set -l data $dir/data
    set -l meta $dir/meta
    mkdir -p $dir

    if test -f $meta
        read -l last slow_until < $meta
        test -n "$slow_until"; or set slow_until 0
        test -n "$last"; or set last 0

        string match -qr '^[0-9]+$' "$slow_until"; or set slow_until 0
        string match -qr '^[0-9]+$' "$last"; or set last 0

        if test $now -lt $slow_until
            if set -q _flag_verbose
                echo "Backing off until $slow_until (now: $now)"
            end
            return
        end
        if test (math $now - $last) -lt $ttl
            if set -q _flag_verbose
                echo "Cache still valid (last fetch: $last, ttl: $ttl, now: $now)"
            end
            return
        end
    end

    # ---- url ---------------------------------------------------------------
    set -l format (__wttr_format)
    set -l query "format=$format"

    if set -q WTTR_UNITS
        set query "$query&$WTTR_UNITS"
    end

    if set -q WTTR_LANGUAGE
        set query "$query&lang=$WTTR_LANGUAGE"
    end

    set -l url "https://wttr.in?$query"
    if set -q WTTR_DEFAULT_LOCATION
        set -l location (string replace -a ' ' '+' "$WTTR_DEFAULT_LOCATION")
        set url "https://wttr.in/$location?$query"
    end

    if set -q _flag_verbose
        echo "Fetching URL: $url"
    end

    # ---- fetch -------------------------------------------------------------
    set -l curl_opts -fsS --max-time $timeout
    if set -q _flag_verbose
        set curl_opts -fS --max-time $timeout
    end

    set -l out (curl $curl_opts "$url" 2>/dev/null)
    if test $status -ne 0 -o -z "$out"
        if set -q _flag_verbose
            echo "Fetch failed or returned empty"
        end
        test -n "$last"; or set last 0
        string match -qr '^[0-9]+$' "$last"; or set last 0
        echo "$last "(math $now + $backoff) > $meta
        return
    end

    if set -q _flag_verbose
        echo "Successfully fetched weather and saved to $data"
    end

    echo $out > $data
    echo "$now 0" > $meta
end

