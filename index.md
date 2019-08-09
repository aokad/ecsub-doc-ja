---
layout: default
permalink: /
---

# ecsub 利用の手引き

## ecsub とは？

[dsub](https://github.com/DataBiosphere/dsub) から着想を得た Amazon Elastic Container Servise (Amazon ECS) を使用したバッチジョブ実行エンジンです。  
Amazon Elastic Compute Cloud (Amazon EC2) にインスタンスを作成して docker コンテナを構築しバッチジョブを実行します。  
入出力ソースとして Amazon Simple Storage Service (Amazon S3) を使用することができます。  

--> [実行の仕組み](./tutorial#overview)

## セットアップ

--> [【AWS管理者向け】AWS セットアップ](./setup#getting-started-on-aws)  
--> [【ユーザ向け】インストールとユーザ設定](./setup#install-and-setup)  

## ジョブを実行する

コマンドラインからスクリプトファイル ([サンプル](https://raw.githubusercontent.com/aokad/wordcount/master/run_wordcount.sh)) とタスクファイル ([サンプル](https://raw.githubusercontent.com/aokad/wordcount/master/tasks_wordcount.tsv)) と呼ばれる定義ファイルを指定して実行します。

デモはここから

<a href="https://asciinema.org/a/cpxOiNghJchavKXBMSZjrfE2D"><img src="https://asciinema.org/a/cpxOiNghJchavKXBMSZjrfE2D.png" width="600"/></a>

--> [ジョブを実行する](./tutorial#%E3%83%90%E3%83%83%E3%83%81%E3%82%B8%E3%83%A7%E3%83%96%E3%82%92%E5%AE%9F%E8%A1%8C%E3%81%99%E3%82%8B)

## タスクファイル

ジョブを実行するにはタスクファイルと呼ばれるタブ区切り (tsv) の定義ファイルが必要です。  

--> [タスクファイルの書き方](./tutorial#%E3%82%BF%E3%82%B9%E3%82%AF%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E8%A7%A3%E8%AA%AC)

## トラブルシューティング

--> [エラーかな？と思ったら](./trouble-shooting)

## ライセンス

[GPLv.3](https://github.com/aokad/ecsub/blob/master/LICENSE)

## コンタクト

ご質問やフィードバックなど，お気軽にご連絡ください。
genomon.devel@gmail.com

対面形式，skype でのアポイントはこちらで受け付けています。  
Genomon Office Hour: https://genomon-office.youcanbook.me/

