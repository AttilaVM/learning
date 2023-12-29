
def modulo_hash(x):
    return x % 3

#  for i in range(20):
    #  hash_key = modulo_hash(i)
    #  print(i, '\t', hash_key)


animals = ['cat', 'dog', 'raven']

for a in animals:
    sum_hash = 0
    int_list = []
    for c in a:
        char_numeric_value = ord(c)
        sum_hash = sum_hash + char_numeric_value
        int_list.append(char_numeric_value)

    bucket = modulo_hash(sum_hash)

    print(f'{ a };{ int_list };{ sum_hash };{ bucket }')

