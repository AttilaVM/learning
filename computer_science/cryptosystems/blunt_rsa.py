import math
import random
from dataclasses import dataclass

@dataclass(repr=True)
class PublicKey:
    N: int
    e: int

@dataclass(repr=True)
class PrivateKey:
    N: int
    d: int

@dataclass(repr=True)
class KeyPair:
    private_key: PrivateKey
    public_key: PublicKey


def is_prime(n:int) -> bool:
    for i in range(2, n):
        if n % i == 0:
            return False
    return True


def find_prime_up_to(n:int) -> list[int]:
    primes = []
    for i in range(2, n+1):
        if is_prime(i):
            primes.append(i)
    return primes

def factor_tree(n:int, factors = []) -> list[int]:
    possible_prime_factors = find_prime_up_to(n)

    for p in possible_prime_factors:
        m = n % p
        if m != 0:
            continue
        d = n // p
        factors.append(p)

        if d == 1:
            return factors

        if is_prime(d):
            factors.append(d)
            return factors

        factors = factor_tree(d, factors)
        return factors

    return [] # in case there are zero prime factos for 1 it is true

def factorize(n):
    return factor_tree(n, [])


def get_intersection_of_factors(a:int, b:int) -> int:
    factors_of_a = factorize(a)
    factors_of_b = factorize(b)

    intersection_of_factors = []
    for f in factors_of_a:
        if f in factors_of_b:
            intersection_of_factors.append(f)
            factors_of_b.remove(f)

    return intersection_of_factors


def greatest_common_divisor(a:int, b:int) -> int:
    intersection_of_factors = get_intersection_of_factors(a, b)
    return math.prod(intersection_of_factors) # math.prod will return 1 for an empty list which is what we want


def create_semiprime(prime_range_min: int, prime_range_max: int) -> int:
    primes:list[int] = find_prime_up_to(prime_range_max)
    valid_primes = [i for i in primes if i >= prime_range_min and i <= prime_range_max]

    if len(valid_primes) < 2:
        raise ValueError("Must be at least 2 valid primes to choose")

    selected_primes = random.sample(valid_primes, 2)
    p = selected_primes[0]
    q = selected_primes[1]

    N = p * q

    print(f"p={p}")
    print(f"q={q}")
    print(f"N={N}")

    return N

def find_coprimes(n:int) -> list[int]:
    factors_of_n_set = set(factorize(n))

    coprimes_of_n = []
    for i in range(1, n):
        factors_of_i_set = set(factorize(i))

        if factors_of_n_set & factors_of_i_set == set():
            coprimes_of_n.append(i)
    return coprimes_of_n


# phi function or the number of coprimes lesser or equal than `n` and 1
def phi_function(n:int) -> int:
    if is_prime(n):
        return n - 1

    coprimes = find_coprimes(n)
    return len(coprimes)

def phi_function_for_semiprime(p: int, q: int) -> int:
    # Efficient phi function for RSA semiprimes N = p * q
    # phi(p * q) = (p - 1) * (q - 1) when p and q are distinct primes
    return (p - 1) * (q - 1)

def find_exponent_e(N:int, method="greatest"):
    phi = phi_function(N)

    print(f"phi={phi}")

    potential_e_list = []
    for e_candidate in range(2, phi):
        if greatest_common_divisor(e_candidate, phi) == 1:
            potential_e_list.append(e_candidate)

    print("Possible e vlaues: ", potential_e_list)

    if method == "greatest":
        e = potential_e_list[-1]
    elif method == "random":
        e = random.sample(potential_e_list, 1)[0]
    else:
        ValueError("Uknown method for e exponent selection")

    print(f"e={e} (method: {method})")

    return e

def find_exponent_e_efficient(p: int, q: int, method="greatest"):
    phi = phi_function_for_semiprime(p, q)
    print(f"phi={phi}")
    
    potential_e_list = []
    for e_candidate in range(2, phi):
        if greatest_common_divisor(e_candidate, phi) == 1:
            potential_e_list.append(e_candidate)
    
    print("Possible e values: ", potential_e_list)
    
    if method == "greatest":
        e = potential_e_list[-1]
    elif method == "random":
        e = random.sample(potential_e_list, 1)[0]
    else:
        raise ValueError("Unknown method for e exponent selection")
    
    print(f"e={e} (method: {method})")
    return e

def find_exponent_d_efficient(e: int, p: int, q: int, method="random") -> int:
    phi = phi_function_for_semiprime(p, q)
    
    potential_d_list = []
    for i in range(2, phi):
        if (e * i) % phi == 1:
            potential_d_list.append(i)
    
    if len(potential_d_list) == 0:
        raise ValueError("Cannot find d exponent in range")
    
    print(f"Possible d values:", potential_d_list)
    
    if method == "greatest":
        d = potential_d_list[-1]
    elif method == "random":
        d = random.sample(potential_d_list, 1)[0]
    
    print(f"d={d} (method: {method})")
    return d

def generate_key_pair(prime_range_min:int, prime_range_max:int) -> KeyPair:
    # Get the semiprime and the individual primes for efficient phi calculation
    primes = find_prime_up_to(prime_range_max)
    valid_primes = [i for i in primes if i >= prime_range_min and i <= prime_range_max]
    
    if len(valid_primes) < 2:
        raise ValueError("Must be at least 2 valid primes to choose")
    
    selected_primes = random.sample(valid_primes, 2)
    p = selected_primes[0]
    q = selected_primes[1]
    N = p * q
    
    print(f"p={p}")
    print(f"q={q}")
    print(f"N={N}")
    
    e = find_exponent_e_efficient(p, q)
    d = find_exponent_d_efficient(e, p, q)

    key_pair = KeyPair(
        private_key = PrivateKey(N=N, d=d),
        public_key = PublicKey(N=N, e=e),
    )

    print(f"Private key: N={N}, d={d}")
    print(f"Public key: N={N}, e={e}")

    return key_pair

def client_encrypt_message(public_key, method="greatest"):
    N = public_key.N
    e = public_key.e

    # select message
    potential_m_list = []
    for i in range(2, N - 1):
        if greatest_common_divisor(i, N) == 1:
            potential_m_list.append(i)

    print("Potential m values", potential_m_list)

    if method == "greatest":
        m_cleartext = potential_m_list[-1]
    elif method == "random":
        m_cleartext = random.sample(potential_m_list, 1)[0]

    print(f"m_cleartext_client={m_cleartext}")

    # encrypt message

    m_cyphertext = (m_cleartext ** e) % N

    print(f"m_cyphertext_client={m_cyphertext}")

    return m_cyphertext


def key_pair_process(prime_range_min:int, prime_range_max:int):
    print(f"\nKey-pair simulation wiht prime range {prime_range_min} - {prime_range_max}")
    key_pair = generate_key_pair(prime_range_min, prime_range_max)
    private_key = key_pair.private_key
    public_key = key_pair.public_key

    m_cyphertext = client_encrypt_message(public_key)

    # decrypt
    N = private_key.N
    d = private_key.d

    m_cleartext = (m_cyphertext ** d) % N
    print(f"m_decoded_server={m_cleartext}")


def main():
    key_pair_process(3, 10)
    key_pair_process(20, 30)
    key_pair_process(30, 40)

if __name__ == "__main__":
    main()