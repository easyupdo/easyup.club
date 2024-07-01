---
title: ffmpeg
date: 2024-06-27 10:07:25
tags:
---

### 使用v4l2-ctl和ffmpeg捕获linux摄像头数据

#### v4l2设备驱动测试
1. 测试功能合规性
>  v4l2-compliance -d /dev/video

2. ceshi 


#### 查询linux摄像头信息

1. 查询linux下的v4l2驱动的摄像头
> v4l2-ctl --all -list-devices 

2. 查询linux摄像头支持格式
> v4l2-ctl --list-formats -d /dev/video0 
> v4l2-ctl --list-formats-ext -d /dev/video0

3. 查询v4l2设备的控制命令
> v4l2-ctl --list-ctrls -d /dev/video0

#### 使用v4l2-ctl 捕获数据

> v4l2-ctl --stream-mmap --stream-count=1 -d /dev/video0 --set-fmt-video=width=1280,height=720,pixelformat=YUYV --stream-to=output.yuv --verbose --stream-poll


#### 使用ffmpeg捕获摄像头数据

1. 捕获v4l2驱动的/dev/video0摄像头 yuyv422格式的数据并保存为output.mkv
> ffmpeg -f v4l2 -pix_fmt yuyv422 -i /dev/video0 -c:v copy output.mkv -loglevel debug

2. 指定格式参数捕获数据
> ffmpeg -f v4l2 -input_format yuyv422 -framerate 30 -video_size 640x480 -i /dev/video0 -c:v libx264 -pix_fmt yuv420p output.mp4



#### 使用nginx-rtmp模块作为rtmp服务
1. 安装nginx
> sudo apt install nginx
2. 安装rtmp模块
> sudo apt install libnginx-mod-rtmp -y
3. 配置nginx-rtmp服务

```c
// /etc/nginx/nginx.conf
rtmp {
        server {
                listen 1935;
                chunk_size 4096;
 
                application live {
                        live on;
                        record off;
                }
        }
}

```

4. 测试nginx 配置是否正确
> nginx -t
5. 重启nginx服务
> sudo nginx -s reload
6. 查看rtmp服务是否启动
> sudo netstat -anp | grep ningx //可以看到 1935端口信息
    

#### 使用ffmpeg推流
1. 推流
> ffmpeg -f v4l2 -input_format mjpeg -framerate 30 -video_size 640x480 -i /dev/video0  -c:v libx264 -pix_fmt yuv420p -preset fast -b:v 1000k -minrate 500k -maxrate 2000k -bufsize 2000k -g 60 -f flv rtmp://10.66.146.116/live/we


2. 推流
> ffmpeg -f v4l2  -framerate 30 -video_size 640x480 -i /dev/video0  -c:v libx264 -pix_fmt yuv420p -preset fast -b:v 1000k -minrate 500k -maxrate 2000k -bufsize 2000k -g 60 -f flv rtmp://10.66.146.116/live/we




#### orin 多媒体设备
https://docs.nvidia.com/jetson/archives/r35.3.1/DeveloperGuide/text/SD/CameraDevelopment/SensorSoftwareDriverProgramming.html#port-binding


https://github.com/VC-MIPI-modules/vc_mipi_nvidia/issues/59