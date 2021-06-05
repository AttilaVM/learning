#!/bin/bash
# pmap shows the memory map of a process
set -euo pipefail

sleep 10 &
pid_sleep=$!

pmap -x $pid_sleep

# 148428:   sleep 10
# Address           Kbytes     RSS   Dirty Mode  Mapping
# 000055fbd1437000      28      28       0 r-x-- sleep
# 000055fbd1437000       0       0       0 r-x-- sleep
# 000055fbd163e000       4       4       4 r---- sleep
# 000055fbd163e000       0       0       0 r---- sleep
# 000055fbd163f000       4       4       4 rw--- sleep
# 000055fbd163f000       0       0       0 rw--- sleep
# 000055fbd2239000     132       8       8 rw---   [ anon ]
# 000055fbd2239000       0       0       0 rw---   [ anon ]
# 00007fe0d8034000    1948    1328       0 r-x-- libc-2.27.so
# 00007fe0d8034000       0       0       0 r-x-- libc-2.27.so
# 00007fe0d821b000    2048       0       0 ----- libc-2.27.so
# 00007fe0d821b000       0       0       0 ----- libc-2.27.so
# 00007fe0d841b000      16      16      16 r---- libc-2.27.so
# 00007fe0d841b000       0       0       0 r---- libc-2.27.so
# 00007fe0d841f000       8       8       8 rw--- libc-2.27.so
# 00007fe0d841f000       0       0       0 rw--- libc-2.27.so
# 00007fe0d8421000      16      12      12 rw---   [ anon ]
# 00007fe0d8421000       0       0       0 rw---   [ anon ]
# 00007fe0d8425000     156     156       0 r-x-- ld-2.27.so
# 00007fe0d8425000       0       0       0 r-x-- ld-2.27.so
# 00007fe0d8499000    1644     328       0 r---- locale-archive
# 00007fe0d8499000       0       0       0 r---- locale-archive
# 00007fe0d8634000       8       8       8 rw---   [ anon ]
# 00007fe0d8634000       0       0       0 rw---   [ anon ]
# 00007fe0d864c000       4       4       4 r---- ld-2.27.so
# 00007fe0d864c000       0       0       0 r---- ld-2.27.so
# 00007fe0d864d000       4       4       4 rw--- ld-2.27.so
# 00007fe0d864d000       0       0       0 rw--- ld-2.27.so
# 00007fe0d864e000       4       4       4 rw---   [ anon ]
# 00007fe0d864e000       0       0       0 rw---   [ anon ]
# 00007ffc668aa000     136      16      16 rw---   [ stack ]
# 00007ffc668aa000       0       0       0 rw---   [ stack ]
# 00007ffc6694d000      12       0       0 r----   [ anon ]
# 00007ffc6694d000       0       0       0 r----   [ anon ]
# 00007ffc66950000       8       4       0 r-x--   [ anon ]
# 00007ffc66950000       0       0       0 r-x--   [ anon ]
# ffffffffff600000       4       0       0 r-x--   [ anon ]
# ffffffffff600000       0       0       0 r-x--   [ anon ]
# ---------------- ------- ------- -------
# total kB            6184    1932      88
