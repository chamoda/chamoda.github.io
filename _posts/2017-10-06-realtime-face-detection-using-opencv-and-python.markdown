---
title: "Realtime face detection using OpenCV and Python"
layout: post
date: 2017-10-06 14:40
tag:
- machine-learning
- ai
- python
- opencv
- osx
category: blog
#star: false
---

Detection is an important application of computer vision. In this post I'm going to detail out how to do real time face detection using Viola Jones Algorithm introduced in paper [Rapid object detection using a boosted cascade of simple features (2001)](http://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.10.6807). Mind the word detection, we are not going to recognize, means which one the face belong. This is merely detection that there is a face. We are going to use [OpenCV](https://opencv.org) (Open Source Computer Vision Library). Opencv is written in C++ but there are interfaces for other languages so will use python.

# Installation

Note that following instructions are for OSX. Steps as follows

* First install [Anaconda](https://www.anaconda.com/download/). 
* Then create python 3 virtual environment with `conda create -n py3 python=3.6`. 
* Then type `source activate py3` which will activate python 3 environment. 
* Now install opencv with `conda install -c conda-forge opencv`.
* Check the installation with `echo -e "import cv2; print(cv2.__version__)" | python` command. It should output `3.3.0`
* Make sure your system has `ffmpeg` installed which is required for reading a video stream from video formats like `mp4, mkv`. Using brew you can install ffmpeg with one command `brew install ffmpeg`

# Time for action

First we are going to do a quick implementation.

```python
import cv2

cap = cv2.VideoCapture("input.mp4")

face_cascade = cv2.CascadeClassifier('haarcascade_frontalface_default.xml')

while(True):

    ret, frame = cap.read()

    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

    faces = face_cascade.detectMultiScale(gray, 1.3, 5) 
    
    for (x,y,w,h) in faces:

      cv2.rectangle(frame, (x, y), (x+w, y+h), (0 , 0, 255), 2)
    
    cv2.imshow('frame', frame)

    if cv2.waitKey(1) & 0xFF == ord('q'):
        
        break

cap.release()

cv2.destroyAllWindows()
```

In summery we are trying to do is read a video file frame by frame, applying Viola Jones algorithm with trained parameters then apply a rectangle layer if a face found, displaying the modified output frame by frame. 

`cap = cv2.VideoCapture("input.mp4")` import the video. You can also use the web cam instead of a video just pass `0` as parameter like `cap = cv2.VideoCapture(0)`. 

Next we are going to load trained model. `haarcascade_frontalface_default.xml` is a model already trained using lot of faces and non faces and lot of computing power. Training good models sometime takes days not hours. Thankful above model is trained by Intel using lot of data. The model we are using here comes with the installation of OpenCv. Generally you can find those models at your `opencv-installation-directory/share/OpenCV/haarcascades` but this could differ depends on your OS and installation method. 

Next in a `while` loop we are reading frame by frame. Then get a given frame and convert into gray scale.

```python
gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
```

A frame is a array of 3 matrices where each matrix is for the respective color blue, green, red. Did you notice the revered order? In OpenCV default representation is BGR not RGB. In the above step we are converting it to gray scale image. `gray` is just a single matrix now. 

```python
faces = face_cascade.detectMultiScale(gray, 1.3, 5) 
```

`detectMultiScale` function detect faces and return an array of positions

<iframe width="100%" height="450" src="https://www.youtube.com/embed/eAJwY8fQvXs" frameborder="0" allowfullscreen></iframe>