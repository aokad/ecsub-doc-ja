---
layout: default
title: Trouble shooting
permalink: ./trouble-shooting
page_index: 5
sublinks:
  - title: ジョブの投入に失敗する
    link: ジョブの投入に失敗する
  - title: タスクが失敗する
    link: タスクが失敗する
---

# エラーかな？と思ったら

## ジョブの投入に失敗する

### FileNotFoundError

```
FileNotFoundError: [Errno 2] No such file or directory: '/home/user/tasks-wordcount.tsv'
```

指定したスクリプトかタスクファイルのパスが間違っています。ご確認ください。

### input 'xxx' is not access

```
[ERROR] input 'aokad-ana-tokyo/wordcount/titles/hamlet.txt' is not access.
```

指定されたファイルが s3 に存在しないか、アクセス権限がありません。  
チェック範囲はタスクファイルのうち `--input` もしくは `--input-recursive` で指定された値と `aws-s3-bucket` で指定されたバケットです。

### There is no Spot capacity

```
[ERROR] Failure request-spot-instances. [Status] open [Code] capacity-not-available [Message] There is no Spot capacity available that matches your request.
```

スポットインスタンスを起動するための空きがAWSにありません。  
時間を空けて再度挑戦するか、別のインスタンスタイプを指定してください。  
特定のインスタンスタイプにこだわりがなければ、`--aws-ec2-instance-type-list` オプションの使用も検討してください。

### multipule regions

```
[ERROR] your task uses multipule regions 'ap-northeast-1,us-east-1'.
```

ロケーション（リージョン）をまたいでデータのやり取りを行うと別途料金が発生しますので、チェック機能が存在します。  
了解したうえで実行する場合は `ignore-location ` オプションをつけて実行してください。

チェック範囲はタスクファイル、`aws-s3-bucket` で指定されたバケット、`aws configure` で指定したデフォルトリージョンです。

## タスクが失敗する

### ログを確認する

スクリプトの不具合やタスクファイルの書き間違い、コンテナイメージのライブラリ不足、失敗する原因は様々ですが、ログを見てみるのが一番確実です。  
以下の手順で確認できます。

--> [タスク実行ログ](./logs#タスク実行ログ)

### メトリクスを確認する

タスクが要求しているスペックに対し、起動したインスタンスのリソース不足が原因のことがあります。 (特にディスク不足)   
以下の手順で確認できます。

--> [メトリクス](./logs#メトリクス)


