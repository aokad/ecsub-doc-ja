---
layout: default
permalink: /
---

# ecsub 利用の手引き

## ecsub とは？

[dsub](https://github.com/DataBiosphere/dsub) から着想を得た Amazon Elastic Container Servise (Amazon ECS) を使用したバッチジョブ実行エンジンです。  
Amazon Elastic Compute Cloud (Amazon EC2) にインスタンスを作成して docker コンテナを構築しバッチジョブを実行します。  
入出力ソースとして Amazon Simple Storage Service (Amazon S3) を使用することができます。  

--> [実行の仕組み](./how-it-works)

## セットアップ

--> [【AWS管理者向け】AWS セットアップ](./setup#dependency)  
--> [【ユーザ向け】インストールとユーザ設定](./setup#getting-started-on-aws)  

## ジョブを実行する

コマンドラインからスクリプトファイル ([サンプル](./assets/examples/run-wordcount.sh)) とタスク定義ファイル ([サンプル](./assets/examples/tasks-wordcount.tsv)) を指定して実行します。

デモはここから

<a href="https://asciinema.org/a/jPvYTBjwnPOkLShtPega5qPvA"><img src="https://asciinema.org/a/jPvYTBjwnPOkLShtPega5qPvA.png" width="600"/></a>

--> [ジョブを実行する](./how-to-use)

## タスクファイル

ジョブを実行するにはタスクファイルと呼ばれるタブ区切り (tsv) の定義ファイルが必要です。  

--> [タスクファイルの書き方](./tasks-format)

## ecsub の機能

ecsub には以下の機能があります。詳細はリンク先をご確認ください。

 - ジョブを実行する
 - メトリクスを取得する
 - ログを確認する
 - ジョブレポートを表示する
 - ジョブを削除する

## トラブルシューティング

--> [エラーかな？と思ったら](./trouble-shooting)

## ライセンス

[GPLv.3](https://github.com/aokad/ecsub/blob/master/LICENSE)

## コンタクト

ご質問やフィードバックなど，お気軽にご連絡ください。
genomon.devel@gmail.com

対面形式，skype でのアポイントはこちらで受け付けています。  
Genomon Office Hour: https://genomon-office.youcanbook.me/

