#!/bin/bash
set -euo pipefail

get_column_number() {
    line="$1"
    pattern="$2"
    sep=$3

    echo "$line" | awk -F "$sep" -v b="$pattern" '
        {
            for (i=1; i<=NF; i++) {
                if ($i == b) {
                    print i
                }
            }
        }
'
}

get_column_number "foo,bar,foobar" "foo" ","
get_column_number "foo,BAR,foobar" "BAR" ","
echo -e "\nfind multiple:"
get_column_number "foo,bar,foobar,foo" "foo" ","
