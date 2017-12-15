# ゲームを実況しよう！ [![CircleCI](https://circleci.com/gh/naichilab/lets-play-mobile-games/tree/master.svg?style=svg)](https://circleci.com/gh/naichilab/lets-play-mobile-games/tree/master)

## サイト概要  
youtuberをはじめとする実況者さんに対して実況可能アプリを提示するサービスを主な目的としたサイトです。

## お手伝いさん募集！  
* サイトの問題点/改善点を指摘してくださる方
* 問題点/改善点を修正/改善してくださる方

以上のような方を随時募集しています！  
issueやプルリク歓迎なので、お手伝いよろしくお願いします！

## 開発環境構築のすゝめ  
RubyやRails導入は個人個人違うと思うので省略します。導入方法が全く分からない方は環境構築を解説している記事（[参考記事](https://qiita.com/SRAUFactory/items/d7b07b45b10408a42046)）を探してみて下さい。  

環境構築が済んでいる方は以下の工程をお願いします。

1. ターミナルで`git clone https://github.com/naichilab/lets-play-mobile-games.git`を実行してプロジェクトをコピーしてきます。

2. プロジェクトに移動して`bundle install --path vendor/bundle`を実行します。

3. いくつかファイルを生成します。
  1. `.env`ファイルを生成。（中身は空でおkです）

  2. `.env.development`ファイルを生成。中身は以下をコピペして下さい。  
    ```
    CONOHA_CONTAINER_NAME=letsplaylist_development
    VIRTUAL_ENV=development
    ```

  3. `.env.test`ファイルを生成。中身は以下をコピペして下さい。  
    ```
    CONOHA_CONTAINER_NAME=letsplaylist_test
    VIRTUAL_ENV=test
    ```

4. `bundle exec rake db:create`と`bundle exec rake db:migrate`を順に実行して下さい。

5. `bundle exec rails s`でサーバーが立ち上がるかチェックしてみて下さい。

6. サーバーが立ち上がりサイトへのアクセスに成功すれば環境構築成功です！開発を進めて下さい！
