import os
import errno
import sys

if __name__ == "__main__" and "__file__" in globals():

    try:
        f = open("non_existent_file.txt", "r")
    except OSError as e:
        sys.exit(os.EX_OSFILE)

    with f:
        print(f.read())
