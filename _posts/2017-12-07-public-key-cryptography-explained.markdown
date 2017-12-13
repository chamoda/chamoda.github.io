---
title: "Public-key Cryptography Explained"
layout: post
date: 2017-12-07 14:40
tag:
- Cryptography 
- Python
category: blog
star: false
---

Public-key cryptography is one of the most used cryptosystems today. It refers to any system that uses a key pair, one for encrypting data and another one for decrypting data. If data encrypted using a key, other key is used to decrypt it. This seems pretty magical at first, but in the end of blog post you will understand how this works. In this blog post I'll start with an analogy to understand what is the purpose of using two key pairs. Then I'll explain the mathematical concepts behind the algorithm. Then I'll implement a toy algorithm to understand it further (But never design your own crypto algorithms). Next I'll explain some `openssl` commands to generate RSA public and private keys which you can use in real world applications.

# Let's start with an analogy

Suppose you are at home and need to send your passbook to the bank. You have to send this by a bad courier service, in fact they always try to inspect and spy what's inside every package. So you buy a locker box with two identical keys. You keep one to yourself and send other one to the bank. You can't send the key with the package because the courier service will open the locker box and inspect. You can't send it separately because this bad courier always make copies of the keys they deliver in hopes of trying them out on future deliveries. So you walk in to the bank yourself to deliver the key to the bank. Now you go home and put the passbook inside the locker box and lock it with your identical key and send it via the bad courier. They deliver the box hopelessly without being able to see what's inside. It was inefficient, you had to visit yourself to the bank first. But can we do better?

This time the bank buy a new kind of locker for this purpose. The new locker box has two keys, one for locking the box (public key), another one for unlocking (private key). The key used to lock can't be used to unlock the box. The key used to unlock can't be used to lock the box. Bank send over the locker box to you along with the locking key (public key). As usual the bad courier makes a copy of the key in hopes of future endeavors. Now you put the passbook inside the box and lock it with your locking key (public key). You keep the key and send the box. Courier tries to unlock the box using the key the have had copied, but no luck. It can only unlock using the unlocking key (private key) only owned by the bank. 

 Modern Internet is like the bad courier, filled with hackers inspecting unencrypted packets. We need something similar to the second paragraph to secure the Internet communication. 

The first paragraph is an analogy of symmetric encryption. Second paragraph discuss asymmetric encryption, which is the category public encryption belongs. But how could we design such a lock digitally? 

# The Underlying Mathematics

We can write our encryption function as $$C = E(M)$$ where $$M$$ is the message we want to encrypt, $$E$$ is the function that does the encryption and $$C$$ is the encrypted message. Decryption is $$M = D(C)$$. Let's define our functions. 

$$
E(M) = M^e \bmod n
$$

$$
D(C) = C^d \bmod n
$$

$$e$$ and $$d$$ are public and private keys respectively. $$n$$ is a large number which is a multiple of two large prime numbers. $$\bmod$$ means the modulo operation. Most programming languages represent this by `%` symbol. Given two positive numbers $$a$$ and $$n$$ result of $$a \bmod n$$ is the reminder when $$a$$ divides by $$n$$. For example $$7 \bmod 3 = 1$$ because when $$7$$ divides by $$3$$ remainder is $$1$$. We could write above equations in another way using modular arithmetic syntax.

$$
E(M) \equiv M^e \pmod{n}
$$

$$
D(C) \equiv C^d \pmod{n}
$$

If $$ a \equiv b \pmod{n}$$ then $$a$$ and $$b$$ has a congruence relationship. That means $$a - b$$ is dividable by $$n$$ and $$a \bmod n$$ and $$b \bmod n$$ both has the same reminder.

Now we can write the following congruence relation. This relationship must be true for encryption and decryption to work properly. $$D(E(M))$$ must always return original $$M$$ back. 

$$
M \equiv D(E(M)) \equiv (M^e)^d \pmod{n}
$$

Now we need to find a relationship between $$e$$ and $$m$$ in such that $$D(E(M))$$ holds true. To move forward we need another equation. For that we are going to start with Fermat's little theorem from number theory. Theorem state the follows 

$$
a^p \equiv a \pmod{p}
$$

