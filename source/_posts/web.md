---
title: web
date: 2020-10-13 17:40:08
tags: [web html js]
---

# html 表单<form>
- 常使用的为
```c
<form action="提交的url" methed="post">
Name:<input type="text" name="name">
Passwd:<input type="text" name="passwd">
<input type="submit" value="提交">
</form>
会使用name:输入的值 passwd:输入的值 提交到后台
```
使用action和ajax提交form数据例子:
- 使用action提交表单数据
```c
 <form method="POST" action="/login/">
        <label>Name:</label> <input type="text" name="name">
        <label>Passwd:</label><input type="text" name="passwd">
        <input type="submit" value="登陆" id="login"  >
 </form>
 
```
- 使用ajax提交表单数据
```c

    <form id="form">
        <label>Name:</label> <input type="text" name="name">
        <label>Passwd:</label><input type="text" name="passwd">
        <input type="submit" value="登陆" id="login"  >
    </form>

    <script src="../static/js/jquery.min.js"></script>
    <script>
        $("#login").click(function () {
            $.ajax({
                type: 'POST',
                url: '/login/',
                data: $("form").serialize(),//获取表单数据
                success: function (params) {
                    console.log("Get login.html success")
                    console.log(params)
                },
                error: function (params) {
                    console.log("Get login.html error")
                }
            });
            return false;//禁止提交表单(禁止get提交 要不然post提交后还会有一个get提交)
        });
    </script>
```

## django 跨域问题

方法一:
```c
最常用的方法是在view.py中引入 
from django.views.decorators.csrf import csrf_exempt
然后在跨域访问的方法上使用 @csrf_exempt 声明
这样即可处理django跨域访问问题
```
方法二:
```c
也可以使用django插件处理跨域问题 具体搜索
```

- django返回页面的方法
```c
在view模块中，我们可以定义返回的页面以及数据，目前总结当前用的几种方法

1. return HttpResponse（'hello world'）

这种方法可以直接放回html的body。

2. return render(request,'xx.html',{'data':xxxx})

这种方法可以返回某个页面，并且可以在返回的页面中使用模板来调用我们返回的数据，这种方法也是应用最多的方法

3. return HttpResponseRedirect（'/index/'）

这种方法是通过返回路径，然后去urls中匹配页面，通常用来重定向使用，应用次数也挺多。

4、不通过view模块，直接跳转html

在url模块中使用from django.views.generic import TemplateView 模块

url(r'^register_go/$', TemplateView.as_view(template_name='register.html')),然后在url中可以直接指向url，不需要通过view模块来实现页面的跳转
```

## django auth模块

 ### 一. 什么是author模块
Auth模块是Django自带的用户认证模块，可以实现包括用户注册、用户登录、用户认证、注销、修改密码等功能。默认使用 auth_user 表来存储用户数据。

