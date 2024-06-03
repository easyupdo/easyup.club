---
title: vue
date: 2020-09-17 10:02:53
tags: [vue]
published: false
---

### vue结构 [vue api](https://cn.vuejs.org/v2/api/#key)
vue中最常用的几个选项

1. **props**:
    
    - 类型:Array<string> | Object
    -详细:
    - **props** 可以是数组或对象，<span style="background-color: rgb(142, 218, 228);">用于接收来自父组件的数据</span>。props 可以是简单的数组，或者使用对象作为替代，对象允许配置高级选项，如类型检测、自定义验证和设置默认值。

    你可以基于对象的语法使用以下选项：

    - **type**：可以是下列原生构造函数中的一种：String、Number、Boolean、Array、Object、Date、Function、Symbol、任何自定义构造函数、或上述内容组成的数组。会检查一个 prop 是否是给定的类型，否则抛出警告。Prop 类型的更多信息在此。
    - **default**：any
    为该 prop 指定一个默认值。如果该 prop 没有被传入，则换做用这个值。对象或数组的默认值必须从一个工厂函数返回。
    - **required**：Boolean
    定义该 prop 是否是必填项。在非生产环境中，如果这个值为 truthy 且该 prop 没有被传入的，则一个控制台警告将会被抛出。
    - **validator**：Function
    自定义验证函数会将该 prop 的值作为唯一的参数代入。在非生产环境下，如果该函数返回一个 falsy 的值 (也就是验证失败)，一个控制台警告将会被抛出。你可以在这里查阅更多 prop 验证的相关信息。
2. **computed**
    - 类型:{ [key: string]: Function | { get: Function, set: Function } }
3. **watch**
    - 类型:{ [key: string]: string | Function | Object | Array }

### computerd vs watch
    
   - computed用来监控自己定义的变量，该变量不在data里面声明，直接在computed里面定义，然后就可以在页面上进行双向数据绑定展示出结果或者用作其他处理；
   - computed比较适合对多个变量或者对象进行处理后返回一个结果值，也就是数多个变量中的某一个值发生了变化则我们监控的这个值也就会发生变化，举例：购物车里面的商品列表和总金额之间的关系，只要商品列表里面的商品数量发生变化，或减少或增多或删除商品，总金额都应该发生变化。这里的这个总金额使用computed属性来进行计算是最好的选择.

#### 与watch之间的区别：

　　刚开始总是傻傻分不清到底在什么时候使用watch，什么时候使用computed。这里大致说一下自己的理解：

   - watch主要用于监控vue实例的变化，它监控的变量当然必须在data里面声明才可以，它可以监控一个变量，也可以是一个对象
   - watch一般用于监控路由、input输入框的值特殊处理等等，它比较适合的场景是一个数据影响多个数据

[vue:选项/数据](https://segmentfault.com/a/1190000014623142)

### 使用过程

1. 组件之间通讯
  - props: 可以用于父子间通讯 (子组件发消息给父组件可以用emit)
    + 这种传递方式一般是将父组件中的data中的数据传递到子组件中,其实这种传递方式只跟子组件有关,即:只要子组件中定义了该props,那么在父组件中使用子组件时就可以想传递普通的属性一样传递自定义的数据到子组件,传递方式是:
    ```c
    //App.vue父组件
    <template>
    <div id="app">
        <users v-bind:users="users"></users>//前者自定义名称便于子组件调用，后者要传递数据名
        <user :fromappmsg={{appmsg}}> //将appmsg传递给子组件user的fromappmsg(props)
    </div>
    </template>
    <script>
    import Users from "./components/Users"
    export default {
    name: 'App',
    data(){
        return{
        users:["Henry","Bucky","Emily"],
        appmsg: '这是要传递给自组件的MSG'
        }
    },
    components:{
        "users":Users
    }
    }
    ```
    ```c
    //users子组件
    <template>
    <div class="hello">
        <ul>
        <li v-for="user in users">{{user}}</li>//遍历传递过来的值，然后呈现到页面
        </ul>
        <div>接收的消息:{{fromappmsg}}</div>
    </div>
    </template>
    <script>
    export default {
    name: 'HelloWorld',
    props: {
        users: {           //这个就是父组件中子标签自定义名字 //一般都会加上验证
        type:Array,
        required:true
        },
        fromappmsg:{
            type: String,
            required: true
        }
    }
    }
    </script>
    ```
    [注]也就是说组件中props是用来声明的,其对应的是父组件中data传过来的.换句话说就是父组件的data传给子组件的props声明的变量.
  - eventbus: 可以用于父子间通讯,兄弟间通讯
  - vuex: vue2.0后推荐的通讯方式.

- created(){} :该函数在组件初始化完成后调用

- $on('事件名称',事件函数) :组册一个事件

- $emit('事件名称',参数1,参数2,...) :触发一个事件



#### VUE 
##### vue使用axios (标红处坑死人不偿命的)
- 方法一: 直接引用

//安装axios
> npm install -save axiox

// 导入.vue
> import <span style="background-color:red">axiox</span> from 'axios' //标红不区分大小写 大小写都可以

// 使用vueprototype扩展
> Vue.prototype.$<span style="background-color:red">axios</span> = axios / Vue.prototype.axios = axios  //标红不区分大小写 大小写都可以

// 在vue中使用: 举例常用的methods:
```c
methods:{
    doAxios(){
        this.$axios.get('http://www.baidu.com') //只能用this
    }
}
```


- 方法二:使用插件的方式引入

//安装axios vue-axios
> npm install -save axios vue-axios

// 导入.vue
> import VueAxios from 'vue-axios' //这是vue中对axios的一个包装器
> import <span style="background-color:red">axios</span> from 'axios'   //标红只能是小写

//使用Vue.usea安装插件(axios)
> Vue.use(VueAxios,axios)

// 在vue中使用: 举例常用的methods:
```c
methods:{
    doAxios(){
        Vue.axios.get('http://www.baidu.com')
    }
}
```