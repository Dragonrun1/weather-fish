# SPDX-FileCopyrightText: 2026 Michael Cummings
# SPDX-License-Identifier: MIT

function __wttr_fetch --description "Fetch wttr.in with TTL, guards, presets"
    # ---- guards ------------------------------------------------------------
    set -q WTTR_DISABLE_SSH; and set -q SSH_CONNECTION; and return
    set -q WTTR_DISABLE_STARSHIP; and type -q starship; and return
    set -q WTTR_DISABLE_TIDE; and type -q tide; and return

    __wttr_dir_enabled; or return
    type -q curl; or return

    # ---- constants ---------------------------------------------------------
    set -l ttl $WTTR_CACHE_TTL
    set -l backoff $WTTR_BACKOFF
    set -l timeout $WTTR_TIMEOUT
    set -l now (date +%s)

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

        test $now -lt $slow_until; and return
        test (math $now - $last) -lt $ttl; and return
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

    # ---- fetch -------------------------------------------------------------
    set -l out (curl -fsS --max-time $timeout "$url" 2>/dev/null)
    if test $status -ne 0 -o -z "$out"
        test -n "$last"; or set last 0
        string match -qr '^[0-9]+$' "$last"; or set last 0
        echo "$last "(math $now + $backoff) > $meta
        return
    end

    echo $out > $data
    echo "$now 0" > $meta
end

