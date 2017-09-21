---
title: "Introduction to Arduino"
layout: post
date: 2017-09-17 14:40
tag:
- arduino
- electronics
category: blog
#star: false
---

Arduino is an amazing platform that connect software to real world. It's a prototype platform easy enough for beginners to start yet flexible enough for advance users. In this blog post you will learn how to prototype a blinking LED using Arduino. Here's the items you need to for this prototype

* 1 x Arduino Nano or Uno Board
* 1 x Breadboard
* 1 x LED 
* 1 x 220 Ω Resister
* 2 x Jumper wires

One of the easiest ways to acquire above component is to buy an Arduino Starter Kit. 

## Simulate First

Before you do anything with hardware components you can simulate everything using software first. I find this is ideal for a beginner to get started. You will be able to iterate faster than using real hardware. Ones you are satisfied you can start implementing it on hardware. For this purpose I'm going to use [Tinkercad](https://www.tinkercad.com) by Autodesk. It's free and very easy to use. Go to [Tinkercad](https://www.tinkercad.com) and create an account. Then go to left panel and click "Circuits". Then click "Create new Circuit" Button. Now we are going to add a breadboard to canvas.

## Breadboard

Purpose the breadboard is get rid of soldering step when prototyping. Click "+ Components" Button. Search for "breadboard" in Search box. Drag and drop "Small Breadboard" to canvas.

![Breadboard Diagram]({{ site.url }}/assets/posts/introduction-to-arduino/breadboard.png)

Notice the horizontal green lines. They are interconnected underneath. + and - lines are there to provide power to circuit. Vertical green lines are also connected underneath and so on. Purpose is to make connection between components. Next step is to add Arduino board.

## Arduino 101

Go ahead and search for "Arduino Uno R3". Drag and drop the board to canvas. You can see that there are 14 digital pins. PWM (Pulse Width Modulation) pins can be used to send digital signal on defined intervals. On the bottom right is analog inputs. Those pins can be used to get inputs from sensors. Power pins are used to power the Arduino. If the Arduino is connected to USB no need to worry about power pins.

![Arduino UNO R3]({{ site.url }}/assets/posts/introduction-to-arduino/arduino.png)

Now click on the "Code Editor" button. You will see a text editor in bottom of the screen. Notice following C code. 

```c
// Pin 13 has an LED connected on most Arduino boards.
// give it a name:
int led = 13;

// the setup routine runs once when you press reset:
void setup() {
  // initialize the digital pin as an output.
  pinMode(led, OUTPUT);
}

// the loop routine runs over and over again forever:
void loop() {
  digitalWrite(led, HIGH);   // turn the LED on (HIGH is the voltage level)
  delay(1000);               // wait for a second
  digitalWrite(led, LOW);    // turn the LED off by making the voltage LOW
  delay(1000);               // wait for a second
}
```

The function `setup()` will run only at startup, then `loop()` function will run forever. This is the basic structure of Arduino code. Go ahead and click "Upload & Run" button. Notice the blinking LED in the Arduino board. 

We are using `pintMode(led, OUTPUT)` function to initialize the digital pin 13. Pin 13 is a special kind of pin, that it's also connected to LED inside the Arduino board. In the `loop` function we set the voltage to high and adds a one second delay. Then we set the voltage to low and wait for another second. Feel free to experiment with delay values to change the blink interval. Next we are going to add a LED directly to breadboard.

## Blink LED

Search for LED and Resistor and drag and drop to canvas. Build the circuit like following diagram. You may need to rotate resister using rotate button in tool bar. Now click on resister and change the value to 220 Ω. Click "Code Editor" and change `int led = 13;` to `int led = 2;`. Now click "Start Simulation". The LED will start blinking.

![Arduino UNO R3]({{ site.url }}/assets/posts/introduction-to-arduino/circuit.png)

Cool!. Now we are ready to for real hardware.

## Configure SDK

Go to [Arduino](https://www.arduino.cc/en/Main/Software) website and download the SDK. For Mac OS you may also need to install [CH340](https://blog.sengotta.net/signed-mac-os-driver-for-winchiphead-ch340-serial-bridge/) driver and restart the mac. 

Connect it to one of USB ports in computer. Open the SDK and go to "Tools" and select relevant details in the screen shot below. The board I'm using is "Arduino Nano v3.0 ATmega168P" so I've selected board as "Arduino Nano" and processor as "ATmega168". Your selection will differ depending on the model. Next select the serial port. One trick is disconnect the Arduino and check which port is gone. That's the port you want to select. 

![SDK]({{ site.url }}/assets/posts/introduction-to-arduino/tools.png)

Then click the "Upload" button. If it's uploaded without errors then Arduino is properly connected. If you are getting an error it may be a driver issue or incorrect information you have provided for SDK.

## Setup the circuit

Insert the Arduino into breadboard like below if it's a "Nano" board. If the board is "Uno" use it like we did in the simulation. Configure the breadboard like below. Push the Arduino into breadboard and add led and resister. Connect jumper wires correctly. Refer to simulation and try to make the connection between both circuits.

![Final]({{ site.url }}/assets/posts/introduction-to-arduino/final.JPG)

Then add following code to editor and upload.

```c
int led = 2;

void setup() {
  pinMode(led, OUTPUT);
}

void loop() {
  digitalWrite(led, HIGH);
  delay(1000);            
  digitalWrite(led, LOW); 
  delay(1000);            
}
```

You will be able to see a led blinking every second. Code is saved inside the chip so the next time you connect into power or USB the light will blink. That's it!. Feel free to experiment first on the simulator and once you came up with a good design implement it on Arduino.












