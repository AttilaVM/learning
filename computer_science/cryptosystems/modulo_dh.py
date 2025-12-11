import random

class Identity():

    def __init__(self, name:str, N:int, g:int):
        self.name:str = name
        self.N:int = N # modulus (public)
        self.g:int = g # generator value (public)
        self._x:int = None # private value
        self.s:int = None # shared value
        self.k:int = None # common secret

    def generate_secret_value(self):
        self._x = random.randint(2, self.N - 2)
        print(f"{self.name} generates private value: {self._x}")

    def generate_shared_value(self):
        self.s = pow(self.g, self._x, self.N) 
        print(f"{self.name} generates shared value: {self.s}")
        return self.s 

    def derive_common_secret(self, z:int):
        self.k = pow(z, self._x, self.N)
        print(f"{self.name} derives common secret {self.k}")
        

def main():
    
    # agreed upon/public parameters
    N = 23 # modulus (normally a huge prime number)
    g = 5 # generator

    alice = Identity("Alice", N=N, g=g)
    bob = Identity("Bob", N=N, g=g)

    alice.generate_secret_value()
    bob.generate_secret_value()

    a = alice.generate_shared_value()
    b = bob.generate_shared_value()

    alice.derive_common_secret(b)
    bob.derive_common_secret(a)

if __name__ == "__main__":
    main()