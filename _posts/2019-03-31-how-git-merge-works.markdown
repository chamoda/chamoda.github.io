---
title: "How git merge works"
layout: post
date: 2019-03-31 14:40
tag:
- Git 
- Algorithms
category: blog
star: false
---

It feels like magic when you don't understand it. Today I'm going for a deep dive into interal of git merge to undestand what's happening under the hood. I'll use two merge scenarios to demonstrate.

* Merge using git pull.
* Merge a feature branch into master.

### Merge using git pull

This is one of the most common scnerios we do everyday. `git pull` is actully combination of two comands `git fetch` and `git merge`. `git fetch` will fetch data from remote branch. `git merge` will merge from local remote branch to local branch. The most common stratergy is Fast Forward. Suppose we are getting a git pull in master. The graph looks like this. Each letter indicates a commit and -> indicate reference in the tree. 

```
master = A -> B -> C 
remotes/origin/master = A -> B -> C -> D -> E
```

Fast forward is the simplest senario. Suppose C is the HEAD of master. If you type the commmand `git merge origin/master` it will use fast forward machanism. It basically does is moving the HEAD forward to E the lastest commit. 

What if there are changes tree looks like follows

```
master A -> B -> C -> D -> E
remotes/origin/master A -> B -> C -> F -> G -> H
```

When you run git merge in a scenario like this it will merge using recurive method. 
