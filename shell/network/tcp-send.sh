#!/bin/bash
set -eou pipefail

nc -l 9493 &

echo foo > /dev/tcp/127.0.0.1/9493
