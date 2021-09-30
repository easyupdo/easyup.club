---
title: iceoryx
date: 2021-09-30 11:47:59
tags: [ipc,iceoryx]
---
### eclipse-iceoryx/iceoryx

[**github**](https://github.com/ApexAI/iceoryx/blob/master/iceoryx_hoofs/README.md)
#### ARCH






#### 

```c
MemPoolCollectionMemoryBlock m_introspectionMemPoolBlock;
MemPoolSegmentManagerMemoryBlock m_segmentManagerBlock;
PosixShmMemoryProvider m_managementShm;


结构：
IceOryxRouDiComponents

```


#### socket_un process require msg
```c
1 //client require
sendBuffer 
<< IpcMessageTypeToString(IpcMessageType::REG) //注册类型
<< m_runtimeName    //客户端标识名字
<< cxx::convert::toString(pid) //进程id
<< cxx::convert::toString(posix::PosixUser::getUserOfCurrentProcess().getID()) // posixuser进程id
<< cxx::convert::toString(transmissionTimestamp) //时间戳
<< static_cast<cxx::Serialization>(version::VersionInfo::getCurrentVersion()).toString(); //版本信息

2 // server qesponse
runtime::IpcMessage sendBuffer;

auto offset = rp::BaseRelativePointer::getOffset(m_mgmtSegmentId, m_segmentManager);

sendBuffer << runtime::IpcMessageTypeToString(runtime::IpcMessageType::REG_ACK)   //消息类型
<< m_roudiMemoryInterface.mgmtMemoryProvider()->size()  //共享内存大小
<< offset //共享内存快偏移位置（？）
<< transmissionTimestamp //时间戳
<< m_mgmtSegmentId; // 内存段id
```

#### iox 消息交互

client：发送客户端信息  //获取iox-roudi 共享内存信息
server:返回给客户端 关于共享内存的信息



#### 内存分配过程
// 1 个memory provide 分配内存过程

1. 构造memory block (可能n个不同size的block)  统计memory block并记录到memory provider中
2. memory provider 分配内存空间, 并为该内存空间分配segment id, 然后根据记录的 block信息（每一个block的size可能不同），将该内存空间，拆分到N个block中，每一个memroy block中纪录拆分后内存的首地址。



// 1 个memeory provider 消费内存过程


#### 对象内存管理过程
一个memroy manager 包含多个 memory provider;
一个memroy provider 包含多个 memory block;
实际分配内存的对象是 memory provider,然后分配segmentID,再然后拆分到 n个 memroy block中去；

客户端在使用内存的时候 就是按照segmentID来先获取 segment内存，然后，