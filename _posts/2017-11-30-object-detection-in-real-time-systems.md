---
id: 237
title: 'Object Detection in Real-Time Systems'
author: anupamsobti
layout: post
guid: /?p=236
permalink: /2017/11/30/object-detection-in-real-time-systems/
image: images/sysmetrics-paper-blog/cars.jpg
featured: true
hidden: true
dsq_thread_id:
  - "6139360851"
categories:
  - Computer Vision
tags:
  - Object Detection
  - Real-Time systems
  - Metrics
  - Computer Vision
---
Object Detection is the task of detecting objects in an image. It may seem like an easy task for the humans but it's quite complicated for the machines. You can look into more details at [this blog](https://ujjwalkarn.me/2016/08/11/intuitive-explanation-convnets/). In computer vision, the measure of how well a particular algorithm is performing is done in the following way:
> * The algorithm outputs the type of object and a bounding box around that object.
> * The bounding box is compared against the ground truth using an IoU (Intersection over Union) criterion.
> * If the IoU > 0.5, the object is considered detected, otherwise it is considered a false positive.

Even though the criteria works perfectly well for object detection in still images, things get a little more tricky when it comes to video streams. A natural extension to the video streams is as follows:

> * Calculate number of detections on all the images in the video independently.
> * Simply accumulate the results for accuracy on the video stream.

Objects in video streams are repeated very often in consecutive frames since there is a limit on the speed of objects moving in the video. This introduces a redundancy in the object detection required. Therefore, system designers are able to skip frames or use weaker algorithms and still achieve reasonable accuracy. Therefore, when it comes to real-time systems for processing video streams, there are a number of factors which determine the efficacy of the system. The following analysis exposes some of these redundancies and provides a guide for choosing the right algorithms for a system designer. Consider the following examples:

**1. The effect of randomness in the video : ENTROPY**

Have a look at the following videos:

| Fast moving people | Slow moving people |
| :----------------: | :----------------: |
|[![High Entropy Image Sample](/images/sysmetrics-paper-blog/bahnhof-clip.jpg)](https://motchallenge.net/movies/ETH-Bahnhof.mp4){:target="_blank"}|[![Low Entropy Image Sample](/images/sysmetrics-paper-blog/mot16-02-clip.jpg)](https://motchallenge.net/movies/MOT16-02.mp4){:target="_blank"}|

As you would notice, people are moving much faster in the first video than the second video. This would mean that the detector would have to run faster in order to detect all the people in the first video. We quantify this using the following analysis. We plot a histogram of the number of frames in which a person is present.

| High Entropy Video | Low Entropy Video | 
|:-----------------:|:-----------------:|
|![Histogram for high entropy video](/images/sysmetrics-paper-blog/bahnhof_histogram.png) | ![Histogram for low entropy video](/images/sysmetrics-paper-blog/MOT16-02_histogram.png)|

The histogram of the faster video has a much lower mean presence of pedestrians in the frame as compared to the slower video. To make this more clear, imagine the processing requirement for an application where the number of cars are being counted Vs one where the number of people are counted.

| High Compute Requirement | Low Compute Requirement | 
|:-----------------:|:-----------------:|
|![Scene with high compute requirement](/images/sysmetrics-paper-blog/cars.jpg) | ![Scene with low compute requirement](/images/sysmetrics-paper-blog/people.jpg)|

**2. Performance on limited resources : Resource-Contrained Operation**

When the frame-wise accuracy is calculated, the time taken only matters for determining the throughput of the system. The consecutive images are assumed to be unrelated to each other. However, in a video stream, if more time is spent on one frame, the next frame has to be skipped since the stream has to be processed in real-time. This results in lesser people being detected in the stream if the algorithm takes too much time to execute on a certain frame. In isolation from time, following is the comparison of accuracy for different neural network based object-detectors:


| **Algorithm** | **mAP** (Mean Average Precision) | 
| :-------: | :--------------------------: |
| SSD Mobilenet | 21 |
| SSD Inception | 24 |
| RFCN Resnet | 30 |
| Faster RCNN Resnet | 32 |
| Faster RCNN Inception | 37 |

The above algorithms have been provided by Google in their [model zoo](https://github.com/tensorflow/models/blob/master/research/object_detection/g3doc/detection_model_zoo.md) and have been used without fine-tuning/modification. When used for object detection in a real-time stream, the relative run-times cause a significant shift in the relative accuracy of these algorithms in the complete video. We define video-level accuracy as the following:

> Accuracy = Number of people detected / Total Number of people

In addition to detecting the people, many applications like Autonomous Cars, Industrial Robots, [Visually Impaired Aids](http://www.cse.iitd.ac.in/mavi) also prefer that the object be detected at a higher distance from the camera so that appropriate decisions can be taken by the system. We therefore, use a pixelDistance in our results which is essentially the row number in the image. pixelDistance is therefore inversely related to the actual distance of an object from the camera.

| :--------: | :-----------: |
| Detection Results (CPU + GPU) | Detection Results (High-end CPU) |
| ![Detection Result Images (CPU + GPU)](/images/sysmetrics-paper-blog/realTime_GPU.png) | ![Detect Result Images (CPU)](/images/sysmetrics-paper-blog/realTime_CPU.png)
| Detection Results (Low-end CPU) | Detection Results (Raspberry Pi) |
| ![Detection Result Images (Low-end CPU)](/images/sysmetrics-paper-blog/realTime_Atom.png) | ![Detect Result Images (Raspberry Pi)](/images/sysmetrics-paper-blog/realTime_Raspberry.png)

These results show how the accuracy of slower detectors reduces as the platform becomes lower in power. Hence, the best detector comes out to be neither the fastest nor the most accurate but somewhere in between. Even on platforms like a high-end CPU, SSD Mobilenet outperforms all other detectors because of it's capability to perform faster. At different distances, the optimal model/algorithm changes due to variation in object detection accuracies at different distances.

In conclusion, we propose an alternate way to evaluate the object detection algorithms in real-time scenarios. The generalization of this approach remains a question. The ground truth for distances can be obtained based on depth maps and might be different based on different algorithms, for eg, varying radially in obstacle avoidance task. The metric allows us to measure performance while varying different parameters like vehicle speed/walking speed, different hardware platforms and different scenarios closer to the application performance. This is a step towards using application metrics which can be quantified with real parameters and we hope that this enables more innovative ways to measure performance of complete systems and measure performance close to post-integration performance. A framework is also going to be released where other application performances can be measured with arbitrary FPS and according to performance of different detectors on different hardware platforms.

More technical details will soon be published in our paper "Object Detection in Real-Time Systems: Going Beyond Precision" to be published in WACV '18.
