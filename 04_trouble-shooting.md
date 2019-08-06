---
layout: default
title: Trouble Shooting
permalink: /trouble-shooting
page_index: 4
---

## エラーかな？と思ったら

### There is no Spot capacity

```
[ERROR] Failure request-spot-instances. [Status] open [Code] capacity-not-available [Message] There is no Spot capacity available that matches your request.
```

スポットインスタンスを起動するための空きがAWSにありません。  
時間を空けて再度挑戦するか、別のインスタンスタイプを指定してください。  
特定のインスタンスタイプにこだわりがなければ、`--aws-ec2-instance-type-list` オプションの使用も検討してください。

## ジョブが失敗する

### ログを確認する

スクリプトの不具合やタスクファイルの間違い、コンテナイメージのライブラリの不足、等々ジョブが失敗する原因は様々ですが、ログを見てみるのが一番確実です。  
以下の手順で確認できます。

### ジョブメトリクスを確認する

ジョブが要求しているスペックに対し、起動したインスタンスのリソースが不足していることがあります。 (特にディスク不足)   
以下の手順で確認できます。



## 制限事項

 - GPU コンテナに未対応
 - task ロールにはユーザのパーミッションを使用したい

