---
title: "Realtime face detection using OpenCV 3"
layout: post
date: 2017-10-06 14:40
tag:
- machine-learning
- ai
- python
- opencv
category: blog
#star: false
---

Detection is an important application of computer vision. In this post I'm going to detail out how to do real time face detection. Mind the word detection, we are not going to recognize, means which one the face belong. This is merely detection that there is a face. We are going to use [OpenCV](https://opencv.org) (Open Source Computer Vision Library). Opencv is written in C++ but there are interfaces for other languages so will use python.

# Installation

Note that following instructions are for OSX. Steps as follows

* First install [Anaconda](https://www.anaconda.com/download/). 
* Then create python 3 virtual environment with `conda create -n py3 python=3.6`. 
* Then type `source activate py3` which will activate python 3 environment. 
* Now install opencv with `conda install -c conda-forge opencv`.
* Check the installation with `echo -e "import cv2; print(cv2.__version__)" | python` command. It should output `3.3.0`
* Make sure your system has `ffmpeg` installed which is required for reading a video stream from video formats like `mp4, mkv`. Using brew you can install ffmpeg with one command `brew install ffmpeg`

# Time for action

