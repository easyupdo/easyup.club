---
title: 多进程-IPC消息队列-signal
date: 2020-07-16 18:27:50
tags: [linux多进程,IPC消息队列,signal]
---

### Linux IPC 操作

- 查询IPC使用
```c
ipcs -a  是默认的输出信息 打印出当前系统中所有的进程间通信方式的信息
ipcs -m  打印出使用共享内存进行进程间通信的信息
ipcs -q   打印出使用消息队列进行进程间通信的信息
ipcs -s  打印出使用信号进行进程间通信的信息
```

- 删除IPC使用
```c
ipcrm -M shmkey  移除用shmkey创建的共享内存段
ipcrm -m shmid    移除用shmid标识的共享内存段
ipcrm -Q msgkey  移除用msqkey创建的消息队列
ipcrm -q msqid  移除用msqid标识的消息队列
ipcrm -S semkey  移除用semkey创建的信号
ipcrm -s semid  移除用semid标识的信号
```
<!--more-->

### linux 多进程-IPC消息队列-signal结构demo
```c
#include<iostream>
#include <sys/types.h>
#include <unistd.h>
#include <chrono>
#include <thread>
#include <sys/ipc.h>
#include <sys/msg.h>
#include <set>
#include <signal.h>
#include <csignal>
#include <sys/ipc.h>
#include <sys/msg.h>
#include <string.h>
#include <string>
#include <sys/wait.h>
using namespace std;

volatile std::sig_atomic_t sig_num = 0;

void signalHandler( int signum ) {
  for (int i = 0; i < 100000; i++) {
    std::this_thread::sleep_for(std::chrono::seconds(1));
    std::cout << "Fuck Break:" <<" i:"<<i<<" sig:"<< signum <<" pid:"<<getpid()<< std::endl;
  }
  //exit(signum);
}

int main(int argc, char * argv[]) {
  pid_t main_pid = -1;
  struct msg {
    long mtype;
    char mmsg[1024];
  } msg;

  key_t key = key_t(1122);
  int qid =  msgget(key, IPC_CREAT | IPC_EXCL | 0666);
  if (qid != -1) {
    std::cout << "create msg" << std::endl;
  } else {
    std::cout << "alreaty have" << std::endl;
    msgctl(qid, IPC_RMID, NULL);
  }

  pid_t mpid = fork();
  if (mpid == 0) {
    main_pid = getppid();

    for (int i = 0; i < 3; ++i) {
      pid_t pid1 = fork();

      if (pid1 == -1)
        return -1;
      else if (pid1 == 0) {
        std::cout << "#############################I:" << i << "T pid:" << getpid() << std::endl;
        //signal(SIGUSR1, SIG_IGN);
        signal(SIGUSR1, signalHandler);
        //std::cout << "From kill to start"<< std::endl;
        memset(msg.mmsg, 0, 1024);
        std::string id_str = std::to_string(getpid());

        memcpy(msg.mmsg, id_str.c_str(), id_str.length() );
        std::cout << "msgsnd Msg:" << msg.mmsg << std::endl;
        msgsnd(qid, &msg, 1024, 0);

        break;

      } else {

      }
    }

  } else {
    //signal(SIGUSR2, signalHandler);

    struct rmsg {
      long type;
      char buffer[1024];
    } rmsg;
    std::this_thread::sleep_for(std::chrono::seconds(5));
    std::cout << "r qid:" << qid << std::endl;
    msqid_ds msg_info;
    auto how = [&]() -> bool {
      if (!msgctl(qid, IPC_STAT, &msg_info)) {
        std::cout << "qnum:" << msg_info.msg_qnum << std::endl;
        if (msg_info.msg_qnum) {
          return true;
        } else {
          return false;
        }
      }
    };

    // porcess pool
    std::set<pid_t>pool_;

    do {
      msgrcv(qid, &rmsg, 1024, 0, 0);
      std::cout << "msgrcv Msg:" << rmsg.buffer << std::endl;
      pool_.insert(std::stoi(rmsg.buffer));
    } while (how());

    msgctl(qid, IPC_RMID, NULL);
    std::cout << "pid_ start" << std::endl;
    // Trigger Task
    {
      for (auto one : pool_) {
        std::cout << "PoocessID:" << one << std::endl;
        kill(one, SIGUSR1);
      }
    }

    int status;
    wait(&status);

  }
  //getchar();
  return 0;
}
```

