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
1
Public-key cryptography is one of the most used cryptographic systems today. It refers to any system that uses a key pair, one for encrypting data and another one for decrypting data. If data encrypted using one key only other key can be used to decrypt it. In this blog post I'll start with an analogy to understand what is the purpose of using two key pairs. Then I'll explain the mathematical concepts behind the algorithm. Then I'll implement a toy algorithm to understand it further (But never design your own crypto algorithms). Next I'll explain some `openssl` commands to generate RSA public and private keys which you can use of real world applications.

# Let's start with an analogy

Suppose you are at home and need to send your passbook to the bank. You have to send this by a bad courier service, in fact they always try to inspect and spy what's inside every package. So you buy a locker box with two identical keys you keep one to yourself and need to send other one to the bank. You can't send the key with the package because the courier service will open the locker box and inspect. You can't send it separately because this bad courier always make copies of the keys they deliver in hopes of trying them out on future deliveries. So you walk in to the bank yourself to deliver the key to the bank. Now you go home and put the passbook inside the locker box and lock it with your identical key and send it via the bad courier. They deliver the box hopelessly without being able to see what's inside. It was inefficient, you had to visit yourself to the bank first but can we do better?

This time bank buy a new kind of locker for this purpose. The new locker box has two keys, one for locking the box (public key), another one for unlocking (private key). The key used to lock can't be used to unlock the box. The key used to unlock can't be used to lock the box. Bank send over the locker box to you along with the locking key (public key). As usual the bad courier makes a copy of the key in hopes of future endeavors. Now you put the passbook inside the box and lock it with your locking key (public key). You keep the key and send the box. Courier tries to unlock the box using the key the have had copied, but no luck. It can only unlock using the unlocking key (private key) only owned by the bank. 

The first paragraph is an analogy of symmetric encryption. Second paragraph discuss asymmetric encryption, which is the category public encryption belongs. But how could we design such a lock digitally? 

# The Underlying Mathematics

We can write our encryption function as $$C = E(M)$$ where $$M$$ is the message we want to encrypt, $$E$$ is the function that does encryption and $$C$$ is the encrypted message. Decryption is $$M = D(C)$$. Let's define our functions 

$$
E(M) = M^e \bmod n
$$

$$
D(C) = C^d \bmod n
$$

$$e$$ and $$d$$ are public and private keys respectively. $$n$$ is a large number which is a multiple of two large prime numbers. $$\bmod$$ means the modulo operation. Most programming languages represent it by `%` symbol. Given two positive numbers $$a$$ and $$n$$ result of $$a \bmod n$$ is the reminder when $$a$$ divides by $$n$$. For example $$7 \bmod 3 = 1$$ because when $$7$$ divides by $$3$$ remainder is $$1$$. We could write above equations in another way using modular arithmetic syntax.

$$
E(M) \equiv M^e \pmod{n}
$$

$$
D(C) \equiv C^d \pmod{n}
$$

If $$ a \equiv b \pmod{n}$$ then $$a$$ and $$b$$ has a congruence relationship. That means $$a - b$$ is dividable by $$n$$ and $$a \bmod n$$ and $$b \bmod n$$ both has the same reminder.

We can write following equation.

$$M = D(E(M)) = (M^e)^d$$ 

Now we can write the following congruence relation.

$$
D(E(M)) \equiv (M^e)^d \pmod{n}
$$


