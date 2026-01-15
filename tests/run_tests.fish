#!/usr/bin/env fish

set -l tests_dir (dirname (status filename))
set -l project_root (dirname $tests_dir)

# Source all functions
for f in $project_root/functions/*.fish
    source $f
end

# Run doctest.fish on function files
set -l failed 0
for f in $project_root/functions/*.fish
    if grep -q "> " $f
        echo "Testing $f..."
        # Extract examples, remove leading '#' and preserve the remaining 4 spaces for doctest.fish
        set -l tmpfile (mktemp)
        grep "^#" $f | sed 's/^#//' > $tmpfile
        fish $tests_dir/doctest.fish $tmpfile
        if test $status -ne 0
            set failed 1
        end
        rm $tmpfile
    end
end

if test $failed -eq 1
    exit 1
else
    echo "All doctests passed!"
    exit 0
end
