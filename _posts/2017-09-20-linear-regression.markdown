---
title: "Introduction to Machine Learning with Linear Regression"
layout: post
date: 2017-09-20 14:40
tag:
- machine-learning
- ai
- python
category: blog
#star: false
---

Machine learning is all about computers learning itself from data to predict new data. There are two types of categories in machine learning

* Supervised Learning
* Unsupervised Learning

In supervised learning computer learning from input and output while creating a general model which can be used to predict a new output from an input. Unsupervised learning is about discovering pattern in data without knowing explicit labels beforehand. In this post I'm going to talk about linear regression which is a supervised learning method.

# Jupyter Notebook

Jupyter Notebook is an interactive python environment. You can install jupyter notebook with [Anaconda](https://www.anaconda.com/download) which will also install the necessary packages. After installation just run `jupyter notebook` in command line, it will open jupyter notebook instance in browser. Click `New` and create a Python 2 notebook. 

Enter following lines of code in the cell and press `Shift + Enter` which will execute the code. Full notebook is also available on [github](https://github.com).

```python
import numpy as np
import matplotlib.pyplot as plt
```

[Numpy](http://www.numpy.org/) is used for array and matrix operations. It's the most important library in python scientific computing echo system.

[Matplotlib](https://matplotlib.org/) is a plotting library. We will use it to visualize our data.

# Data

In this post I'm not going to use any real data set yet. Instead I'm going to generate some random data first.

```python
rng = np.random.RandomState(42)
x = rng.rand(100) * 10
x = x[:, np.newaxis]
b = rng.rand(100) * 5
b = b[:, np.newaxis]
y = 3 * x + b
```

Here we generate 100 rows of random data so $$m = 100$$. $$m$$ is usually used in machine learning to denote number of data, in this case pairs of $$x$$ and $$y$$. Now we are going to plot dataset using Matplotlib.

```python
plt.scatter(x, y)
plt.xlabel('x axis')
plt.ylabel('y axis')
plt.show()
```

You can see a plot similar to following. Every blue dot is a data point. There are 100 blue dots here.

![plot]({{ site.url }}/assets/posts/linear-regression/plot.png)

Data is distributed in sort of linear nature because of the way we generate random data. 

# Linear Regression

So purpose of the linear regression is to find the equation of a line that do justice to all data points. We will define the equation of the line as $$h(x) = \theta_0 + \theta_1x$$. In machine learning $$h(x)$$ is called the hypothesis function. But this is just a fancy way of writing old school $$y = mx + c$$ where $$c = \theta_0$$ and $$m = \theta_1$$. Now our goal is to find find $$theta_0$$ and $$theta_1$$. If we know the $$theta_0$$ and $$theta_1$$ we can draw the line. To find the $$theta_0$$ and $$theta_1$$ we are going to use a function called cost function.

# Cost Function

Cost function we going to use looks like following equation which is called least square method. 

$$
J(\theta_0, \theta_1) = \frac{1}{2m}\sum_{i=1}^m(h(x^{(0)}) - y)^2
$$ 







