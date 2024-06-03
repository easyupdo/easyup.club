---
title: gtest-gmock
date: 2021-10-13 15:34:38
tags: [gtest,gmock]
published: false
---

#### gmock

gmock 用来模拟接口，使得测试脱离函数间的依赖

```c
//demo.h
#include <string>
using namespace std;

class Parent {
  public:
    virtual ~Parent() {}

    virtual int getNum() const = 0;
    virtual void setResult(int value) = 0;
    virtual void print(const string &str) = 0;
    virtual int calc(int a, double b) = 0;
};

class Target {
  public:
    Target(Parent *parent) :
        parent_(parent)
    { }

    int doThis()
    {
        int v = parent_->getNum();
        parent_->setResult(v);
        while (v -- > 0) {
            parent_->print(to_string(v));
        }
        return parent_->getNum();
    }

    int doThat()
    {
        return parent_->calc(1, 2.2);
    }

  private:
    Parent *parent_;
};

//demo.cc
#include "demo.h"
#include <gmock/gmock.h>

class MockParent : public Parent {
  public:
//! MOCK_[CONST_]METHODx(方法名, 返回类型(参数类型列表));
    MOCK_CONST_METHOD0(getNum, int());    //! 由于 getNum() 是 const 成员函数，所以要使用 MOCK_CONST_METHODx
    MOCK_METHOD1(setResult, void(int));
    MOCK_METHOD1(print, void(const string &));
    MOCK_METHOD2(calc, int(int, double));
};

using ::testing::Return;
using ::testing::_;

TEST(demo, 1) {
    MockParent p;
    Target t(&p);

    //! 设置 p.getNum() 方法的形为
    EXPECT_CALL(p, getNum())
        .Times(2)    //! 期望被调两次
        .WillOnce(Return(2))   //! 第一次返回值为2
        .WillOnce(Return(10)); //! 第二次返回值为10

    //! 设置 p.setResult(), 参数为2的调用形为
    EXPECT_CALL(p, setResult(2))
        .Times(1);

    EXPECT_CALL(p, print(_))  //! 表示任意的参数，其中 _ 就是 ::testing::_ ，如果冲突要注意
        .Times(2);

    EXPECT_EQ(t.doThis(), 10);
}

TEST(demo, 2) {
    MockParent p;
    Target t(&p);

    EXPECT_CALL(p, calc(1, 2.2))
        .Times(1)
        .WillOnce(Return(3));

    EXPECT_EQ(t.doThat(), 3);
}
```

##### 由于gmock是用来测试c++的，但是在实际测试中有对c函数测试的需求，我们使用一下库来对c函数打桩
https://github.com/apriorit/gmock-global

```c
//1.引入头文件
#include <gmock/gmock.h>
#include "gmock-global.h"

// 2. mockc函数
MOCK_GLOBAL_FUNC2(popen,FILE*(const char*,const char*));

// 3. 使用函数
TEST(ConfigLoader,shell){
    std::string cmd = "ls";
    EXPECT_GLOBAL_CALL(popen,popen(cmd.c_str(), "r")).Times(2).WillOnce(::testing::Return((FILE*)NULL));
    shell("pwd");  //shell是实现的一个函数不是 cmd-shell
}
```



#### lcov 测试代码覆盖度 https://www.cnblogs.com/chwei2ch/p/10678467.html