### 二、auth模块的使用
1. 创建超级用户（create_superuser()）
```c
创建超级用户就是在auth_user表中插入数据，密码是加密的，因此不能手动在数据库中插入数据

（1）用命令创建

python3 manage.py createsuperuser
（2）用Python代码创建

from django.contrib.auth.models import User
user = User.objects.create_superuser（username='用户名',password='密码',email='邮箱',...）
```
2. 验证用户（authenticate()）
```c
验证用户名以及密码是否正确，一般需要username 、password两个关键字参数。如果认证成功（用户名和密码正确有效），便会返回一个 User 对象

from django.contrib import auth
user = auth.authenticate(request, username=name, password=pwd)
相当于是在数据库中查询：

user=models.User.objects.filter(name=name,pwd=pwd).first()
```
3. 登录用户（login()）
```c
该函数接受一个HttpRequest对象，以及一个经过认证的User对象。

该函数实现一个用户登录的功能。它本质上会在后端为该用户生成相关session数据。

user = auth.authenticate(username=username, password=password)
if user is not None:
    login(request, user)
    return HttpResponse('登录成功')
```
4. 登录成功
```c
一旦登录成功，调了这个函数login(request,user)，在以后的视图类（函数）中的request中就会有一个user对象，就是当前已登录的用户对象。
```
5. 注销（logout()）
```c
该函数接受一个HttpRequest对象，无返回值。

当调用该函数时，当前请求的session信息会全部清除，即调用request.session.flush()。该用户即使没有登录，使用该函数也不会报错。

auth.logout(request)
```
6. 登录认证装饰器
```c
快捷的给某个视图添加登录校验。

若用户没有登录，则会跳转到django默认的 登录URL '/accounts/login/ ' 并传递当前访问url的绝对路径 (登陆成功后，会重定向到该路径)。

如果需要自定义登录的URL，则需要在settings.py文件中通过LOGIN_URL进行修改。

from django.contrib.auth.decorators import login_required

@login_required(redirect_field_name='eee',login_url='/login/')
# redirect_field_name:修改?后面的key值,一般不回去修改

# login_url:如果没有登录,跳转到的页面
    # login_url局部配置
    @login_required(login_url='/login/')
    
    # login_url全局配置
    # 在setting文件中配置    
    LOGIN_URL='/login/'
    直接使用 @login_required
```
7. 创建普通用户（create_user()）
```c
from django.contrib.auth.models import User
user = User.objects.create_user（username='用户名',password='密码',email='邮箱',...）
```
8. 校验密码（check_password()）
```c
# 先拿到用户(可以是登录用户,可以现查)
user = request.user
# 或者 
user = authenticate(username=username, password=password)

pwd = request.POST.get('pwd')
ret = user.check_password(pwd)
```
9. 修改密码（set_password()）
```c
注意：设置完一定要调用用户对象的save方法！！！

修改密码时，可以先校验原密码输入是否正确，原密码正确再开始修改密码

user.set_password(pwd)
user.save()
```
10. is_authenticated()
```c
用来判断当前请求是否通过了认证。如果通过验证，是true，反之false

ret = request.user.is_authenticated()
```
11. 删除用户
```c
删除用户和用orm在表中删除数据一样
```
12. User对象的其他属性
```c
# 在网站上线以前，将is_active和is_staff设置为False
is_active    # 禁止登录网站(用户还存在,封号)
is_staff    # 是否对网站有管理权限(能不能登录admin)

request.user.is_active = False
request.user.is_staff = False
```
### 三、扩展默认的auth_user表
1. 方法一：定义一个表模型,跟User一对一关联
```c
from django.contrib.auth.models import User

class UserDetail(models.Model):
    phone=models.CharField(max_length=32)
    # 一对一跟auth_user表做关联
    # 如果是从外部引入的表模型,是不能加引号的
    # 如果加引号,只是在当前model找
    user=models.OneToOneField(to=User)
```    
2. 方法二：定义一个表模型,继承(AbstractUser)
```c
from django.contrib.auth.models import AbstractUser

class UserInfo(AbstractUser):
    # username,password...都继承了
    phone=models.CharField(max_length=32)
    sex=models.BooleanField()
    
注意：

一旦我们通过继承来实现扩展auth_user表，那么做数据库迁移，以后就没有auth_user这个表了，以后认证组件用的表就是UserInfo。原来使用 auth_user 表模型的地方全部要用新的表模型——UserInfo

引用Django自带的User表，继承使用时需要设置，在setting中对新表进行配置:

AUTH_USER_MODEL ='app01.UserInfo'
```

## 前端判断用户登陆行为
- 前端判断用户登录状态方法
网站有很多权限控制，登录用户和未登录用户显示的内容有差别。
前后端分离后，前端怎样判断用户是否已登录？有哪些方式？

