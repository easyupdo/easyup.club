---
title: vscode-extension
date: 2021-09-30 11:24:55
tags: [vscode,extension]
---

### vscode-extension develop

[传送门](https://www.jianshu.com/p/e642856f6044)
[JDebugger](https://github.com/easyupdo/JDebugger)
[StockInfo](https://github.com/easyupdo/StockInfo)
<article class="_2rhmJa"><h2>1.概览</h2>
<h3>1.1 vscode插件可以做什么</h3>
<blockquote>
<p>vscode编辑器是可高度自定义的，我们使用vscode插件几乎可以对vscode编辑器进行所有形式的自定义，只要你想做，基本上没有不能实现的。</p>
</blockquote>
<p><code>vscode</code>插件开发的官方文档为：<br>
<a href="https://links.jianshu.com/go?to=https%3A%2F%2Fcode.visualstudio.com%2Fapi" target="_blank">https://code.visualstudio.com/api</a><br>
中文文档：<br>
<a href="https://links.jianshu.com/go?to=https%3A%2F%2Fliiked.github.io%2FVS-Code-Extension-Doc-ZH%2F%23%2F" target="_blank">https://liiked.github.io/VS-Code-Extension-Doc-ZH/#/</a><br>
vscode插件可以实现</p>
<ul>
<li class="task-list-item"> 自定义命令</li>
<li class="task-list-item"> 快捷键</li>
<li class="task-list-item"> 自定义菜单项</li>
<li class="task-list-item"> 自定义跳转</li>
<li class="task-list-item"> 自动补全</li>
<li class="task-list-item"> 悬浮提示</li>
<li class="task-list-item"> 新增语言支持</li>
<li class="task-list-item"> 语法检查</li>
<li class="task-list-item"> 语法高亮</li>
<li class="task-list-item"> 代码格式化<br>
····</li>
</ul>
<h3>1.2 如何创建插件</h3>
<blockquote>
<p>可以通过官方脚手架来生成vscode插件模板工程。</p>
</blockquote>
<p><strong>首先安装脚手架</strong><br>
<code>npm install -g yo generator-code</code><br>
<strong>然后进入工作目录，使用脚手架</strong><br>
<code>yo code</code><br>
</p><div class="image-package">
<div class="image-container" style="max-width: 700px; max-height: 752px; background-color: transparent;">
<div class="image-container-fill" style="padding-bottom: 107.39000000000001%;"></div>
<div class="image-view" data-width="1434" data-height="1540"><img data-original-src="//upload-images.jianshu.io/upload_images/5796542-3f4cf900944696a7.png" data-original-width="1434" data-original-height="1540" data-original-format="image/png" data-original-filesize="355039" data-image-index="0" style="cursor: zoom-in;" class="" src="//upload-images.jianshu.io/upload_images/5796542-3f4cf900944696a7.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp"></div>
</div>
<div class="image-caption">1.png</div>
</div><p></p>
<p>通过上图可以看到，生成一个vscode插件工程时可以选择是创建一个已有的语言的插件还是一个全新的语言的插件，并且可以选择插件开发语言。<br>
<strong>本文以创建一个新语言的插件为例。</strong><br>
<strong>vscode插件开发可以使用TypeScript开发，也可以使用JS，两种方式能实现的功能是一样的。</strong><br>
下面是自动生成的插件工程文件</p>
<div class="image-package">
<div class="image-container" style="max-width: 700px; max-height: 556px;">
<div class="image-container-fill" style="padding-bottom: 50.55%;"></div>
<div class="image-view" data-width="1100" data-height="556"><img data-original-src="//upload-images.jianshu.io/upload_images/5796542-f5382093da891343.png" data-original-width="1100" data-original-height="556" data-original-format="image/png" data-original-filesize="126175" data-image-index="1" style="cursor: zoom-in;" class="image-loading"></div>
</div>
<div class="image-caption">3.png</div>
</div>
<p>其中，最核心的两个文件是<code>package.json</code>和<code>extension.js</code>，<code>package.json</code>是整个插件工程的配置文件，<code>extension.js</code>则是工程的入口文件。下面将对这两个文件进行详细的介绍。</p>
<h3>1.3 package.json详解</h3>
<div class="image-package">
<div class="image-container" style="max-width: 700px; max-height: 358px;">
<div class="image-container-fill" style="padding-bottom: 51.05%;"></div>
<div class="image-view" data-width="1524" data-height="778"><img data-original-src="//upload-images.jianshu.io/upload_images/5796542-ecad25c6c53af6a6.png" data-original-width="1524" data-original-height="778" data-original-format="image/png" data-original-filesize="147813" data-image-index="2" style="cursor: zoom-in;" class="image-loading"></div>
</div>
<div class="image-caption">4.png</div>
</div>
<div class="image-package">
<div class="image-container" style="max-width: 700px; max-height: 593px;">
<div class="image-container-fill" style="padding-bottom: 84.67%;"></div>
<div class="image-view" data-width="1852" data-height="1568"><img data-original-src="//upload-images.jianshu.io/upload_images/5796542-2e927acf1d6f6eb2.png" data-original-width="1852" data-original-height="1568" data-original-format="image/png" data-original-filesize="335381" data-image-index="3" style="cursor: zoom-in;" class="image-loading"></div>
</div>
<div class="image-caption">5.png</div>
</div>
<p><em>注</em>：&lt;u&gt;以上配置项在刚创建完的工程文件中不全存在，本文为了更全面介绍配置项，所以后面人为添加了一些配置项。&lt;/u&gt;</p>
<h5><strong><code>activationEvents</code></strong></h5>
<p><code>activationEvents</code>配置项配置插件的激活数组，即在什么情况下插件会被激活，目前支持以下8种配置：</p>
<ul>
<li class="task-list-item"> onLanguage： 在打开对应语言文件时</li>
<li class="task-list-item"> onCommand： 在执行对应命令时</li>
<li class="task-list-item"> onDebug： 在 debug 会话开始前</li>
<li class="task-list-item"> onDebugInitialConfigurations： 在初始化 debug 设置前</li>
<li class="task-list-item"> onDebugResolve： 在 debug 设置处理完之前</li>
<li class="task-list-item"> workspaceContains： 在打开一个文件夹后，如果文件夹内包含设置的文件名模式时</li>
<li class="task-list-item"> onFileSystem： 打开的文件或文件夹，是来自于设置的类型或协议时</li>
<li class="task-list-item"> onView： 侧边栏中设置的 id 项目展开时</li>
<li class="task-list-item"> onUri： 在基于 vscode 或 vscode-insiders 协议的 url 打开时</li>
<li class="task-list-item"> onWebviewPanel： 在打开设置的 webview 时</li>
<li class="task-list-item"> *: 在打开 vscode 的时候，如果不是必须一般不建议这么设置</li>
</ul>
<h5><strong><code>contributes</code></strong></h5>
<p><code>contributes</code>配置项是整个插件的贡献点，也就是说这个插件有哪些功能。<code>contributes</code>字段可以设置的<code>key</code>也基本显示了<code>vscode</code>插件可以做什么。</p>
<ul>
<li class="task-list-item"> configuration：通过这个配置项我们可以设置一个属性，这个属性可以在<code>vscode</code>的<code>settings.json</code>中设置，然后在插件工程中可以读取用户设置的这个值，进行相应的逻辑。</li>
<li class="task-list-item"> commands：命令，通过<code>cmd</code>+<code>shift</code>+<code>p</code>进行输入来实现的。</li>
<li class="task-list-item"> menus：通过这个选项我们可以设置右键的菜单</li>
<li class="task-list-item"> keybindings：可以设置快捷键</li>
<li class="task-list-item"> languages：设置语言特点，包括语言的后缀等</li>
<li class="task-list-item"> grammars：可以在这个配置项里设置描述语言的语法文件的路径，vscode可以根据这个语法文件来自动实现语法高亮功能</li>
<li class="task-list-item"> snippets：设置语法片段相关的路径<br>
. . . . .</li>
</ul>
<h3>extension.js</h3>
<p><code>extension.js</code>是插件工程的入口文件，当插件被激活，即触发<code>package.json</code>中的<code>activationEvents</code>配置项时，<code>extension.js</code>文件开始执行。<br>
在<code>extension.js</code>中对需要的功能进行注册，主要使用<code>vscode.commands.register...</code>相关的<code>api</code>，来为<code>package.json</code>中的<code>contributes</code>配置项中的事件绑定方法或者监听器。<br>
<code>vscode.commands.register...</code>相关的<code>api</code>主要有：</p>
<ul>
<li class="task-list-item"> <code>vscode.languages.registerCompletionItemProvider()</code>
</li>
<li class="task-list-item"> <code>vscode.commands.registerCommand()</code>
</li>
<li class="task-list-item"> <code>vscode.languages.registerCodeActionsProvider()</code>
</li>
<li class="task-list-item"> <code>vscode.languages.registerCodeLensProvider()</code>
</li>
<li class="task-list-item"> <code>vscode.languages.registerHoverProvider()</code><br>
. . . . .<br>
<div class="image-package">
<div class="image-container" style="max-width: 700px; max-height: 460px;">
<div class="image-container-fill" style="padding-bottom: 65.62%;"></div>
<div class="image-view" data-width="1844" data-height="1210"><img data-original-src="//upload-images.jianshu.io/upload_images/5796542-77efa6569b25c8e7.png" data-original-width="1844" data-original-height="1210" data-original-format="image/png" data-original-filesize="299819" data-image-index="4" style="cursor: zoom-in;" class="image-loading"></div>
</div>
<div class="image-caption">6.png</div>
</div>
</li>
</ul>
<h3>1.4 插件生命周期</h3>
<p>下面我们运行一下这个插件工程，按<code>F5</code>运行插件，这个时候会自动打开一个新的vscode界面，我们按<code>cmd</code>+<code>shift</code>+<code>p</code>，在命令框输入<code>plugin-demo.helloWorld</code>命令，既可以看到在vscode的界面的右下角弹出一个弹框，弹框显示<code>Hello World from plugin-demo2</code>，这正是我们在<code>extension.js</code>中为<code>plugin-demo.helloWorld</code>中为<code>plugin-demo.helloWorld</code>命令绑定的事件。<br>
</p><div class="image-package">
<div class="image-container" style="max-width: 700px; max-height: 116px;">
<div class="image-container-fill" style="padding-bottom: 11.790000000000001%;"></div>
<div class="image-view" data-width="984" data-height="116"><img data-original-src="//upload-images.jianshu.io/upload_images/5796542-6af7d8ccfa08cc8c.png" data-original-width="984" data-original-height="116" data-original-format="image/png" data-original-filesize="19014" data-image-index="5" style="cursor: zoom-in;" class="image-loading"></div>
</div>
<div class="image-caption">7.png</div>
</div><p></p>
<p>下面我们梳理一下这个弹框出现的整个流程：</p>
<br>
<div class="image-package">
<div class="image-container" style="max-width: 700px; max-height: 329px;">
<div class="image-container-fill" style="padding-bottom: 46.93%;"></div>
<div class="image-view" data-width="1790" data-height="840"><img data-original-src="//upload-images.jianshu.io/upload_images/5796542-68fb0ab04ac22d20.png" data-original-width="1790" data-original-height="840" data-original-format="image/png" data-original-filesize="154824" data-image-index="6" style="cursor: zoom-in;" class="image-loading"></div>
</div>
<div class="image-caption">8.png</div>
</div>
<ul>
<li>1.<strong><code>activationEvents</code></strong>:在<code>package.json</code>的<code>activationEvents</code>配置项中设置插件激活时机，这里设置的是<code>onCommand:plugin-demo.helloWorld</code>，即输入命令<code>onCommand:plugin-demo.helloWorld</code>时激活。</li>
<li>2.<strong><code>contributes</code></strong>：<code>package.json</code>中的<code>contributes</code>配置项表示这个插件增加了哪些功能，这里设置了<code>commands</code>,增加的命令，在这一项中声明了一个命令<code>plugin-demo.helloWorld</code>。</li>
<li>3.<strong><code>Register</code></strong>:在<code>extension.js</code>文件中的<code>activate(context)</code>方法中，使用<code>vscode.commands.registerCommand()</code>这一API为命令<code>plugin-demo.helloWorld</code>绑定事件，绑定的事件为<code>vscode.window.showInformationMessage('Hello World from plugin-demo2!')</code>，即弹出弹框。</li>
<li>4.在命令框中输入<code>plugin-demo.helloWorld</code>，此时插件被激活，进入<code>extension.js</code>中执行<code>activate()</code>方法，由于已经在<code>contributes</code>配置项中声明了命令<code>plugin-demo.helloWorld</code>,所以在<code>activate()</code>方法中为该命令绑定一个事件，由于在命令框中输入了这个命令，所以命令绑定的事件立即被触发执行，所以在vscode的右下角弹出了弹出框。</li>
</ul>
<blockquote>
<p><strong>VSCode的插件都运行在一个独立的进程里, 被称为 Extension Host, 它加载并运行插件, 让插件感觉自己好像在主进程里一样, 同时又严格限制插件的响应时间, 避免插件影响主界面进程。</strong></p>
</blockquote>
<div class="image-package">
<div class="image-container" style="max-width: 700px; max-height: 481px;">
<div class="image-container-fill" style="padding-bottom: 68.63%;"></div>
<div class="image-view" data-width="1530" data-height="1050"><img data-original-src="//upload-images.jianshu.io/upload_images/5796542-e251aec33d17d9d3.png" data-original-width="1530" data-original-height="1050" data-original-format="image/png" data-original-filesize="244553" data-image-index="7" style="cursor: zoom-in;" class="image-loading"></div>
</div>
<div class="image-caption">9.png</div>
</div>
<h2>2.具体的功能介绍</h2>
<h3>命令</h3>
<p>关于命令我们之前在分析插件的生命周期的时候就已经讲过，首先在<code>package.json</code>的<code>contributes</code>配置项中声明命令：</p>
<div class="_2Uzcx_"><button class="VJbwyy" type="button" aria-label="复制代码"><i aria-label="icon: copy" class="anticon anticon-copy"><svg viewBox="64 64 896 896" focusable="false" class="" data-icon="copy" width="1em" height="1em" fill="currentColor" aria-hidden="true"><path d="M832 64H296c-4.4 0-8 3.6-8 8v56c0 4.4 3.6 8 8 8h496v688c0 4.4 3.6 8 8 8h56c4.4 0 8-3.6 8-8V96c0-17.7-14.3-32-32-32zM704 192H192c-17.7 0-32 14.3-32 32v530.7c0 8.5 3.4 16.6 9.4 22.6l173.3 173.3c2.2 2.2 4.7 4 7.4 5.5v1.9h4.2c3.5 1.3 7.2 2 11 2H704c17.7 0 32-14.3 32-32V224c0-17.7-14.3-32-32-32zM350 856.2L263.9 770H350v86.2zM664 888H414V746c0-22.1-17.9-40-40-40H232V264h432v624z"></path></svg></i></button><pre class="line-numbers  language-bash"><code class="  language-bash">"commands": [
    {
        "command": "plugin-demo.helloWorld",
        "title": "Hello World"
    }
]
<span aria-hidden="true" class="line-numbers-rows"><span></span><span></span><span></span><span></span><span></span><span></span></span></code></pre></div>
<p>然后在<code>extension.js</code>的<code>activate()</code>中去注册该命令，绑定事件：</p>
<div class="_2Uzcx_"><button class="VJbwyy" type="button" aria-label="复制代码"><i aria-label="icon: copy" class="anticon anticon-copy"><svg viewBox="64 64 896 896" focusable="false" class="" data-icon="copy" width="1em" height="1em" fill="currentColor" aria-hidden="true"><path d="M832 64H296c-4.4 0-8 3.6-8 8v56c0 4.4 3.6 8 8 8h496v688c0 4.4 3.6 8 8 8h56c4.4 0 8-3.6 8-8V96c0-17.7-14.3-32-32-32zM704 192H192c-17.7 0-32 14.3-32 32v530.7c0 8.5 3.4 16.6 9.4 22.6l173.3 173.3c2.2 2.2 4.7 4 7.4 5.5v1.9h4.2c3.5 1.3 7.2 2 11 2H704c17.7 0 32-14.3 32-32V224c0-17.7-14.3-32-32-32zM350 856.2L263.9 770H350v86.2zM664 888H414V746c0-22.1-17.9-40-40-40H232V264h432v624z"></path></svg></i></button><pre class="line-numbers  language-jsx"><code class="  language-jsx"><span class="token keyword">let</span> disposable <span class="token operator">=</span> vscode<span class="token punctuation">.</span>commands<span class="token punctuation">.</span><span class="token function">registerCommand</span><span class="token punctuation">(</span><span class="token string">'plugin-demo.helloWorld'</span><span class="token punctuation">,</span> <span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
    
        vscode<span class="token punctuation">.</span>window<span class="token punctuation">.</span><span class="token function">showInformationMessage</span><span class="token punctuation">(</span><span class="token string">'Hello World from plugin-demo2!'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span aria-hidden="true" class="line-numbers-rows"><span></span><span></span><span></span><span></span></span></code></pre></div>
<p>所有注册类的API执行后都要将将结果放到<code>context.subscriptions</code>中去：</p>
<div class="_2Uzcx_"><button class="VJbwyy" type="button" aria-label="复制代码"><i aria-label="icon: copy" class="anticon anticon-copy"><svg viewBox="64 64 896 896" focusable="false" class="" data-icon="copy" width="1em" height="1em" fill="currentColor" aria-hidden="true"><path d="M832 64H296c-4.4 0-8 3.6-8 8v56c0 4.4 3.6 8 8 8h496v688c0 4.4 3.6 8 8 8h56c4.4 0 8-3.6 8-8V96c0-17.7-14.3-32-32-32zM704 192H192c-17.7 0-32 14.3-32 32v530.7c0 8.5 3.4 16.6 9.4 22.6l173.3 173.3c2.2 2.2 4.7 4 7.4 5.5v1.9h4.2c3.5 1.3 7.2 2 11 2H704c17.7 0 32-14.3 32-32V224c0-17.7-14.3-32-32-32zM350 856.2L263.9 770H350v86.2zM664 888H414V746c0-22.1-17.9-40-40-40H232V264h432v624z"></path></svg></i></button><pre class="line-numbers  language-css"><code class="  language-css">context.subscriptions.<span class="token function">push</span><span class="token punctuation">(</span>disposable<span class="token punctuation">)</span><span class="token punctuation">;</span>
<span aria-hidden="true" class="line-numbers-rows"><span></span></span></code></pre></div>
<p>这样当插件被激活后，输入命令，命令绑定的事件就会被执行。</p>
<h3>菜单</h3>
<blockquote>
<p>菜单也是通过和命令关联起来来实现其功能的</p>
</blockquote>
<div class="_2Uzcx_"><button class="VJbwyy" type="button" aria-label="复制代码"><i aria-label="icon: copy" class="anticon anticon-copy"><svg viewBox="64 64 896 896" focusable="false" class="" data-icon="copy" width="1em" height="1em" fill="currentColor" aria-hidden="true"><path d="M832 64H296c-4.4 0-8 3.6-8 8v56c0 4.4 3.6 8 8 8h496v688c0 4.4 3.6 8 8 8h56c4.4 0 8-3.6 8-8V96c0-17.7-14.3-32-32-32zM704 192H192c-17.7 0-32 14.3-32 32v530.7c0 8.5 3.4 16.6 9.4 22.6l173.3 173.3c2.2 2.2 4.7 4 7.4 5.5v1.9h4.2c3.5 1.3 7.2 2 11 2H704c17.7 0 32-14.3 32-32V224c0-17.7-14.3-32-32-32zM350 856.2L263.9 770H350v86.2zM664 888H414V746c0-22.1-17.9-40-40-40H232V264h432v624z"></path></svg></i></button><pre class="line-numbers  language-bash"><code class="  language-bash">"menus": {
    "editor/title": [{
    "when": "editorFocus",
    "command": "plugin-demo.helloWorld",
    "alt": "",
    "group": "navigation"
    }]
}
<span aria-hidden="true" class="line-numbers-rows"><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span></span></code></pre></div>
<p>以上是一个菜单项的完整配置.</p>
<ul>
<li>
<strong><code>editor/title:</code></strong> 定义这个菜单出现在哪里，这里是定义出现在编辑标题菜单栏。</li>
<li>
<strong><code>when:</code></strong> 菜单在什么时候出现，这里是有光标的时候出现</li>
<li>
<strong><code>command:</code></strong> 点击这个菜单要执行的命令</li>
<li>
<strong><code>alt:</code></strong> 按住<code>alt</code>再选择菜单时应该执行的命令</li>
<li>
<strong><code>group:</code></strong> 定义菜单分组</li>
</ul>
<p>菜单项对应的命令为<code>plugin-demo.helloWorld</code>，我们再在<code>contributions</code>的<code>commands</code>中找到这个命令:</p>
<div class="_2Uzcx_"><button class="VJbwyy" type="button" aria-label="复制代码"><i aria-label="icon: copy" class="anticon anticon-copy"><svg viewBox="64 64 896 896" focusable="false" class="" data-icon="copy" width="1em" height="1em" fill="currentColor" aria-hidden="true"><path d="M832 64H296c-4.4 0-8 3.6-8 8v56c0 4.4 3.6 8 8 8h496v688c0 4.4 3.6 8 8 8h56c4.4 0 8-3.6 8-8V96c0-17.7-14.3-32-32-32zM704 192H192c-17.7 0-32 14.3-32 32v530.7c0 8.5 3.4 16.6 9.4 22.6l173.3 173.3c2.2 2.2 4.7 4 7.4 5.5v1.9h4.2c3.5 1.3 7.2 2 11 2H704c17.7 0 32-14.3 32-32V224c0-17.7-14.3-32-32-32zM350 856.2L263.9 770H350v86.2zM664 888H414V746c0-22.1-17.9-40-40-40H232V264h432v624z"></path></svg></i></button><pre class="line-numbers  language-bash"><code class="  language-bash">"commands": [
    {
        "command": "plugin-demo.helloWorld",
        "title": "菜单栏测试"
    }
        ]
<span aria-hidden="true" class="line-numbers-rows"><span></span><span></span><span></span><span></span><span></span><span></span></span></code></pre></div>
<p>这里命令的<code>title</code>将作为菜单项的名字显示，当然我们也可以设置菜单项的<code>icon</code>。<br>
我们之前已经在<code>extension.js</code>中注册过这个命令了，因此不用再注册。</p>
<p>按<code>F5</code>运行插件，保证插件被激活后，使光标出现，在编辑器的右上角我们可以看到出现一个新增的菜单：<br>
</p><div class="image-package">
<div class="image-container" style="max-width: 700px; max-height: 188px;">
<div class="image-container-fill" style="padding-bottom: 26.040000000000003%;"></div>
<div class="image-view" data-width="722" data-height="188"><img data-original-src="//upload-images.jianshu.io/upload_images/5796542-3dacba95b216425c.png" data-original-width="722" data-original-height="188" data-original-format="image/png" data-original-filesize="21270" data-image-index="8" style="cursor: zoom-in;" class="image-loading"></div>
</div>
<div class="image-caption">10.png</div>
</div><p></p>
<p>当我们点击这个菜单时，其会执行关联的<code>command</code>在<code>extension.js</code>中绑定的事件。</p>
<h3>快捷键</h3>
<blockquote>
<p><strong>快捷键的设置比较简单，其执行功能同样依赖于其关联的命令<code>command</code>。</strong></p>
</blockquote>
<div class="_2Uzcx_"><button class="VJbwyy" type="button" aria-label="复制代码"><i aria-label="icon: copy" class="anticon anticon-copy"><svg viewBox="64 64 896 896" focusable="false" class="" data-icon="copy" width="1em" height="1em" fill="currentColor" aria-hidden="true"><path d="M832 64H296c-4.4 0-8 3.6-8 8v56c0 4.4 3.6 8 8 8h496v688c0 4.4 3.6 8 8 8h56c4.4 0 8-3.6 8-8V96c0-17.7-14.3-32-32-32zM704 192H192c-17.7 0-32 14.3-32 32v530.7c0 8.5 3.4 16.6 9.4 22.6l173.3 173.3c2.2 2.2 4.7 4 7.4 5.5v1.9h4.2c3.5 1.3 7.2 2 11 2H704c17.7 0 32-14.3 32-32V224c0-17.7-14.3-32-32-32zM350 856.2L263.9 770H350v86.2zM664 888H414V746c0-22.1-17.9-40-40-40H232V264h432v624z"></path></svg></i></button><pre class="line-numbers  language-bash"><code class="  language-bash">"keybindings": [
    {
        "command": "plugin-demo.helloWorld",
        "key": "ctrl+{",
        "mac": "cmd+{",
        "when": "editorTextFocus"
    }
]
<span aria-hidden="true" class="line-numbers-rows"><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span></span></code></pre></div>
<ul>
<li>
<strong><code>command:</code></strong> 快捷键关联的命令</li>
<li>
<strong><code>key:</code></strong> Windows平台对应的快捷键</li>
<li>
<strong><code>mac:</code></strong> mac平台对应的快捷键</li>
<li>
<strong><code>when:</code></strong> 什么时候快捷键有效</li>
</ul>
<p>当插件被激活后，并且满足快捷键有效的时间，按快捷键就可以找到<code>extension.js</code>中与快捷键关联的<code>command</code>所不绑定的事件并执行。</p>
<h3>悬停提示</h3>
<blockquote>
<p><strong>悬停提示的思路是在<code>extension.js</code>中注册一个悬停事件，然后根据提供的<code>docuemnt</code>、<code>position</code>已经文件名，文件路径等信息作出相应的逻辑。</strong></p>
</blockquote>
<p>主要API：</p>
<p><code>function registerHoverProvider(selector: DocumentSelector, provider: HoverProvider): Disposable;</code><br>
这一API返回一个<code>HoverProvider</code>对象，这一对象需要加入到<code>context.subscription</code>中。</p>
<p><code>provideHover(document: TextDocument, position: Position, token: CancellationToken): ProviderResult&lt;Hover&gt;;</code><br>
这一API返回一个<code>PrioviderResult</code>对象，当我们把光标放在某个位置时显示的内容，就是这个对象封装的。</p>
<p>下面我们写一个简单的demo，我们对package.json文件中的<code>main</code>这个单词进行悬停提示：</p>
<div class="_2Uzcx_"><button class="VJbwyy" type="button" aria-label="复制代码"><i aria-label="icon: copy" class="anticon anticon-copy"><svg viewBox="64 64 896 896" focusable="false" class="" data-icon="copy" width="1em" height="1em" fill="currentColor" aria-hidden="true"><path d="M832 64H296c-4.4 0-8 3.6-8 8v56c0 4.4 3.6 8 8 8h496v688c0 4.4 3.6 8 8 8h56c4.4 0 8-3.6 8-8V96c0-17.7-14.3-32-32-32zM704 192H192c-17.7 0-32 14.3-32 32v530.7c0 8.5 3.4 16.6 9.4 22.6l173.3 173.3c2.2 2.2 4.7 4 7.4 5.5v1.9h4.2c3.5 1.3 7.2 2 11 2H704c17.7 0 32-14.3 32-32V224c0-17.7-14.3-32-32-32zM350 856.2L263.9 770H350v86.2zM664 888H414V746c0-22.1-17.9-40-40-40H232V264h432v624z"></path></svg></i></button><pre class="line-numbers  language-jsx"><code class="  language-jsx"><span class="token keyword">function</span> <span class="token function">activate</span><span class="token punctuation">(</span><span class="token parameter">context</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>

    <span class="token keyword">const</span> hover <span class="token operator">=</span> vscode<span class="token punctuation">.</span>languages<span class="token punctuation">.</span><span class="token function">registerHoverProvider</span><span class="token punctuation">(</span><span class="token string">'json'</span><span class="token punctuation">,</span> <span class="token punctuation">{</span>
        <span class="token function">provideHover</span><span class="token punctuation">(</span><span class="token parameter">document<span class="token punctuation">,</span> position<span class="token punctuation">,</span> token</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
            <span class="token keyword">const</span> fileName <span class="token operator">=</span> document<span class="token punctuation">.</span>fileName<span class="token punctuation">;</span>
            <span class="token keyword">const</span> word <span class="token operator">=</span> document<span class="token punctuation">.</span><span class="token function">getText</span><span class="token punctuation">(</span>document<span class="token punctuation">.</span><span class="token function">getWordRangeAtPosition</span><span class="token punctuation">(</span>position<span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
            <span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token regex">/\/package\.json$/</span><span class="token punctuation">.</span><span class="token function">test</span><span class="token punctuation">(</span>fileName<span class="token punctuation">)</span> <span class="token operator">&amp;&amp;</span> <span class="token regex">/\bmain\b/</span><span class="token punctuation">.</span><span class="token function">test</span><span class="token punctuation">(</span>word<span class="token punctuation">)</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
                <span class="token keyword">return</span> <span class="token keyword">new</span> <span class="token class-name">vscode<span class="token punctuation">.</span>Hover</span><span class="token punctuation">(</span><span class="token string">"测试悬停提示"</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
            <span class="token punctuation">}</span>
            <span class="token keyword">return</span> <span class="token keyword">undefined</span><span class="token punctuation">;</span>
        <span class="token punctuation">}</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

    context<span class="token punctuation">.</span>subscriptions<span class="token punctuation">.</span><span class="token function">push</span><span class="token punctuation">(</span>hover<span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span>
<span aria-hidden="true" class="line-numbers-rows"><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span></span></code></pre></div>
<p>运行插件，保证插件被激活的状态下，将光标放在<code>package.json</code>文件的<code>main</code>单词上：<br>
</p><div class="image-package">
<div class="image-container" style="max-width: 700px; max-height: 310px;">
<div class="image-container-fill" style="padding-bottom: 40.58%;"></div>
<div class="image-view" data-width="764" data-height="310"><img data-original-src="//upload-images.jianshu.io/upload_images/5796542-5290183f8cb4a5dd.gif" data-original-width="764" data-original-height="310" data-original-format="image/gif" data-original-filesize="1227854" data-image-index="9" style="cursor: zoom-in;" class="image-loading"></div>
</div>
<div class="image-caption">12.gif</div>
</div><p></p>
<h3>代码片段</h3>
<p>代码片段也叫<code>snippets</code>，就是输入一个前缀，会得到一个或多个提示，然后回车带出很多代码。</p>
<p>想要在vscode插件中实现<code>snippets</code>的功能，首先要在<code>package.json</code>的<code>contributes</code>配置项中配置<strong>代码提示文件的文件路径：</strong></p>
<div class="_2Uzcx_"><button class="VJbwyy" type="button" aria-label="复制代码"><i aria-label="icon: copy" class="anticon anticon-copy"><svg viewBox="64 64 896 896" focusable="false" class="" data-icon="copy" width="1em" height="1em" fill="currentColor" aria-hidden="true"><path d="M832 64H296c-4.4 0-8 3.6-8 8v56c0 4.4 3.6 8 8 8h496v688c0 4.4 3.6 8 8 8h56c4.4 0 8-3.6 8-8V96c0-17.7-14.3-32-32-32zM704 192H192c-17.7 0-32 14.3-32 32v530.7c0 8.5 3.4 16.6 9.4 22.6l173.3 173.3c2.2 2.2 4.7 4 7.4 5.5v1.9h4.2c3.5 1.3 7.2 2 11 2H704c17.7 0 32-14.3 32-32V224c0-17.7-14.3-32-32-32zM350 856.2L263.9 770H350v86.2zM664 888H414V746c0-22.1-17.9-40-40-40H232V264h432v624z"></path></svg></i></button><pre class="line-numbers  language-bash"><code class="  language-bash">"snippets": [
    {
        "language": "lizard",
        "path": "./snippets.json"
        }
    ]
<span aria-hidden="true" class="line-numbers-rows"><span></span><span></span><span></span><span></span><span></span><span></span></span></code></pre></div>
<p>这里<code>language</code>设置了<code>snippets</code>作用于何种语言，<code>path</code>设置了服务于<code>snippets</code>的文件的路径。<br>
再看一下在<code>snippets.json</code>文件中：</p>
<div class="_2Uzcx_"><button class="VJbwyy" type="button" aria-label="复制代码"><i aria-label="icon: copy" class="anticon anticon-copy"><svg viewBox="64 64 896 896" focusable="false" class="" data-icon="copy" width="1em" height="1em" fill="currentColor" aria-hidden="true"><path d="M832 64H296c-4.4 0-8 3.6-8 8v56c0 4.4 3.6 8 8 8h496v688c0 4.4 3.6 8 8 8h56c4.4 0 8-3.6 8-8V96c0-17.7-14.3-32-32-32zM704 192H192c-17.7 0-32 14.3-32 32v530.7c0 8.5 3.4 16.6 9.4 22.6l173.3 173.3c2.2 2.2 4.7 4 7.4 5.5v1.9h4.2c3.5 1.3 7.2 2 11 2H704c17.7 0 32-14.3 32-32V224c0-17.7-14.3-32-32-32zM350 856.2L263.9 770H350v86.2zM664 888H414V746c0-22.1-17.9-40-40-40H232V264h432v624z"></path></svg></i></button><pre class="line-numbers  language-json"><code class="  language-json"><span class="token punctuation">{</span>
    <span class="token property">"View组件"</span><span class="token operator">:</span> <span class="token punctuation">{</span>
        <span class="token property">"prefix"</span><span class="token operator">:</span> <span class="token string">"View"</span><span class="token punctuation">,</span>
        <span class="token property">"body"</span><span class="token operator">:</span> <span class="token punctuation">[</span>
            <span class="token string">"&lt;View&gt;"</span><span class="token punctuation">,</span>
            <span class="token string">"${1}"</span><span class="token punctuation">,</span>
            <span class="token string">"&lt;/VIew&gt;"</span>
        <span class="token punctuation">]</span><span class="token punctuation">,</span>
        <span class="token property">"description"</span><span class="token operator">:</span> <span class="token string">"View组件"</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span>
<span aria-hidden="true" class="line-numbers-rows"><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span></span></code></pre></div>
<ul>
<li>
<strong><code>"View组件"：</code></strong> <code>snippet</code>的名称</li>
<li>
<strong><code>"prefix"：</code></strong> 前缀，即输入什么可以出现<code>snippets</code>的提示</li>
<li>
<strong><code>"body"：</code></strong> 按回车后出现的一大段代码，是一个数组，数组里面是字符串，每个字符串代表一行代码，<code>${1}</code>表示第一个光标的位置，同样，<code>${2}</code>表示第二个光标的位置</li>
<li>
<strong><code>"description"：</code></strong> 对于这个<code>snippet</code>的描述，当我们选中这个<code>snipets</code>提示时，描述会出现在后面。<br>
现在，我们运行插件，并保证插件被激活，在规定的语言下，输入<code>View</code>:<br>
<div class="image-package">
<div class="image-container" style="max-width: 602px; max-height: 120px;">
<div class="image-container-fill" style="padding-bottom: 19.93%;"></div>
<div class="image-view" data-width="602" data-height="120"><img data-original-src="//upload-images.jianshu.io/upload_images/5796542-ad8bbbdabe352a54.gif" data-original-width="602" data-original-height="120" data-original-format="image/gif" data-original-filesize="381531" data-image-index="10" style="cursor: zoom-in;" class="image-loading"></div>
</div>
<div class="image-caption">11.gif</div>
</div>
</li>
</ul>
<h2>3.详细讲解的插件功能</h2>
<h3>代码高亮</h3>
<p><strong>当我们为一个已有的语言创建插件时，<code>package.json</code>中默认不会有代码高亮相关的配置，当我们为一个新语言开发插件时，插件工程的<code>package.json</code>文件中默认有语法高亮相关的配资。</strong><br>
这一配置仍然在<code>contributes</code>中：<br>
</p><div class="image-package">
<div class="image-container" style="max-width: 700px; max-height: 242px;">
<div class="image-container-fill" style="padding-bottom: 24.01%;"></div>
<div class="image-view" data-width="1008" data-height="242"><img data-original-src="//upload-images.jianshu.io/upload_images/5796542-37c0402cbacfa583.png" data-original-width="1008" data-original-height="242" data-original-format="image/png" data-original-filesize="40147" data-image-index="11" style="cursor: zoom-in;" class="image-loading"></div>
</div>
<div class="image-caption">20.png</div>
</div><p></p>
<p>上图中<code>grammars</code>的<code>path</code>项设置了<strong>描述新语言的语法</strong>的文件路径。<br>
然后我们看到这个语法文件<code>lizard.tmLanguage.json</code>，vscode会根据这个语法文件自动实现语法高亮的功能。我们找到该文件中的一段：<br>
</p><div class="image-package">
<div class="image-container" style="max-width: 700px; max-height: 282px;">
<div class="image-container-fill" style="padding-bottom: 27.49%;"></div>
<div class="image-view" data-width="1026" data-height="282"><img data-original-src="//upload-images.jianshu.io/upload_images/5796542-0cfde9fce90a537c.png" data-original-width="1026" data-original-height="282" data-original-format="image/png" data-original-filesize="39038" data-image-index="12" style="cursor: zoom-in;" class="image-loading"></div>
</div>
<div class="image-caption">21.png</div>
</div><p></p>
<p>先不管这里每一项表示什么含义，首先运行代码，输入<code>for</code>、<code>return</code>、<code>if</code>、<code>while</code>等关键字中的其中一个，会发现关键字出现了高亮，这便实现了简单的高亮功能。<br>
上面的的代码中。<br>
<code>lizard.tmLanguage.json</code>中的语法是<code>TextMate</code>语法，关于<code>TextMate</code>的介绍：<br>
<a href="https://links.jianshu.com/go?to=https%3A%2F%2Fmacromates.com%2Fmanual%2Fen%2Flanguage_grammars" target="_blank">https://macromates.com/manual/en/language_grammars</a><br>
<a href="https://links.jianshu.com/go?to=https%3A%2F%2Fwww.apeth.com%2Fnonblog%2Fstories%2Ftextmatebundle.html" target="_blank">https://www.apeth.com/nonblog/stories/textmatebundle.html</a><br>
</p><div class="image-package">
<div class="image-container" style="max-width: 700px; max-height: 215px;">
<div class="image-container-fill" style="padding-bottom: 20.419999999999998%;"></div>
<div class="image-view" data-width="1053" data-height="215"><img data-original-src="//upload-images.jianshu.io/upload_images/5796542-5af2bc882131617e.png" data-original-width="1053" data-original-height="215" data-original-format="image/png" data-original-filesize="74379" data-image-index="13" style="cursor: zoom-in;" class="image-loading"></div>
</div>
<div class="image-caption">22.png</div>
</div><p></p>
<p>上面的代码中：<br>
<strong><code>match</code></strong>是一个正则表达式，但是使用的是<code>ruby regular expression</code>,进行匹配，<strong><code>name</code></strong>是被匹配的表达式的<code>scope selector</code>，关于<code>scope selector</code>的介绍见链接：<br>
<a href="https://links.jianshu.com/go?to=https%3A%2F%2Fmacromates.com%2Fmanual%2Fen%2Fscope_selectors" target="_blank">https://macromates.com/manual/en/scope_selectors</a><br>
<code>vscode</code>根据这个<code>scope selector</code>进行上色。<br>
下面介绍一下本文为新语言写语法文件的案例：<br>
为属性结构写语法，属性结构模板为:<code>style = {width:8, height:9}</code><br>
</p><div class="image-package">
<div class="image-container" style="max-width: 700px; max-height: 620px;">
<div class="image-container-fill" style="padding-bottom: 73.9%;"></div>
<div class="image-view" data-width="839" data-height="620"><img data-original-src="//upload-images.jianshu.io/upload_images/5796542-90e8486f8b0883c0.png" data-original-width="839" data-original-height="620" data-original-format="image/png" data-original-filesize="114603" data-image-index="14" style="cursor: zoom-in;" class="image-loading"></div>
</div>
<div class="image-caption">23.png</div>
</div><p></p>
<h3>代码提示</h3>
<blockquote>
<p>代码提示是我们使用vscode开发的时候不可获取的一个功能，即当我们输入代码的一部分的时候，这时候<code>vscode</code>显示一个提示列表，我们可以选择一个提示项，然后回车，这样代码的剩余部分就自动补全了。</p>
</blockquote>
<p>代码提示相关的主要的API是：<br>
<strong><code>registerCompletionItemProvider(selector: DocumentSelector, provider: CompletionItemProvider, ...triggerCharacters: string[]): Disposable;</code></strong></p>
<ul>
<li>第一个参数是实现代码提示的文件的类型。</li>
<li>第二个参数是一个<code>CompletionItemProvider</code>类型的对象,在创建这个对象内部，我们需要根据<code>document</code>、<code>position</code>等信息进行逻辑处理，返回一个<code>CompletionItem</code>的数组，每一个<code>CompletionItem</code>就代表一个提示项。</li>
<li>第三个参数是可选的触发提示的字符列表。</li>
</ul>
<p><strong>下面列出一些与代码提示相关的其他的一些API，这些API大多与文本、单词的处理相关，因为我们进行代码提示时需要知道当前光标所在单词的上下文，这样才能很好的给出智能提示，而要得到当前光标的上下文，就需要对光标附近乃至整个文件进行文本分析。</strong></p>
<ul>
<li>
<strong><code>与TextDocument相关</code></strong><br>
<code>TextDocument</code>的对象实际是当前文件对象，所以我们可以根据该对象得到当前文件与文本相关的所有信息。</li>
<li>
<code>lineAt(line: number): TextLine;</code> 根据行数返回一个行的对象</li>
<li>
<code>lineAt(position: Position): TextLine;</code> 根据一个位置返回这一行的行对象</li>
<li>
<code>getText(range?: Range): string;</code> 根据范围，返回这个范围的文本</li>
<li>
<code>getWordRangeAtPosition(position: Position, regex?: RegExp): Range | undefined;</code> 根据<code>position</code>返回这个位置所在的单词。</li>
<li>
<code>text.charAt()</code> 返回字符串在某个位置的字符</li>
</ul>
<p>下面写一个代码提示的简单的demo:</p>
<div class="_2Uzcx_"><button class="VJbwyy" type="button" aria-label="复制代码"><i aria-label="icon: copy" class="anticon anticon-copy"><svg viewBox="64 64 896 896" focusable="false" class="" data-icon="copy" width="1em" height="1em" fill="currentColor" aria-hidden="true"><path d="M832 64H296c-4.4 0-8 3.6-8 8v56c0 4.4 3.6 8 8 8h496v688c0 4.4 3.6 8 8 8h56c4.4 0 8-3.6 8-8V96c0-17.7-14.3-32-32-32zM704 192H192c-17.7 0-32 14.3-32 32v530.7c0 8.5 3.4 16.6 9.4 22.6l173.3 173.3c2.2 2.2 4.7 4 7.4 5.5v1.9h4.2c3.5 1.3 7.2 2 11 2H704c17.7 0 32-14.3 32-32V224c0-17.7-14.3-32-32-32zM350 856.2L263.9 770H350v86.2zM664 888H414V746c0-22.1-17.9-40-40-40H232V264h432v624z"></path></svg></i></button><pre class="line-numbers  language-jsx"><code class="  language-jsx"><span class="token keyword">function</span> <span class="token function">activate</span><span class="token punctuation">(</span><span class="token parameter">context</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>

    <span class="token keyword">const</span> provider <span class="token operator">=</span> vscode<span class="token punctuation">.</span>languages<span class="token punctuation">.</span><span class="token function">registerCompletionItemProvider</span><span class="token punctuation">(</span><span class="token string">'plaintext'</span><span class="token punctuation">,</span> <span class="token punctuation">{</span>
        <span class="token function">provideCompletionItems</span><span class="token punctuation">(</span><span class="token parameter">document<span class="token punctuation">,</span> position</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
            <span class="token keyword">const</span> completionItem1 <span class="token operator">=</span> <span class="token keyword">new</span> <span class="token class-name">vscode<span class="token punctuation">.</span>CompletionItem</span><span class="token punctuation">(</span><span class="token string">'Hello World!'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
            <span class="token keyword">const</span> completionItem2 <span class="token operator">=</span> <span class="token keyword">new</span> <span class="token class-name">vscode<span class="token punctuation">.</span>CompletionItem</span><span class="token punctuation">(</span><span class="token string">'World Peace!'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
            <span class="token keyword">return</span> <span class="token punctuation">[</span>completionItem1<span class="token punctuation">,</span> completionItem2<span class="token punctuation">]</span><span class="token punctuation">;</span>
        <span class="token punctuation">}</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
        
    context<span class="token punctuation">.</span>subscriptions<span class="token punctuation">.</span><span class="token function">push</span><span class="token punctuation">(</span>provider<span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span>
<span aria-hidden="true" class="line-numbers-rows"><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span></span></code></pre></div>
<p>我们在这里创建了两个<code>CompletionItem</code>对象，这样，当我们输入<code>Hello World!</code>或<code>World Peace</code>的一部分时，插件会自动显示提示项，回车即可进行补全。</p>
<div class="image-package">
<div class="image-container" style="max-width: 480px; max-height: 208px;">
<div class="image-container-fill" style="padding-bottom: 43.33%;"></div>
<div class="image-view" data-width="480" data-height="208"><img data-original-src="//upload-images.jianshu.io/upload_images/5796542-fb3892835cbe2d59.gif" data-original-width="480" data-original-height="208" data-original-format="image/gif" data-original-filesize="691866" data-image-index="15" style="cursor: zoom-in;" class="image-loading"></div>
</div>
<div class="image-caption">13.gif</div>
</div>
<hr>
<h3>自定义语言实现代码提示</h3>
<blockquote>
<p>上面的demo中我们实现了一个简单的代码提示的demo，但是这种异常简单的代码提示机会是没有任何价值的，为一个语言实现代码提示必须要结合当前光标位置的上下文来实现，根据上下文来分析当前光标所在单词属于类名、变量名、函数名等等，再提供相对应的提示。</p>
</blockquote>
<blockquote>
<p>为一个语言实现代码提示的主要方式有两种，第一种是使用抽象语法树，分析语法节点，分析当前位置属于哪一节点，第二种方式是直接使用正则匹配等方式来粗略判断当前位置的上下文，目前成熟的开发语言的代码提示均使用第一种方式，但是第一种方法同时也要处理语法错误时的分析，因此对个人而言难度相对比较大，本文采用第二种方式对新语言提供代码提示。</p>
</blockquote>
<p>下面是新语言的一个模板：</p>
<br>
<div class="image-package">
<div class="image-container" style="max-width: 700px; max-height: 550px;">
<div class="image-container-fill" style="padding-bottom: 78.46%;"></div>
<div class="image-view" data-width="1876" data-height="1472"><img data-original-src="//upload-images.jianshu.io/upload_images/5796542-02c3c283994400e0.png" data-original-width="1876" data-original-height="1472" data-original-format="image/png" data-original-filesize="245385" data-image-index="16" style="cursor: zoom-in;" class="image-loading"></div>
</div>
<div class="image-caption">14.png</div>
</div>
<p>其中主要包括两种结构：<strong><code>组件</code></strong>、<strong><code>全局变量</code></strong>，这两种结构的形式都是非常固定的，<strong><code>组件</code></strong> 的一般结构如下：</p>
<p><code>&lt;ComponentName propertyName = {key: value, key: value} propertyName2 = {}···/&gt;</code></p>
<p>或者</p>
<p><code>&lt;ComponentName propertyName = {key: value, key: value} propertyName2 = {}···&gt;&lt;/ComponentName&gt;</code></p>
<p>而<strong><code>全局变量</code></strong>的结构如果我们把<code>globalVar =</code>这部分结构忽略，只看<code>{}</code>里面的内容，很容易发现其结构与<code>json</code>无异，<strong>这提醒我全局变量的结构可以把它当成一个<code>json</code>对象进行解析，当然在此之前还需要做许多额外工作，保证解析的正确进行。</strong></p>
<p>简而言之，对这个新语言的代码提示主要集中在5个部分：组件名称、组件的属性名称、组件的属性名称里的key、组件的属性名称里的value（有一些value是枚举值，因此需要进行提示）、全局变量的key。</p>
<blockquote>
<p><strong><code>我们前面一直提到实现代码提示要结合当前光标的上下文进行分析，其实质就是根据光标位置的上下文分析当前光标的位置属于哪一类，是属于组件名还是属性名等等。</code></strong></p>
</blockquote>
<p>因此问题就转化为如何根据当前光标的上下文得到光标处属于哪一类。本文处理次问题的逻辑如下：</p>
<ul>
<li>1.首先从当前位置开始往前寻找，找到象征一个组件开始的<code>&lt;</code>，在此过程中如果遇见一个组件结尾标志的<code>/&gt;</code>或者<code>&lt;/NAME&gt;</code>结构，则停止寻找，说明当前光标不在组件里，可以判断当前光标是在全局变量处。</li>
<li>2.在1中对光标在组件内还是组件外进行了区分。如果光标在组件内，则需要判断属于组件内的组件名、属性名、属性key、属性value的哪一种。</li>
<li>3.使用api找到当前光标所在单词的起始位置，然后判断该其起始位置与<code>&lt;</code>位置之间是否有除空格外的其他字符，若没有，则当前位置是组件名，若有，则当前位置不是组件名，需要继续区分，通过是否在括号内判断当前位置是不是属性名。</li>
<li>4.<code>{}</code>内是<code>key</code>和<code>value</code>，使用<code>:</code>来进行区分。</li>
</ul>
<p>这样就对五种情况进行了区分，然后可以针对每种情况给出有正对性的提示。<br>
下面是最后的实现效果：</p>
<h3>代码自动补全</h3>
<blockquote>
<p>在<code>html</code>中当我们输入<code>&lt;label</code> 再输入一个<code>&gt;</code>时，这时候vscode会自动帮我们添加上<code>&lt;/label&gt;</code>，不需要我们敲回车就能完成，这种自动补全的方式能提高开发效率，下面就谈一下其实现。</p>
</blockquote>
<p>下面就以<code>&lt;label&gt;&lt;/label&gt;</code>的实现为例：<br>
当敲入<code>&gt;</code>时，首先要计算得到组件名<code>componnetName</code>，然后：<br>
</p><div class="image-package">
<div class="image-container" style="max-width: 661px; max-height: 146px;">
<div class="image-container-fill" style="padding-bottom: 22.09%;"></div>
<div class="image-view" data-width="661" data-height="146"><img data-original-src="//upload-images.jianshu.io/upload_images/5796542-f559ffb0d96e5713.png" data-original-width="661" data-original-height="146" data-original-format="image/png" data-original-filesize="34788" data-image-index="17" style="cursor: zoom-in;" class="image-loading"></div>
</div>
<div class="image-caption">16.png</div>
</div><p></p>
<p>实现效果：</p>
<div class="image-package">
<div class="image-container" style="max-width: 406px; max-height: 158px;">
<div class="image-container-fill" style="padding-bottom: 38.92%;"></div>
<div class="image-view" data-width="406" data-height="158"><img data-original-src="//upload-images.jianshu.io/upload_images/5796542-0d08cba25dce746f.gif" data-original-width="406" data-original-height="158" data-original-format="image/gif" data-original-filesize="243970" data-image-index="18" style="cursor: zoom-in;" class="image-loading"></div>
</div>
<div class="image-caption">17.gif</div>
</div>
<h3>加载本地的文件</h3>
<blockquote>
<p>有时候插件可能想要读取用户自己自定义的文件，来实现某个功能，这个时候就需要把用户的文件路径传递给插件。</p>
</blockquote>
<p>解决这个问题的办法可以是给<code>vscode</code>的<code>settings</code>增加有一个设置项，用户填写对应的值，<code>vscode</code>插件就可以读取这个值，进而读取相关的文件。<br>
给<code>settings</code>增加设置项可以通过<code>package.json</code>文件的<code>contributes</code>进行配置：<br>
</p><div class="image-package">
<div class="image-container" style="max-width: 637px; max-height: 278px;">
<div class="image-container-fill" style="padding-bottom: 43.64%;"></div>
<div class="image-view" data-width="637" data-height="278"><img data-original-src="//upload-images.jianshu.io/upload_images/5796542-958e143ad28a1300.png" data-original-width="637" data-original-height="278" data-original-format="image/png" data-original-filesize="30899" data-image-index="19" style="cursor: zoom-in;" class="image-loading"></div>
</div>
<div class="image-caption">18.png</div>
</div><p></p>
<p>然后我们就可以在<code>settings</code>中设置<code>customPath</code>这个设置项的值：<br>
</p><div class="image-package">
<div class="image-container" style="max-width: 700px; max-height: 415px;">
<div class="image-container-fill" style="padding-bottom: 55.93%;"></div>
<div class="image-view" data-width="742" data-height="415"><img data-original-src="//upload-images.jianshu.io/upload_images/5796542-8400547ae284b664.png" data-original-width="742" data-original-height="415" data-original-format="image/png" data-original-filesize="54633" data-image-index="20" style="cursor: zoom-in;" class="image-loading"></div>
</div>
<div class="image-caption">19.png</div>
</div><p></p>
<p>最后在插件工程中读取<code>customPath</code>的值：<br>
<code>const path = vscode.workspace.getConfiguration('lizard').get('customPath');</code></p>
<h2>4.打包、发布、升级</h2>
<h3><strong>发布插件到插件市场</strong></h3>
<ul>
<li>1.安装<code>vsce(Visual Studio Code Extension)</code><br>
<code>npm install -g vsce</code>
</li>
<li>2.在网站<code>https://dev.azure.com/vscode</code>获取一个<code>access token</code>，这个token用来创建一个<code>publisher</code>
</li>
<li>3.创建<code>publisher</code><br>
<code>vscr create-publisher (publisher name)</code>
</li>
<li>4.登入一个<code>publisher</code><br>
<code>vscde login (publisher name)</code>
</li>
<li>5.打包<br>
<code>vsce package</code>
</li>
<li>6.发布<br>
<code>vsce publish</code>
</li>
</ul>
<h3>升级</h3>
<ul>
<li>1.首先在<code>package.json</code>文件中修改插件的版本号。</li>
<li>2.使用命令<code>vsce publish</code>升级</li>
</ul>
<h2>参考</h2>
<p><a href="https://links.jianshu.com/go?to=https%3A%2F%2Fcode.visualstudio.com%2Fapi" target="_blank">vscode插件开发官方文档</a></p>
<p><a href="https://links.jianshu.com/go?to=https%3A%2F%2Fliiked.github.io%2FVS-Code-Extension-Doc-ZH%2F%23%2F" target="_blank">vscode插件开发中文文档</a></p>
<p><a href="https://links.jianshu.com/go?to=https%3A%2F%2Fmacromates.com%2Fmanual%2Fen%2Flanguage_grammars" target="_blank">TextMate官方介绍</a><br>
对理解TextMate极有帮助的文档<br>
<a href="https://links.jianshu.com/go?to=https%3A%2F%2Fwww.apeth.com%2Fnonblog%2Fstories%2Ftextmatebundle.html" target="_blank">https://www.apeth.com/nonblog/stories/textmatebundle.html</a></p>
<p>知乎讲vscode原理的<br>
<a href="https://links.jianshu.com/go?to=https%3A%2F%2Fzhuanlan.zhihu.com%2Fp%2F99198980" target="_blank">https://zhuanlan.zhihu.com/p/99198980</a><br>
vscode入门的博文教程<br>
<a href="https://links.jianshu.com/go?to=https%3A%2F%2Fwww.cnblogs.com%2Fliuxianan%2Fp%2Fvscode-plugin-overview.html" target="_blank">https://www.cnblogs.com/liuxianan/p/vscode-plugin-overview.html</a></p>
<hr>
<p>原文地址<a href="https://links.jianshu.com/go?to=%255Bhttps%3A%2F%2Fwww.jianshu.com%2Fp%2Fe642856f6044%255D%28https%3A%2F%2Fwww.jianshu.com%2Fp%2Fe642856f6044%29" target="_blank"></a><a href="https://www.jianshu.com/p/e642856f6044" target="_blank">https://www.jianshu.com/p/e642856f6044</a><br>
</p>
</article>



##### npm use

1. 在nodejs工程中新增依赖包package.json:


typescript:
npm install --save-dev webpack webpack-dev-server typescript ts-loader