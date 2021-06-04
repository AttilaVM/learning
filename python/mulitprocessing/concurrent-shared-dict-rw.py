#!/usr/bin/env python3

"""
This example code show that a shared dictionary can be accessed
without locking if:

There is one writer and one "poper" (who reads and deletes the key-value pair)
because the `__setitem__` and `pop` are calls are atomic thanks to the manager
"""

import multiprocessing as mp
import random
import json

def generate_random_even_number():
    n = int(random.random() * 1000)
    if n % 2 != 0:
        return n + 1
    else:
        return n

def producer(shared_dict, end_event):
    while True:
        even_numbers = [generate_random_even_number() for i in range(20)]
        test_dict = {
            "foo": "bar",
            "numbers": even_numbers
        }
        test_json = json.dumps(test_dict)
        shared_dict["test_key"] = test_json
        if end_event.is_set():
            return


if __name__ == "__main__" and "__file__" in globals():
    mgr = mp.Manager()
    shared_dict = mgr.dict()
    end_event = mp.Event()

    proc_producer = mp.Process(
        name   = "producer",
        target = producer,
        args   = (
                shared_dict,
                end_event,
        )
    )

    proc_producer.start()

    for i in range(100):
        try:
            test_json = shared_dict.pop("test_key")
        except KeyError:
            continue
        test_dict = json.loads(test_json)
        sum = 0
        for n in test_dict["numbers"]:
            sum = sum + n
        if sum % 2 != 0:
            breakpoint()
        else:
            print(sum)
    print(i)
    end_event.set()
    proc_producer.join()






