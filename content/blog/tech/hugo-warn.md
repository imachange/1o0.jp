---
title: "`WARN .File.Path on zero object.`の修正"
date: 2020-12-06T23:05:51+09:00
draft: true
slug: ""
category:
- ""
tag:
- "hugo"
- "WARN"
---

前提
----

* Hugo Static Site Generator v0.74.3

背景
----

思うところがあって、テーマファイルにこういうコードを書いた。

```html

{{ with .CurrentSection }}
{{ if ne .File.Path .FirstSection.File.Path }}
<p>examle</p>
{{ end }}
{{ end }}

```

やりたいことは次の通り。

1. 今いるセクションと、今いるセクションの第一階層とを比べる。
2. 第一階層ではないときに処理をさせたい。

このコードを含んだテーマでビルドしたところ、以下のような注意**WARN**が出るようになった。

```bash

$ hugo server -w --disableFastRender -D -F
Building sites … WARN 2020/12/06 22:58:20 .File.Path on zero object. Wrap it in if or with: {{ with .File }}{{ .Path }}{{ end }}

```

解決
----

別にエラーではないので、記事は生成される。

とはいえ、注意**WARN**がずっと出ているのも気持ち悪い。

エラーコードを見ていて、もしかして、.Fileは要らないのかな、と思い、次の通りに修正したところ、注意**WARN**されなくなった。

```html

{{ with .CurrentSection }}
{{ if ne .Path .FirstSection.Path }}
<p>examle</p>
{{ end }}
{{ end }}

```

とりあえず、これで問題なく動いているが、今後なにか変更があるかも知れない。

いちおう、この件については、この二件のスレッドが詳しそうだ。

今後、見返すこともあるかもしれない。

* [Error: What to replace .File.Dir with in hugo-book - support - HUGO](https://discourse.gohugo.io/t/error-what-to-replace-file-dir-with-in-hugo-book/18118)
* [\[SOLVED\] .File.UniqueID on zero object in Where clause - support - HUGO](https://discourse.gohugo.io/t/solved-file-uniqueid-on-zero-object-in-where-clause/19554)