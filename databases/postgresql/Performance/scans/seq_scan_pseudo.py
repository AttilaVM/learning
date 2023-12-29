
for block in table:
    if is_block_cached(block):
        rows = read_cache(block)
    else:
        rows = read_disk(block)

    for row in rows:
        yield row


for block_id in heap:
    if is_block_cached(block_id) and is_block_visible(block_id):
        rows = read_cache(block_id)
    else:
        rows = read_disk(block_id)

    for row in rows:
        if filter_condition(row):
            if is_toasted(row):
                row = read_from_toast_table(row)

            yield row



tid = read_index_for_tid(key)
block_id, local_tuple_id = split(tid)

if is_block_cached(block_id):
    rows = read_cache(block_id)
else:
    rows = read_disk(block_id)

row = rows[local_tuple_id]

yield(row)


for key in keys:
    tid = read_index_for_tid(key)
    block_id, local_tuple_id = split(tid)

    if is_block_cached(block_id) and is_block_visible(block_id):
        rows = read_cache(block_id)
    else:
        rows = read_disk(block_id)

    row = rows[local_tuple_id]

    yield(row)


for key in keys:
    tid = read_index_for_tid(key)
    block_id, local_tuple_id = split(tid)

    if is_block_visible(block_id):
        row = read_index_for_attributes(key)
    else:
        rows = read_disk(block_id)
        row = rows[local_tuple_id]

yield row



block_bitmap = [0, 0, 0...0]
for key in keys:
    tid = read_index_for_tid(key)
    block_id, local_tuple_id = split(tid)

    # Set corresponding bit to 1
    block_bitmap.set(block_id)

in_contigous_block_sequance = False
contigous_seq = []
for i, bit in bitmap:
    if bit == 1:
        in_contigous_block_sequance = True
        contigous_seq.append(i)

    if bit == 0:
        if in_contigous_block_sequance is True:
            block_id_seq = convert(contigous_seq)
            read_block_seq(block_id_seq)
        in_contigous_block_sequance = False


