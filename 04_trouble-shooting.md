---
layout: default
title: Trouble Shooting
permalink: /trouble-shooting
page_index: 4
---


## エラーかな？と思ったら

### remainingResources(MEMORY)

```
[ERROR] remainingResources(MEMORY): xxx
```

メモリが足りていない

```
ecsub submit \
(省略)
--memory 30
```

### There is no Spot capacity

```
[ERROR] Failure request-spot-instances. [Status] open [Code] capacity-not-available [Message] There is no Spot capacity available that matches your request.
```

スポットインスタンスを起動するための空きがAWSにありません。  
時間を空けて再度挑戦するか、別のインスタンスタイプを指定してください。  
特定のインスタンスタイプにこだわりがなければ、`--aws-ec2-instance-type-list` オプションの使用も検討してください。

### instance-type xxx is not supported in ecsub

```
[ERROR] instance-type m5d.2xlarge is not supported in ecsub.
```

指定されたインスタンスタイプは現在、ecsubで対応していません。
別のインスタンスタイプをお試しください。

対応しているインスタンスタイプは "{ecsub}/scripts.ecsub/aws_config.py" の INSTANCE_TYPE で定義されています。

### Limit

```
[ERROR] instance-type m5d.2xlarge is not supported in ecsub.
```

指定されたインスタンスタイプは現在、ecsubで対応していません。
別のインスタンスタイプをお試しください。

対応しているインスタンスタイプは "{ecsub}/scripts.ecsub/aws_config.py" の INSTANCE_TYPE で定義されています。

