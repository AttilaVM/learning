#!/usr/bin/env bash
set -euo pipefail

if ./read_file.py 2> error.log
then
    echo "do stuff"
else
    exit_code=$?
    echo "file is not readable, exit code: $exit_code" > /dev/stderr
    exit $exit_code
fi
