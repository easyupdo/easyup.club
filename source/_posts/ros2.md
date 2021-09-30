---
title: ros2
date: 2021-09-30 11:37:31
tags: [ros2]
---

#### ROS2

##### ros2 创建一个pkg
ros2 pkg create <pkg_name>
```c
//生成的pkg结构
 test                       //pkg_name
    ├── CMakeLists.txt      //
    ├── include             
    ├── package.xml         
    └── src
```

#### ros2 命令行

1. ##### topic发布

- 查看topic: ros2 topic list
- 查看topic详细信息: ros2 topic info <topic>

>$ros2 topic pub <topic_name> <msg/msg_type> <msg>   //msg 是需要yaml格式
egs. ros2 topic pub /chatter std_msgs/String "data: Hello!"


2. ##### topic订阅

>ros2 topic echo <topic_name>
egs. ros2 topic echo /chatter


3. ##### ros2 service
```c
  $ ros2 service list //查看服务
  $ ros2 service list -t //带数据类型查看服务
  $ ros2 service type <service_name> //查看服务类型
  $ros2 service call <service_name> <service_type> <arguments> //发送服务请求

  //egs ROS2 调试
  $ros2 service call /Service_ICVOS_SM_Perceive icvos_msgs/srv/Icvossrvs "{header: {stamp: {sec: 0, nanosec: 1}, frame_id: hid}, msg_type: MSG_TYPE, msg_data: MSG_DATA}"

  //调试IcvossrvsArray
  $ros2 service call /Service_ICVOS_SM_Perceive icvos_msgs_array/srv/IcvossrvsArray "{header: {stamp: {sec: 0, nanosec: 1}, frame_id: hid}, msg_type: icvos.Header, msg_data: MSG_DATA}"

```
4. ##### ros2 param [参考](https://www.guyuehome.com/10864)

```c
$ ros2 param list //查看参数列表
$ ros2 param get <node_name> <parameter_name> //获取节点参数信息
$ros2 param set <node_name> <parameter_name> <value> //设置节点参数信息
$ ros2 param dump <node_name> //将参数保存成文件，生成node_name.yaml
$ros2 run <package_name> <executable_name> --ros-args --params-file <file_name> //从文件加载参数启动节点

```

5. ##### ros2 action [参考](https://www.guyuehome.com/10898)

```c
$ros2 action list //查看动作
$ros2 action list -g //带数据类型查看动作
$ros2 action send_goal <action_name> <action_type> <values> //发布action目标
```

6. lifecycle
```c
ros2 lifecycle nodes        // 列出所有 LC 节点
ros2 lifecycle get <node>   // 列出指定节点或所有 LC 节点的当前状态。
ros2 lifecycle list <node>  // 列出指定节点可能的下一个状态和相应的转换调用（名称和 ID）。
ros2 lifecycle set <node> <transition> // 在 LC 节点上触发转换（按名称或 ID）。

// 可以调用的状态
● 配置（configure）

● 激活（activate）

● 停用（deactivate）

● 清理（cleanup）

● 关闭（shutdown）

```


#### ros2自定义消息

1. ##### 创建包
> $ ros2 pkg create test_msgs //包名一定是xxx_xxx格式，不要是XX2XX格式

2. ##### 创建msg目录和文件

1. 创建目录
> $ mkdir -p test_msgs/msg //创建msg目录
2. 编写*.msg文件
> $ vim msg/TestMsgs.msg //首字母大写 后边生成的hpp文件名根这个名字有关。 [TestMsgs <--> test_msgs.hpp] [Testmsgs <--> testmsgs.hpp
// TestMsgs.msg内容:
    int32 Num

3. 修改CMmakeList.txt 规则
```c
find_package(rosidl_default_generators REQUIRED)

rosidl_generate_interfaces(${PROJECT_NAME}
  "msg/TestMsgs.msg"
 )
 ```
 4. 修改package.xml规则
 ```xml
 <build_depend>rosidl_default_generators</build_depend>

<exec_depend>rosidl_default_runtime</exec_depend>

<member_of_group>rosidl_interface_packages</member_of_group>
 ```

 5. 构建
 >$ colcon build

 6. 设置环境变量
 > $ source ./install/setup.bash
 // 之后就可以查看时候设置到ros2的环境中了
 > ros2 msg show [tab自动补全]  //如果发现有test_msgs/TestMsgs 就证明成功，之后在其他节点引用将用到

 7. 测试自定义消息
 ```c
 //消息使用格式:
 <pkg_name>::msg::<*.msg文件名>

test_msgs::msg::TestMsgs tms = test_msgs::msg::TestMsgs();//就是一个数据结构，实际应该是解析成一个对象（我猜的）
//访问结构成员
tms.num

// 头文件引用格式
#include "test_msgs/msg/test_msgs.hpp"//TestMsgs.msg

 ```




##### icvos 消息

- icvosmsgs.msg
```c
std_msgs/Header header
string msg_type
string msg_data
```

- icvosmsgsarray.msg
```c
std_msgs/Header header
icvos_msgs/msg/Icvosmsgs[] msgs //这个需要系统先有icvos_msgs/msg/Icvosmsgs

//也就是说 依赖的消息要先编译好加载到系统里去
```


#### ROS2 错误

```c
//ros2 没有使用init初始化
terminate called after throwing an instance of 'rclcpp::exceptions::RCLInvalidArgument'
  what():  failed to create interrupt guard condition: context argument is null, at /opt/ros2_ws/src/ros2/rcl/rcl/src/rcl/guard_condition.c:65
```

