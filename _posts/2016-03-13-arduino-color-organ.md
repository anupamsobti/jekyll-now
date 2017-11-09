---
id: 30
title: Arduino Color Organ
date: 2016-03-13T18:14:40+00:00
author: anupamsobti
layout: post
guid: http://opensekrets.wordpress.com/?p=30
permalink: /2016/03/13/arduino-color-organ/
dsq_thread_id:
  - "6141123661"
image: /wp-content/uploads/2016/03/Implementation.png
categories:
  - Uncategorized
tags:
  - Arduino
  - cedt
  - color organ
  - fft
  - nsit
---
We saw a Makezine <a href="http://makezine.com/2013/05/16/use-op-amps-to-make-a-led-color-organ/" target="_blank">video</a> which showed how to use Opamp circuits (filters) to make a color organ. A color organ is a device which synchronizes some cool lighting effects with the music input that it receives. This was the inspiration behind making it digitally.

I did this project under the guidance of Prof. Dhananjay Gadre at CEDT (Centre for Electronics Design and Technology), NSIT. For making a digital implementation of the color organ, we decided to use an Arduino. Additionally, we built a shield for the audio input using a phone and the LEDs for creating the light effects. The following schematic describes the circuit implementation:

<a href="/2016/03/13/arduino-color-organ/schematic/" rel="attachment wp-att-200"><img class="alignnone wp-image-200 size-full" src="/wp-content/uploads/2016/03/Schematic.png" alt="Schematic" width="1048" height="473" srcset="/wp-content/uploads/2016/03/Schematic.png 1048w, /wp-content/uploads/2016/03/Schematic-300x135.png 300w, /wp-content/uploads/2016/03/Schematic-768x347.png 768w, /wp-content/uploads/2016/03/Schematic-1024x462.png 1024w, /wp-content/uploads/2016/03/Schematic-700x316.png 700w" sizes="(max-width: 1048px) 100vw, 1048px" /></a>

The SL1 connector was used to test the circuit with a function generator before using the random input from an audio file. The mobile phone audio output could be tapped using the audio jack on the board. As you may have noticed, the audio signal was biased with a DC bias of 2.5V (R1 = R2) before feeding it to the analog input port of the Arduino. The approach helps in getting a better range from the ADC so that the signals can be used without clamping. The diodes are for overvoltage protection from the signal generator. A prototype developed looked like this:

<a href="/2016/03/13/arduino-color-organ/projectpic/" rel="attachment wp-att-201"><img class="alignnone wp-image-201 size-full" src="/wp-content/uploads/2016/03/ProjectPic.png" alt="ProjectPic" width="511" height="348" srcset="/wp-content/uploads/2016/03/ProjectPic.png 511w, /wp-content/uploads/2016/03/ProjectPic-300x204.png 300w" sizes="(max-width: 511px) 100vw, 511px" /></a>

I used a custom made shield however you can go ahead with a proto shield or a general purpose pcb as well. The arduino receives the input signal through it&#8217;s analog input ports and digitizes the signal from a level of 0 to 1023 using a 10-bit ADC (Analog to Digital Converter). This time domain sample of the input wave is then converted to the frequency domain using a technique called Fast Fourier Transform (FFT). FFT enables to analyse streams of input data and find out which frequencies it contains.

For example, if there is a lot of bass in the music, it would translate to a low frequency signal. I separated the input signal into three bands of frequency and gave a proportional output to the LEDs so that the brightness can be controlled. The brightness is controllable because the LEDs are connected to PWM pins in the Arduino. PWM or Pulse Width Modulation is a technique where you switch on/off the LED for a specific time in a fixed time period so that the net effect is a change in brightness. Since the period is very small and the operation is done repeatedly, the LED appears to be dim/bright depending on the distribution of on/off time.<figure id="attachment_202" style="width: 575px" class="wp-caption alignnone">

<a href="/2016/03/13/arduino-color-organ/implementation/" rel="attachment wp-att-202"><img class="wp-image-202 size-full" src="/wp-content/uploads/2016/03/Implementation.png" alt="Implementation of the overall system" width="575" height="262" srcset="/wp-content/uploads/2016/03/Implementation.png 575w, /wp-content/uploads/2016/03/Implementation-300x137.png 300w" sizes="(max-width: 575px) 100vw, 575px" /></a>Implementation of the overall system</figure> 

The FFT was implemented using the FFT Library available here: http://neuroelec.googlecode.com/files/ffft_Library.zip

The Library was also accompanied by a wonderful processing application, FFTVisualizer. We used this application while testing the frequency translation through a Function Generator. The following setup was done in order to probe the signal and the serial data of FFT was communicated to the PC via USB.

<a href="/2016/03/13/arduino-color-organ/testingapparatus/" rel="attachment wp-att-203"><img class="alignnone wp-image-203 size-full" src="/wp-content/uploads/2016/03/TestingApparatus.png" alt="TestingApparatus" width="661" height="497" srcset="/wp-content/uploads/2016/03/TestingApparatus.png 661w, /wp-content/uploads/2016/03/TestingApparatus-300x226.png 300w, /wp-content/uploads/2016/03/TestingApparatus-465x350.png 465w" sizes="(max-width: 661px) 100vw, 661px" /></a>

A Bayonet Connector (the one used with oscilloscopes) was soldered with 2 wires and hooked to the 2 pin connector on the Arduino Shield. A sine wave of 1kHz frequency was generated by the function generator and after some iterations in the code, we saw this output in the processing application

<a href="/2016/03/13/arduino-color-organ/fftvisualizer/" rel="attachment wp-att-204"><img class="alignnone wp-image-204 size-full" src="/wp-content/uploads/2016/03/FFTVisualizer.png" alt="FFTVisualizer" width="785" height="596" srcset="/wp-content/uploads/2016/03/FFTVisualizer.png 785w, /wp-content/uploads/2016/03/FFTVisualizer-300x228.png 300w, /wp-content/uploads/2016/03/FFTVisualizer-768x583.png 768w, /wp-content/uploads/2016/03/FFTVisualizer-461x350.png 461w" sizes="(max-width: 785px) 100vw, 785px" /></a>

This happened when there was a fest ongoing in the college. This was the &#8220;Eureka&#8221; moment for me after a lot of days of effort. After confirming I could replicate the results at different frequencies, I headed to the musical night 🙂

Now that my hardware was working, a few more modifications were done in the code to separate this entire spectrum into 3 bands which could be transformed into the light intensity of LEDs. The code is attached <a href="http://www.anupamsobti.com/miscProjectFiles/ColorOrganCode.ino" target="_blank">here</a>. I left the original comments in the code which point to the processing application and some other resources.

The final test was done with the audio from mobile phone. We used an audio splitter so that we could connect both the speakers as well as the Arduino with the audio signal. The resultant video is here:



The project is a fun way to understand the concepts of sound, frequency and basics of electronics. Have fun!
