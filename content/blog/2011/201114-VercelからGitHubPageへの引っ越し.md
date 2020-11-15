---
title: "VercelからGitHubPageへの引っ越し"
date: 2020-11-14T03:38:06+09:00
draft: false
slug: "moving-vercel-github"
---

リニューアル前には[Vercel](https://vercel.com/)をつかってホストしていたが、なぜかつかえなくなった。

理由がわからないので、Github Pagesに移行することにした。

<!-- more -->

これまでの構成{#so-far}
----

ブログをつくりなおす旨、前回のブログでは宣言した。

リニューアル前のブログでは次の手順で記事を更新していた。

1. ローカルでMarkdownファイルを作成する。
2. Git add + commit + push
3. (ここから自動)Github上のリモートリポジトリが更新される。
4. リモートリポジトリの更新を検知して、Vercelがブログをビルドする。

しかし、なぜか、以下のエラーが頻発して更新できなくなった。

```
Error: module "[NAME]" not found; either add it as a Hugo Module or store it in "[THEME_DIR]".: module does not exist
```

原因探求に時間を食いたくなかったので、ホスト先を移行することにした。

移転先の候補{#candidate}
----

Githubとの連携を軸に考えると、Vercelからの移転先は以下の2つに絞られる。

1. [Netlify](https://www.netlify.com/)
2. [GitHub Pages](https://pages.github.com/)

NetlifyはVercelの前につかっていたということもあるし、今回はビルドで転んでいるので、同様のつまずきがあると面倒だと思った。

そんなわけで、今までつかったことのないGitHub Pageをつかうことにした。

移行の手順{#move}
----

### 【config.toml】publishDirとcanonifyurlを追加。{#add_publishDir_canonifyurl}

config.tomlに二行、設定項目を追加した。

```
publishDir = "docs"
canonifyurls = true
```

`publishDir`は、`$ hugo`コマンドで生成したファイル群を出力するフォルダを指定する。`docs`にするのがGitHub Pageの設定の問題。

`canonifyurls = true`にすると、たとえ、どこで出力されようとも、ブログ内のURIは`baseurl`で指定したURIを基準にする。

書き換えを行ったら`$ hugo`コマンドを実行。

`$ git add` + `$ git commit` + `$ git push`する。

### 【DNS設定】Aコードの書き換え※独自ドメイン利用の場合。

[Managing a custom domain for your GitHub Pages site - GitHub Docs](https://docs.github.com/en/free-pro-team@latest/github/working-with-github-pages/managing-a-custom-domain-for-your-github-pages-site)を参照。

利用しているDNSサービスのダッシュボートでAレコードを以下の数値に書き換える。

- 185.199.108.153
- 185.199.109.153
- 185.199.110.153
- 185.199.111.153

### 【GitHub】Github Pagesの設定

GitHubでブログリポジトリの「settings」タブを開く。

スクロールしていって、GitHub Pagesの項目を見つける。

Custom domainのフォームに準備した独自ドメインを入力して、Saveボタンをクリック。

しばらくしてから、Custom domainに設定したURI"http://example.com"にアクセスしてみる。

アクセスできたら、Enforce HTTPSのチェックを入れる。

しばらく待つとSSL化されて、"https://example.com"でアクセスできるようになる。

それまでは気長に待つ。

* 補足：[DNSの切り替え待ちで確認するべきこと]({{< ref "201115-DNSの切り替え待ちで確認するべきこと.md" >}})

### 今後のこと

GitHub Pagesに引っ越すことができた。

しばらく、ここでいろいろと遊んでみることにする。

もし、Vercelの不具合の原因がわかったら、そちらへの再移行も考えていきたい。

ダメならダメで帰ってきたらいい、くらいに、つかいこんでいきたい。
