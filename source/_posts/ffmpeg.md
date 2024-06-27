---
title: ffmpeg
date: 2024-06-27 10:07:25
tags:
---

### 使用v4l2-ctl和ffmpeg捕获linux摄像头数据

#### 查询linux摄像头信息

1. 查询linux下的v4l2驱动的摄像头
> v4l2-ctl --all -list-devices 

2. 查询linux摄像头支持格式
> v4l2-ctl --list-formats -d /dev/video0 
> v4l2-ctl --list-formats-ext -d /dev/video0

#### 使用v4l2-ctl 捕获数据

> v4l2-ctl --stream-mmap --stream-count=1 -d /dev/video0 --set-fmt-video=width=1280,height=720,pixelformat=YUYV --stream-to=output.yuv --verbose --stream-poll


#### 使用ffmpeg捕获摄像头数据

1. 捕获v4l2驱动的/dev/video0摄像头 yuyv422格式的数据并保存为output.mkv
> ffmpeg -f v4l2 -pix_fmt yuyv422 -i /dev/video0 -c:v copy output.mkv -loglevel debug

2. 