If $$p$$ is a prime number and $$a$$ is any integer number $$a^p - a$$ is an integer multiple of $$p$$. We can also write this as 

$$
a \times a^{p - 1} \equiv a \times 1 \pmod{p}
$$

Removing $$a$$ from both sides we get 

$$
a^{p - 1} \equiv 1 \pmod{p}
$$

Now let's look at a function called Euler's totient function. In number theory Euler's totient function counts number of positive integers given integer $$n$$ that are relatively prime to $$n$$. Relative primes are numbers that don't have divisors other than $$1$$. If $$a$$ and $$b$$ are relatively prime then we can write that greatest common divisor is $$1$$. We usually write this as $$gcd(a, b) = 1$$. For example $$10$$ and $$7$$ are relatively prime because $$gcd(10, 7) = 1$$. Now to the totient function, notice that if $$n$$ is a prime all the postive integers less than $$n$$ are relatively prime to $$n$$. We can write this as

$$
\phi(n) = n - 1
$$

So what does it have to do with our previous equations? Now we can write something like this using Euler's totient function.

$$
M^{\phi(n)} \equiv 1 \pmod{n}
$$

Now we are going to prepare above equations to match $$M^{ed} \equiv M \pmod{n}$$ which is similar to $$M \equiv D(E(M)) \equiv (M^e)^d \pmod{n}$$ with some reordering. As the first step of the preparation take the power $$k$$ on both sides

$$
M^{k\phi(n)} \equiv 1^k \pmod{n}
$$

Since $$1^k$$ is $$1$$ 

$$
M^{k\phi(n)} \equiv 1 \pmod{n}
$$

Now Let's multiply both sides by $$M$$

$$
M \times M^{k\phi(n)} \equiv M \times 1 \pmod{n}
$$

$$
M^{k\phi(n) + 1} \equiv M \pmod{n}
$$

Now we also have the following equation

$$
M^{ed} \equiv M \pmod{n}
$$

Did you notice the similarity in the right side of the two equations? Now we can write 

$$
k\phi(n) + 1 = ed
$$

Now this is exactly the following by the definition of modular arithmetic syntax.

$$
ed \equiv 1 \pmod{\phi(n)}
$$

We can expand $$\phi(n)$$ further because $$n$$ is a multiple of two prime numbers.

$$
n = p \times q
$$

$$
\phi(n) = \phi(p) \times \phi(q)
$$

$$
\phi(n) = (p - 1) \times (q - 1)
$$

So we can write 

$$
ed \equiv 1 \pmod{(p -1 )(q - 1)}
$$

Now choose a random private key $$d$$ such that $$ 1 < d < \phi(n) $$ and $$gcd(d, \phi(n)) = 1$$ (Which means they need to be relatively prime). Now we can find $$e$$ using modular inverse algorithm.

Now that we have found keys $$e$$ and $$d$$ we can use them to encrypt and decrypt messages. In the next section I will give a numeric example which will clear up most of the details.

# Numerical Example 

Let's choose two prime numbers $$p$$ $$q$$. We choose small values to make calculations easier but in practice RSA algorithm use very large prime numbers. 

$$
p = 3
$$

$$
q = 11
$$

$$
n = p \times q = 3 \times 11 = 33
$$

And let's calculate the Euler's totient function

$$
\phi(n) = (p - 1)(q - 1) = 2 \times 10 = 20
$$

Now we choose $$d$$ such that it's relatively prime to $$\phi(n)$$. Let's say 

$$d = 7$$

Now compute $$e$$ such that 

$$
d \times e \bmod \phi(n) = 1
$$

$$
7 \times e \bmod 20 = 1
$$

If $$e = 3$$ then $$7 \times 3 \bmod 20 = 1$$ satisfies the equation. 

Now private key is $$d = (7, 33)$$ and public key is $$e = (3, 33)$$. Now let's encrypt some number $$M = 2$$ using public key. Of course if you need to encrypt chars you must convert them to integers first.

$$
C = M^e \bmod n
$$

$$
C = 2^3 \bmod 33
$$

$$
C = 8
$$

Now let's decrypt $$C$$ using private key. 

$$
M = C^d \bmod n
$$

$$
M = 8^7 \bmod 33
$$

$$
M = 2
$$

