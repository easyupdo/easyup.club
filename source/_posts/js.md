---
title: js
date: 2020-07-13 09:32:31
tags: js , nodejs
---

* [N-API](#n-api)
* [nodejs module系统](#nodejs-module系统)
* [使用node-gyp编译使用N-API的cpp代码.](#使用node-gyp编译使用n-api的cpp代码)
* [react native](#react-native)
* [typescript](#typescript)
* [typescript 关键词](#typescript-关键词)
* [HTML问题](#html问题)

### N-API
``` c++
// 首先要引用 node_api.h
#include <node_api.h>

// 定义native方法 SayHello 打印一个字符串"Hello"
napi_value SayHello(napi_env env, napi_callback_info info) {
  printf("Hello\n");
  return nullptr;
}
// 如果把hello.cc看做js文件，则Init 方法的作用就是初始化当前module。
// 但是Init方法不能修改module，只能修改module的exports。
// env :当前javascript的上下文文件
// exports : 即可看做当前文件的model.exports，初始化之前是一个空对象。
napi_value Init(napi_env env, napi_value exports) {
  napi_status status;
  napi_value fn;

// 将上面的SayHello 方法生成一个可供javascript调用的napi_value对象。
// 并且赋值给指针 fn。
// status 为是否生成成功的状态值 ，若成功则值为 napi_ok。
  status =  napi_create_function(env, nullptr, 0, SayHello, nullptr, &fn);
  if (status != napi_ok) return nullptr;

// 将刚才生成的javascript 对象方法fn 添加到exports中，属性名为sayHello
// 翻译为javascript代码为：exports.sayHello = fn;
  status = napi_set_named_property(env, exports, "sayHello", fn);
  if (status != napi_ok) return nullptr;

 // 后将exports 返回 完成module的初始化
  return exports;
}

// 注册当前module
NAPI_MODULE(NODE_GYP_MODULE_NAME, Init)
```

<!--more-->

#### nodejs module系统
```c++
//直接导出对象 引用该模块的代码不需要使用new初始化 可以直接使用.
module.exports = {}// nodejs的模块公共访问的接口
module.exports = {
    "name":"jay",
    "age":18,
    "fun":function tj(){console.log("log")}
}

//ES5写法导出带有构造方法的对象  引用该模块的代码需要使用new初始化
module.exports = function Test(){
    this.name = "jay";
    this.fun = function tj(){console.log("log")}
}


//ES6 Class写法导出对象  引用该模块的代码同样需要使用new来初始化
module.exports = class Test {
    constructor(){
    }
    tfun(){
        console.log("This is class Test.tfun");
    }
};
```

### 使用node-gyp编译使用N-API的cpp代码.

node-gyp使用binding.gyp作为项目的配置文件(名字是固定的)
```c++
binding.gyp:
{
  "targets": [
    {
      "target_name": "hello",
      "sources": [ "./hello.cc" ]
    }
  ]
}
node-gyp指令:
$node-gyp configure //自动配置gyp项目
$node-gyp build     //使用binding.gyp组建项目
$node-gyp clean     //清理byp项目

$node-gyp rebuild ={node-gyp configure + node-gyp build + node-gyp clean}
之后会被编译成{文件名}.node 位置在/build/Release/xxx.node
在需要引入该模块的js文件中,需要var xxx = reauire(../build/Release/xxx);
```

### react native

用到的工具有:reactnative,react-native-cli
使用npm install react-native-cli -g 全局安装react-native-cli脚手架工具

helloworld工程:
使用react-native init myapp //初始化app
工程结构:
├── App.js                  // App组件
├── HelloWorld.js           //user helloworld组件 测试 jay添加的
├── RN.md                   // 学习笔记
├── __tests__               //test目录
├── android                 // android目录
├── app.json                //app.json
├── babel.config.js         //babel工具配置文件
├── index.js                //入口
├── ios                     //ios目录
├── metro.config.js         
├── node_modules
├── package-lock.json
└── package.json            //npm工具包配置


rn入口为index.js.rn中全是组建,在index.js中就是把组建注册???



### typescript

- 变量声明:
```ts
 typescript提供可选类型.
 var name:string = "jay";
 var age:number = 18;
```

- 类:
```ts
class TS {
    //属性:
    name:string;
    age:number;
    //方法:
    GetName():string{
        return this.name;
    }
}
```
```ts
- 类声明关键词:
//声明类
declare class TS{

} ;
```
#### typescript 关键词
> interface 和 type
```ts
interface TS{
}

type TS = {

}

type Jstring = string;
type JstringOrJnum = string|number;
type Jtype = [string,number]

interface只能声明一个对象或者函数,type不仅可以声明一个对象或者函数而且还可以声明基本类型别名，联合类型，元组等类型
```
- interface 和 class
typescript中声明一个类型，我们通常会有两种做法：
1. 使用class
```ts
  export default class state {
    userInfo: {
        name: string,
        age: number
    }
}
```
2. 使用interface:
```ts
export interface STATE {
    userInfo : {
        name: string,
        age: number
    }
}
```
> 由于typescript的宗旨是兼容js，运行时要擦除所有类型信息，
因此interface在运行时是会被完全消除的。
而class经过编译后，在运行时依然存
在。因此如果要声明的类型只是纯粹的类型信息，只需要声明interface即可。

}


- typescript ?: 
```ts
typescript 中 ?:表示可选
class TS{
    name:string; //必选项
    age?:number; //可选项
}
```

### HTML问题

在HTML中元素使用js函数的时候要保证函数定义和使用在一个块中.
例如:
``` html

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Hello World!</title>
  <meta http-equiv="Content-Security-Policy" content="script-src 'self' 'unsafe-inline';" />
  <script src="./renderer.js">
  </script>
</head>
<body>
  <h1 id="h1">Hello World!</h1>
  <script>
    function work() { //定义在body中,body中可以使用
      console.log("This is Do");
    }
  </script>
  <button id="btn" onclick="work()">button</button>
</body>
</html>
button在使用onclick的时候是可以访问work函数
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Hello World!</title>
  <meta http-equiv="Content-Security-Policy" content="script-src 'self' 'unsafe-inline';" />
  <script src="./renderer.js">
    function work() { //虽然定义了 但是是定义在headr中 在body中访问不到
      console.log("This is Do");
    }
  </script>
</head>
<body>
  <h1 id="h1">Hello World!</h1>
  <button id="btn" onclick="work()">button</button>
</body>
</html>
button在使用onclick的时候访问不到work函数
```




