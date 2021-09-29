---
title: Docker
date: 2020-10-27 11:51:32
tags: [docker]
---

### Docker使用
docker常用的命令
```c
docker images //1.查看本地docker images
docker search key //2.搜索带key的images

docker run images bash  //3.创建并启动一个容器 
docker run -it images bash //3.创建并启动一个容器 退出容器后会停止容器
docker run -dit image bash //3.穿件一个后台运行的容器

docker start 容器id //启动一个已经存在的容器

docker ps -a //4.查询本地已经存在的容器 如果没运行可以使用 docker start 容器id 来启动容器
docker ps -s //5.查询本地已经运行的容器  //有一个字段是NAME 代表容器的名字

docker exec -it  NAME bash  //6.操作一个已经启动的名为NAME的容器

docker commit -a "user name" -m "info"  已经存在的容器的id/name  新镜像的名字 //提交到镜像 会更新镜像内容
```
> 注:启动的容器不管是运行中的还是停止的只要是容器存在,那么操作过的容器内容就会一直存在这个容器中.直到将这个容器销毁数据将不存在.即:只要容器不删除 操作的数据就一直在


8.删除一个docker image
  $docker rmi image_name
  $docker rmi image_id
  使用image 名字 或者 image id来指定要删除的镜像,当有相同的镜像的时候只能使用指定名字来删除
  
 9.删除一个docker 容器
  $docker rm container_name
  $docker rm container_id
 使用container 名字或这ID来删除一个容器
 注意,容器在删除的时候必须已经停止
 
 ```c
#杀死所有正在运行的容器
docker kill $(docker ps -a -q)

#删除所有已经停止的容器
docker rm $(docker ps -a -q)

#删除所有未打 dangling 标签的镜像
docker rmi $(docker images -q -f dangling=true)

#删除所有镜像
docker rmi $(docker images -q)

#强制删除镜像名称中包含“doss-api”的镜像
docker rmi --force $(docker images | grep doss-api | awk '{print $3}')

#删除所有未使用数据
docker system prune

#只删除未使用的volumes
docker volume prune
```

##### 还有一个是 docker 数据持久化
docker run -v hostpath:/home/user/web xximg

### docker容器创建后 只要不使用docker rm name/id 删除容器 对启动的容器操作的内容一直存在


#### docker push image 到私有仓库

```c
# 将本地镜像打tag 准备push到私有仓库
# docker tag image:tag 私有仓库地址/image:tag
docker tag hello-world:0.1 127.0.0.1:5000/nginx:latest
# push 本地镜像到私有仓库
# docker push  "docker tag 打好的镜像
docker push 127.0.0.1:5000/nginx:latest
```
 
 
 #### docker 使用dockerfile创建镜像
 ```c
   #使用dockerfile创建镜像
   # -t tag //生成的 image:tag
   docker build -t server:v0.1 .

   docker build -t server:v0.1 -f Dockerfile.txt . //使用Dockerfile.txt生成镜像
```
 




---
### docker 安装以及使用
#### docker 更改root dir

ubuntu:docker-19.x:/etc/default下添加:
DOCKER_OPTS=--graph="/vdb1/docker" 
然后重启docker


#### 非root用户使用docker
1.docker在安装的时候会创建一个docker组,只需要将非root用户添加到docker组后就可以操作docker,具体操作如下:
linux将用户添加组别操作:
a1. usermod -a -G docker jay //将jay添加到docker组别
a2. gpassword -M jay docker //将jay添加到docker组别
b. nergrp docker //刷新组别 


docker 映射主机端口到容器内端口
