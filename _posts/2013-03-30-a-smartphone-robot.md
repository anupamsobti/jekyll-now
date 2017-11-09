---
id: 73
title: A Smartphone Robot
date: 2013-03-30T16:31:06+00:00
author: anupamsobti
layout: post
guid: http://opensekrets.wordpress.com/?p=73
permalink: /2013/03/30/a-smartphone-robot/
dsq_thread_id:
  - "6166991992"
image: /wp-content/uploads/2013/03/BotFinal.png
categories:
  - Electronic Projects
tags:
  - Android
  - Arduino
  - GUI
  - MATLAB
  - Robot
  - Smartphone
  - Smartphone Robot
---
Yes ! You heard it right ! It is a robot with your smartphone mounted on it.

Why should you do it ?

1. Fun: What is cooler than using that old android phone which was not being used to make your own robot with loads of functionalities !

2. Learning: Learn basic robotics tasks like driving a motor and connection mechanisms, in this case, bluetooth and a little tinge of MATLAB for creating the GUI.

It started off as a thought of making something interesting enough so that I would make sincere efforts to get it work. I identified that a robot which can be wirelessly controlled and communicate data from a set of sensors would be a good idea to work on. Over some days, as the idea matured, I decided to use a smartphone instead of using the individual sensors. Not only would using the individual sensors make the system difficult to bring up but it would cost a lot. A smartphone has a whole variety of sensors and actuators, namely mic, camera, display, speakers, accelerometer that it was perfect for the system I was trying to make. This way, we could make it compatible to anybody&#8217;s phone and make it an easy DIY project.

Since I already had my old phone lying around, it also gave us cost efficiency. A second hand phone is worth pennies anyway, why not build an awesome robot for yourself.

Here is the block diagram I thought of.

<img class="alignnone wp-image-183 " src="/wp-content/uploads/2013/03/Communication-1-1024x478.png" alt="Communication" width="676" height="305" />

&nbsp;

Since I already had experience with Arduino, the last two pieces were a piece of cake. Just wire things up and write the code. The challenging part was the Android Application, PC Application and the Bluetooth connectivity for the arduino to interact with the phone. I wanted the phone to be easily detachable, so I wanted to use the bluetooth only and not any other interface. A friend Ashish volunteered to join the project for the android app development. The Android application was required to relay the signals it receives over Wifi to the Arduino, so that the bot can be controlled anywhere in the house as long as it is connected to the Wifi. Here&#8217;s a link to the <a href="https://play.google.com/store/apps/details?id=com.bluetooth2" target="_blank">app</a>.

**The Android Smartphone **streams the video from its camera to the PC, with the help of an application called <a href="https://play.google.com/store/apps/details?id=com.pas.webcam&hl=en" target="_blank">IP Webcam</a> (yes it is pretty awesome).

**The PC Application **developed in MATLAB using the utility GUIDE, is used to receive the video, to send the control signals back to the phone, which in-turn communicates it to the Bluetooth present on an Arduino Shield.

<a href="http://arduino.cc/" target="_blank">Arduino</a> is probably the biggest name in open source hardware. Arduino Shields are nothing but circuits stacked onto Arduino with the help of pinheads. It provides an easy to use mechanism for rapidly prototyping your circuits. Bluetooth was ordered from <a href="http://www.rhydolabz.com/index.php?main_page=product_info&products_id=1159" target="_blank">here</a>.

DC **Motors** were used for driving the robot, obtained from <a href="http://www.pololu.com/catalog/product/1093" target="_blank">here</a>. Yes, they are costly but they make the robot look great ! You can alternatively use cheaper motors you obtain from your local market.

&nbsp;

Here is the schematic diagram of the connections you will need to make.

[<img class="alignleft size-full wp-image-159" src="/wp-content/uploads/2013/04/smartphonebot.jpg" alt="Schematic" width="570" height="302" srcset="/wp-content/uploads/2013/04/smartphonebot.jpg 856w, /wp-content/uploads/2013/04/smartphonebot-300x159.jpg 300w, /wp-content/uploads/2013/04/smartphonebot-768x408.jpg 768w, /wp-content/uploads/2013/04/smartphonebot-658x350.jpg 658w" sizes="(max-width: 570px) 100vw, 570px" />](/wp-content/uploads/2013/04/smartphonebot.jpg)

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

You can access the codes for the GUI and the code used in Arduino from <a href="https://docs.google.com/file/d/0B_5eRz5cayvXMWhESk5wbVBqX0E/edit?usp=sharing" target="_blank">here</a>.

The initial design was something like this:

<img class="alignnone wp-image-182 size-medium" src="/wp-content/uploads/2013/03/InitialDesign-240x300.png" alt="InitialDesign" width="240" height="300" srcset="/wp-content/uploads/2013/03/InitialDesign-240x300.png 240w, /wp-content/uploads/2013/03/InitialDesign-280x350.png 280w, /wp-content/uploads/2013/03/InitialDesign.png 500w" sizes="(max-width: 240px) 100vw, 240px" />

This human like bot had a great turning radius, but wasn&#8217;t very stable. The phone stand was drilled into the laser cut bottom and the arduino was mounted on the same. We decided to go with a much more aesthetically pleasing and stable bot for the final version. The design was made and laser cut. The final bot looked like this:

<img class="alignnone wp-image-184 " src="/wp-content/uploads/2013/03/BotFinal.png" alt="BotFinal" width="764" height="564" />

Beauty! Isn&#8217;t it? 🙂

The design was much more stable because of the weights being distributed properly. An analysis of the weight distribution is as illustrated below:

<img class="alignnone wp-image-180 " src="/wp-content/uploads/2013/03/CentreOfMass.png" alt="CentreOfMass" width="695" height="583" />

The battery was placed below the Arduino, further stabilizing the robot. Overall, it was a fun experience. The thing that amazed me the most was that we worked on so many different platforms.

  * Windows &#8211; For the GUI Development
  * Android &#8211; For the Mobile App
  * Arduino &#8211; For the Embedded code/Hardware Interaction
  * Hardware Design &#8211; For the chassis

It was a very rewarding experience for all of us, and ofcourse, the sight of our hard work was very satisfying.
