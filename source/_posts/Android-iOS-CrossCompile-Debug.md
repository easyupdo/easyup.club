---
title: Andoroid-iOS-CrossCompile-Debug
date: 2020-07-15 18:23:19
tags: [Android,iOS,CrossCompile]
---
#### Android cross compile

Android交叉编译需要Android NDK环境,应先下载NDK环境.
一般使用NDK环境是使用
- 生成编译工具链
```c
//生成静态编译工具链
$ $ANDROID_NDK_ROOT_DIR/build/tools/make_standalone_toolchain.py --arch $ARM --api $ANDROID_API --stl=libc++ --install-dir $ANDROID_TOOLCHAIN_INSTALL_DIR
```
<!--more-->
```c
├── AndroidVersion.txt
├── MODULE_LICENSE_BSD_LIKE
├── MODULE_LICENSE_MIT
├── NOTICE
├── aarch64-linux-android
├── arm-linux-androideabi
├── bin                     //可执行目录
├── i686-linux-android
├── include                 //头文件依赖
├── lib                     //lib
├── lib64                   //lib64
├── libexec
├── manifest_5220042.xml
├── share
├── sysroot                 //sysroot目录
└── x86_64-linux-android
```
- 使用生成的编译工具链交叉编译适合Android运行的可执行程序
```c
$arm-linux-android-clang++ main.cc -o main_Android
```
Android 重要编译说明
-mfpu           //使用浮点运算
-mfloat-abi     //浮点运算规则  soft softfp hard
-Wl,-rpath=     //-Wl 是告诉编译器 之后的参数都传入连接器 -rpath是指定程序连接的库路径 此选项不LD_PATH优先级高
-Wl,-soname=    //-soname 可执行文件在连接库的时候 实际连接的库名字

- [注]一般-Wl,-rpath=  -Wl,-soname 都加上 // -Wl,-rpath=. -Wl,-soname=libXXX.so
```c
//android常用参数说明
--atrget                //指定架构(arm-linux-androideabi/aarch64-linux-android)
--gcc-toolchain         //指定编译工具链路径
-march=armv7-a          //选择arm处理器指令集 在mac系统中一般是使用-arch(armv7,armv7s,arm64,x86_64)
-mthumb                 //应该是选择是否支持thumb指令集
-mfpu=vfpv3-d16         //忘记是啥作用了
-mfloat-abi=softfp      //浮点数设置 具体忘记了
-funwind-tables
-no-canonical-prefixes
-nostdlib               // 如果不加会出现找不到xxx.o的问题
-sysroot                //指定编译器在编译的时候搜索的目录(一般在找不到文件的时候需要用户指定目录)
//for release
-O3                     //编译O3级别优化
-DNDEBUG                //编译时去除DEBUG信息,比如assert选项等
//其他参数可根据业务需求增添
```

- 使用cmake文件交叉编译
```c
// buidl.cmake
# toolchain file example
set (CMAKE_SYSTEM_NAME  Android)
set (CMAKE_SYSTEM_VERSION 16)
set (CMAKE_ANDROID_ARCH_ABI armeabi-v7a)

set (CMAKE_ANDROID_STANDALONE_TOOLCHAIN /Users/jay/Work_Android/Do_Work/armeabi-v7a/armv7_16_toolchain)
// 在cmake编译的时候选择 使用cmake文件进行编译  cmake记得使用GUI的 省事
```

##### 编译lightGBM

-frtti -fexceptions -mfloat-abi=softfp -mfpu=neon -std=gnu++0x -Wno-deprecated -ftree-vectorize -ffast-math -fsingle-precision-constant -nostdlib -D__ANDROID_API__=24
然后加上 -L最低支持的api路径


##### arm64-v8a:/Users/jay/Work_Android/Do_Work/arm64-v8a/aarch64_21_toolchain/bin/clang++ -D__ANDROID_API__=24 -L/Users/jay/Work_Android/Do_Work/arm64-v8a/aarch64_21_toolchain/sysroot/usr/lib/aarch64-linux-android/21 -lc++_shared --target=aarch64-none-linux-android --gcc-toolchain=/Users/jay/Work_Android/Do_Work/arm64-v8a/aarch64_21_toolchain --sysroot=/Users/jay/Work_Android/Do_Work/arm64-v8a/aarch64_21_toolchain/sysroot  -frtti -fexceptions -mfloat-abi=softfp -mfpu=neon -std=gnu++0x -Wno-deprecated -ftree-vectorize -ffast-math -fsingle-precision-constant -fopenmp=libomp -std=c++11 -pthread -O3 -Wextra -Wall -Wno-ignored-attributes -Wno-unknown-pragmas -Wno-return-type -fPIC -funroll-loops -g  -fPIE -pie -Wl,--gc-sections CMakeFiles/lightgbm.dir/src/main.cpp.o CMakeFiles/lightgbm.dir/src/application/application.cpp.o CMakeFiles/lightgbm.dir/src/boosting/boosting.cpp.o CMakeFiles/lightgbm.dir/src/boosting/gbdt.cpp.o CMakeFiles/lightgbm.dir/src/boosting/gbdt_model_text.cpp.o CMakeFiles/lightgbm.dir/src/boosting/gbdt_prediction.cpp.o CMakeFiles/lightgbm.dir/src/boosting/prediction_early_stop.cpp.o CMakeFiles/lightgbm.dir/src/io/bin.cpp.o CMakeFiles/lightgbm.dir/src/io/config.cpp.o CMakeFiles/lightgbm.dir/src/io/config_auto.cpp.o CMakeFiles/lightgbm.dir/src/io/dataset.cpp.o CMakeFiles/lightgbm.dir/src/io/dataset_loader.cpp.o CMakeFiles/lightgbm.dir/src/io/file_io.cpp.o CMakeFiles/lightgbm.dir/src/io/json11.cpp.o CMakeFiles/lightgbm.dir/src/io/metadata.cpp.o CMakeFiles/lightgbm.dir/src/io/parser.cpp.o CMakeFiles/lightgbm.dir/src/io/tree.cpp.o CMakeFiles/lightgbm.dir/src/metric/dcg_calculator.cpp.o CMakeFiles/lightgbm.dir/src/metric/metric.cpp.o CMakeFiles/lightgbm.dir/src/network/linker_topo.cpp.o CMakeFiles/lightgbm.dir/src/network/linkers_mpi.cpp.o CMakeFiles/lightgbm.dir/src/network/linkers_socket.cpp.o CMakeFiles/lightgbm.dir/src/network/network.cpp.o CMakeFiles/lightgbm.dir/src/objective/objective_function.cpp.o CMakeFiles/lightgbm.dir/src/treelearner/data_parallel_tree_learner.cpp.o CMakeFiles/lightgbm.dir/src/treelearner/feature_parallel_tree_learner.cpp.o CMakeFiles/lightgbm.dir/src/treelearner/gpu_tree_learner.cpp.o CMakeFiles/lightgbm.dir/src/treelearner/serial_tree_learner.cpp.o CMakeFiles/lightgbm.dir/src/treelearner/tree_learner.cpp.o CMakeFiles/lightgbm.dir/src/treelearner/voting_parallel_tree_learner.cpp.o  -o ../lightgbm