```c

  icvos_msgs_array::srv::IcvossrvsArray::Response res;

  auto message = icvos_msgs::msg::Icvosmsgs();

  uint64_t t = std::chrono::system_clock::now().time_since_epoch().count();
  message.header.stamp.sec = t / uint64_t(1e9);
  message.header.stamp.nanosec = t % uint64_t(1e9);
  message.msg_type="Jay_ICOVS_TYPE";
  message.msg_data = "Jay_ICVOS_DATA";

  std::vector<icvos_msgs::msg::Icvosmsgs> ivec_msg = {message};

  res.msgs = ivec_msg;       //我们可以使用赋值的方式初始

  res.msgs[0].msg_data = "server 2 client data";

  res.msgs[0].msg_type = "icvos.VehicleReport";

```


-DICVOS_AP_PATH=/share/ICVOS-CORE/core


##### core/develop_jay[ros2]

- 构建

  - 工程依赖:

data_stream_framework 依赖ros2_icovs_msg/icvos_msgs, ros2_icvos_msg/icvos_msgs_array, icvos_api,
构建控制脚本为.cmake/ros2build.cmake。//构建过程中需要的依赖可以再该脚本中增加/修改。典型依赖是protobuf_util.so
再依赖工程下有build_alone.sh构建脚本，构建需要修改-DICVOS_AP_PATH=/share/ICVOS-CORE/core变量

  1. 构建ro2 msgs

其中ros2_icovs_msg/icovs_msgs_array 依赖 ros2_icvos_msg/icvos_msgs工程，用户需依次构建[构建指令:colcon build]，每个工程构建完并source/install/setup.bash将自定义消息加载到ros2系统，

  2.  查询ros2 msg加载成功

$ros2 msg list  //出现icvos_msg/xx/xx   和  icvos_msg_array/xx/xx 即表示成功

  3. 构建icvos_api

  使用工程下build_alone.sh //注意修改-DICVOS_AP_PATH=/share/ICVOS-CORE/core变量

  4. 构建data_stream_framework

  使用工程下build_alone.sh //注意修改-DICVOS_AP_PATH=/share/ICVOS-CORE/core变量

- 构建环境:

  docker image:172.16.8.120/icvos/icvos0.8:v1.0.9

- 构建平台:

  x64-ros2


- 测试

  1. 测试demo
  demo目录下.cc文件

  2. 测试yaml

  data_stream_framwork/Debug/conf
  server使用test_copy_server client使用test_copy_client
  pub/sub使用test



##### 功能层软件构建方法

1. copy icvos_api/pacakge.xml YOUP_PORJECT_DIR

2. 修改<name>XXX<name>中XXX=CMakeLists.txt中project(NAME)NAME.

3. copy icvos_api/build_alone.sh YOU_PROJECT_DIR

4. 修改build_alone.sh中-DICVOS_AP_PATH=/YOU_PROJECT_DIR/core

5. bash build_alone.sh //即可构建功能层软件,构建成功会在Debug下生成目标文件。



#### 可能的错误

1. 找不到protobuf_util头文件
在ros2build.cmake中有指定protobuf_util的头文件和lib，用户需要指定该路径，两种方法1. 你可以指定已经构建好的protobuf-util[x64]; 2. 你可以使用common/develop_jay直接在172.16.8.120/icvos/icvos0.8:v1.0.9下构建后指定该路径

2. 找不到jsoncpp头文件
 apt-get install libjsoncpp-dev


 #####  core/.cmake/ros2build.cmake下指定protobuf_utils路径
 
 #protobuf_utils
list(APPEND protobuf_utils_INCLUDE_DIR

  /share/ICVOS-COMMON/common/protobuf_utils/protobuf_utils_cpp/include
  /share/ICVOS-COMMON/common/protobuf_utils/protobuf_utils_cpp/pb_src
  
  
)

list(APPEND protobuf_utils_LIBRARIES

  /share/ICVOS-COMMON/common/protobuf_utils/protobuf_utils_cpp/Debug/lib/libprotobuf_utils.so
  

)

#### ros2 rcl logger
```c
  //Logger
  // ret = rcl_logging_configure_with_output_handler(
  //     &context.global_arguments,
  //     allocator,
  //     NULL);
  
  // int default_log_level = rcutils_logging_get_default_logger_level();
  // rcutils_logging_set_default_logger_level(10);
  // int fix_log_level = rcutils_logging_get_default_logger_level();

  // set name_logger level
  //rcutils_ret_t rcutils_logging_set_logger_level(const char * name, int level);

  //set logger handler
  // rcutils_logging_set_output_handler() // 
  ```

#### ros2 rclcpp executor 事件循环

// 将node添加到executor中（publisher subcriptiion service client）
1. executor.add_node(){
  weak_nodes_; //添加node
  guard_conditions_; //添加node 的 guard_conditions

  然后在spin循环中先查找any_exec [subscription_handles_,service_handles_,client_handles_,timer_handles_,waitable_handles_],如果exec_存在，则执行对应的回调，如果不存在，collect_entities，设置wait_set_然后使用rcl_wait监控wait_set_, 如果有fd[rmw_subscriptions,rmw_guard_conditions,rmw_services,rmw_clients,rmw_events]被触发,然后根据wait_set_清理无关实体[比如说waitable_handles_中没有数据的（IPM）[ipm中is_ready(wait_set)中wait_set无用，直接检测buffer_->has_data()]],然后继续获取any_exec，获取到exec后执行exec对应的回调。
}



2. ros2/rmw_fastrtps/rmw_wait.cpp:29:check_wait_set_for_data
第38行:data的获取
第39行:custom_subscriber_into->listener_->hasData();// 需要分析多线程竞争条件 predicate




#### ros2 发布和订阅逻辑

发布数据的时候，发布者会判断intra_process_is_enabled_, 如果使用ipm则继续判断是否多个订阅者订阅一个发布者，如果有多个订阅者，则将msg转为shared_ptr 然后发布




