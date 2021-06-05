#!/bin/bash
set -euo pipefail

gcc main.c \
    && ./a.out \
        | column -t -s '|' \
        | less

