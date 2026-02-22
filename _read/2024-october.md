---
layout: post
title: What I read in October 2024
year: 2024
month: October
date: 2024-10-31
published: true
---

## Books

## [Refactoring UI by Adam Wathan (goodreads.com)](https://www.goodreads.com/book/show/43190966-refactoring-ui)

Key personal takeaways,

* Start design with a feature, not layout.
* Define a design system in advance.
* Understanding visual hierarchy is key to good design.
* Semantics are secondary, hierarchy is more important.
* Separate visual hierarchy from document hierarchy.
* Developing an eye for all of the details that make a good typeface can take years, meanwhile steal from people who care about typefaces.
* Baseline, don't center.
* Ditch Hex for HSL.

## [An Essay on Economic Theory by Richard Cantillon (goodreads.com)](https://www.goodreads.com/book/show/9121382-an-essay-on-economic-theory)

Just read this as a foundational precursor to Adam Smith's The Wealth of Nations. This book is one of the earliest works to introduce the concept of the "entrepreneur".

## [Elon Musk by Walter Isaacson (goodreads.com)](https://www.goodreads.com/book/show/122765395-elon-musk)

I picked this up because I’ve enjoyed most of Walter Isaacson's previous biographies, but this one doesn’t quite measure up to his previous work. 

## Articles

## [The Copenhagen Book (thecopenhagenbook.com)](https://thecopenhagenbook.com)

General guidelines on implementing auth in web apps. Here's what I got out from the book.

* Tokens should have at least 112 bits (14 bytes) of entropy. 256 bits (32 bytes) is recommended. Good way to quickly generate a token with 256 bits entropy is `openssl rand -hex 32`
* For extra security situations tokens should be hashed with SHA-256.
* Use sudo mode sessions for high security situations. Basically assign a time limited token after doing extra authentication to do sensitive operations. GitHub asking to re-authenticate when doing a sensitive operation is a good example for this.
* For password hashing Argon2id is the first choice, followed by Scrypt then Bcrypt.

## [Try to Fix It One Level Deeper (https://matklad.github.io)](https://matklad.github.io/2024/09/06/fix-one-level-deeper.html)

When a bug is found in software, the fix often seems straightforward. However, by taking a moment to focus closely, you'll often uncover a deeper issue that, once resolved, can prevent similar bugs from occurring in the future. Always aim to fix problems one level deeper!