#### lightGBM:
编译条件: 将最低版本的crtend_android.o和crtbegin_dynamic.o连接到编译工程Makefile所在的目录
编译参数:-frtti -fexceptions -mfloat-abi=softfp -mfpu=neon  -Wno-deprecated -ftree-vectorize -ffast-math  -D__ANDROID_API__=24

1.lightGBM编译报找不到getifaddrs和freeifaddrs,NDK中最低支持版本为Android API24.其中arm64v8最低Android API要求21;armv7最低Android API要求16.该函数在lightGBM中分布式中使用.
2.在lightGBM/log.h中有使用stderr和stdout,在anroid中可以通过指定android-api适配该功能.在lightGBM中log系统中使用.

1.仅提取使用到的算法(去除分布式和log系统).
2.自定义实现1中的两个函数.


- armv7:
1. error: undefined reference to 'pthread_atfork ->连接平台的libc++.so  (16/libc++.solibc++.so)
2. error: undefined reference to 'stderr' -> 通过指定Android API -D__ANDROID_API__=24
3. error: undefined reference to 'getifaddrs' -> NDK中不包含

- armv8: 类似armv7

#### iOS cross compile

MacOS iOS 使用的编译环境都是XCode提供的.Apple使用的编译环境是llvm.
一般Apple的llvm环境在/Applications/Xcode.app/Contents/中.其中编译工具可执行文件
在/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin下

##### 如何使用apple编译工具编译适合不同平台的程序

- 编译适合MacOS运行的可执行程序(-mmacosx-version-min=10.9:最低版本要求)
```c
$g++/clang++ main.cc -o main //编译
$file main 或者 $lipo -info main //提示为x86_64架构的程序
```

- 编译适合iOS运行的可执行程序 (最关键的 -arch -miphones-version-min -isysroot 其他连接库-stdlib=libc++ -lc++ -lc++abi)
其中-stdlib=libc++:代表的是连接到clang的c库上,在交叉编译的时候如果不加次连接条件会出现类似“ld: symbol(s) not found for architecture armv7”
``` c
$g++/clang++ main.cc -o main_ios -arch armv7 -miphoneos-version-min=6.1 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iphoneos11.4.sdk
$file main-ios 或者$lipo -info main-ios//提示为armv7的可执行程序
```
`1. -arch:为apple llvm编译环境的架构选择参数(armv7 armv7s arm64 x86_64).`
`2. -miphoneos-version-min:为最低支持的版本库.`
`3. -isysroot:为编译时依赖的平台环境.`




#### mac 使用小技巧
- 查找编译器默认搜索路径
```c
clang++ -E -x c++ - -v < /dev/null
```


#### Android 调试技术

Android是arm指令集定制linux系统.
- 直接将Android当作一个开发版调试
Andorid可执行目录为/system/bin目录
1. 将system目录从新挂载为可读写 (root权限下:su)
```c
//查询当前/system 挂载信息 ro:read only
PHONE#mount  | grep system

//将/system修改为可读写权限,使用auto自动选择挂载位置
PHONE#mount -o rw,remount -t auto /system

//验证是否修改成功 ro->rw
PHONE#mount | grep system

之后就可以将交叉编译后的可执行文件导入system/bin目录下如同操作linux一样操作了

//导入system中 //system不具备使用adb直接导入,先导入sdcard/Download
PC$adb push XXX /mnt/sdcard/Download
PHONE:# cp -r /mnt/sdcard/Download/XXX /system/bin

进入system/bin/XXX中操作目标.

```

- 使用AndroidStudio集成测试.
将需要测试的c库使用Android native集成到工程中在App中测试.
//AndroidStudio使用lldb调试.
(lldb)add-dsym xx.x.so  //导入xx.x.so符号表(-g) 之后就可以跟踪调试了.
