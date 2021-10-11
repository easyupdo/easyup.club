---
title: protobuf3
date: 2021-09-30 11:23:12
tags: [proto pb3]
---
### protobuf3 

#### protobuf3 消息定义

1. 消息格式

```c
// msg.proto
syntax = "proto3"

message jmsg {
    string name = 1;
}

```
2. 如果有修饰符
所指定的消息字段修饰符必须是如下之一：
singular：一个格式良好的消息应该有0个或者1个这种字段（但是不能超过1个）。
repeated：在一个格式良好的消息中，这种字段可以重复任意多次（包括0次）。重复的值的顺序会被保留。

在proto3中，repeated的标量域默认情况虾使用packed。

<div id="cnblogs_post_body" class="blogpost-body blogpost-body-html">
<h1 id="定义一个消息类型-1"><span id="DefiningAMessageType">定义一个消息类型</span></h1>
<p>先来看一个非常简单的例子。假设你想定义一个“搜索请求”的消息格式，每一个请求含有一个查询字符串、你感兴趣的查询结果所在的页数，以及每一页多少条查询结果。可以采用如下的方式来定义消息类型的.proto文件了：</p>
<div class="cnblogs_Highlighter sh-gutter">
<div><div id="highlighter_352427" class="syntaxhighlighter  java"><div class="toolbar"><span><a href="#" class="toolbar_item command_help help">?</a></span></div><table border="0" cellpadding="0" cellspacing="0"><tbody><tr><td class="gutter"><div class="line number1 index0 alt2">1</div><div class="line number2 index1 alt1">2</div><div class="line number3 index2 alt2">3</div><div class="line number4 index3 alt1">4</div><div class="line number5 index4 alt2">5</div><div class="line number6 index5 alt1">6</div><div class="line number7 index6 alt2">7</div></td><td class="code"><div class="container"><div class="line number1 index0 alt2"><code class="java plain">syntax = </code><code class="java string">"proto3"</code><code class="java plain">;</code></div><div class="line number2 index1 alt1">&nbsp;</div><div class="line number3 index2 alt2"><code class="java plain">message SearchRequest {</code></div><div class="line number4 index3 alt1"><code class="java spaces">&nbsp;&nbsp;</code><code class="java plain">string query = </code><code class="java value">1</code><code class="java plain">;</code></div><div class="line number5 index4 alt2"><code class="java spaces">&nbsp;&nbsp;</code><code class="java plain">int32 page_number = </code><code class="java value">2</code><code class="java plain">;</code></div><div class="line number6 index5 alt1"><code class="java spaces">&nbsp;&nbsp;</code><code class="java plain">int32 result_per_page = </code><code class="java value">3</code><code class="java plain">;</code></div><div class="line number7 index6 alt2"><code class="java plain">}</code></div></div></td></tr></tbody></table></div></div>
</div>
<p>　　</p>
<ul>
<li>文件的第一行指定了你正在使用proto3语法：如果你没有指定这个，编译器会使用proto2。这个指定语法行必须是文件的非空非注释的第一个行。</li>
<li>SearchRequest消息格式有3个字段，在消息中承载的数据分别对应于每一个字段。其中每个字段都有一个名字和一种类型。</li>
</ul>
<h2 id="指定字段类型"><a name="t1"></a><span id="SpecifyingFieldTypes">指定字段类型</span></h2>
<p>在上面的例子中，所有字段都是标量类型：两个整型（page_number和result_per_page），一个string类型（query）。当然，你也可以为字段指定其他的合成类型，包括枚举（enumerations）或其他消息类型。</p>
<h2 id="分配标识号"><a name="t2"></a><span id="AssigningTags">分配标识号</span></h2>
<p>正如你所见，在消息定义中，每个字段都有唯一的一个数字标识符。这些标识符是用来在消息的二进制格式中识别各个字段的，一旦开始使用就不能够再改变。注：[1,15]之内的标识号在编码的时候会占用一个字节。[16,2047]之内的标识号则占用2个字节。所以应该为那些频繁出现的消息元素保留 [1,15]之内的标识号。切记：要为将来有可能添加的、频繁出现的标识号预留一些标识号。</p>
<p>最小的标识号可以从1开始，最大到2^29 - 1, or 536,870,911。不可以使用其中的[19000－19999]（ (从FieldDescriptor::kFirstReservedNumber 到 FieldDescriptor::kLastReservedNumber)）的标识号， Protobuf协议实现中对这些进行了预留。如果非要在.proto文件中使用这些预留标识号，编译时就会报警。同样你也不能使用早期<a href="https://developers.google.com/protocol-buffers/docs/proto3?hl=zh-cn#reserved" target="_blank">保留</a>的标识号。</p>
<h2 id="指定字段规则"><a name="t3"></a><span id="SpecifyingFieldRules">指定字段规则</span></h2>
<p>所指定的消息字段修饰符必须是如下之一：</p>
<ul>
<li>singular：一个格式良好的消息应该有0个或者1个这种字段（但是不能超过1个）。</li>
<li>
<p>repeated：在一个格式良好的消息中，这种字段可以重复任意多次（包括0次）。重复的值的顺序会被保留。</p>
<p>在proto3中，repeated的标量域默认情况虾使用packed。</p>
<p>你可以了解更多的pakced属性在<a href="https://developers.google.com/protocol-buffers/docs/encoding?hl=zh-cn#packed" target="_blank">Protocol Buffer 编码</a></p>
</li>
</ul>
<h2 id="添加更多消息类型"><a name="t4"></a><span id="AddingMoreMessageTypes">添加更多消息类型</span></h2>
<p>在一个.proto文件中可以定义多个消息类型。在定义多个相关的消息的时候，这一点特别有用——例如，如果想定义与SearchResponse消息类型对应的回复消息格式的话，你可以将它添加到相同的.proto文件中，如：</p>
<div class="cnblogs_Highlighter sh-gutter">
<div><div id="highlighter_459345" class="syntaxhighlighter  java"><div class="toolbar"><span><a href="#" class="toolbar_item command_help help">?</a></span></div><table border="0" cellpadding="0" cellspacing="0"><tbody><tr><td class="gutter"><div class="line number1 index0 alt2">1</div><div class="line number2 index1 alt1">2</div><div class="line number3 index2 alt2">3</div><div class="line number4 index3 alt1">4</div><div class="line number5 index4 alt2">5</div><div class="line number6 index5 alt1">6</div><div class="line number7 index6 alt2">7</div><div class="line number8 index7 alt1">8</div><div class="line number9 index8 alt2">9</div></td><td class="code"><div class="container"><div class="line number1 index0 alt2"><code class="java plain">message SearchRequest {</code></div><div class="line number2 index1 alt1"><code class="java spaces">&nbsp;&nbsp;</code><code class="java plain">string query = </code><code class="java value">1</code><code class="java plain">;</code></div><div class="line number3 index2 alt2"><code class="java spaces">&nbsp;&nbsp;</code><code class="java plain">int32 page_number = </code><code class="java value">2</code><code class="java plain">;</code></div><div class="line number4 index3 alt1"><code class="java spaces">&nbsp;&nbsp;</code><code class="java plain">int32 result_per_page = </code><code class="java value">3</code><code class="java plain">;</code></div><div class="line number5 index4 alt2"><code class="java plain">}</code></div><div class="line number6 index5 alt1">&nbsp;</div><div class="line number7 index6 alt2"><code class="java plain">message SearchResponse {</code></div><div class="line number8 index7 alt1"><code class="java spaces">&nbsp;</code><code class="java plain">...</code></div><div class="line number9 index8 alt2"><code class="java plain">}</code></div></div></td></tr></tbody></table></div></div>
</div>
<p>　　</p>
<h2 id="添加注释"><span id="AddingComments">添加注释</span></h2>
<p>向.proto文件添加注释，可以使用C/C++/java风格的双斜杠（//） 语法格式，如：</p>
<div class="cnblogs_Highlighter sh-gutter">
<div><div id="highlighter_956728" class="syntaxhighlighter  java"><div class="toolbar"><span><a href="#" class="toolbar_item command_help help">?</a></span></div><table border="0" cellpadding="0" cellspacing="0"><tbody><tr><td class="gutter"><div class="line number1 index0 alt2">1</div><div class="line number2 index1 alt1">2</div><div class="line number3 index2 alt2">3</div><div class="line number4 index3 alt1">4</div><div class="line number5 index4 alt2">5</div></td><td class="code"><div class="container"><div class="line number1 index0 alt2"><code class="java plain">message SearchRequest {</code></div><div class="line number2 index1 alt1"><code class="java spaces">&nbsp;&nbsp;</code><code class="java plain">string query = </code><code class="java value">1</code><code class="java plain">;</code></div><div class="line number3 index2 alt2"><code class="java spaces">&nbsp;&nbsp;</code><code class="java plain">int32 page_number = </code><code class="java value">2</code><code class="java plain">;&nbsp; </code><code class="java comments">// Which page number do we want?</code></div><div class="line number4 index3 alt1"><code class="java spaces">&nbsp;&nbsp;</code><code class="java plain">int32 result_per_page = </code><code class="java value">3</code><code class="java plain">;&nbsp; </code><code class="java comments">// Number of results to return per page.</code></div><div class="line number5 index4 alt2"><code class="java plain">}</code></div></div></td></tr></tbody></table></div></div>
</div>
<p>　　</p>
<h2 id="保留标识符reserved"><span id="ReservedFields">保留标识符（Reserved）</span></h2>
<p>如果你通过删除或者注释所有域，以后的用户可以重用标识号当你重新更新类型的时候。如果你使用旧版本加载相同的.proto文件这会导致严重的问题，包括数据损坏、隐私错误等等。现在有一种确保不会发生这种情况的方法就是指定保留标识符（and/or names, which can also cause issues for JSON serialization不明白什么意思），protocol buffer的编译器会警告未来尝试使用这些域标识符的用户。</p>
<div class="cnblogs_Highlighter sh-gutter">
<div><div id="highlighter_811731" class="syntaxhighlighter  java"><div class="toolbar"><span><a href="#" class="toolbar_item command_help help">?</a></span></div><table border="0" cellpadding="0" cellspacing="0"><tbody><tr><td class="gutter"><div class="line number1 index0 alt2">1</div><div class="line number2 index1 alt1">2</div><div class="line number3 index2 alt2">3</div><div class="line number4 index3 alt1">4</div></td><td class="code"><div class="container"><div class="line number1 index0 alt2"><code class="java plain">message Foo {</code></div><div class="line number2 index1 alt1"><code class="java spaces">&nbsp;&nbsp;</code><code class="java plain">reserved </code><code class="java value">2</code><code class="java plain">, </code><code class="java value">15</code><code class="java plain">, </code><code class="java value">9</code> <code class="java plain">to </code><code class="java value">11</code><code class="java plain">;</code></div><div class="line number3 index2 alt2"><code class="java spaces">&nbsp;&nbsp;</code><code class="java plain">reserved </code><code class="java string">"foo"</code><code class="java plain">, </code><code class="java string">"bar"</code><code class="java plain">;</code></div><div class="line number4 index3 alt1"><code class="java plain">}</code></div></div></td></tr></tbody></table></div></div>
</div>
<p>　　</p>
<p>注：不要在同一行reserved声明中同时声明域名字和标识号</p>
<h2 id="从proto文件生成了什么"><a name="t7"></a><span id="What'sGeneratedFromYour.proto">从.proto文件生成了什么？</span></h2>
<p>当用protocol buffer编译器来运行.proto文件时，编译器将生成所选择语言的代码，这些代码可以操作在.proto文件中定义的消息类型，包括获取、设置字段值，将消息序列化到一个输出流中，以及从一个输入流中解析消息。</p>
<ul>
<li>对C++来说，编译器会为每个.proto文件生成一个.h文件和一个.cc文件，.proto文件中的每一个消息有一个对应的类。</li>
<li>对Java来说，编译器为每一个消息类型生成了一个.java文件，以及一个特殊的Builder类（该类是用来创建消息类接口的）。</li>
<li>对Python来说，有点不太一样——Python编译器为.proto文件中的每个消息类型生成一个含有静态描述符的模块，，该模块与一个元类（metaclass）在运行时（runtime）被用来创建所需的Python数据访问类。</li>
<li>对go来说，编译器会位每个消息类型生成了一个.pd.go文件。</li>
<li>对于Ruby来说，编译器会为每个消息类型生成了一个.rb文件。</li>
<li>javaNano来说，编译器输出类似域java但是没有Builder类</li>
<li>对于Objective-C来说，编译器会为每个消息类型生成了一个pbobjc.h文件和pbobjcm文件，.proto文件中的每一个消息有一个对应的类。</li>
<li>对于C#来说，编译器会为每个消息类型生成了一个.cs文件，.proto文件中的每一个消息有一个对应的类。</li>
</ul>
<p>你可以从如下的文档链接中获取每种语言更多API(proto3版本的内容很快就公布)。<a href="https://developers.google.com/protocol-buffers/docs/reference/overview?hl=zh-cn" target="_blank">API Reference</a></p>
<h1 id="标量数值类型-1"><a name="t8"></a><span id="ScalarValueTypes">标量数值类型</span></h1>
<p>一个标量消息字段可以含有一个如下的类型——该表格展示了定义于.proto文件中的类型，以及与之对应的、在自动生成的访问类中定义的类型：</p>
<p>&nbsp;</p>
<div class="table-wrapper"><table>
<thead>
<tr><th>.proto Type</th><th align="center">Notes</th><th align="right">C++ Type</th><th>Java Type</th><th>Python Type[2]</th><th>Go Type</th><th>Ruby Type</th><th>C# Type</th><th>PHP Type</th></tr>
</thead>
<tbody>
<tr>
<td>double</td>
<td align="center">&nbsp;</td>
<td align="right">double</td>
<td>double</td>
<td>float</td>
<td>float64</td>
<td>Float</td>
<td>double</td>
<td>float</td>
</tr>
<tr>
<td>float</td>
<td align="center">&nbsp;</td>
<td align="right">float</td>
<td>float</td>
<td>float</td>
<td>float32</td>
<td>Float</td>
<td>float</td>
<td>float</td>
</tr>
<tr>
<td>int32</td>
<td align="center">使用变长编码，对于负值的效率很低，如果你的域有可能有负值，请使用sint64替代</td>
<td align="right">int32</td>
<td>int</td>
<td>int</td>
<td>int32</td>
<td>Fixnum 或者 Bignum（根据需要）</td>
<td>int</td>
<td>integer</td>
</tr>
<tr>
<td>uint32</td>
<td align="center">使用变长编码</td>
<td align="right">uint32</td>
<td>int</td>
<td>int/long</td>
<td>uint32</td>
<td>Fixnum 或者 Bignum（根据需要）</td>
<td>uint</td>
<td>integer</td>
</tr>
<tr>
<td>uint64</td>
<td align="center">使用变长编码</td>
<td align="right">uint64</td>
<td>long</td>
<td>int/long</td>
<td>uint64</td>
<td>Bignum</td>
<td>ulong</td>
<td>integer/string</td>
</tr>
<tr>
<td>sint32</td>
<td align="center">使用变长编码，这些编码在负值时比int32高效的多</td>
<td align="right">int32</td>
<td>int</td>
<td>int</td>
<td>int32</td>
<td>Fixnum 或者 Bignum（根据需要）</td>
<td>int</td>
<td>integer</td>
</tr>
<tr>
<td>sint64</td>
<td align="center">使用变长编码，有符号的整型值。编码时比通常的int64高效。</td>
<td align="right">int64</td>
<td>long</td>
<td>int/long</td>
<td>int64</td>
<td>Bignum</td>
<td>long</td>
<td>integer/string</td>
</tr>
<tr>
<td>fixed32</td>
<td align="center">总是4个字节，如果数值总是比总是比228大的话，这个类型会比uint32高效。</td>
<td align="right">uint32</td>
<td>int</td>
<td>int</td>
<td>uint32</td>
<td>Fixnum 或者 Bignum（根据需要）</td>
<td>uint</td>
<td>integer</td>
</tr>
<tr>
<td>fixed64</td>
<td align="center">总是8个字节，如果数值总是比总是比256大的话，这个类型会比uint64高效。</td>
<td align="right">uint64</td>
<td>long</td>
<td>int/long</td>
<td>uint64</td>
<td>Bignum</td>
<td>ulong</td>
<td>integer/string</td>
</tr>
<tr>
<td>sfixed32</td>
<td align="center">总是4个字节</td>
<td align="right">int32</td>
<td>int</td>
<td>int</td>
<td>int32</td>
<td>Fixnum 或者 Bignum（根据需要）</td>
<td>int</td>
<td>integer</td>
</tr>
<tr>
<td>sfixed64</td>
<td align="center">总是8个字节</td>
<td align="right">int64</td>
<td>long</td>
<td>int/long</td>
<td>int64</td>
<td>Bignum</td>
<td>long</td>
<td>integer/string</td>
</tr>
<tr>
<td>bool</td>
<td align="center">&nbsp;</td>
<td align="right">bool</td>
<td>boolean</td>
<td>bool</td>
<td>bool</td>
<td>TrueClass/FalseClass</td>
<td>bool</td>
<td>boolean</td>
</tr>
<tr>
<td>string</td>
<td align="center">一个字符串必须是UTF-8编码或者7-bit ASCII编码的文本。</td>
<td align="right">string</td>
<td>String</td>
<td>str/unicode</td>
<td>string</td>
<td>String (UTF-8)</td>
<td>string</td>
<td>string</td>
</tr>
<tr>
<td>bytes</td>
<td align="center">可能包含任意顺序的字节数据。</td>
<td align="right">string</td>
<td>ByteString</td>
<td>str</td>
<td>[]byte</td>
<td>String (ASCII-8BIT)</td>
<td>ByteString</td>
<td>string<br><br></td>




</tr>




</tbody>



</table></div>
<p>你可以在文章<a href="https://developers.google.com/protocol-buffers/docs/encoding?hl=zh-cn" target="_blank">Protocol Buffer 编码</a>中，找到更多“序列化消息时各种类型如何编码”的信息。</p>
<ol>
<li>在java中，无符号32位和64位整型被表示成他们的整型对应形似，最高位被储存在标志位中。</li>
<li>对于所有的情况，设定值会执行类型检查以确保此值是有效。</li>
<li>64位或者无符号32位整型在解码时被表示成为ilong，但是在设置时可以使用int型值设定，在所有的情况下，值必须符合其设置其类型的要求。</li>
<li>python中string被表示成在解码时表示成unicode。但是一个ASCIIstring可以被表示成str类型。</li>
<li>Integer在64位的机器上使用，string在32位机器上使用</li>


</ol>
<h1 id="默认值"><a name="t9"></a><span id="DefaultValues">默认值</span></h1>
<p>当一个消息被解析的时候，如果被编码的信息不包含一个特定的singular元素，被解析的对象锁对应的域被设置位一个默认值，对于不同类型指定如下：</p>
<ul>
<li>对于strings，默认是一个空string</li>
<li>对于bytes，默认是一个空的bytes</li>
<li>对于bools，默认是false</li>
<li>对于数值类型，默认是0</li>
<li>对于枚举，默认是第一个定义的枚举值，必须为0;</li>
<li>
<p>对于消息类型（message），域没有被设置，确切的消息是根据语言确定的，详见<a href="https://developers.google.com/protocol-buffers/docs/reference/overview?hl=zh-cn" target="_blank">generated code guide</a></p>
<p>对于可重复域的默认值是空（通常情况下是对应语言中空列表）。</p>
<p>注：对于标量消息域，一旦消息被解析，就无法判断域释放被设置为默认值（例如，例如boolean值是否被设置为false）还是根本没有被设置。你应该在定义你的消息类型时非常注意。例如，比如你不应该定义boolean的默认值false作为任何行为的触发方式。也应该注意如果一个标量消息域被设置为标志位，这个值不应该被序列化传输。</p>
<p>查看<a href="https://developers.google.com/protocol-buffers/docs/reference/overview?hl=zh-cn" target="_blank">generated code guide</a>选择你的语言的默认值的工作细节。</p>


</li>


</ul>
<h1 id="枚举-1"><a name="t10"></a><span id="Enumerations">枚举</span></h1>
<p>当需要定义一个消息类型的时候，可能想为一个字段指定某“预定义值序列”中的一个值。例如，假设要为每一个SearchRequest消息添加一个 corpus字段，而corpus的值可能是UNIVERSAL，WEB，IMAGES，LOCAL，NEWS，PRODUCTS或VIDEO中的一个。 其实可以很容易地实现这一点：通过向消息定义中添加一个枚举（enum）并且为每个可能的值定义一个常量就可以了。</p>
<p>在下面的例子中，在消息格式中添加了一个叫做Corpus的枚举类型——它含有所有可能的值 ——以及一个类型为Corpus的字段：</p>
<div class="cnblogs_Highlighter sh-gutter">
<div><div id="highlighter_172621" class="syntaxhighlighter  java"><div class="toolbar"><span><a href="#" class="toolbar_item command_help help">?</a></span></div><table border="0" cellpadding="0" cellspacing="0"><tbody><tr><td class="gutter"><div class="line number1 index0 alt2">1</div><div class="line number2 index1 alt1">2</div><div class="line number3 index2 alt2">3</div><div class="line number4 index3 alt1">4</div><div class="line number5 index4 alt2">5</div><div class="line number6 index5 alt1">6</div><div class="line number7 index6 alt2">7</div><div class="line number8 index7 alt1">8</div><div class="line number9 index8 alt2">9</div><div class="line number10 index9 alt1">10</div><div class="line number11 index10 alt2">11</div><div class="line number12 index11 alt1">12</div><div class="line number13 index12 alt2">13</div><div class="line number14 index13 alt1">14</div><div class="line number15 index14 alt2">15</div></td><td class="code"><div class="container"><div class="line number1 index0 alt2"><code class="java plain">message SearchRequest {</code></div><div class="line number2 index1 alt1"><code class="java spaces">&nbsp;&nbsp;</code><code class="java plain">string query = </code><code class="java value">1</code><code class="java plain">;</code></div><div class="line number3 index2 alt2"><code class="java spaces">&nbsp;&nbsp;</code><code class="java plain">int32 page_number = </code><code class="java value">2</code><code class="java plain">;</code></div><div class="line number4 index3 alt1"><code class="java spaces">&nbsp;&nbsp;</code><code class="java plain">int32 result_per_page = </code><code class="java value">3</code><code class="java plain">;</code></div><div class="line number5 index4 alt2"><code class="java spaces">&nbsp;&nbsp;</code><code class="java keyword">enum</code> <code class="java plain">Corpus {</code></div><div class="line number6 index5 alt1"><code class="java spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="java plain">UNIVERSAL = </code><code class="java value">0</code><code class="java plain">;</code></div><div class="line number7 index6 alt2"><code class="java spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="java plain">WEB = </code><code class="java value">1</code><code class="java plain">;</code></div><div class="line number8 index7 alt1"><code class="java spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="java plain">IMAGES = </code><code class="java value">2</code><code class="java plain">;</code></div><div class="line number9 index8 alt2"><code class="java spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="java plain">LOCAL = </code><code class="java value">3</code><code class="java plain">;</code></div><div class="line number10 index9 alt1"><code class="java spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="java plain">NEWS = </code><code class="java value">4</code><code class="java plain">;</code></div><div class="line number11 index10 alt2"><code class="java spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="java plain">PRODUCTS = </code><code class="java value">5</code><code class="java plain">;</code></div><div class="line number12 index11 alt1"><code class="java spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="java plain">VIDEO = </code><code class="java value">6</code><code class="java plain">;</code></div><div class="line number13 index12 alt2"><code class="java spaces">&nbsp;&nbsp;</code><code class="java plain">}</code></div><div class="line number14 index13 alt1"><code class="java spaces">&nbsp;&nbsp;</code><code class="java plain">Corpus corpus = </code><code class="java value">4</code><code class="java plain">;</code></div><div class="line number15 index14 alt2"><code class="java plain">}</code></div></div></td></tr></tbody></table></div></div>
</div>
<p>　　</p>
<p>如你所见，Corpus枚举的第一个常量映射为0：每个枚举类型必须将其第一个类型映射为0，这是因为：</p>
<ul>
<li>必须有有一个0值，我们可以用这个0值作为默认值。</li>
<li>
<p>这个零值必须为第一个元素，为了兼容proto2语义，枚举类的第一个值总是默认值。</p>
<p>你可以通过将不同的枚举常量指定位相同的值。如果这样做你需要将allow_alias设定位true，否则编译器会在别名的地方产生一个错误信息。</p>
<div class="cnblogs_Highlighter sh-gutter">
<div><div id="highlighter_76261" class="syntaxhighlighter  java"><div class="toolbar"><span><a href="#" class="toolbar_item command_help help">?</a></span></div><table border="0" cellpadding="0" cellspacing="0"><tbody><tr><td class="gutter"><div class="line number1 index0 alt2">1</div><div class="line number2 index1 alt1">2</div><div class="line number3 index2 alt2">3</div><div class="line number4 index3 alt1">4</div><div class="line number5 index4 alt2">5</div><div class="line number6 index5 alt1">6</div><div class="line number7 index6 alt2">7</div><div class="line number8 index7 alt1">8</div><div class="line number9 index8 alt2">9</div><div class="line number10 index9 alt1">10</div><div class="line number11 index10 alt2">11</div></td><td class="code"><div class="container"><div class="line number1 index0 alt2"><code class="java keyword">enum</code> <code class="java plain">EnumAllowingAlias {</code></div><div class="line number2 index1 alt1"><code class="java spaces">&nbsp;&nbsp;</code><code class="java plain">option allow_alias = </code><code class="java keyword">true</code><code class="java plain">;</code></div><div class="line number3 index2 alt2"><code class="java spaces">&nbsp;&nbsp;</code><code class="java plain">UNKNOWN = </code><code class="java value">0</code><code class="java plain">;</code></div><div class="line number4 index3 alt1"><code class="java spaces">&nbsp;&nbsp;</code><code class="java plain">STARTED = </code><code class="java value">1</code><code class="java plain">;</code></div><div class="line number5 index4 alt2"><code class="java spaces">&nbsp;&nbsp;</code><code class="java plain">RUNNING = </code><code class="java value">1</code><code class="java plain">;</code></div><div class="line number6 index5 alt1"><code class="java plain">}</code></div><div class="line number7 index6 alt2"><code class="java keyword">enum</code> <code class="java plain">EnumNotAllowingAlias {</code></div><div class="line number8 index7 alt1"><code class="java spaces">&nbsp;&nbsp;</code><code class="java plain">UNKNOWN = </code><code class="java value">0</code><code class="java plain">;</code></div><div class="line number9 index8 alt2"><code class="java spaces">&nbsp;&nbsp;</code><code class="java plain">STARTED = </code><code class="java value">1</code><code class="java plain">;</code></div><div class="line number10 index9 alt1"><code class="java spaces">&nbsp;&nbsp;</code><code class="java comments">// RUNNING = 1;&nbsp; // Uncommenting this line will cause a compile error inside Google and a warning message outside.</code></div><div class="line number11 index10 alt2"><code class="java plain">}</code></div></div></td></tr></tbody></table></div></div>
</div>
<p>枚举常量必须在32位整型值的范围内。因为enum值是使用可变编码方式的，对负数不够高效，因此不推荐在enum中使用负数。如上例所示，可以在 一个消息定义的内部或外部定义枚举——这些枚举可以在.proto文件中的任何消息定义里重用。当然也可以在一个消息中声明一个枚举类型，而在另一个不同 的消息中使用它——采用MessageType.EnumType的语法格式。</p>
<p>当对一个使用了枚举的.proto文件运行protocol buffer编译器的时候，生成的代码中将有一个对应的enum（对Java或C++来说），或者一个特殊的EnumDescriptor类（对 Python来说），它被用来在运行时生成的类中创建一系列的整型值符号常量（symbolic constants）。</p>
<p>在反序列化的过程中，无法识别的枚举值会被保存在消息中，虽然这种表示方式需要依据所使用语言而定。在那些支持开放枚举类型超出指定范围之外的语言中（例如C++和Go），为识别的值会被表示成所支持的整型。在使用封闭枚举类型的语言中（Java），使用枚举中的一个类型来表示未识别的值，并且可以使用所支持整型来访问。在其他情况下，如果解析的消息被序列号，未识别的值将保持原样。</p>
<p>关于如何在你的应用程序的消息中使用枚举的更多信息，请查看所选择的语言<a href="http://code.google.com/intl/zh-CN/apis/protocolbuffers/docs/reference/overview.html%E3%80%82" target="_blank">generated code guide</a></p>
<h1 id="使用其他消息类型-1"><span id="UsingOtherMessageTypes">使用其他消息类型</span></h1>
<p>你可以将其他消息类型用作字段类型。例如，假设在每一个SearchResponse消息中包含Result消息，此时可以在相同的.proto文件中定义一个Result消息类型，然后在SearchResponse消息中指定一个Result类型的字段，如：</p>
</li>
<li>
<div class="cnblogs_Highlighter sh-gutter">
<div><div id="highlighter_491932" class="syntaxhighlighter  java"><div class="toolbar"><span><a href="#" class="toolbar_item command_help help">?</a></span></div><table border="0" cellpadding="0" cellspacing="0"><tbody><tr><td class="gutter"><div class="line number1 index0 alt2">1</div><div class="line number2 index1 alt1">2</div><div class="line number3 index2 alt2">3</div><div class="line number4 index3 alt1">4</div><div class="line number5 index4 alt2">5</div><div class="line number6 index5 alt1">6</div><div class="line number7 index6 alt2">7</div><div class="line number8 index7 alt1">8</div><div class="line number9 index8 alt2">9</div></td><td class="code"><div class="container"><div class="line number1 index0 alt2"><code class="java plain">message SearchResponse {</code></div><div class="line number2 index1 alt1"><code class="java spaces">&nbsp;&nbsp;</code><code class="java plain">repeated Result results = </code><code class="java value">1</code><code class="java plain">;</code></div><div class="line number3 index2 alt2"><code class="java plain">}</code></div><div class="line number4 index3 alt1">&nbsp;</div><div class="line number5 index4 alt2"><code class="java plain">message Result {</code></div><div class="line number6 index5 alt1"><code class="java spaces">&nbsp;&nbsp;</code><code class="java plain">string url = </code><code class="java value">1</code><code class="java plain">;</code></div><div class="line number7 index6 alt2"><code class="java spaces">&nbsp;&nbsp;</code><code class="java plain">string title = </code><code class="java value">2</code><code class="java plain">;</code></div><div class="line number8 index7 alt1"><code class="java spaces">&nbsp;&nbsp;</code><code class="java plain">repeated string snippets = </code><code class="java value">3</code><code class="java plain">;</code></div><div class="line number9 index8 alt2"><code class="java plain">}</code></div></div></td></tr></tbody></table></div></div>
</div>
<h2 id="嵌套类型-1"><span id="NestedTypes">嵌套类型</span></h2>
<p>你可以在其他消息类型中定义、使用消息类型，在下面的例子中，Result消息就定义在SearchResponse消息内，如：</p>
<div class="cnblogs_Highlighter sh-gutter">
<div><div id="highlighter_196604" class="syntaxhighlighter  java"><div class="toolbar"><span><a href="#" class="toolbar_item command_help help">?</a></span></div><table border="0" cellpadding="0" cellspacing="0"><tbody><tr><td class="gutter"><div class="line number1 index0 alt2">1</div><div class="line number2 index1 alt1">2</div><div class="line number3 index2 alt2">3</div><div class="line number4 index3 alt1">4</div><div class="line number5 index4 alt2">5</div><div class="line number6 index5 alt1">6</div><div class="line number7 index6 alt2">7</div><div class="line number8 index7 alt1">8</div></td><td class="code"><div class="container"><div class="line number1 index0 alt2"><code class="java plain">message SearchResponse {</code></div><div class="line number2 index1 alt1"><code class="java spaces">&nbsp;&nbsp;</code><code class="java plain">message Result {</code></div><div class="line number3 index2 alt2"><code class="java spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="java plain">string url = </code><code class="java value">1</code><code class="java plain">;</code></div><div class="line number4 index3 alt1"><code class="java spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="java plain">string title = </code><code class="java value">2</code><code class="java plain">;</code></div><div class="line number5 index4 alt2"><code class="java spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="java plain">repeated string snippets = </code><code class="java value">3</code><code class="java plain">;</code></div><div class="line number6 index5 alt1"><code class="java spaces">&nbsp;&nbsp;</code><code class="java plain">}</code></div><div class="line number7 index6 alt2"><code class="java spaces">&nbsp;&nbsp;</code><code class="java plain">repeated Result results = </code><code class="java value">1</code><code class="java plain">;</code></div><div class="line number8 index7 alt1"><code class="java plain">}</code></div></div></td></tr></tbody></table></div></div>
</div>
<p>如果你想在它的父消息类型的外部重用这个消息类型，你需要以Parent.Type的形式使用它，如：</p>
</li>
</ul>
<div class="cnblogs_Highlighter sh-gutter">
<div><div id="highlighter_574748" class="syntaxhighlighter  java"><div class="toolbar"><span><a href="#" class="toolbar_item command_help help">?</a></span></div><table border="0" cellpadding="0" cellspacing="0"><tbody><tr><td class="gutter"><div class="line number1 index0 alt2">1</div><div class="line number2 index1 alt1">2</div><div class="line number3 index2 alt2">3</div></td><td class="code"><div class="container"><div class="line number1 index0 alt2"><code class="java plain">message SomeOtherMessage {</code></div><div class="line number2 index1 alt1"><code class="java spaces">&nbsp;&nbsp;</code><code class="java plain">SearchResponse.Result result = </code><code class="java value">1</code><code class="java plain">;</code></div><div class="line number3 index2 alt2"><code class="java plain">}</code></div></div></td></tr></tbody></table></div></div>
</div>
<p>　　</p>
<h2 id="更新一个消息类型-1"><span id="UpdatingAMessageType">更新一个消息类型</span></h2>
<p>如果一个已有的消息格式已无法满足新的需求——如，要在消息中添加一个额外的字段——但是同时旧版本写的代码仍然可用。不用担心！更新消息而不破坏已有代码是非常简单的。在更新时只要记住以下的规则即可。</p>
<ul>
<li>不要更改任何已有的字段的数值标识。</li>
<li>如果你增加新的字段，使用旧格式的字段仍然可以被你新产生的代码所解析。你应该记住这些元素的默认值这样你的新代码就可以以适当的方式和旧代码产生的数据交互。相似的，通过新代码产生的消息也可以被旧代码解析：只不过新的字段会被忽视掉。注意，未被识别的字段会在反序列化的过程中丢弃掉，所以如果消息再被传递给新的代码，新的字段依然是不可用的（这和proto2中的行为是不同的，在proto2中未定义的域依然会随着消息被序列化）</li>
<li>非required的字段可以移除——只要它们的标识号在新的消息类型中不再使用（更好的做法可能是重命名那个字段，例如在字段前添加“OBSOLETE_”前缀，那样的话，使用的.proto文件的用户将来就不会无意中重新使用了那些不该使用的标识号）。</li>
<li>int32, uint32, int64, uint64,和bool是全部兼容的，这意味着可以将这些类型中的一个转换为另外一个，而不会破坏向前、 向后的兼容性。如果解析出来的数字与对应的类型不相符，那么结果就像在C++中对它进行了强制类型转换一样（例如，如果把一个64位数字当作int32来 读取，那么它就会被截断为32位的数字）。</li>
<li>sint32和sint64是互相兼容的，但是它们与其他整数类型不兼容。</li>
<li>string和bytes是兼容的——只要bytes是有效的UTF-8编码。</li>
<li>嵌套消息与bytes是兼容的——只要bytes包含该消息的一个编码过的版本。</li>
<li>fixed32与sfixed32是兼容的，fixed64与sfixed64是兼容的。</li>
<li>枚举类型与int32，uint32，int64和uint64相兼容（注意如果值不相兼容则会被截断），然而在客户端反序列化之后他们可能会有不同的处理方式，例如，未识别的proto3枚举类型会被保留在消息中，但是他的表示方式会依照语言而定。int类型的字段总会保留他们的</li>
</ul>
<h1 id="any-1"><a name="t16"></a><span id="Any">Any</span></h1>
<p>Any类型消息允许你在没有指定他们的.proto定义的情况下使用消息作为一个嵌套类型。一个Any类型包括一个可以被序列化bytes类型的任意消息，以及一个URL作为一个全局标识符和解析消息类型。为了使用Any类型，你需要导入<code>import google/protobuf/any.proto</code></p>
<div class="cnblogs_Highlighter sh-gutter">
<div><div id="highlighter_815072" class="syntaxhighlighter  java"><div class="toolbar"><span><a href="#" class="toolbar_item command_help help">?</a></span></div><table border="0" cellpadding="0" cellspacing="0"><tbody><tr><td class="gutter"><div class="line number1 index0 alt2">1</div><div class="line number2 index1 alt1">2</div><div class="line number3 index2 alt2">3</div><div class="line number4 index3 alt1">4</div><div class="line number5 index4 alt2">5</div><div class="line number6 index5 alt1">6</div></td><td class="code"><div class="container"><div class="line number1 index0 alt2"><code class="java keyword">import</code> <code class="java string">"google/protobuf/any.proto"</code><code class="java plain">;</code></div><div class="line number2 index1 alt1">&nbsp;</div><div class="line number3 index2 alt2"><code class="java plain">message ErrorStatus {</code></div><div class="line number4 index3 alt1"><code class="java spaces">&nbsp;&nbsp;</code><code class="java plain">string message = </code><code class="java value">1</code><code class="java plain">;</code></div><div class="line number5 index4 alt2"><code class="java spaces">&nbsp;&nbsp;</code><code class="java plain">repeated google.protobuf.Any details = </code><code class="java value">2</code><code class="java plain">;</code></div><div class="line number6 index5 alt1"><code class="java plain">}</code></div></div></td></tr></tbody></table></div></div>
</div>
<p>　　</p>
<p>对于给定的消息类型的默认类型URL是<code>type.googleapis.com/packagename.messagename</code>。</p>
<p>不同语言的实现会支持动态库以线程安全的方式去帮助封装或者解封装Any值。例如在java中，Any类型会有特殊的<code>pack()</code>和<code>unpack()</code>访问器，在C++中会有<code>PackFrom()</code>和<code>UnpackTo()</code>方法。</p>
<div class="cnblogs_Highlighter sh-gutter">
<div><div id="highlighter_100825" class="syntaxhighlighter  java"><div class="toolbar"><span><a href="#" class="toolbar_item command_help help">?</a></span></div><table border="0" cellpadding="0" cellspacing="0"><tbody><tr><td class="gutter"><div class="line number1 index0 alt2">1</div><div class="line number2 index1 alt1">2</div><div class="line number3 index2 alt2">3</div><div class="line number4 index3 alt1">4</div><div class="line number5 index4 alt2">5</div><div class="line number6 index5 alt1">6</div><div class="line number7 index6 alt2">7</div><div class="line number8 index7 alt1">8</div><div class="line number9 index8 alt2">9</div><div class="line number10 index9 alt1">10</div><div class="line number11 index10 alt2">11</div><div class="line number12 index11 alt1">12</div><div class="line number13 index12 alt2">13</div><div class="line number14 index13 alt1">14</div></td><td class="code"><div class="container"><div class="line number1 index0 alt2"><code class="java comments">// Storing an arbitrary message type in Any.</code></div><div class="line number2 index1 alt1"><code class="java plain">NetworkErrorDetails details = ...;</code></div><div class="line number3 index2 alt2"><code class="java plain">ErrorStatus status;</code></div><div class="line number4 index3 alt1"><code class="java plain">status.add_details()-&gt;PackFrom(details);</code></div><div class="line number5 index4 alt2">&nbsp;</div><div class="line number6 index5 alt1"><code class="java comments">// Reading an arbitrary message from Any.</code></div><div class="line number7 index6 alt2"><code class="java plain">ErrorStatus status = ...;</code></div><div class="line number8 index7 alt1"><code class="java keyword">for</code> <code class="java plain">(</code><code class="java keyword">const</code> <code class="java plain">Any&amp; detail : status.details()) {</code></div><div class="line number9 index8 alt2"><code class="java spaces">&nbsp;&nbsp;</code><code class="java keyword">if</code> <code class="java plain">(detail.Is&lt;NetworkErrorDetails&gt;()) {</code></div><div class="line number10 index9 alt1"><code class="java spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="java plain">NetworkErrorDetails network_error;</code></div><div class="line number11 index10 alt2"><code class="java spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="java plain">detail.UnpackTo(&amp;network_error);</code></div><div class="line number12 index11 alt1"><code class="java spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="java plain">... processing network_error ...</code></div><div class="line number13 index12 alt2"><code class="java spaces">&nbsp;&nbsp;</code><code class="java plain">}</code></div><div class="line number14 index13 alt1"><code class="java plain">}</code></div></div></td></tr></tbody></table></div></div>
</div>
<p>　　</p>
<p>目前，用于Any类型的动态库仍在开发之中&nbsp;<br>如果你已经很熟悉<a href="https://developers.google.com/protocol-buffers/docs/proto?hl=zh-cn" target="_blank">proto2语法</a>，使用Any替换<a href="https://developers.google.com/protocol-buffers/docs/proto?hl=zh-cn#extensions" target="_blank">拓展</a></p>
<h1 id="oneof-1"><a name="t17"></a><span id="Oneof">Oneof</span></h1>
<p>如果你的消息中有很多可选字段， 并且同时至多一个字段会被设置， 你可以加强这个行为，使用oneof特性节省内存.</p>
<p>Oneof字段就像可选字段， 除了它们会共享内存， 至多一个字段会被设置。 设置其中一个字段会清除其它字段。 你可以使用<code>case()</code>或者<code>WhichOneof()</code>&nbsp;方法检查哪个oneof字段被设置， 看你使用什么语言了.</p>
<h2 id="使用oneof"><a name="t18"></a><span id="UsingOneof">使用Oneof</span></h2>
<p>为了在.proto定义Oneof字段， 你需要在名字前面加上oneof关键字, 比如下面例子的test_oneof:</p>
<div class="cnblogs_Highlighter sh-gutter">
<div><div id="highlighter_117401" class="syntaxhighlighter  java"><div class="toolbar"><span><a href="#" class="toolbar_item command_help help">?</a></span></div><table border="0" cellpadding="0" cellspacing="0"><tbody><tr><td class="gutter"><div class="line number1 index0 alt2">1</div><div class="line number2 index1 alt1">2</div><div class="line number3 index2 alt2">3</div><div class="line number4 index3 alt1">4</div><div class="line number5 index4 alt2">5</div><div class="line number6 index5 alt1">6</div></td><td class="code"><div class="container"><div class="line number1 index0 alt2"><code class="java plain">message SampleMessage {</code></div><div class="line number2 index1 alt1"><code class="java spaces">&nbsp;&nbsp;</code><code class="java plain">oneof test_oneof {</code></div><div class="line number3 index2 alt2"><code class="java spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="java plain">string name = </code><code class="java value">4</code><code class="java plain">;</code></div><div class="line number4 index3 alt1"><code class="java spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="java plain">SubMessage sub_message = </code><code class="java value">9</code><code class="java plain">;</code></div><div class="line number5 index4 alt2"><code class="java spaces">&nbsp;&nbsp;</code><code class="java plain">}</code></div><div class="line number6 index5 alt1"><code class="java plain">}</code></div></div></td></tr></tbody></table></div></div>
</div>
<p>　　</p>
<p>然后你可以增加oneof字段到 oneof 定义中. 你可以增加任意类型的字段, 但是不能使用repeated 关键字.</p>
<p>在产生的代码中, oneof字段拥有同样的 getters 和setters， 就像正常的可选字段一样. 也有一个特殊的方法来检查到底那个字段被设置. 你可以在相应的语言<a href="https://developers.google.com/protocol-buffers/docs/reference/overview?hl=zh-cn" target="_blank">API指南</a>中找到oneof API介绍.</p>
<h2 id="oneof-特性"><a name="t19"></a><span id="OneofFeatures">Oneof 特性</span></h2>
<ul>
<li>设置oneof会自动清楚其它oneof字段的值. 所以设置多次后，只有最后一次设置的字段有值.</li>
</ul>
<div class="cnblogs_Highlighter sh-gutter">
<div><div id="highlighter_581513" class="syntaxhighlighter  java"><div class="toolbar"><span><a href="#" class="toolbar_item command_help help">?</a></span></div><table border="0" cellpadding="0" cellspacing="0"><tbody><tr><td class="gutter"><div class="line number1 index0 alt2">1</div><div class="line number2 index1 alt1">2</div><div class="line number3 index2 alt2">3</div><div class="line number4 index3 alt1">4</div><div class="line number5 index4 alt2">5</div></td><td class="code"><div class="container"><div class="line number1 index0 alt2"><code class="java plain">SampleMessage message;</code></div><div class="line number2 index1 alt1"><code class="java plain">message.set_name(</code><code class="java string">"name"</code><code class="java plain">);</code></div><div class="line number3 index2 alt2"><code class="java plain">CHECK(message.has_name());</code></div><div class="line number4 index3 alt1"><code class="java plain">message.mutable_sub_message();&nbsp;&nbsp; </code><code class="java comments">// Will clear name field.</code></div><div class="line number5 index4 alt2"><code class="java plain">CHECK(!message.has_name());</code></div></div></td></tr></tbody></table></div></div>
</div>
<p>　　</p>
<ul>
<li>如果解析器遇到同一个oneof中有多个成员，只有最会一个会被解析成消息。</li>
<li>oneof不支持<code>repeated</code>.</li>
<li>反射API对oneof 字段有效.</li>
<li>如果使用C++,需确保代码不会导致内存泄漏. 下面的代码会崩溃， 因为<code>sub_message</code>&nbsp;已经通过<code>set_name()</code>删除了</li>
</ul>
<div class="cnblogs_Highlighter sh-gutter">
<div><div id="highlighter_687903" class="syntaxhighlighter  java"><div class="toolbar"><span><a href="#" class="toolbar_item command_help help">?</a></span></div><table border="0" cellpadding="0" cellspacing="0"><tbody><tr><td class="gutter"><div class="line number1 index0 alt2">1</div><div class="line number2 index1 alt1">2</div><div class="line number3 index2 alt2">3</div><div class="line number4 index3 alt1">4</div></td><td class="code"><div class="container"><div class="line number1 index0 alt2"><code class="java plain">SampleMessage message;</code></div><div class="line number2 index1 alt1"><code class="java plain">SubMessage* sub_message = message.mutable_sub_message();</code></div><div class="line number3 index2 alt2"><code class="java plain">message.set_name(</code><code class="java string">"name"</code><code class="java plain">);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </code><code class="java comments">// Will delete sub_message</code></div><div class="line number4 index3 alt1"><code class="java plain">sub_message-&gt;set_...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </code><code class="java comments">// Crashes here</code></div></div></td></tr></tbody></table></div></div>
</div>
<p>　　</p>
<ul>
<li>在C++中，如果你使用<code>Swap()</code>两个oneof消息，每个消息，两个消息将拥有对方的值，例如在下面的例子中，<code>msg1</code>会拥有<code>sub_message</code>并且<code>msg2</code>会有<code>name</code>。</li>
</ul>
<div class="cnblogs_Highlighter sh-gutter">
<div><div id="highlighter_44371" class="syntaxhighlighter  java"><div class="toolbar"><span><a href="#" class="toolbar_item command_help help">?</a></span></div><table border="0" cellpadding="0" cellspacing="0"><tbody><tr><td class="gutter"><div class="line number1 index0 alt2">1</div><div class="line number2 index1 alt1">2</div><div class="line number3 index2 alt2">3</div><div class="line number4 index3 alt1">4</div><div class="line number5 index4 alt2">5</div><div class="line number6 index5 alt1">6</div><div class="line number7 index6 alt2">7</div></td><td class="code"><div class="container"><div class="line number1 index0 alt2"><code class="java plain">SampleMessage msg1;</code></div><div class="line number2 index1 alt1"><code class="java plain">msg1.set_name(</code><code class="java string">"name"</code><code class="java plain">);</code></div><div class="line number3 index2 alt2"><code class="java plain">SampleMessage msg2;</code></div><div class="line number4 index3 alt1"><code class="java plain">msg2.mutable_sub_message();</code></div><div class="line number5 index4 alt2"><code class="java plain">msg1.swap(&amp;msg2);</code></div><div class="line number6 index5 alt1"><code class="java plain">CHECK(msg1.has_sub_message());</code></div><div class="line number7 index6 alt2"><code class="java plain">CHECK(msg2.has_name());</code></div></div></td></tr></tbody></table></div></div>
</div>
<p>　　</p>
<h2 id="向后兼容性问题"><span id="Backwards-compatibilityissues">向后兼容性问题</span></h2>
<p>当增加或者删除oneof字段时一定要小心. 如果检查oneof的值返回<code>None/NOT_SET</code>, 它意味着oneof字段没有被赋值或者在一个不同的版本中赋值了。 你不会知道是哪种情况，因为没有办法判断如果未识别的字段是一个oneof字段。</p>
<p>Tage 重用问题：</p>
<ul>
<li>将字段移入或移除oneof：在消息被序列号或者解析后，你也许会失去一些信息（有些字段也许会被清除）</li>
<li>删除一个字段或者加入一个字段：在消息被序列号或者解析后，这也许会清除你现在设置的oneof字段</li>
<li>分离或者融合oneof：行为与移动常规字段相似。</li>
</ul>
<h1 id="map映射"><a name="t21"></a><span id="Maps">Map（映射）</span></h1>
<p>如果你希望创建一个关联映射，protocol buffer提供了一种快捷的语法：</p>
<div class="cnblogs_code">
<pre>map&lt;key_type, value_type&gt; map_field = N;</pre>
</div>
<p>其中<code>key_type</code>可以是任意Integer或者string类型（所以，除了floating和bytes的任意标量类型都是可以的）<code>value_type</code>可以是任意类型。</p>
<p>例如，如果你希望创建一个project的映射，每个<code>Projecct</code>使用一个string作为key，你可以像下面这样定义：</p>
<div class="cnblogs_code">
<pre>map&lt;<span style="color: rgba(0, 0, 255, 1)">string</span>, Project&gt; projects = <span style="color: rgba(128, 0, 128, 1)">3</span>;</pre>
</div>
<ul>
<li>Map的字段可以是repeated。</li>
<li>序列化后的顺序和map迭代器的顺序是不确定的，所以你不要期望以固定顺序处理Map</li>
<li>当为.proto文件产生生成文本格式的时候，map会按照key 的顺序排序，数值化的key会按照数值排序。</li>
<li>从序列化中解析或者融合时，如果有重复的key则后一个key不会被使用，当从文本格式中解析map时，如果存在重复的key。</li>
</ul>
<p>生成map的API现在对于所有proto3支持的语言都可用了，你可以从<a href="https://developers.google.com/protocol-buffers/docs/reference/overview?hl=zh-cn" target="_blank">API指南</a>找到更多信息。</p>
<h2 id="向后兼容性问题-1"><span id="Backwardscompatibility">向后兼容性问题</span></h2>
<p>map语法序列化后等同于如下内容，因此即使是不支持map语法的protocol buffer实现也是可以处理你的数据的：</p>
<div class="cnblogs_code"><div class="cnblogs_code_toolbar"><span class="cnblogs_code_copy"><a href="javascript:void(0);" onclick="copyCnblogsCode(this)" title="复制代码"><img src="//common.cnblogs.com/images/copycode.gif" alt="复制代码"></a></span></div>
<pre><span style="color: rgba(0, 0, 0, 1)">message MapFieldEntry {
  key_type key </span>= <span style="color: rgba(128, 0, 128, 1)">1</span><span style="color: rgba(0, 0, 0, 1)">;
  value_type value </span>= <span style="color: rgba(128, 0, 128, 1)">2</span><span style="color: rgba(0, 0, 0, 1)">;
}

repeated MapFieldEntry map_field </span>= N;</pre>
<div class="cnblogs_code_toolbar"><span class="cnblogs_code_copy"><a href="javascript:void(0);" onclick="copyCnblogsCode(this)" title="复制代码"><img src="//common.cnblogs.com/images/copycode.gif" alt="复制代码"></a></span></div></div>
<h1 id="包"><span id="Packages">包</span></h1>
<p>当然可以为.proto文件新增一个可选的package声明符，用来防止不同的消息类型有命名冲突。如：</p>
<div class="cnblogs_Highlighter sh-gutter">
<div><div id="highlighter_693146" class="syntaxhighlighter  java"><div class="toolbar"><span><a href="#" class="toolbar_item command_help help">?</a></span></div><table border="0" cellpadding="0" cellspacing="0"><tbody><tr><td class="gutter"><div class="line number1 index0 alt2">1</div><div class="line number2 index1 alt1">2</div></td><td class="code"><div class="container"><div class="line number1 index0 alt2"><code class="java keyword">package</code> <code class="java plain">foo.bar;</code></div><div class="line number2 index1 alt1"><code class="java plain">message Open { ... }</code></div></div></td></tr></tbody></table></div></div>
</div>
<p>　　在其他的消息格式定义中可以使用包名+消息名的方式来定义域的类型，如：</p>
<div class="cnblogs_Highlighter sh-gutter">
<div><div id="highlighter_714759" class="syntaxhighlighter  java"><div class="toolbar"><span><a href="#" class="toolbar_item command_help help">?</a></span></div><table border="0" cellpadding="0" cellspacing="0"><tbody><tr><td class="gutter"><div class="line number1 index0 alt2">1</div><div class="line number2 index1 alt1">2</div><div class="line number3 index2 alt2">3</div><div class="line number4 index3 alt1">4</div><div class="line number5 index4 alt2">5</div></td><td class="code"><div class="container"><div class="line number1 index0 alt2"><code class="java plain">message Foo {</code></div><div class="line number2 index1 alt1"><code class="java spaces">&nbsp;&nbsp;</code><code class="java plain">...</code></div><div class="line number3 index2 alt2"><code class="java spaces">&nbsp;&nbsp;</code><code class="java plain">required foo.bar.Open open = </code><code class="java value">1</code><code class="java plain">;</code></div><div class="line number4 index3 alt1"><code class="java spaces">&nbsp;&nbsp;</code><code class="java plain">...</code></div><div class="line number5 index4 alt2"><code class="java plain">}</code></div></div></td></tr></tbody></table></div></div>
</div>
<p>　　</p>
<p>包的声明符会根据使用语言的不同影响生成的代码。</p>
<ul>
<li>对于C++，产生的类会被包装在C++的命名空间中，如上例中的<code>Open</code>会被封装在&nbsp;<code>foo::bar</code>空间中； - 对于Java，包声明符会变为java的一个包，除非在.proto文件中提供了一个明确有<code>java_package</code>；</li>
<li>对于 Python，这个包声明符是被忽略的，因为Python模块是按照其在文件系统中的位置进行组织的。</li>
<li>对于Go，包可以被用做Go包名称，除非你显式的提供一个<code>option go_package</code>在你的.proto文件中。</li>
<li>对于Ruby，生成的类可以被包装在内置的Ruby名称空间中，转换成Ruby所需的大小写样式 （首字母大写；如果第一个符号不是一个字母，则使用PB_前缀），例如<code>Open</code>会在<code>Foo::Bar</code>名称空间中。</li>
<li>对于javaNano包会使用Java包，除非你在你的文件中显式的提供一个<code>option java_package</code>。</li>
<li>对于C#包可以转换为<code>PascalCase</code>后作为名称空间，除非你在你的文件中显式的提供一个<code>option csharp_namespace</code>，例如，<code>Open</code>会在<code>Foo.Bar</code>名称空间中</li>
</ul>
<h2 id="包及名称的解析"><a name="t24"></a><span id="PackagesandNameResolution">包及名称的解析</span></h2>
<p>Protocol buffer语言中类型名称的解析与C++是一致的：首先从最内部开始查找，依次向外进行，每个包会被看作是其父类包的内部类。当然对于 （<code>foo.bar.Baz</code>）这样以“.”分隔的意味着是从最外围开始的。</p>
<p>ProtocolBuffer编译器会解析.proto文件中定义的所有类型名。 对于不同语言的代码生成器会知道如何来指向每个具体的类型，即使它们使用了不同的规则。</p>
<h1 id="定义服务service"><a name="t25"></a><span id="DefiningServices">定义服务(Service)</span></h1>
<p>如果想要将消息类型用在RPC(远程方法调用)系统中，可以在.proto文件中定义一个RPC服务接口，protocol buffer编译器将会根据所选择的不同语言生成服务接口代码及存根。如，想要定义一个RPC服务并具有一个方法，该方法能够接收 SearchRequest并返回一个SearchResponse，此时可以在.proto文件中进行如下定义：</p>
<div class="cnblogs_Highlighter sh-gutter">
<div><div id="highlighter_279287" class="syntaxhighlighter  java"><div class="toolbar"><span><a href="#" class="toolbar_item command_help help">?</a></span></div><table border="0" cellpadding="0" cellspacing="0"><tbody><tr><td class="gutter"><div class="line number1 index0 alt2">1</div><div class="line number2 index1 alt1">2</div><div class="line number3 index2 alt2">3</div></td><td class="code"><div class="container"><div class="line number1 index0 alt2"><code class="java plain">service SearchService {</code></div><div class="line number2 index1 alt1"><code class="java spaces">&nbsp;&nbsp;</code><code class="java plain">rpc Search (SearchRequest) returns (SearchResponse);</code></div><div class="line number3 index2 alt2"><code class="java plain">}</code></div></div></td></tr></tbody></table></div></div>
</div>
<p>　　</p>
<p>最直观的使用protocol buffer的RPC系统是<a href="https://github.com/grpc/grpc-experiments" target="_blank">gRPC</a>一个由谷歌开发的语言和平台中的开源的PRC系统，gRPC在使用protocl buffer时非常有效，如果使用特殊的protocol buffer插件可以直接为您从.proto文件中产生相关的RPC代码。</p>
<p>如果你不想使用gRPC，也可以使用protocol buffer用于自己的RPC实现，你可以从<a href="https://developers.google.com/protocol-buffers/docs/proto?hl=zh-cn#services" target="_blank">proto2语言指南中找到更多信息</a></p>
<p>还有一些第三方开发的PRC实现使用Protocol Buffer。参考<a href="https://github.com/google/protobuf/blob/master/docs/third_party.md" target="_blank">第三方插件wiki</a>查看这些实现的列表。</p>
<h1 id="json-映射"><a name="t26"></a><span id="JSONMapping">JSON 映射</span></h1>
<p>Proto3 支持JSON的编码规范，使他更容易在不同系统之间共享数据，在下表中逐个描述类型。</p>
<p>如果JSON编码的数据丢失或者其本身就是<code>null</code>，这个数据会在解析成protocol buffer的时候被表示成默认值。如果一个字段在protocol buffer中表示为默认值，体会在转化成JSON的时候编码的时候忽略掉以节省空间。具体实现可以提供在JSON编码中可选的默认值。</p>
<div class="table-wrapper"><table>
<thead>
<tr><th>proto3</th><th>JSON</th><th>JSON示例</th><th>注意</th></tr>
</thead>
<tbody>
<tr>
<td>message</td>
<td>object</td>
<td>{“fBar”: v, “g”: null, …}</td>
<td>产生JSON对象，消息字段名可以被映射成lowerCamelCase形式，并且成为JSON对象键，null被接受并成为对应字段的默认值</td>
</tr>
<tr>
<td>enum</td>
<td>string</td>
<td>“FOO_BAR”</td>
<td>枚举值的名字在proto文件中被指定</td>
</tr>
<tr>
<td>map</td>
<td>object</td>
<td>{“k”: v, …}</td>
<td>所有的键都被转换成string</td>
</tr>
<tr>
<td>repeated V</td>
<td>array</td>
<td>[v, …]</td>
<td>null被视为空列表</td>
</tr>
<tr>
<td>bool</td>
<td>true, false</td>
<td>true, false</td>
<td>&nbsp;</td>
</tr>
<tr>
<td>string</td>
<td>string</td>
<td>“Hello World!”</td>
<td>&nbsp;</td>
</tr>
<tr>
<td>bytes</td>
<td>base64 string</td>
<td>“YWJjMTIzIT8kKiYoKSctPUB+”</td>
<td>&nbsp;</td>
</tr>
<tr>
<td>int32, fixed32, uint32</td>
<td>number</td>
<td>1, -10, 0</td>
<td>JSON值会是一个十进制数，数值型或者string类型都会接受</td>
</tr>
<tr>
<td>int64, fixed64, uint64</td>
<td>string</td>
<td>“1”, “-10”</td>
<td>JSON值会是一个十进制数，数值型或者string类型都会接受</td>
</tr>
<tr>
<td>float, double</td>
<td>number</td>
<td>1.1, -10.0, 0, “NaN”, “Infinity”</td>
<td>JSON值会是一个数字或者一个指定的字符串如”NaN”,”infinity”或者”-Infinity”，数值型或者字符串都是可接受的，指数符号也可以接受</td>
</tr>
<tr>
<td>Any</td>
<td>object</td>
<td>{“@type”: “url”, “f”: v, … }</td>
<td>如果一个Any保留一个特上述的JSON映射，则它会转换成一个如下形式：<code>{"@type": xxx, "value": yyy}</code>否则，该值会被转换成一个JSON对象，<code>@type</code>字段会被插入所指定的确定的值</td>
</tr>
<tr>
<td>Timestamp</td>
<td>string</td>
<td>“1972-01-01T10:00:20.021Z”</td>
<td>使用RFC 339，其中生成的输出将始终是Z-归一化啊的，并且使用0，3，6或者9位小数</td>
</tr>
<tr>
<td>Duration</td>
<td>string</td>
<td>“1.000340012s”, “1s”</td>
<td>生成的输出总是0，3，6或者9位小数，具体依赖于所需要的精度，接受所有可以转换为纳秒级的精度</td>
</tr>
<tr>
<td>Struct</td>
<td>object</td>
<td>{ … }</td>
<td>任意的JSON对象，见struct.proto</td>
</tr>
<tr>
<td>Wrapper types</td>
<td>various types</td>
<td>2, “2”, “foo”, true, “true”, null, 0, …</td>
<td>包装器在JSON中的表示方式类似于基本类型，但是允许nulll，并且在转换的过程中保留null</td>
</tr>
<tr>
<td>FieldMask</td>
<td>string</td>
<td>“f.fooBar,h”</td>
<td>见fieldmask.proto</td>
</tr>
<tr>
<td>ListValue</td>
<td>array</td>
<td>[foo, bar, …]</td>
<td>&nbsp;</td>
</tr>
<tr>
<td>Value</td>
<td>value</td>
<td>&nbsp;</td>
<td>任意JSON值</td>
</tr>
<tr>
<td>NullValue</td>
<td>null</td>
<td>&nbsp;</td>
<td>JSON null</td>
</tr>
</tbody>
</table></div>
<h1 id="选项-1"><a name="t27"></a><span id="Options">选项</span></h1>
<p>在定义.proto文件时能够标注一系列的options。Options并不改变整个文件声明的含义，但却能够影响特定环境下处理方式。完整的可用选项可以在google/protobuf/descriptor.proto找到。</p>
<p>一些选项是文件级别的，意味着它可以作用于最外范围，不包含在任何消息内部、enum或服务定义中。一些选项是消息级别的，意味着它可以用在消息定义的内部。当然有些选项可以作用在域、enum类型、enum值、服务类型及服务方法中。到目前为止，并没有一种有效的选项能作用于所有的类型。</p>
<p>如下就是一些常用的选择：</p>
<ul>
<li><code>java_package</code>&nbsp;(文件选项) :这个选项表明生成java类所在的包。如果在.proto文件中没有明确的声明java_package，就采用默认的包名。当然了，默认方式产生的 java包名并不是最好的方式，按照应用名称倒序方式进行排序的。如果不需要产生java代码，则该选项将不起任何作用。如：</li>
</ul>
<div class="cnblogs_code">
<pre>option java_package = <span style="color: rgba(128, 0, 0, 1)">"</span><span style="color: rgba(128, 0, 0, 1)">com.example.foo</span><span style="color: rgba(128, 0, 0, 1)">"</span>;</pre>
</div>
<ul>
<li><code>java_outer_classname</code>&nbsp;(文件选项): 该选项表明想要生成Java类的名称。如果在.proto文件中没有明确的java_outer_classname定义，生成的class名称将会根据.proto文件的名称采用驼峰式的命名方式进行生成。如（foo_bar.proto生成的java类名为FooBar.java）,如果不生成java代码，则该选项不起任何作用。如：</li>
</ul>
<div class="cnblogs_code">
<pre>option java_outer_classname = <span style="color: rgba(128, 0, 0, 1)">"</span><span style="color: rgba(128, 0, 0, 1)">Ponycopter</span><span style="color: rgba(128, 0, 0, 1)">"</span>;</pre>
</div>
<p><code>optimize_for</code>(文件选项): 可以被设置为 SPEED, CODE_SIZE,或者LITE_RUNTIME。这些值将通过如下的方式影响C++及java代码的生成：&nbsp;</p>
<ul>
<ul>
<li><code>SPEED (default)</code>: protocol buffer编译器将通过在消息类型上执行序列化、语法分析及其他通用的操作。这种代码是最优的。</li>
<li><code>CODE_SIZE</code>: protocol buffer编译器将会产生最少量的类，通过共享或基于反射的代码来实现序列化、语法分析及各种其它操作。采用该方式产生的代码将比SPEED要少得多， 但是操作要相对慢些。当然实现的类及其对外的API与SPEED模式都是一样的。这种方式经常用在一些包含大量的.proto文件而且并不盲目追求速度的 应用中。</li>
<li><code>LITE_RUNTIME</code>: protocol buffer编译器依赖于运行时核心类库来生成代码（即采用libprotobuf-lite 替代libprotobuf）。这种核心类库由于忽略了一 些描述符及反射，要比全类库小得多。这种模式经常在移动手机平台应用多一些。编译器采用该模式产生的方法实现与SPEED模式不相上下，产生的类通过实现 MessageLite接口，但它仅仅是Messager接口的一个子集。</li>
</ul>
</ul>
<div class="cnblogs_Highlighter sh-gutter">
<div><div id="highlighter_485004" class="syntaxhighlighter  java"><div class="toolbar"><span><a href="#" class="toolbar_item command_help help">?</a></span></div><table border="0" cellpadding="0" cellspacing="0"><tbody><tr><td class="gutter"><div class="line number1 index0 alt2">1</div></td><td class="code"><div class="container"><div class="line number1 index0 alt2"><code class="java plain">option optimize_for = CODE_SIZE;</code></div></div></td></tr></tbody></table></div></div>
</div>
<p>　　</p>
<ul>
<li><code>cc_enable_arenas</code>(文件选项):对于C++产生的代码启用<a href="https://developers.google.com/protocol-buffers/docs/reference/arenas?hl=zh-cn" target="_blank">arena allocation</a></li>
<li><code>objc_class_prefix</code>(文件选项):设置Objective-C类的前缀，添加到所有Objective-C从此.proto文件产生的类和枚举类型。没有默认值，所使用的前缀应该是苹果推荐的3-5个大写字符，注意2个字节的前缀是苹果所保留的。</li>
<li><code>deprecated</code>(字段选项):如果设置为<code>true</code>则表示该字段已经被废弃，并且不应该在新的代码中使用。在大多数语言中没有实际的意义。在java中，这回变成<code>@Deprecated</code>注释，在未来，其他语言的代码生成器也许会在字标识符中产生废弃注释，废弃注释会在编译器尝试使用该字段时发出警告。如果字段没有被使用你也不希望有新用户使用它，尝试使用保留语句替换字段声明。</li>
</ul>
<div class="cnblogs_code">
<pre>int32 old_field = <span style="color: rgba(128, 0, 128, 1)">6</span> [deprecated=<span style="color: rgba(0, 0, 255, 1)">true</span>];</pre>
</div>
<h2 id="自定义选项"><span id="CustomOptions">自定义选项</span></h2>
<p>ProtocolBuffers允许自定义并使用选项。该功能应该属于一个高级特性，对于大部分人是用不到的。如果你的确希望创建自己的选项，请参看<a href="https://developers.google.com/protocol-buffers/docs/proto?hl=zh-cn#customoptions" target="_blank">&nbsp;Proto2 Language Guide</a>。注意创建自定义选项使用了拓展，拓展只在proto3中可用。</p>
<h1 id="生成访问类"><span id="GeneratingYourClasses">&nbsp;</span></h1>
<p>&nbsp;</p>
</div>


##### 编译protobuf-c:
1. aarch64
> $./configure CC=aarch64-target-linux-gnu-gcc CXX=aarch64-target-linux-gnu-g++ --host=aarch64-target-linux --disable-protoc --prefix=/home/jay/Work/Tools/protobuf-c/protobuf-c-1.4.0/build-armx

2. x86_64
> $./configure --prefix=/home/dev/Tools/protobuf-c-x64/protobuf-c-1.4.0/build-x64 protobuf_LIBS=/home/dev/Tools/protobuf-cpp-x64/protobuf-3.5.1/build-x64/lib/libprotobuf.so protobuf_CFLAGS='-L/home/dev/Tools/protobuf-cpp-x64/protobuf-3.5.1/build-x64/lib/ -I/home/dev/Tools/protobuf-cpp-x64/protobuf-3.5.1/build-x64/include'

***注*** protobuf-c 编译依赖 protobuf-cpp 所以 请先编译protobuf-cpp。 protobuf-cpp中包含google/compiler/*

**其他错误** protoc（protoc --version） 的版本应该跟protobuf-cpp的本版对应 如果不对应会提示

##### 编译protobuf-cpp
1. aarch64

> $ ./configure CC=aarch64-target-linux-gnu-gcc CXX=aarch64-target-linux-gnu-g++ --host=aarch64-target-linux --prefix=/home/dev/Tools/protobuf-cpp-aarch64/protobuf-3.5.1/build-aarch64 --with-sysroot=/home/dev/App/MDC_Cross_Compiler/sysroot/ --with-protoc=/home/dev/Tools/protobuf-cpp-x64/protobuf-3.5.1/build-x64/bin/protoc //protc最好先生成x64的备用，后边针对.proto文件会有一个版本的验证
> 如果出现as:xxxxxxx"64":是因为使用了编译器的as,使用export=/usr/bin/as/"$PATH 更新成系统的as就可以了

2. x86
> $./configure --prefix=/home/dev/Tools/protobuf-cpp-x64/protobuf-3.5.1/build-x64