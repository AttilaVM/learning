#!/bin/bash
set -euo pipefail

gcc -pthread main.c
./a.out
