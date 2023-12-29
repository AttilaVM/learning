#!/bin/bash
set -eou pipefail

nc -l 9493 &

# this file does not exists, but a special bash syntax send data over IP/TCP
echo foo > /dev/tcp/127.0.0.1/9493

# the same with netcat
nc -l 9493 &
echo 'bar' | nc 127.0.0.1 9493
