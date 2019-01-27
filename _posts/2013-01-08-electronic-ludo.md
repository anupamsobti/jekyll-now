---
id: 31
title: Electronic Ludo
date: 2013-01-08T20:38:42+00:00
author: anupamsobti
layout: post
guid: /?p=31
permalink: /2013/01/08/electronic-ludo/
dsq_thread_id:
  - "6145459850"
image: /wp-content/uploads/2016/01/ludo1.png
categories:
  - Electronic Projects
tags:
  - "8085"
  - college projects
  - electronic ludo
  - games
  - ludo
  - microprocessor projects
  - nsit
---
The project was done as a part of Microprocessors Lab Work at Netaji Subhas Institute of Technology (NSIT), Delhi under Prof. Dhananjay V Gadre in 2012. The course &#8220;Microprocessors&#8221; is typically taught by taking the example of a particular microprocessor and understanding the in-depth architecture along with the Instruction Set. That was, in fact, the case at NSIT. 8085 Microprocessor by Ramesh S. Gaonkar was our only textbook. The book thoroughly covers most of the aspects of 8085. The accompanying lab was equipped with ready-made 8085 kits where you could punch in the instructions and perform several experiments. Now, this is a good way to learn, since you see it working when you punch in new instructions, create a subroutine or just implement even a single program, provided you understand what&#8217;s going on on the inside. What&#8217;s better? Make your own hardware. The approach would not only help us in understanding the software but also pose the challenges of hardware design.

A detour was therefore taken in the microprocessors lab. Instead of the traditional approach, we were asked to think of something we&#8217;d like to make and then implement it using 8085. Whoa! We had a lot to learn. I had been involved in circuit design with microcontrollers before which was pretty simple when you compare it to the way circuits have to be designed with microprocessors. First of all, there are so many connections! 16-bit busses being routed on the PCB for interaction with the RAM, ROM, peripherals and all the care that has to be taken in order to ensure that things would work; the glue logic, the address decoding, latches for address identification. &#8220;Are we back in the stone age?&#8221;, I asked myself. It must be really difficult for the designers back then who would do all this, that too without any EDA tools at all. Having said that, it was a great learning experience. We wanted to make something simple yet interactive, in a way that gets the attention of the masses. I remember going to Prof. Dhananjay with a rough schematic where I had multiple chips controlling different aspects of the design which he discarded outright. The next few days were instrumental in creating the final schematic and also taught me a lot about efficient, modular and ergonomic design.

The initial idea looked something like this in Google&#8217;s 3D view software:

<img class="  wp-image-163 alignnone" src="/wp-content/uploads/2016/01/ludo1.png" alt="ludo1" width="578" height="271" srcset="/wp-content/uploads/2016/01/ludo1.png 1300w, /wp-content/uploads/2016/01/ludo1-300x141.png 300w, /wp-content/uploads/2016/01/ludo1-768x360.png 768w, /wp-content/uploads/2016/01/ludo1-1024x480.png 1024w, /wp-content/uploads/2016/01/ludo1-700x328.png 700w" sizes="(max-width: 578px) 100vw, 578px" />

After quite a few iterations on paper and eagle for the schematics and board layouts, we decided on having two boards stacked onto each other to distribute the complexity of the design. The boards were manufactured with the help of a local PCB vendor, Daljeet Singh. The board on the bottom would be the control unit responsible for majority of decision making and data crunching required; and the top board would be the eye candy, the necessary game controls and visuals along with the necessary drivers (PNP transistors) for the LEDs.

The bottom board, pre-fabrication looked like this:<figure id="attachment_164" style="width: 573px" class="wp-caption alignnone">
<img class="alignnone  wp-image-164" src="/wp-content/uploads/2016/01/bottomboard.png" alt="bottomBoard" width="573" height="276" />
</figure> 

[//]: # <figcaption class="wp-caption-text">
The bottom Board : Control System of the Project

[//]: # </figcaption>

This consisted of the voltage regulation, 8085 (the brain), 8155 (the arms and legs), the EPROM and some other necessary peripherals required for the working of the system. The top board, as described above was the eye candy. It consisted of LEDs that would show the position of the current player, the number a player got on the dice and a few switches for controlling the game flow.<figure id="attachment_165" style="width: 581px" class="wp-caption alignnone">
<img class="alignnone  wp-image-165" src="/wp-content/uploads/2016/01/topboard.png" alt="topboard" width="581" height="272" /></figure> 

[\\]: # <figcaption class="wp-caption-text">
The top board : The LED arrangement has provisions for the player position and the centre of the board shows the dice in it&#8217;s typical arrangement.

[\\]: # </figcaption>

The two boards were stacked upon each other using burgstrips. After a few evenings spent on testing the LEDs and soldering everything together, the final shape of the board was ready. A top view of the real hardware can be seen as under.

[<img id="i-33" class="size-full wp-image alignnone" src="/wp-content/uploads/2013/01/img_0003.jpg?w=580" alt="Image" />](/wp-content/uploads/2013/01/img_0003.jpg)

and a side view demonstrates the stacking of two boards over each other using pinheads.

[<img id="i-37" class="size-full wp-image alignnone" src="/wp-content/uploads/2013/01/img_0004.jpg?w=580" alt="Image" />](/wp-content/uploads/2013/01/img_0004.jpg)

The schematic, layout and source code may be downloaded from <a title="Files" href="https://docs.google.com/open?id=0B7Te24iPllNVN3Jkb1FHRFJsSUE" target="_blank">here.</a>

It was game time now. We had to write the software for this giant now. Along with time multiplexing between the different LED channels, we had to constantly monitor the switches for input and have a random number generator for the dice as well. Roughly the algorithm can be summarized as under:

<img class="alignnone  wp-image-172" src="/wp-content/uploads/2016/01/algo.png" alt="algo" width="573" height="608" />

The subroutine for the LEDs could be implemented in the main loop or using the timer interrupt from 8155 timer. I chose to use the former, even though the diagram shows otherwise.

The programming had to be done by creating the binary from the assembly and then flashing it to an EPROM (yeah, the one you have to erase every time with a UV light). After numerous days of struggling with the 8085 simulator and many flashes of the code (and waiting for the code to be erased after ejecting the EPROM from the board and placing it in the UV eraser), it worked! We were able to satisfactorily play a few games of ludo, all that with an 8085.

It was one hell of a project, loads of learning and the realisation that every time I can flash new code to a microcontroller using a mouse-click, or use an At-tiny controller with just 6 I/Os and a few minutes of routing, it&#8217;s awesome! 🙂

**List of all components used is as under:**

**Integrated Circuits**

  1. 8085 Microprocessor
  2. 8155
  3. ROM (27128)
  4. Latch: 74373
  5. Regulator: 7805
  6. NAND Gate: 7400

**Other Components**

  1. LEDs    3mm    &#8211;           80
  2. Transistors 
      1. BD140 &#8211;           14
      2. BD139 &#8211;           6
  3. Burgstrips:       2 (both Male and Female)
  4. Crystal Oscillator:       6Mhz
  5. Push button Switches  2

&nbsp;

Some notes during the algorithm development are [here !](/wp-content/uploads/2013/01/electronic-ludo.pdf).

The following video unveils the beast 😛
