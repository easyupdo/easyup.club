---
title: can
date: 2024-06-27 17:34:38
tags:
---

#### linux模拟使用can

1. 安装can模块
> sudo modprobe vcan

2. 创建can接口
> sudo ip link add dev vcan0 type vcan

3. 配置激活can接口
> sudo ip link set vcan0 up

4. 验证can接口配置是否正确
> ip -details link show vcan0

5. 使用can-utils控制can数据