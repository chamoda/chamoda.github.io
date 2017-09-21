---
title: "Connect LED light to Internet using Raspberry Pi"
layout: post
date: 2017-09-20 14:40
tag:
- raspberry-pi
- electronics
- python
- flask
- react
category: blog
#star: false
---

This is a step by step guide to controlling a LED light from web browser. This writing assumes you are using Raspberry Pi 3 model B. Here's list of things you need.

* Raspberry Pi 3 model B with Raspbian OS installed
* Breadboard 
* 2 male to female jumper wires
* LED
* 220 Ω Resister

Make sure you are connected using network cable or WiFi and can ssh into raspberry pi. 

# GPIO Basics

![RPI]({{ site.url }}/assets/posts/connect-led-light-to-internet/rpi.jpg)

26 out of 40 pins are GPIO (General Purpose Input Output) in Raspberry Pi. There are two types of pin numbering systems used.

* GPIO Numbering 
* Physical Numbering

GPIO Numbering is the most used method, so I will use that method here. Numbering in raspberry pi is rather wired so take a color print out of the following image and keep it near the device.

![GPIO]({{ site.url }}/assets/posts/connect-led-light-to-internet/gpio.png)

# Circuit

Connect components like in following image.

![GPIO]({{ site.url }}/assets/posts/connect-led-light-to-internet/final.JPG)

If you want to know basics of the breadboard and circuit read my previews [post]({{ site.url }}/introduction-to-arduino). 

The red jumper wire is connected to pin number 17. 

Black wire is connected to black pin. 

Now fire up the terminal and connect to pi using ssh. Then type following commands.

```bash
gpio -g write 17 1
gpio -g write 17 0
```

If you have configured the circuit correctly the led will turn on when you enter `gpio -g write 17 1` command. `gpio -g write 17 0` command will turn off the light. In next step we will control the led using python.

# Backend

Now we are going to use python [Flask](http://flask.pocoo.org/) micro framework to write an small API to control the led from anywhere. Here's the led.py which control the led.

```python
import RPi.GPIO as GPIO

class LED:
	
	channel = 17

	def __init__(self, channel):
		
		self.channel = channel

		GPIO.setmode(GPIO.BCM)

		GPIO.setup(self.channel, GPIO.OUT)

	def on(self):
		
		GPIO.output(self.channel, GPIO.HIGH)

		return "on"

	def off(self):

		GPIO.output(self.channel, GPIO.LOW)

		return "off"
```

First we are importing GPIO library. This library comes pre installed with Raspbian OS. In the initializer we have initialized channel which is equal to 17. `GPIO.setmode(GPIO.BCM)` is an essential step to let the runtime know which numbering system you are going to use. Then we will prepare the pin 17 for outputs using `GPIO.setup(self.channel, GPIO.OUT)`. In the `on()` function we are outputting a high value to to pin 17 by `GPIO.output(self.channel, GPIO.HIGH)`. Off function makes output to low value which will make led turn off. 

Now we are going to write the micro service API. Here's what the `serve.py` file looks like.

```python
from flask import Flask
from flask import request

from led import LED

app = Flask(__name__)

@app.route('/', methods=['POST'])
def main():
	
	action = request.values['action']

	led = LED(17)

	if action == 'on':
		led.on()

	if action == 'off':
		led.off()

	return 'success'
```

It's just a post request that takes parameter `action` which can be either `on` or `off`. I've made the full project code available in this github [repo](https://github.com/chamoda/rpi-led-project). Run following commands

```bash
git clone git@github.com:chamoda/rpi-led-project.git
cd rpi-led-project/backend
```

Now start the flask server 

```
FLASK_APP=serve.py flask run --host=0.0.0.0
```

This command will start a server at port 5000 along your local ip.

## Frontend

For the front end we are going to use [React](https://facebook.github.io/react/). It's just an interface with two buttons that makes requests to the micro service.

Proceed following steps.

```
cd ../frontend
npm install
npm start
```

This will start a server at port 3000

![React]({{ site.url }}/assets/posts/connect-led-light-to-internet/react.png)

I'm not going to detail out the code here, you can find the full source code in fronend folder of git [repo](https://github.com/chamoda/rpi-led-project)

## Open to Internet

You have to port forward both ports 3000, 5000 from your router. Now you can turn on or off the led using your public ip. How cool is that!




