---
id: 226
title: Simple Example of Threading in Python
date: 2016-04-28T15:41:48+00:00
author: anupamsobti
layout: post
guid: http://anupamsobti.com/?p=226
permalink: /2016/04/28/simple-example-of-threading-in-python/
dsq_thread_id:
  - "6179546115"
categories:
  - Uncategorized
tags:
  - basic
  - example
  - python
  - simple
  - threading
---
Recently, I had to write a python program which ran several threads for different tasks. I came across some examples of using threads but couldn&#8217;t find a very basic explanation of the same. So, here it is:
  
```python
#!python3
  
import time
  
import threading

#lock to serialize console output
  
lock = threading.Lock()

def secondPrinter(): #Prints once a second
		while(True):
				time.sleep(1)
				with lock:
						print(threading.current_thread().name,&#8221;Second Printer&#8221;)

def halfSecondPrinter(): #Prints twice a second
		while True:
				time.sleep(0.5)
				with lock:
						print(threading.current_thread().name,&#8221;HalfSecond Printer&#8221;)

def quarterSecondPrinter(): #Prints 4 times a second
		while True:
				time.sleep(0.25)
				with lock:
						print(threading.current_thread().name,&#8221;quarterSecondPrinter&#8221;)

secondThread = threading.Thread(target=secondPrinter) #Target contains the name of the function to be called on start
  
secondThread.daemon = True #So that thread is killed when parent process is killed
  
halfSecondThread = threading.Thread(target=halfSecondPrinter)
  
halfSecondThread.daemon = True
  
quarterSecondThread = threading.Thread(target=quarterSecondPrinter)
  
quarterSecondThread.daemon = True

#Finally starting all threads
  
secondThread.start()
  
halfSecondThread.start()
  
quarterSecondThread.start()

time.sleep(5.1) #To prevent main program from exiting

```

Most of the code is self explanatory. Three threads have been initialized which print data in 1 second, 0.5 second and 0.25 second repeatedly. Therefore, you would expect the secondPrinter to be executed 5 times, halfSecondPrinter to be executed 10 times and the quarterSecondPrinter to be executed 20 times. The output is as follows:

  
```
Thread-3 quarterSecondPrinter
  
Thread-2 HalfSecond Printer
  
Thread-3 quarterSecondPrinter
  
Thread-3 quarterSecondPrinter
  
Thread-1 Second Printer
  
Thread-2 HalfSecond Printer
  
Thread-3 quarterSecondPrinter
  
Thread-3 quarterSecondPrinter
  
Thread-2 HalfSecond Printer
  
Thread-3 quarterSecondPrinter
  
Thread-3 quarterSecondPrinter
  
Thread-1 Second Printer
  
Thread-2 HalfSecond Printer
  
Thread-3 quarterSecondPrinter
  
Thread-3 quarterSecondPrinter
  
Thread-2 HalfSecond Printer
  
Thread-3 quarterSecondPrinter
  
Thread-3 quarterSecondPrinter
  
Thread-1 Second Printer
  
Thread-2 HalfSecond Printer
  
Thread-3 quarterSecondPrinter
  
Thread-3 quarterSecondPrinter
  
Thread-2 HalfSecond Printer
  
Thread-3 quarterSecondPrinter
  
Thread-3 quarterSecondPrinter
  
Thread-1 Second Printer
  
Thread-2 HalfSecond Printer
  
Thread-3 quarterSecondPrinter
  
Thread-3 quarterSecondPrinter
  
Thread-2 HalfSecond Printer
  
Thread-3 quarterSecondPrinter
  
Thread-3 quarterSecondPrinter
  
Thread-1 Second Printer
  
Thread-2 HalfSecond Printer
  
Thread-3 quarterSecondPrinter
  
```