```c
方法一：

登录成功后，后端返回一个 cookie，根据这个 cookie 的有无来判断；退出登录时，后端会删除这个 cookie；

方法二：

登录成功后，前端设置 cookie，比如'isLogin = true'，根据isLogin的值去判断；退出登录时删除 cookieisLogin 或设置  'isLogin = false'。

方法三：

前台发送登录请求
后台返回 token，前台得到后台返回的 token，将其写入到 localStorage 中，后续请求中都携带 token
后台判断 token 是否过期，如果过期就对前台的请求响应过期标识或者状态码
前台得到过期标识后，清除 localStorage 中的 token，然后重定向到 login 路由
```
- 基于token的身份验证
```c
基于Token的身份验证

在实现登录功能的时候,正常的B/S应用都会使用cookie+session的方式来做身份验证,后台直接向cookie中写数据,但是由于移动端的存在,移动端是没有cookie机制的,所以使用token可以实现移动端和客户端的token通信。

验证流程

整个基于Token的验证流程如下:

客户端使用用户名跟密码请求登录
服务器收到请求,去验证用户名和密码
验证成功后,服务端会签发一个Token,再把这个Token发送到客户端
客户端收到的Token以后可以把它存储起来,比如放在Cookie或LocalStorage里
客户端每次向服务器发送其他请求的时候都要带着服务器签发的Token
服务器收到请求,去验证客户端请求里面带着的Token,如果验证成功,就像客户端返回请求的数据
```

## ajax 上传文件 [web参考手册](https://developer.mozilla.org/zh-CN/docs/Web/API)
 - 一般使用 FormData
```c
    // 提交文件
    $("#net_files").change(function () {
    var files = this.files
    console.log(files)
    console.log(files[0])
    var formdata = new FormData();
    for(var i = 0;i< files.length;i++){
        formdata.append("file",files[i])
        console.log("file:",files[i])
    }
    $.ajax({
        type: 'POST',
        url: '/hello/',
        data: formdata,
        cache: false,
        processData: false,
        contentType: false,
        async: false,
        success: function (params) {
            console.log("ajax 执行成功")
            console.log(params)
        },
        error: function (params) {
            console.log("ajax 执行失败")
        }
    })
})
```
- jQuery中的ajax完整参数

1. url:

> 要求为String类型的参数，（默认为当前页地址）发送请求的地址。


2. type:
> 要求为String类型的参数，请求方式（post或get）默认为get。注意其他http请求方法，例如put和delete也可以使用，但仅部分浏览器支持。


3. timeout:

> 要求为Number类型的参数，设置请求超时时间（毫秒）。此设置将覆盖$.ajaxSetup()方法的全局设置。

4. async:

> 要求为Boolean类型的参数，默认设置为true，所有请求均为异步请求。如果需要发送同步请求，请将此选项设置为false。注意，同步请求将锁住浏览器，用户其他操作必须等待请求完成才可以执行。

5. cache:

> 要求为Boolean类型的参数，默认为true（当dataType为script时，默认为false），设置为false将不会从浏览器缓存中加载请求信息。

6. data:

> 要求为Object或String类型的参数，发送到服务器的数据。如果已经不是字符串，将自动转换为字符串格式。get请求中将附加在url后。防止这种自动转换，可以查看　　processData选项。对象必须为key/value格式

7. dataType:

> 要求为String类型的参数，预期服务器返回的数据类型。如果不指定，JQuery将自动根据http包mime信息返回responseXML或responseText，并作为回调函数参数传递。可用的类型如下：

8. xml：
> 返回XML文档，可用JQuery处理。
9. html：
> 返回纯文本HTML信息；包含的script标签会在插入DOM时执行。
10. script：
> 返回纯文本JavaScript代码。不会自动缓存结果。除非设置了cache参数。注意在远程请求时（不在同一个域下），所有post请求都将转为get请求。
11. json：
> 返回JSON数据。
12. jsonp：
> JSONP格式。使用SONP形式调用函数时，
例如myurl?callback=?，JQuery将自动替换后一个“?”为正确的函数名，以执行回调函数。
13. text：
> 返回纯文本字符串。
14. beforeSend：

>要求为Function类型的参数，发送请求前可以修改XMLHttpRequest对象的函数，例如添加自定义HTTP头。在beforeSend中如果返回false可以取消本次ajax请求。XMLHttpRequest对象是惟一的参数。<br>
function(XMLHttpRequest){    
    this;   //调用本次ajax请求时传递的options参数    
}
15. complete：

> 要求为Function类型的参数，请求完成后调用的回调函数（请求成功或失败时均调用）。参数：XMLHttpRequest对象和一个描述成功请求类型的字符串。<br>
function(XMLHttpRequest, textStatus){
    this;    //调用本次ajax请求时传递的options参数
}
16. success：

