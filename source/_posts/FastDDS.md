---
abbrlink: ''
categories: []
date: '2024-03-25T11:21:40+08:00'
tags: []
title: FastDDS
updated: '2024-06-03T17:56:35.665+08:00'
---
### 服务发现

#### SPDP

负责participant之间的发现，并为DCPSParticipant主题关联内置实体（endpoint）。

##### 如何做

每一个participant中SPDP创建两个RTPS build-in endpoint: SPDPbuildinParticipantWriter  和SPDPbuildinParticipantReader

SPDPbuildinParticipantWriter:是一个RTPS Best-Effort的 StatelessWriter,其HistoryCache内部包含了一个单对象的SPDPDiscorverParticipantData.

通过可配置的周期性向预设值的Locator发布participant的信息

##### SEDP

指定了如何在本地的topic，datareader，datawriter上交换发现信息，并为DCPSSubscribtion，DCPSPublication，DCPSTopic关联内置的实体（endpoint）。其中DCPSTopic关联的Writer和Reader不是必须的，是可选的。

#### QoS

#### 共享内存

#### class

##### 负责创建Resource 包括发送和接受的

NetworkFactory

##### 负责创建Transport

TransportInterface  UDPTransportInterface UDPv4Transport:

##### 创建发送Resource

SenderResource UDPSenderResource

##### 创建接受Resource

TransportReceiverInterface ReceiverResource ChannelResource UDPChannelResource

##### 跟创建Transport管理相关的

TransportDescriptorInterface PortBaseTransportDescriptor SocketTransportDescriptor UDPTransportDescriptor UDPv4TransportDescriptor
