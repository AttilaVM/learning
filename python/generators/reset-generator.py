#!/usr/bin/env python3
import itertools

def generator():
    for i in range(5):
        yield i
        i = i + 1


gen = generator()

print("1. generator:")
for x in gen:
    print(x)

gen, gen_backup = itertools.tee(gen)

print("\n2. generator:")
for x in gen_backup:
    print(x)
