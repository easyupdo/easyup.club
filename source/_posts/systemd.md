---
title: systemd
date: 2021-09-29 16:14:46
tags: [管理启动,systemd]

---

#### linux 使用systemd管理启动文件

#### service新建文件位置
***/etc/***

##### service文件结构
***其中[Unit][Service][Install]不可缺少*** 
```c
[Unit]
Description=
Documentation=
After=network.target
Wants=
Requires=

[Service]
ExecStart=/home/downey/test.sh
ExecStop=
ExecReload=/home/downey/test.sh
Type=simple

[Install]
WantedBy=multi-user.target
```

##### service文件配置项解析
```c
Description：运行软件描述
Documentation：软件的文档
After：因为软件的启动通常依赖于其他软件，这里是指定在哪个服务被启动之后再启动，设置优先级
Wants：弱依赖于某个服务，目标服务的运行状态可以影响到本软件但不会决定本软件运行状态
Requires：强依赖某个服务，目标服务的状态可以决定本软件运行。
ExecStart：执行命令
ExecStop：停止执行命令
ExecReload：重启时的命令
Type：软件运行方式，默认为simple
WantedBy：这里相当于设置软件，选择运行在linux的哪个运行级别，只是在systemd中不在有运行级别概念，但是这里权当这么理解。
> 还有其他的配置项
```