#!/bin/bash
set -euo pipefail


curl -G https://api.github.com/search/repositories\
    --data-urlencode "q=docker followers:>1000" \
    --data-urlencode "sort=created" \
    --data-urlencode "order=desc" \
    -H "Accept: application/vnd.github.preview" \
    | jq --color-output \
    '.' \
    | less