> 要求为Function类型的参数，请求成功后调用的回调函数，有两个参数。
(1)由服务器返回，并根据dataType参数进行处理后的数据。
(2)描述状态的字符串。<br>
function(data, textStatus){
    //data可能是xmlDoc、jsonObj、html、text等等
    this;  //调用本次ajax请求时传递的options参数
}
17. error:

要求为Function类型的参数，请求失败时被调用的函数。该函数有3个参数，即XMLHttpRequest对象、错误信息、捕获的错误对象(可选)。ajax事件函数如下：

function(XMLHttpRequest, textStatus, errorThrown){
//通常情况下textStatus和errorThrown只有其中一个包含信息
this;   //调用本次ajax请求时传递的options参数
}
18. contentType：

> 要求为String类型的参数，当发送信息至服务器时，内容编码类型默认为 "application/x-www-form-urlencoded" 。该默认值适合大多数应用场合。

19. dataFilter：

> 要求为Function类型的参数，给Ajax返回的原始数据进行预处理的函数。提供data和type两个参数。data是Ajax返回的原始数据，type是调用jQuery.ajax时提供的dataType参数。函数返回的值将由jQuery进一步处理。<br>
function(data, type){
    //返回处理后的数据
    return data;
}
20. dataFilter：

>要求为Function类型的参数，给Ajax返回的原始数据进行预处理的函数。提供data和type两个参数。data是Ajax返回的原始数据，type是调用jQuery.ajax时提供的dataType参数。函数返回的值将由jQuery进一步处理。<br>
function(data, type){
    //返回处理后的数据
    return data;
}
21. global：

> 要求为Boolean类型的参数，默认为true。表示是否触发全局ajax事件。设置为false将不会触发全局ajax事件，ajaxStart或ajaxStop可用于控制各种ajax事件。

22. ifModified：

> 要求为Boolean类型的参数，默认为false。仅在服务器数据改变时获取新数据。服务器数据改变判断的依据是Last-Modified头信息。默认值是false，即忽略头信息。

23. jsonp：

> 要求为String类型的参数，在一个jsonp请求中重写回调函数的名字。该值用来替代在"callback=?"这种GET或POST请求中URL参数里的"callback"部分，例如{jsonp:'onJsonPLoad'}会导致将"onJsonPLoad=?"传给服务器。

24. username：

> 要求为String类型的参数，用于响应HTTP访问认证请求的用户名。

25. password：

> 要求为String类型的参数，用于响应HTTP访问认证请求的密码。

26. processData：

> 要求为Boolean类型的参数，默认为true。默认情况下，发送的数据将被转换为对象（从技术角度来讲并非字符串）以配合默认内容类型"application/x-www-form-urlencoded"。如果要发送DOM树信息或者其他不希望转换的信息，请设置为false。

27. scriptCharset：

> 要求为String类型的参数，只有当请求时dataType为"jsonp"或者"script"，并且type是GET时才会用于强制修改字符集(charset)。通常在本地和远程的内容编码不同时使用。<br>
   > ```c
   > $(function(){
   >     $('#send').click(function(){
   >         $.ajax({
   >         type: "GET",
   >         url: "test.json",
   >         data: {username:$("#username").val(), content:$("#content").val()},
   >         dataType: "json",
   >         success: function(data){
   >                     console.log(data);
   >                 }
   >          });
   >     });
   >  });
   >  ```

### 后台(python)处理上传的文件

从request.FILES中获得的真实的文件。这个字典的每个输入都是一个UploadedFile对象——一个上传之后的文件的简单的包装。

###### 你通常会使用下面的几个方法来访问被上传的内容：