It works :). I've implemented this as a toy algorithm using python. Never implement your own cryptography algorithms though, to use in production environments.

```python
from __future__ import division
from Crypto.Util import number
import os
from fractions import gcd
```

`from Crypto.Util import number` for generating random primes. 

```python
class RSA:
    
    p = q = n = d = e = pi_n = 0
    
    def __init__(self):
        
        self.generate()
        
    def generate(self):
        
        self.p = number.getPrime(10, os.urandom)
        self.q = number.getPrime(10, os.urandom)
        
        self.n = self.p * self.q
        
        self.pi_n = (self.p - 1) * (self.q - 1)
        
        self.d = self.choose_d()
        
        self.e = self.choose_e()
        
    def choose_d(self):
        
        self.d = self.find_a_coprime(self.pi_n)
        
        return self.d
                    
    def find_a_coprime(self, a):
        
        for i in range(2, a):
            
            if gcd(i, a) == 1:
                
                return i
            
    def choose_e(self):
        
        for i in range(self.n):
            
            if (i * self.d) % self.pi_n == 1:
                
                return i
    
    def public_key(self):
        
        return (self.e, self.n)
    
    def private_key(self):
        
        return (self.d, self.n)
    
    def encrypt(self, m, key):
        
        return pow(m, key[0]) % key[1]
    
    def decrypt(self, c, key):
        
        return pow(c, key[0]) % key[1]
```

Now we can create `RSA` class 

```python
rsa = RSA()
```

Following should output `99` if our algorithm works and it does :)

```python
rsa.decrypt(rsa.encrypt(99, rsa.public_key()), rsa.private_key())
```

# How is it secure

Whole security of public key encryption depends on that given a public key no one should be able to generate private key from that public key. Remember $$ed \equiv 1 \pmod{\phi(n)}$$? So, to calculate d from e attacker needs to know $$\phi(n)$$. But only way to calculate that is $$(p - 1)(q - 1)$$. Only key generator knows $$p$$ and $$q$$. When $$p$$ $$q$$ are large enough no one can calculate (Yet!) $$p$$, $$q$$ from $$n$$. The whole cryotosystem depends on this assumption.

# Practical Usage

Public key cryptography is used everywhere. HTTPS run on public key cryptography (Not only RSA but it plays a huge role). If you need to use public key cryptography for your own application you can use openssl. openssl is a full featured toolkit which can generate RSA keys among lot of other things. To generate a key pair type following in command line (Assuming you are on UNIX based system)	

```
openssl genpkey -algorithm RSA -out private_key.pem -pkeyopt rsa_keygen_bits:2048
```

You will generate `private_key.pem` file from above command. In this key there are lot of information encoded that it can be used to extract public key.

```
openssl rsa -pubout -in private_key.pem -out public_key.pem
```

`public_key.pem` only contain details to encrypt or decrypt something so it can be shared. But you should never share your `private_key.pem`

Now let's encrypt some data using public key.

```
echo "reqviescat in constantia, ergo, repræsentatio cvpidi avctoris religionis" > key.bin
```

```
openssl rsautl -encrypt -inkey public_key.pem -pubin -in key.bin -out key.bin.enc
```

Encrypted data is written to `key.bin.enc`. Now let's decrypt it again

```
openssl rsautl -decrypt -inkey private_key.pem -in key.bin.enc -out key.bin
```

If you open `key.bin` file you can see that same data is there. 

# Additional Resources

Toy RSA Algorithm - [Github](https://github.com/chamoda/rsa_algorithm)

Original RSA Paper - [A Method for Obtaining Digital Signatures and Public-Key Cryptosystems](https://people.csail.mit.edu/rivest/Rsapaper.pdf)

Modular Arithmetic - [Wikipedia](https://en.wikipedia.org/wiki/Modular_arithmetic)

Fermat's Little Theorem - [Wikipedia](https://en.wikipedia.org/wiki/Fermat%27s_little_theorem)

Coprime integers - [Wikipedia](https://en.wikipedia.org/wiki/Coprime_integers)

Euler's totient function - [Wikipedia](https://en.wikipedia.org/wiki/Euler%27s_totient_function)

Modular multiplicative inverse - [Wikipedia](https://en.wikipedia.org/wiki/Modular_multiplicative_inverse)
