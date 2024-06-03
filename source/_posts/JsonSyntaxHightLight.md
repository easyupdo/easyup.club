---
title: JsonSyntaxHightLight
date: 2020-08-27 11:30:18
tags: [syntax,json]
published: false
---
#### Html:
```c
<head>


    <style>
        pre {outline: 1px solid #ccc; padding: 5px; margin: 5px; }
        .string { color: green; }
        .number { color: darkorange; }
        .boolean { color: blue; }
        .null { color: magenta; }
        .key { color: red; }
       </style>

</head>
```
<!--more-->
```

<body>
    <font color="red">ddd</font>
    <pre>{
        <span class="key">"a":</span> <span class="number">1</span>,
        <span class="key">"b":</span> <span class="string">"foo"</span>,
        <span class="key">"c":</span> [
            <span class="boolean">false</span>,
            <span class="string">"false"</span>,
            <span class="null">null</span>,
            <span class="string">"null"</span>,
            {
                <span class="key">"d":</span> {
                    <span class="key">"e":</span> <span class="number">130000</span>,
                    <span class="key">"f":</span> <span class="string">"1.3e5"</span>
                }
            }
        ]
    }</pre>
    <script type="text/javascript">
  function output(inp) {
    document.body.appendChild(document.createElement('pre')).innerHTML = inp;
}

function syntaxHighlight(json) {
    json = json.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
    return json.replace(/("(\\u[a-zA-Z0-9]{4}|\\[^u]|[^\\"])*"(\s*:)?|\b(true|false|null)\b|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?)/g, function (match) {
        var cls = 'number';
        if (/^"/.test(match)) {
            if (/:$/.test(match)) {
                cls = 'key';
            } else {
                cls = 'string';
            }
        } else if (/true|false/.test(match)) {
            cls = 'boolean';
        } else if (/null/.test(match)) {
            cls = 'null';
        }
        return '<span class="' + cls + '">' + match + '</span>';
    });
}

var obj = {a:1, 'b':'foo', c:[false,'false',null, 'null', {d:{e:1.3e5,f:'1.3e5'}}]};
var str = JSON.stringify(obj, undefined, 4);

console.log(obj);
console.log(str);

//output(str);

console.log(syntaxHighlight(str))

output(syntaxHighlight(str));
    </script>

</body>
```
