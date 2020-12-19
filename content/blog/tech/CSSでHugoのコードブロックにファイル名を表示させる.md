---
title: "CSSだけでHugoのコードブロックにファイル名を表示させる"
date: 2020-12-02T06:15:25+09:00
draft: false
slug: "codeblock-name"
category:
- "試考作誤"
tags:
- "Hugo"
- "CSS"
---

前提
----

* Hugo Static Site Generator v0.74.3

Hugoでの**コードブロック**`<pre><code>〜</code></pre>`の取り扱い
----

Markdown記法では`｀｀｀`(上)と`｀｀｀`(下)で挟み込んだところの記述がコードブロックとして認識される[^1]。

[^1]:エスケープする方法がわからなかったので`｀｀｀`は全角で記述している。ほんとうは半角。

Hugoでは`｀｀｀html`(上)と記述すると「これはhtmlの記述なのだ」とHugoが認識して自動的にハイライトしてくれる。

```markdown

｀｀｀

<p>ハイライトされない。</p>

｀｀｀

｀｀｀html

<p>ハイライトされる。</p>

｀｀｀

```

こういう記述は、このように出力される。

```

<p>ハイライトされない。</p>

```

```html

<p>ハイライトされる。</p>

```

実現したいこととその手段
---

[Qiita](https://qiita.com/)では`｀｀｀html:sample.html`と表記すると、コードブロックに<samp>sample.html</samp>と表示される。

```html:sample.html

<p>ハイライトされて、しかも、タイトルも表示される。</p>

```

Hugoではデフォルトではそのような機能はついていないので、何かしらの手段を用いて実装しなければならない。

みな、同じようなことを考えるようで、おおまかに分けて、２つの方法が紹介されている。

### Javascriptで実装

* [GitHub Pagesでコードブロックにファイル名を表示する](https://hachy.github.io/2018/11/14/add-file-name-to-code-block-in-jekyll-on-github-pages.html)
* [コードブロックにファイル名を指定する (若月駿)](https://shwaka.github.io/2019/07/12/named-codeblock.html)

Javascriptはあまり使いたくなかったので、テーマ側で素のhtmlとして出力できないかと考えた。

### テーマ側で実装

* [【Hugo】コードブロック内にファイル名を表示する | みどりみちのブログ](https://midorimici.com/posts/hugo-code-name/)
* [コードブロックにファイル名を指定する (plugin) (若月駿)](https://shwaka.github.io/2019/07/25/named-codeblock-plugin.html) Jekyllの場合

みどりみちさんの手法は、とても魅力的だったが、どうもうまく表示されない。

たぶん、単純な間違えがあるんだろうとは思うけど、それがわかるほどの知識が今、ない。

そのうち、リトライしたい。

CSSだけで実装
----

出力されているソースコードを見ると、こうなっている。

```html

<div class="highlight">
    <pre style="color:#f8f8f2;background-color:#272822;-moz-tab-size:4;-o-tab-size:4;tab-size:4">
        <code class="language-html:sample.html" data-lang="html:sample.html">
            &lt;<span style="color:#f92672">p</span>&gt;ハイライトされて、しかも、タイトルも表示される。&lt;/<span style="color:#f92672">p</span>&gt;
        </code>
    </pre>
</div>

```

CSSのcontentプロパティで`data-lang`を表示させればいいのではないか。

読み込んでいるCSS or Style要素に以下のコードを追加してみた。

```css

pre > code[data-lang]:before{
content: attr(data-lang)"\A";
white-space: pre;
}

```

これで`pre`直下の`code`で、`data-lang`属性をもっている場合のみ、<samp>html:sample.html</samp>と表示される。

まとめ
----

この方法の欠点としては以下のものが考えられる。

* Hugoの仕様に依存している。
* <samp>html:sample.html</samp>は不格好？
* <samp>html:sample.html</samp>はコピーできない。

Hugoの仕様については変更があれば対応できる。

種類とファイル名がわかるようにしたいと思っていたので、<samp>html:sample.html</samp>という表示は不格好ではあるかも知れないが、許容範囲だ。

ファイル名をコピーするという需要はどれほどあるのだろうか。ファイル名を確かめることはあっても、それをコピー＆ペーストした体験はないので、問題ない。

メリットとしては、とてもシンプルだ、ということに尽きる。

たぶん、Hugoに限らず、移植できる可能性がある。
