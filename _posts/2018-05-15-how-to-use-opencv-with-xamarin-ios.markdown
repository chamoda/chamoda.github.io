---
title: "How to use OpenCV with Xamarin iOS"
layout: post
date: 2018-05-15 14:40
tag:
- xamarin
- ios
- opencv
category: blog
#star: false
---

Recently I had to use OpenCV on a Xamarin iOS project. I'm writing this to remove some frustating hours of anyone tries to do the same. Unfortunately you can't code opencv directly on Xamarin. You have to create an Static Framwork using Xcode and write opencv functions using C++. Then you need to bind the static framework to Xamarin using iOS binding project. 