* UploadedFile.read（）：从文件中读取整个上传的数据。小心整个方法：如果这个文件很大，你把它读到内存中会弄慢你的系统。你可以想要使用chunks（）来代替，看下面；
* UploadedFile.chunks()：如果上传的文件足够大需要分块就返回真。默认的这个值是2.5M，当然这个值是可以调节的。
一个简单的例子：
```html
<form id="myform" enctype="multipart/form-data">
    <span>选择上传的文件</span><input type="file" id="upload" name="myfiles" multiple><br/>
    <input id="submit" type="button" value="上传">
</form>
<script>
    $(document).ready(function(){
        $("#submit").click(function () {
            var form_data = new FormData();
            var len = $('#upload')[0].files.length;
            for(var i =0;i<len;i++) {
                var file_info = $('#upload')[0].files[i];
                form_data.append('myfiles', file_info);
            }
            $.ajax({
                url:'upload/',   // 这里对应url.py中的 url(r'upload', views.upload)
                type:'POST',
                data: form_data,
                processData: false,  // tell jquery not to process the data
                contentType: false, // tell jquery not to set contentType
                success: function(callback) {
                    alert('success');
                }
            });
        });
    });
</script>
```
```py
//后台
//uploadfile.views.py
from django.http import HttpResponse

def upload(request):
    if request.method == 'POST':
        files = request.FILES.getlist('myfiles')
        for f in files:
            file = open('file/' + f.name, 'wb+')
            for chunk in f.chunks():
                file.write(chunk)
            file.close()
        return HttpResponse("OK!")
    else:
        return HttpResponse("NOT OK!")
```


在f.chunks()上循环而不是用read()保证大文件不会大量使用你的系统内存。


