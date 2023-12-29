#!/usr/bin/env python3
import sys
import os
import errno

fname = "no_such_a_file.txt"

try:
    f = open(fname, 'rb')
except OSError as e:
    if e.errno == errno.ENOENT:
        print(
            f"No such a file or directory (errno: { e.errno }):",
            fname, file=sys.stderr
        )
    else:
        # for other OS errno codes you may want to write
        # your more specific error messages which
        print(
            f"Cannot oppen file (errno: { e.errno } ):",
            fname,
            file=sys.stderr
        )
    sys.exit(os.EX_OSFILE)

with f:
    reader = csv.reader(f)
    for row in reader:
        pass #do stuff here
