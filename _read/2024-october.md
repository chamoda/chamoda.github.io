---
layout: post
title: What I Read in October 2024
year: 2024
month: October
date: 2024-10-12
published: false
---

### Books

#### [Refactoring UI (goodreads.com)](https://www.goodreads.com/book/show/43190966-refactoring-ui)

Key personal takeaways

* Start design with features feature, not a layout.
* Define a desine systems in advance
* Understanding visual hierarchy is key to good design.
* Semantics are secondary, hierarchy is more important.
* Separate visual hierarchy from document hierarchy.
* Developing an eye for all of the details that make a good typeface can take years, meanwhile steal from people that cares about typefaces.
* Baseline, don't center.
* Ditch Hex for HSL.

### Articles

#### [The Copenhagen Book (thecopenhagenbook.com)](https://thecopenhagenbook.com)

General guidelines on implementing auth in web apps. Here's what I got out from the article/minibook

* Tokens should have at least 112 bits (14 bytes) of entropy. 256 bits (32 bytes) is recommended. Good way to quickly generate a token with 256 bits entropy is `openssl rand -hex 32`
* For extra security situations tokens should be hashed with SHA-256
* Use sudo mode sessions for high security situations. Basically assign a time limited token after doing extra authentication to do sensitive operations. GitHub asking to re-authenticate when doing a sensitive operation is a good example for this.
* For password hashing Argon2id is the first choice, followed by Scrypt then Bcrypt.