### Django 设置cookie 设置session 后台传递前端数据
[django设置cookie/sessio](https://www.cnblogs.com/Sunzz/p/10573246.html)

#### 自签名证书
 ##### 引言
使用HTTP（超文本传输）协议访问互联网上的数据是没有经过加密的。也就是说，任何人都可以通过适当的工具拦截或者监听到在网络上传输的数据流。但是有时候，我们需要在网络上传输一些安全性或者私秘性的数据，譬如：包含信用卡及商品信息的电子订单。这个时候，如果仍然使用HTTP协议，势必会面临非常大的风险！相信没有人能接受自己的信用卡号在互联网上裸奔。

HTTPS（超文本传输安全）协议无疑可以有效的解决这一问题。所谓HTTPS，其实就是HTTP和SSL/TLS的组合，用以提供加密通讯及对网络服务器的身份鉴定。HTTPS的主要思想是在不安全的网络上创建一安全信道，防止黑客的窃听和攻击。

SSL（安全套接层）可以用来对Web服务器和客户端之间的数据流进行加密。

SSL利用非对称密码技术进行数据加密。加密过程中使用到两个秘钥：一个公钥和一个与之对应的私钥。使用公钥加密的数据，只能用与之对应的私钥解密；而使用私钥加密的数据，也只能用与之对应的公钥解密。因此，如果在网络上传输的消息或数据流是被服务器的私钥加密的，则只能使用与其对应的公钥解密，从而可以保证客户端与与服务器之间的数据安全。

 ##### 数字证书（Certificate）
在HTTPS的传输过程中，有一个非常关键的角色——数字证书，那什么是数字证书？又有什么作用呢？

所谓数字证书，是一种用于电脑的身份识别机制。由数字证书颁发机构（CA）对使用私钥创建的签名请求文件做的签名（盖章），表示CA结构对证书持有者的认可。数字证书拥有以下几个优点：

使用数字证书能够提高用户的可信度
数字证书中的公钥，能够与服务端的私钥配对使用，实现数据传输过程中的加密和解密
在证认使用者身份期间，使用者的敏感个人数据并不会被传输至证书持有者的网络系统上
X.509证书包含三个文件：key，csr，crt。

key是服务器上的私钥文件，用于对发送给客户端数据的加密，以及对从客户端接收到数据的解密
csr是证书签名请求文件，用于提交给证书颁发机构（CA）对证书签名
crt是由证书颁发机构（CA）签名后的证书，或者是开发者自签名的证书，包含证书持有人的信息，持有人的公钥，以及签署者的签名等信息
备注：在密码学中，X.509是一个标准，规范了公开秘钥认证、证书吊销列表、授权凭证、凭证路径验证算法等。

##### 创建自签名证书的步骤
注意：以下步骤仅用于配置内部使用或测试需要的SSL证书。

- 第1步：生成私钥
使用openssl工具生成一个RSA私钥

 
```c
$ openssl genrsa -des3 -out server.key 2048
说明：生成rsa私钥，des3算法，2048位强度，server.key是秘钥文件名。

注意：生成私钥，需要提供一个至少4位的密码。
```
- 第2步：生成CSR（证书签名请求）
    生成私钥之后，便可以创建csr文件了。

    此时可以有两种选择。理想情况下，可以将证书发送给证书颁发机构（CA），CA验证过请求者的身份之后，会出具签名证书（很贵）。另外，如果只是内部或者测试需求，也可以使用OpenSSL实现自签名，具体操作如下：

 
```c
$ openssl req -new -key server.key -out server.csr
说明：需要依次输入国家，地区，城市，组织，组织单位，Common Name和Email。其中Common Name，可以写自己的名字或者域名，如果要支持https，Common Name应该与域名保持一致，否则会引起浏览器警告。


Country Name (2 letter code) [AU]:CN
State or Province Name (full name) [Some-State]:Beijing
Locality Name (eg, city) []:Beijing
Organization Name (eg, company) [Internet Widgits Pty Ltd]:joyios  //可以为空
Organizational Unit Name (eg, section) []:info technology          //可以为空
Common Name (e.g. server FQDN or YOUR name) []:demo.joyios.com     //可以为空
Email Address []:liufan@joyios.com                                 //可以为空
 ```

- 第3步：删除私钥中的密码
在第1步创建私钥的过程中，由于必须要指定一个密码。而这个密码会带来一个副作用，那就是在每次Apache启动Web服务器时，都会要求输入密码，这显然非常不方便。要删除私钥中的密码，操作如下：

 
```c
cp server.key server.key.org
openssl rsa -in server.key.org -out server.key
 
```

- 第4步：生成自签名证书
如果你不想花钱让CA签名，或者只是测试SSL的具体实现。那么，现在便可以着手生成一个自签名的证书了。

需要注意的是，在使用自签名的临时证书时，浏览器会提示证书的颁发机构是未知的。

```c
$ openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
说明：crt上有证书持有人的信息，持有人的公钥，以及签署者的签名等信息。当用户安装了证书之后，便意味着信任了这份证书，同时拥有了其中的公钥。证书上会说明用途，例如服务器认证，客户端认证，或者签署其他证书。当系统收到一份新的证书的时候，证书会说明，是由谁签署的。如果这个签署者确实可以签署其他证书，并且收到证书上的签名和签署者的公钥可以对上的时候，系统就自动信任新的证书。
```

- 第5步：安装私钥和证书
将私钥和证书文件复制到Apache的配置目录下即可，在Mac 10.10系统中，复制到/etc/apache2/目录中即可。



##### css设置div居中
方法一：利用定位（常用方法,推荐）
```c
.parent{

position:relative;

}

.child{

position:absolute;

top:50%;

left:50%;

margin-top:-50px;

margin-left:-50px;

}

方法一的原理就是定位中心点是盒子的左上顶点，所以定位之后我们需要回退盒子一半的距离。
```
 

方法二：利用margin:auto;
```c
.parent{

position:relative;

}

.child{

position:absolute;

margin:auto;

top:0;

left:0;

right:0;

bottom:0;

}
```
方法三：利用display:table-cell;
```c
.parent{

display:table-cell;

vertical-align:middle;

text-align:center;

}

.child{

display:inline-block;

}
```
方法四：利用display：flex;设置垂直水平都居中；
```c
.parent{

display:flex;

justify-content:center;

align-items:center;

}
```
方法五：计算父盒子与子盒子的空间距离(这跟方法一是一个道理)；
```c
计算方法：父盒子高度或者宽度的一半减去子盒子高度或者宽的的一半。

.child{

margin-top:200px;

margin-left:200px;

}
```
方法六：利用transform
```c
.parent{

position:relative;

}

.child{

position:absolute;

top:50%;

left:50%;

transform:translate(-50%,-50%);

}
```
方法七：利用calc计算
```c
.parent{

position:relative;

}

.child{

position:absolute;

top:calc(200px);//（父元素高-子元素高）÷ 2=200px

let:calc(200px);//（父元素宽-子元素宽）÷ 2=200px

}
```