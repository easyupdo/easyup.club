---
title: c++总结
date: 2020-11-04 14:33:55
tags: [ c++ ]
---
[TOC]
   * [基础知识](#基础知识)
      * [说一下 static 关键字的作用](#说一下-static-关键字的作用)
      * [C   中的四种 cast 转换](#c-中的四种-cast-转换)
      * [指针和引用的区别](#指针和引用的区别)
      * [__cplusplus 编译宏](#__cplusplus-编译宏)
      * [_builtin_expect](#_builtin_expect)
      * [union 联合](#union-联合)
      * [大端和小端](#大端和小端)
      * [C   和 C 区别](#c-和-c-区别)
      * [请你说一下你理解的c  中的 smart pointer  四个智能指针：shared_ptr, unique_ptr, weak_ptr, auto_ptr](#请你说一下你理解的c中的-smart-pointer--四个智能指针shared_ptr-unique_ptr-weak_ptr-auto_ptr)
      * [new 和 make_shared 区别](#new-和-make_shared-区别)
      * [请你来说一下fork函数](#请你来说一下fork函数)
      * [写入时复制思想(写时复制)](#写入时复制思想写时复制)
      * [析构函数调用顺序](#析构函数调用顺序)
      * [C   STL 容器](#c-stl-容器)
         * [array](#array)
         * [deque](#deque)
         * [vector](#vector)
         * [forward_list](#forward_list)
         * [list](#list)
         * [map](#map)
         * [multimap](#multimap)
         * [unordered_map](#unordered_map)
         * [queue(队列适配器 FIFO)](#queue队列适配器-fifo)
         * [priority_queue](#priority_queue)
         * [set](#set)
         * [unordered_set](#unordered_set)
         * [stack(栈适配器)](#stack栈适配器)
      * [Zero-copy 技术](#zero-copy-技术)
      * [GDB 调试](#gdb-调试)
      * [Linux 下死循环等问题调试方法](#linux-下死循环等问题调试方法)
      * [多线程](#多线程)
      * [多进程](#多进程)
      * [网络编程](#网络编程)
      * [类与类之间的关系](#类与类之间的关系)
         * [依赖](#依赖)
         * [关联](#关联)
         * [聚合](#聚合)
         * [组合](#组合)
         * [继承(泛化)](#继承泛化)
         * [实现](#实现)
   * [操作系统](#操作系统)
      * [Linux 系统信号](#linux-系统信号)
   * [工程](#工程)
      * [请你回答一下git中, merge 和 rebase 区别](#请你回答一下git中-merge-和-rebase-区别)
   * [思想(设计模式/思想, 编程思想)](#思想设计模式思想-编程思想)
      * [关注点分离思想(Separation of concerns, SOC)](#关注点分离思想separation-of-concerns-soc)
      * [OOP的设计模式的五项原则](#oop的设计模式的五项原则)
         * [开放-封闭原则](#开放-封闭原则)
         * [单一职责原则](#单一职责原则)
         * [接口隔离原则(Interface Segregation Principle)](#接口隔离原则interface-segregation-principle)
         * [里氏替换原则(Liskov Substitution Principle)](#里氏替换原则liskov-substitution-principle)
         * [依赖倒置原则(Dependence Inversion Principle)](#依赖倒置原则dependence-inversion-principle)
      * [常见的设计模式](#常见的设计模式)
         * [单例模式](#单例模式)
         * [工厂模式](#工厂模式)
         * [观察者模式](#观察者模式)
         * [装饰器模式](#装饰器模式)
   * [编程](#编程)
      * [写出完整版的strcpy函数](#写出完整版的strcpy函数)
      * [写一个“标准”宏MIN，这个宏输入两个参数并返回较小的一个](#写一个标准宏min这个宏输入两个参数并返回较小的一个)
      * [编写一个函数，作用是把一个char组成的字符串循环右移n个。比如原来是“abcdefghi”如果n=2，移位后应该是“hiabcdefg”](#编写一个函数作用是把一个char组成的字符串循环右移n个比如原来是abcdefghi如果n2移位后应该是hiabcdefg)
      * [编写类String的构造函数、析构函数和赋值函数，已知类String的原型为:](#编写类string的构造函数析构函数和赋值函数已知类string的原型为)
# 基础知识
## 说一下 static 关键字的作用
- 限制变量或函数作用域只本程序文件
  + 若变量或函数被 static 修饰，则只能在本程序中使用，其他程序文件不能使用(非 static 可以通过 extern 关键字声明该变量是在其他文件内定义的，此文件可调用)。不加 static 修饰的，则默认是可以被其他程序文件调用的。
  ***原理: 默认的变量和函数名（统一称为符号）在编译成汇编代码 .s 文件时会有 .globl func_name, .globl 指示告诉汇编器， func_name 这个符号要被链接器用到(汇编文件在经过汇编器处理成二进制的 .o 文件时, 符号会被变量或函数实际的地址值代替), 所以要在目标文件的符号表中标记它是一个全局符号。如果一个符号没有用 .globl 声明，就表示这个符号不会被链接器用到。而用 static 关键字修饰的函数或变量在被编译成汇编代码 .s 文件时，就不会被 .globl 声明, 因此不会参与后续链接也就不会被其他程序文件调用到。(不同程序文件的函数变量互相调用是在链接各个 .o 文件步骤后进行的，前面的预编译、编译、汇编步骤都是对单个文件进行操作)***

+ 指定变量存储位置
  - 对于函数内的局部变量，都是在***栈内存区***存放，函数结束后就自动释放，但是全局的和函数内的 static 修饰的变量都是存放在***数据区***的，且只存一份，***直到整个程序结束后才自动释放***。
  - 由于 static 修饰的变量只存一份地址，即同一地址。所以不管函数调用多少次，函数内定义 static 变量的语句只会在第一次调用时执行，后面调用都不再执行也不再初始化，而是对该地址内的数据进行操作(即***只初始化一次***)。

+ C++ 类中 static 关键字修饰的成员变量
  + 类中被 static 关键字修饰的成员变量属于类，而不是属于某个实例。***只有一个地址保存一份数据存放于数据区***。在类中只是声明，并不是定义，因此不分配内存，对类用 sizeof 求大小也不会将 static 变量的大小计算在内。
  + 必须在类的外部，对类的 static 成员变量进行定义(定义之后才会分配唯一内存，此时该类静态成员变量相当于是一个全局的静态变量了，只是调用时需要使用类名加 ::)。 ***若只定义不初始化，则默认初始化为 0***。
  + public 的静态成员变量既可以通过类名引用，也可以通过对象名引用(会自动转换为类名引用)。

+ C++ 类中被 static 关键字修饰的成员函数
  + ***只能调用本类的静态成员变量或函数,不能调用本类的非静态成员函数和变量***。因为非静态成员函数和变量在类成员函数中调用时，都是由形参中隐含一个指向当前实例对象的 this 指针来调用，而静态成员函数没有这个 this 指针形参。

[^1]参考:https://www.jianshu.com/p/0b2d9679a9f2[^1]

+ **请说出static和const关键字尽可能多的作用**
  + static
    + 函数体内static变量的作用范围为该函数体，不同于auto变量，该变量的内存只被分配一次，因此其值在下次调用时仍维持上次的值
    + 在模块内的static全局变量可以被模块内所用函数访问，但不能被模块外其它函数访问
    + 在模块内的static函数只可被这一模块内的其它函数调用，这个函数的使用范围被限制在声明它的模块内
    + 在类中的static成员变量属于整个类所拥有，对类的所有对象只有一份拷贝
    + 在类中的static成员函数属于整个类所拥有，这个函数不接收this指针，因而只能访问类的static成员变量
  + const
    + 欲阻止一个变量被改变，可以使用const关键字。在定义该const变量时，通常需要对它进行初始化，因为以后就没有机会再去改变它了
    + 对指针来说，可以指定指针本身为const，也可以指定指针所指的数据为const，或二者同时指定为const
    + 在一个函数声明中，const可以修饰形参，表明它是一个输入参数，在函数内部不能改变其值

## C++ 中的四种 cast 转换
+ const_cast
  + 去除指针或引用的 const 属性, 并且仍然指向原来的对象。
+ static_cast
  + 在编译期对变量进行强制类型转换，相当于 C 语言中的强制类型转换语法。
  + 转换数据类型，类的上下行转换
  + 转换数据类型，由于没有运行时类型检查来保证转换的安全性，不安全
  + 类的上下行转换，由于没有运行时类型检查，下行转换不安全
  + static_cast 不能转换掉原有类型的 const、volatile、或者 __unaligned 属性
  + c++ 的任何的隐式转换都是使用 static_cast 来实现
+ dynamic_cast
  + 安全的上下行转换。
  + 需要注意的是，dynamic_cast的使用必须同时满足以下所有条件:
    + 被转换的变量的类型为基类指针或引用，且其确实存放了一个继承类指针或引用
    + 基类具有虚表，即基类必须至少定义了一个虚函数
+ reinterpret_cast
  + 这个强制类型转换的作用是提供某个变量在***底层数据***上的重新解释。当我们对一个变量使用reinterpretcast后，编译器将无视任何不合理行为，强行将被转换变量的***内存数据***重解释为某个新的类型。需要注意的是，reinterpret_cast 要求转换前后的类型所占用***内存大小一致***，否则将引发编译时错误。
  + 进行无关类型的转换
  + 用在任意的指针间的转换，任意引用间的转换，指针和足够大的整型之间的转换，整型到指针的转换。

[^2]参考:https://www.cnblogs.com/zeppelin5/p/10075569.html[^2]
[^3]参考:https://baijiahao.baidu.com/s?id=1643939248815582630&wfr=spider&for=pc[^3]

## 指针和引用的区别
  + 引用必须被初始化，而指针不用，可以为空。
  + 引用不是对象，而指针本身是对象
  + 引用指向对象本身，而指针指向的对象地址。

## __cplusplus 编译宏
```
#ifdef __cplusplus
extern "C" {
#endif
/*...*/
#ifdef __cplusplus
}
#endif

例如，假设某个函数的原型为：
void foo(int x, int y);
该函数被C编译器编译后在 symbol 库中的名字为 _foo，而C++编译器则会产生像 _foo_int_int之类的名字。_foo_int_int 这样的名字包含了函数名和函数参数数量及类型信息，C++就是靠这种机制来实现函数重载的。
为了实现C和C++的混合编程，C++提供了C连接交换指定符号extern "C"来解决名字匹配问题，函数声明前加上 extern "C"后，则编译器就会按照C语言的方式将该函数编译为 _foo，这样C语言中就可以调用C++的函数了。
```

## _builtin_expect
+ GUNC 下的跳转优化宏，提高执行效率. 下面是 folly Likely.h 的定义示范
```
#undef LIKELY
#undef UNLIKELY

#if defined(__GNUC__)
#define LIKELY(x) (__builtin_expect((x), 1))
#define UNLIKELY(x) (__builtin_expect((x), 0))
#else
#define LIKELY(x) (x)
#define UNLIKELY(x) (x)
#endif
```

## union 联合
+ 联合是一种特殊的类，一个union可以有多个数据成员，这些数据成员共同使用同一片存储空间，分配给一个union对象的存储空间至少要能容纳它的最大数据成员。
+ union不能含有引用类型的成员，默认情况下，union的成员都是公有的，这一点和struct相同.
+ union既不能继承自其他类，也不能作为基类使用，所以在union中不能含有虚函数
+ 为union的一个数据成员赋值时会令其它数据成员变成未定义的状态
+ 它的所有成员相对于基地址的偏移量都为0
+ union 定义可以指定成员所占的空间:
```
union u {
    unsigned int bb : 7; // (bit 0-6)
};
```
+ 匿名 union. 匿名union是一个未命名的union，一旦我们定义了一个匿名union，编译器就自动为该union创建一个未命名对象。
```
int main(void) {
    union {
        unsigned char value1;
        unsigned short value2;
        unsigned int value3;
    };
    value3 = 0x90909090;
    printf("%x\n", value1);//0x90
    printf("%x\n", value2);//0x9090
    printf("%x\n", value3);//0x90909090
    system("pause");
    return 0;
}
```
+ union 应用场景
  + 用来节省内存空间(多个变量使用同一处内存)
  + 用来判断大端还是小端，和解决***TCP黏包***问题.
  ```
  union littleOrBig {
      int number;
      char numByte;
  };

  使用的时候，给number赋值1，然后判断numByte是否等于1是大端还是小端，等于1是小端
  ```
  ```
  同理，解决TCP黏包的核心在于每次发送数据时，需要把数据的长度，放在数据的前面一起发送出去。我们使用联合体，就可以很容的把数据长度转成byte。联合体如下：
  union tcpUnion {
      int number;
      char numByte[4];
  };
  ```

[^4]参考:https://www.jianshu.com/p/35b187613ec6[^4]
[^5]参考:https://blog.csdn.net/HFUTWXY/article/details/102574101[^5]

## 大端和小端
+ 大端： 低地址存高数据位，高地址存底数据位
+ 小端:  低地址存低数据位，高地址存高数据位
```
把 0x112233 这个数存放到存储器中，采用大小端方式存储就是如下方式：
大端模式: 11 22 33
          低地址 --> 高地址
小端模式: 33 22 11
          低地址 --> 高地址
```

## C++ 和 C 区别
+ 设计思想上
  + C++是面向对象的语言，而C是面向过程的结构化编程语言
+ 语法上
  + C++具有封装、继承和多态三种特性
  + C++相比C，增加多许多类型安全的功能，比如强制类型转换
  + C++支持范式编程，比如模板类、函数模板等

## 请你说一下你理解的c++中的 smart pointer  四个智能指针：shared_ptr, unique_ptr, weak_ptr, auto_ptr
+ auto_ptr（c++98的方案，cpp11已经抛弃)
  + 采用所有权模式
  ```
  auto_ptr< string> p1 (new string ("I reigned lonely as a cloud."));
  auto_ptr<string> p2;
  p2 = p1; //auto_ptr不会报错.

  此时不会报错，p2剥夺了p1的所有权，但是当程序运行时访问p1将会报错。所以auto_ptr的缺点是：存在潜在的内存崩溃问题！
  ```
+ unique_ptr (替换 auto_ptr)
  + unique_ptr实现独占式拥有或严格拥有概念，保证同一时间内只有一个智能指针可以指向该对象。它对于避免资源泄露(例如"以 new 创建对象后因为发生异常而忘记调用 delete")特别有用。
  + 采用所有权模式
  + C++有一个标准库函数std::move()，让你能够将一个unique_ptr赋给另一个。
  + 代码示例:
  ```
  #include <iostream>
  #include <memory>

  int main() {
      // member fuction reset
      std::unique_ptr<int> up; // empty

      up.reset(new int); // takes ownership of pointer
      *up = 5;
      std::cout << *up << '\n';

      up.reset(new int); // deletes managed object, acquires new pointer
      *up = 10;
      std::cout << *up << '\n';

      up.reset(); // deletes managed object

      // member function swap
      std::unique_ptr<int> foo(new int(10));
      std::unique_ptr<int> bar(new int(20));

      foo.swap(bar);
      std::cout << "foo: " << *foo << '\n';
      std::cout << "bar: " << *bar << '\n';
      // output: foo:20   bar: 10

      // member function release
      std::unique_ptr<int> auto_pointer(new int);
      int *manual_pointer;

      *auto_pointer = 10;

      manual_pointer = auto_pointer.release();
      // (auto_pointer is now empty)

      std::cout << "manual_pointer points to " << *manual_pointer << '\n';

      delete manual_pointer;

      // output: manual_pointer points to 10

      return 0;
  }
  ```
+ shared_ptr
  + shared_ptr实现共享式拥有概念。多个智能指针可以指向相同对象，该对象和其相关资源会在“最后一个引用被销毁”时候释放。从名字share就可以看出了资源可以被多个指针共享，它使用计数机制来表明资源被几个指针共享。可以通过成员函数use_count()来查看资源的所有者个数。除了可以通过new来构造，还可以通过传入auto_ptr, unique_ptr,weak_ptr来构造。当我们调用release()时，当前指针会释放资源所有权，计数减一。当计数等于0时，资源会被释放。
  + shared_ptr 是为了解决 auto_ptr 在对象所有权上的局限性(auto_ptr 是独占的), 在使用引用计数的机制上提供了可以共享所有权的智能指针。
  + 成员函数：
    + use_count 返回引用计数的个数
    + unique 返回是否是独占所有权( use_count 为 1)
    + swap 交换两个 shared_ptr 对象(即交换所拥有的对象)
    + reset 放弃内部对象的所有权或拥有对象的变更, 会引起原有对象的引用计数的减少
    + get 返回内部对象(指针), 由于已经重载了()方法, 因此和直接使用对象是一样的.如 shared_ptr<int> sp(new int(1)); sp 与 sp.get()是等价的
+ weak_ptr
  + weak_ptr 是一种***不控制对象生命周期***的智能指针, 它指向一个 ***shared_ptr 管理***的对象. ***进行该对象的内存管理的是那个强引用的 shared_ptr.**** weak_ptr 只是提供了对管理对象的一个访问手段。weak_ptr 设计的目的是为配合 shared_ptr 而引入的一种智能指针来协助 shared_ptr 工作, 它***只可以从一个 shared_ptr 或另一个 weak_ptr 对象构造***, 它的构造和析构不会引起引用记数的增加或减少。weak_ptr 是用来***解决 shared_ptr 相互引用时的死锁问题***,如果说两个 shared_ptr 相互引用,那么这两个指针的引用计数永远不可能下降为0,资源永远不会释放。它是对对象的一种弱引用，不会增加对象的引用计数，和 shared_ptr 之间可以相互转化，shared_pt 可以直接赋值给它，它可以通过调用 lock 函数来获得 shared_ptr。
  ```
  class B;
  class A {
  public:
    shared_ptr<B> pb_;
    ~A(){
        cout<<"A delete\n";
    }
  };
  class B {
  public:
    shared_ptr<A> pa_;
    ~B() {
        cout<<"B delete\n";
    }
  };
  void fun() {
    shared_ptr<B> pb(new B());
    shared_ptr<A> pa(new A());
    pb->pa_ = pa;
    pa->pb_ = pb;
    std::cout << pb.use_count() << std::endl;
    std::cout << pa.use_count() << std::endl;
  }
  int main() {
    fun();
    return 0;
  }

  可以看到fun函数中pa ，pb之间互相引用，两个资源的引用计数为2，当要跳出函数时，智能指针pa，pb析构时两个资源引用计数会减一，但是两者引用计数还是为1，导致跳出函数时资源没有被释放（A B的析构函数没有被调用），如果把其中一个改为weak_ptr就可以了，我们把类A里面的shared_ptr pb_; 改为weak_ptr pb_; 运行结果如下，这样的话，资源B的引用开始就只有1，当pb析构时，B的计数变为0，B得到释放，B释放的同时也会使A的计数减一，同时pa析构时使A的计数减一，那么A的计数为0，A得到释放。
  注意的是我们不能通过weak_ptr直接访问对象的方法，比如B对象中有一个方法print(),我们不能这样访问，pa->pb_->print(); 英文pb_是一个weak_ptr，应该先把它转化为shared_ptr,如：shared_ptr p = pa->pb_.lock(); p->print();
  ```

## new 和 make_shared 区别
   + make_shared 比 new 性能更好，因为 new 实际上是有两次内存分配(new 需要为对象分配一次内存，还要为控制块再分配一次), 而 make_shared 只需要分配一块独立的内存用来保存对象和控制块。
   + new 可能会产生内存碎片，原因同上
   + 在作为参数传入函数时, new 有可能能造成内存泄漏
   [^6]https://blog.csdn.net/coolmeme/article/details/43405155[^6]
+ 请你回答一下为什么析构函数必须是虚函数？为什么C++默认的析构函数不是虚函数
  + 将可能会被继承的父类的析构函数设置为虚函数，可以保证当我们 new 一个子类，然后使用***基类指针指向该子类对***象，释放基类指针时可以释放掉子类的空间，防止内存泄漏。
  + C++默认的析构函数不是虚函数是因为虚函数需要额外的虚函数表和虚表指针，占用额外的内存。而对于不会被继承的类来说，其析构函数如果是虚函数，就会浪费内存。因此C++默认的析构函数不是虚函数，而是只有当需要当作父类时，设置为虚函数

## 请你来说一下fork函数
  + fork：创建一个和当前进程映像一样的进程可以通过 fork() 系统调用
  ```
  #include <sys/types.h>
  #include <unistd.h>
  pid_t fork(void);
  ```
  + 成功调用 fork() 会创建一个新的进程，它几乎与调用 fork() 的进程一模一样，这两个进程都会继续运行。在子进程中，成功的 fork() 调用会返 回0。在父进程中 fork() 返回子进程的 pid。如果出现错误，fork() 返回一个负值。
  + 最常见的 fork() 用法是创建一个新的进程，然后使用 exec() 载入二进制映像，替换当前进程的映像。这种情况下，派生（fork）了新的进程，而这个子进程会执行一个新的二进制可执行文件的映像。这种“派生加执行”的方式是很常见的。
  + 在早期的Unix系统中，创建进程比较原始。当调用fork时，内核会把所有的内部数据结构复制一份，复制进程的页表项，然后把父进程的地址空间中的内容逐页的复制到子进程的地址空间中。但从内核角度来说，逐页的复制方式是十分耗时的。现代 的Unix系统采取了更多的优化，例如Linux，采用了***写时复制***的方法，而不是对父进程空间进程整体复制。
## 写入时复制思想(写时复制)
  + ***写入时复制***是一种计算机程序设计领域的优化策略。其核心思想是，如果有多个调用者同时请求相同资源（如内存或磁盘上的数据存储），他们会共同获取相同的指针指向相同的资源，直到某个调用者试图修改资源的内容时，系统才会真正复制一份专用副本（private copy）给该调用者，而其他调用者所见到的最初的资源仍然保持不变。这个过程对其他的调用者是透明的（transparently）。此作法的主要优点是如果调用者没有修改该资源，就不会有副本（private copy）被建立，因此多个调用者只是读取操作是可以共享同一份资源。
  + 应用
    + ***虚拟内存管理中的写时复制***: 一般把这种被共享访问的页面标记为只读。当一个task试图向内存中写入数据时，内存管理单元（MMU）抛出一个异常，内核处理该异常时为该task分配一份物理内存并复制数据到此内存，重新向MMU发出执行该task的写操作。
    + ***数据存储中的写时复制***: [Linux]等的文件管理系统使用了写时复制策略。[数据库]服务器也一般采用了写时复制策略，为用户提供一份snapshot。
    + ***软件应用中的写时复制***: [C++标准程序库]中的[std::string]类，在C++98/C++03标准中是允许写时复制策略。但在[C++11]标准中为了提高并行性取消了这一策略。 GCC从版本5开始，std::string不再采用COW策略

    [^7]参考：https://www.jianshu.com/p/8292e285e26a[^7]

## 析构函数调用顺序
   + 1）派生类本身的析构函数；2）对象成员析构函数；3）基类析构函数。

## C++ STL 容器
### array
   + 内存连续，大小在编译期确定无法改变, 元素的分配不是依赖 allocator.
   + 元素访问方法和数组一样。
   + array 可以作为一个 tuple 对象操作, 它重载了 get 接口, 可以使用 tuple_size 和 tuple_element.
   + 交换两个 array 的效率是非常低的，因为它是对两个 array 中的元素一一交换。
### deque
   + 在两端插入和删除元素效率比较高，在两端之外的地方频繁插入和删除元素效率比较差。
   + 不保证元素是连续存储的，分配新内存不需要将原来的元素拷贝到新内存。
   + push_back push_front 新增元素会导致所有的迭代器失效，但指针和引用不会失效。
### vector
   + 和数组一样可以通过下标访问元素且效率一样高，但大小可动态改变。
   + 每次分配内存都会把原来的元素拷贝到新内存，导致效率比较低。所以分配内存会预先分配大约一倍的大小(GNU), vs 编译器下是分配原来的 1/2。
   + 随机访问元素和在末端添加和删除元素效率很高，但在 vector 中间插入和删除元素效率很低
   + push_back 新增元素时, 如果 vector 因为内存不够而发生自动重新分配内存的动作那么所有的这个 vector 相关的迭代器、指针和引用都将失效(原因为第 2 条)。如果没有发生，则失效的仅仅是末尾的迭代器.
### forward_list
   + 实质是一个单链表(内存不连续),且实质上与其在 C 中实现相比无任何开销。
   + 插入和删除效率比 list 要高一点(list 为双链表，增加了一个前向指针)
   + 相比 array、vector、deque 这些序列容器，forward_list 在任何位置插入、删除和移动元素效率比较高，因此在算法中应用比较多比如 排序算法。但不支持随机访问。
### list
   + 实质为一个双向链表
   + 参考 froward_list
### map
   + Maps are typically implemented as binary search trees.
   + key 是唯一的
   + map 中的数据都是有序的，默认是升序.
### multimap
   + Key 可以重复
   + 数据有序
### unordered_map
   + 数据无序
   + 通过 key 访问元素比 map 速度快。但是要查询某一范围内的key值时比map效率低
### queue(队列适配器 FIFO)
   + 因为 queue 支持 empty、size、front、back、push_back、pop_front 操作，所以 queue 基于 deque 实现(但也可以用 list 或 vector 实现)
### priority_queue
   + 基于 vector 实现(也可以用 deque 实现)
### set
   + 基于 binary search trees 实现
   + key 即值，即只保存关键字。
   + 数据有序
   + 元素默认为 const，元素值不能修改，但可以插入和删除.
### unordered_set
   + 和 set 区别参考 map vs unordered_map
### stack(栈适配器)
   + 基于 deque 实现

## Zero-copy 技术
## GDB 调试
## Linux 下死循环等问题调试方法
## 多线程
## 多进程
## 网络编程
## 类与类之间的关系
### 依赖
  + A类使用到了B类一部分属性或方法。不会主动改变B类内的内容。
  + 代码化一些
    + 类A把类B的实例作为方法里的参数使用
    + 类A的某个方法里使用了类B的实例作为局部变量
    + 类A调用了类B的静态方法
  ```
  class Season{
  };
  class Goose{
    public:
       void Migrate(Season season); //或Migrate(Season *season)、Migrate(Season &season)
  };
  ```
  + 因为依赖和被依赖关系比较弱, 所以UML 图里使用虚线+箭头表示. 箭头指向被依赖者.而且一般是单向关系.
### 关联
  + 关联是一种弱关系，但并不是从属关系，关联的连个的类可以看作是平等的，比如一只大雁和老鹰的关系, 就可以看作关联关系
  + A类需要B类作为它的属性，以进行一定的读操作。
  + 因为比依赖关系更强，所以在 UML 图中使用是实线+箭头，双向关联可以省略箭头
  + C++中，通过定义其他类指针类型的成员来实现关联，下面是双向关联的实现方法
  ```
  class Egle{
    class Goose *food;
  };
  class Goose{
    class Egle *predator;
  };
  ```
### 聚合
  + 聚合是一种弱所属关系，比如一只大雁和雁群，就是一种"聚合"关系。和组合相比，被聚合的对象可以属于多个聚合对象，比如，一只大雁可能属于多个雁群。
  + 在 UML 图中使用空心菱形+实线+箭头表示, 箭头指向部分, 菱形指向整体。
  + 在C++语法中，通过类的指针来实现聚合
  ```
  class Goose{
  };
  class Geese{
    public:
        Goose member[10];
  };
  ```
### 组合
  + 组合是将一个对象（部分）放到另一个对象里（组合）。它是一种 "has-a" 的关系。相比"聚合"，组合是一种强所属关系，组合关系的两个对象往往具有相同的生命周期，被组合的对象是在组合对象创建的同时或者创建之后创建，在组合对象销毁之前销毁。一般来说被组合对象不能脱离组合对象独立存在，而且也只能属于一个组合对象。比如，鸟类和翅膀类就是组合关系，在创建一个鸟类对象时，一定要同时或之后创建一个翅膀类对象，销毁一个鸟类对象时，一定要先同时或之前销毁翅膀对象。
  + 在 UML 图中，实心菱形 + 实线 + 箭头表示, 菱形指向整体, 箭头指向部分
  + 在C++语法中，使用在一个类中包含另外一个类类型的成员来实现组合。
  ```
  class Wing{
  };
  class Bird{
    Wing wing;
  };
  ```
### 继承(泛化)
  + 继承是面向对象的三大特征之一，是一种最能体现面向对象代码复用的类关系，对于继承，可以使用"is a"来表示，比如，小轿车(类B)"is a"车(类A)，是对车(类A)的进一步刻画，那么这两个类就是"继承"关系。
  ```
  class Goose : public Bird{
    //子类扩展属性和方法
  };
  ```
  + UML 图中使用带三角箭头的实线表示, 箭头指向父类或父接口.
### 实现
  + 实现对应的是面向对象中的"接口"，即动物都要移动，但是每种移动的方式不一样，鸟要实现自己独有的移动的方法。
  + UML 中使用带三角箭头的虚线表示, 箭头指向接口
  + 在 C++ 中，接口通过的纯虚函数来实现，  C++ 的多态就是通过虚函数来实现的。
  ```
  class Animal{
    public:
        vitual void move();
  };
  class Bird: public Animal{
    void move(){
        //鸟的移动方式，飞
    }
  };
  ```
[^9]参考:https://www.cnblogs.com/h-hg/p/8784232.html[^9]
[^10]参考:https://blog.csdn.net/killfat/article/details/81275798[^10]
[^11]参考:https://www.jianshu.com/p/f35fab1640c6[^11]

# 操作系统
## Linux 系统信号
+ ***SIGHUP***

  本信号在用户终端连接(正常或非正常)结束时发出, 通常是在终端的控制进程结束时, 通知同一session内的各个作业, 这时它们与控制终端不再关联。
+ ***SIGINT***

  程序终止(interrupt)信号, 在用户键入INTR字符(通常是Ctrl-C)时发出，用于通知前台进程组终止进程。
+ ***SIGQUIT***

  和SIGINT类似, 但由QUIT字符(通常是Ctrl-/)来控制. 进程在因收到SIGQUIT退出时会产生core文件, 在这个意义上类似于一个程序错误信号。
+ ***SIGILL***

  执行了非法指令. 通常是因为可执行文件本身出现错误, 或者试图执行数据段. 堆栈溢出时也有可能产生这个信号。
+ ***SIGTRAP***

  由断点指令或其它trap指令产生. 由debugger使用。
+ ***SIGABRT***

  调用abort函数生成的信号。
+ ***SIGBUS***

  非法地址, 包括内存地址对齐(alignment)出错。比如访问一个四个字长的整数, 但其地址不是4的倍数。它与SIGSEGV的区别在于后者是由于对合法存储地址的非法访问触发的(如访问不属于自己存储空间或只读存储空间)。
+ ***SIGFPE***

  在发生致命的算术运算错误时发出. 不仅包括浮点运算错误, 还包括溢出及除数为0等其它所有的算术的错误
+ ***SIGKILL***

  用来立即结束程序的运行. 本信号不能被阻塞、处理和忽略。如果管理员发现某个进程终止不了，可尝试发送这个信号。
+ ***SIGUSR1***

  留给用户使用
+ ***SIGSEGV***

  试图访问未分配给自己的内存, 或试图往没有写权限的内存地址写数据.
+ ***SIGUSR2***

  留给用户使用
+ ***SIGPIPE***

  管道破裂。这个信号通常在进程间通信产生，比如采用FIFO(管道)通信的两个进程，读管道没打开或者意外终止就往管道写，写进程会收到SIGPIPE信号。此外用Socket通信的两个进程，写进程在写Socket的时候，读进程已经终止。
+ ***SIGALRM***

  时钟定时信号, 计算的是实际的时间或时钟时间. alarm函数使用该信号.
+ ***SIGTERM***

  程序结束(terminate)信号, 与SIGKILL不同的是该信号可以被阻塞和处理。通常用来要求程序自己正常退出，shell命令kill缺省产生这个信号。如果进程终止不了，我们才会尝试SIGKILL。
+ ***SIGCHLD***

  子进程结束时, 父进程会收到这个信号。
  如果父进程没有处理这个信号，也没有等待(wait)子进程，子进程虽然终止，但是还会在内核进程表中占有表项，这时的子进程称为僵尸进程。这种情况我们应该避免(父进程或者忽略SIGCHILD信号，或者捕捉它，或者wait它派生的子进程，或者父进程先终止，这时子进程的终止自动由init进程来接管)。
+ ***SIGCONT***

  让一个停止(stopped)的进程继续执行. 本信号不能被阻塞. 可以用一个handler来让程序在由stopped状态变为继续执行时完成特定的工作. 例如, 重新显示提示符
+ ***SIGSTOP***

  停止(stopped)进程的执行. 注意它和terminate以及interrupt的区别:该进程还未结束, 只是暂停执行. 本信号不能被阻塞, 处理或忽略.
+ ***SIGTSTP***

  停止进程的运行, 但该信号可以被处理和忽略. 用户键入SUSP字符时(通常是Ctrl-Z)发出这个信号
+ ***SIGTTIN***

  当后台作业要从用户终端读数据时, 该作业中的所有进程会收到SIGTTIN信号. 缺省时这些进程会停止执行.
+ ***SIGTTOU***

  类似于SIGTTIN, 但在写终端(或修改终端模式)时收到.
+ ***SIGURG***

  有"紧急"数据或out-of-band数据到达socket时产生.
+ ***SIGXCPU***
  超过CPU时间资源限制. 这个限制可以由getrlimit/setrlimit来读取/改变。
+ ***SIGXFSZ***

  当进程企图扩大文件以至于超过文件大小资源限制。
+ ***SIGVTALRM***

  虚拟时钟信号. 类似于SIGALRM, 但是计算的是该进程占用的CPU时间.
+ ***SIGPROF***

  类似于SIGALRM/SIGVTALRM, 但包括该进程用的CPU时间以及系统调用的时间.
+ ***SIGWINCH***

  窗口大小改变时发出.
+ ***SIGIO***

  文件描述符准备就绪, 可以开始进行输入/输出操作.
+ ***SIGPWR***

  Power failure
+ ***SIGSYS***

  非法的系统调用。


+ ***在以上列出的信号中，程序不可捕获、阻塞或忽略的信号有***：
  SIGKILL,SIGSTOP
+ ***不能恢复至默认动作的信号有***：
  SIGILL,SIGTRAP
+ ***默认会导致进程流产的信号有***：
  SIGABRT,SIGBUS,SIGFPE,SIGILL,SIGIOT,SIGQUIT,SIGSEGV,SIGTRAP,SIGXCPU,SIGXFSZ
+ ***默认会导致进程退出的信号有***：
  SIGALRM,SIGHUP,SIGINT,SIGKILL,SIGPIPE,SIGPOLL,SIGPROF,SIGSYS,SIGTERM,SIGUSR1,SIGUSR2,SIGVTALRM
+ ***默认会导致进程停止的信号有***：
  SIGSTOP,SIGTSTP,SIGTTIN,SIGTTOU
+ ***默认进程忽略的信号有***：
  SIGCHLD,SIGPWR,SIGURG,SIGWINCH

+ 此外，SIGIO在SVR4是退出，在4.3BSD中是忽略；SIGCONT在进程挂起时是继续，否则是忽略，不能被阻塞。

# 工程
## 请你回答一下git中, merge 和 rebase 区别
   + merge 会自动根据两个分支的共同祖先和两个分支的最新提交 进行一个三方合并, 然后将合并中修改的内容生成一个新的 commit,即 merge 合并两个分支并生成一个新的提交, 并且仍然后保存原来分支的 commit 记录
   + rebase 会从两个分支的共同祖先开始提取当前分支上的修改，然后将当前分支上的所有修改合并到目标分支的最新提交后面，如果提取的修改有多个，那 git 将依次应用到最新的提交后面。rebase 后只剩下一个分支的 commit 记录

# 思想(设计模式/思想, 编程思想)
## 关注点分离思想(Separation of concerns, SOC)
   + 就是在软件开发中，通过各种手段,将问题的各个关注点分开。
   + 如果一个问题能分解为独立且较小的问题,就是相对较易解决的.问题太过于复杂，要解决问题需要关注的点太多，而程序员的能力是有限的，不能同时关注于问题的各个方面。
   + 实现关注点分离的方法主要有两种，一种是标准化,另一种是抽象与封装。
     + **标准化**: 标准化就是制定一套标准,让使用者都遵守它，将人们的行为统一起来，这样使用标准的人就不用担心别人会有很多种不同的实现，使自己的程序不能和别人的配合。Java EE就是一个标准的大集合。每个开发者只需要关注于标准本身和他所在做的事情就行了。就像是开发镙丝钉的人只专注于开发镙丝钉就行了，而不用关注镙帽是怎么生产的，反正镙帽和镙丝钉按标来就一定能合得上。
     + **抽象与封装**:不断地把程序的某些部分抽像差包装起来,也是实现关注点分离的好方法。一旦一个函数被抽像出来并实现了，那么使用函数的人就不用关心这个函数是如何实现的，同样的，一旦一个类被抽像并实现了，类的使用者也不用再关注于这个类的内部是如何实现的。诸如组件，分层，面向服务，等等这些概念都是在不同的层次上做抽像和包装，以使得使用者不用关心它的内部实现细节。
  + 核心依然是 "高内聚，低耦合"
## OOP的设计模式的五项原则

### 开放-封闭原则
  + open模块的行为必须是开放的、支持扩展的，而不是僵化的。
  + closed在对模块的功能进行扩展时，不应该影响或大规模影响已有的程序模块。一句话概括：一个模块在扩展性方面应该是开放的而在更改性方面应该是封闭的。
  + 核心思想就是对抽象编程，而不对具体编程。
### 单一职责原则
  + 单一职责有2个含义，一个是避免相同的职责分散到不同的类中，另一个是避免一个类承担太多职责。减少类的耦合，提高类的复用性。
### 接口隔离原则(Interface Segregation Principle)
  + 这个原则就是说：使用多个隔离的接口，比使用单个接口要好。其实就是让我们 尽可能地细化接口，把每个完成某特定功能的方法都放在一个专门的接口里，而不是写成一个包含很多功能的胖接口。
  + 该原则的两个目的：
    + 一是降低互相关联的类之间的耦合性
    + 二是不让用户接触到它不需要的接口
### 里氏替换原则(Liskov Substitution Principle)
  + 只要 父类 能出现的地方 子类 就可以出现，而且替换为 子类 也不产生任何异常错误，反之则不然。这主要体现在，我们经常使用抽象类/基类做为方法参数，具体使用哪个子类作为参数传入进去，由调用者决定。
  + 主要针对继承的设计原则
    + 父类的方法都要在子类中实现或者重写，并且派生类只实现其抽象类中生命的方法，而不应当给出多余的,方法定义或实现。
    + 在客户端程序中只应该使用父类对象而不应当直接使用子类对象，这样可以实现运行期间绑定。
### 依赖倒置原则(Dependence Inversion Principle)
  + 高层模块不要依赖低层模块，所以依赖都应该是抽象的，抽象不应该依赖于具体细节而，具体细节应该依赖于抽象
    + 低层模块：不可分割的原子逻辑就是 低层模块
    + 高层模块：低层模块的组装合成后就是 高层模块
    + 抽象：C++ 中体现为基类，抽象类，而不单指抽象类
    + 细节：体现为子类，实现类
  + 通俗点讲，该原则包含以下几点要素
    + 模块间的依赖应该通过抽象发生，具体实现类之间不应该建立依赖关系
    + 接口或者抽象类不依赖于实现类，否则就失去了抽象的意义
    + 实现类依赖于接口或者抽象类

## 常见的设计模式
### 单例模式
   + 单例模式是一种常用的软件设计模式，其定义是单例对象的类只能允许一个实例存在。这种模式涉及到一个单一的类，该类负责创建自己的对象，同时确保只有单个对象被创建。这个类提供了一种访问其唯一的对象的方式，可以直接访问，不需要实例化该类的对象
   + 优点：
     + 1、在内存里只有一个实例，减少了内存的开销，尤其是频繁的创建和销毁实例(比如管理学院首页页面缓存)。
     + 2、避免对资源的多重占用(比如写文件操作)。
   + 缺点：没有接口，不能继承，与单一职责原则冲突，一个类应该只关心内部逻辑，而不关心外面怎么样来实例化。
   + 使用场景：
     + 1、要求生产唯一序列号。
     + 2、WEB 中的计数器，不用每次刷新都在数据库里加一次，用单例先缓存起来。
     + 3、创建的一个对象需要消耗的资源过多，比如 I/O 与数据库的连接等。
   + C++的实现有两种，一种通过局部静态变量，利用其只初始化一次的特点，返回对象。另外一种，则是定义全局的指针，getInstance判断该指针是否为空，为空时才实例化对象
```
template<typename T>
class Singleton {
public:
    static T& getInstance() {
        static T instance;
        return instance;
    }
private:
    Singleton();
};
```
[^8]参考:https://blog.csdn.net/q5707802/article/details/79251148[^8]

### 工厂模式
  + 工厂模式主要解决接口选择的问题。该模式下定义一个创建对象的接口，让其子类自己决定实例化哪一个工厂类，使其创建过程延迟到子类进行。
  + 优点
    + 解耦，代码复用，更改功能容易。
### 观察者模式
  + 定义对象间的一种一对多的依赖关系，当一个对象的状态发生改变时，所有依赖于它的对象都得到通知并被自动更新。
  + 观察者模式中分为观察者和被观察者，当被观察者发生装填改变时，观察者会受到通知。主要为了解决对象状态改变给其他对象通知的问题，其实现类似于观察者在被观察者那注册了一个回调函数。
### 装饰器模式
  + 装饰器模式主要是为了动态的为一个对象增加新的功能，装饰器模式是一种用于代替继承的技术，无需通过继承增加子类就能扩展对象的新功能。这种模式创建了一个装饰类，用来包装原有的类，并在保持类方法签名完整性的前提下，提供了额外的功能。使用对象的关联关系代替继承关系，更加灵活，同时避免类型体系的快速膨胀。
  + 优点
    + 装饰类和被装饰类可以独立发展，不会相互耦合，装饰模式是继承的一个替代模式，装饰模式可以动态扩展一个实现类的功能。
  + 缺点
    + 多层装饰比较复杂
  + 使用场景
    + 1、扩展一个类的功能。
    + 2、动态增加功能，动态撤销。
# 编程
## 写出完整版的strcpy函数
```
char *strcpy(char *dst, char *src){
    assert((dst != NULL) && (src != NULL));
    char *address = dst;
    while((*dst++ = *src++) != '\0');
    return address;
}
```

## 写一个“标准”宏MIN，这个宏输入两个参数并返回较小的一个
```
#define MIN(A,B) ((A) <= (B) ? (A) : (B))
```

## 编写一个函数，作用是把一个char组成的字符串循环右移n个。比如原来是“abcdefghi”如果n=2，移位后应该是“hiabcdefg”
```
void LoopMove(char *str, int steps) {
    int len = strlen(str);
    char tmp[MAXSIZE];
    memcpy(tmp, str+len-steps, steps);
    memcpy(str+steps, str, len-steps);
    memcpy(str, tmp, steps);
}
```
## 编写类String的构造函数、析构函数和赋值函数，已知类String的原型为:
```
class String
{
 public:
    String(const char *str = NULL); // 普通构造函数
    String(const String &other); // 拷贝构造函数
    ~ String(void); // 析构函数
    String & operator =(const String &other); // 赋值函数
    friend ostream &operator<<(ostream &os, String&s);
    friend istream &operator>>(istream &is, String&s);
    friend bool operator==(const String &s1, const String &s2);
 private:
     char *m_data; // 用于保存字符串
};
```
+ 答案:
```
//普通构造函数
String::String(const char *str) {
    if(str == NULL) {
        m_data = new char[1]; // 得分点：对空字符串自动申请存放结束标志'\0'的空
        //加分点：对m_data加NULL 判断
        *m_data = '\0';
    } else {
        int length = strlen(str);
        m_data = new char[length+1];
        strcpy(m_data, str);
    }
}
// String的析构函数
String::~String(void) {
    delete [] m_data; // 或delete m_data;
}
//拷贝构造函数
// 得分点：输入参数为const型
String::String(const String &other) {
    int length = strlen(other.m_data);
    m_data = new char[length+1]; 　　　　
    strcpy(m_data, other.m_data);
}
//赋值函数
// 得分点：输入参数为const型
String & String::operator =(const String &other) {
    //得分点：检查自赋值
    if(this == &other) 　　
        return *this;
    delete [] m_data; 　　　　//得分点：释放原有的内存资源
    int length = strlen( other.m_data );
    m_data = new char[length+1]; 　
    strcpy( m_data, other.m_data );
    return *this; 　　　　　　　　//得分点：返回本对象的引用
}

// 重载是否相等运算符
bool operator==(const String &s1, const String &s2) {
    for (int i = 0; s1.m_data[i] != '\0' && s2.m_data[i] != '\0'; i++ ) {
        if (s1.m_data[i] == s2.m_data[i]) {
            continue;
        } else {
            return false;
        }
    }
}

// 重载输出运算符
ostream &operator<<(ostream &os, String &s) {
    os << s.m_data;
    return os;
}

// 重载输入运算符
istream &operator>>(istream &is, String &s) {
    is >> s.m_data;
    return is;
}

剖析
能够准确无误地编写出String类的构造函数、拷贝构造函数、赋值函数和析构函数的面试者至少已经具备了C++基本功的60%以上！
在这个类中包括了指针类成员变量m_data，当类中包括指针类成员变量时，一定要重载其拷贝构造函数、赋值函数和析构函数，这既是对C++程序员的基本要求，也是《Effective　C++》中特别强调的条款。
仔细学习这个类，特别注意加注释的得分点和加分点的意义，这样就具备了60%以上的C++基本功！
```


