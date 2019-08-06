---
layout: default
title: How to Use
permalink: /how-to-use
page_index: 2
sublinks:
  - title: Install and Setup
    link: install
  - title: Getting started on AWS
    link: getting-started-on-aws
---

# ecsub の使用方法

# tasks ファイルの書き方


タブ区切り ("\t")
先頭はヘッダです。
コンテナにコピーするもの
--input [NAME]  s3 ファイルのパス, 指定ファイルのみコピー
--input-recursive [NAME] s3 ディレクトリのパス, 再帰的にコピー
コンテナから外に出すもの
--output [NAME] s3 ファイルのパス, 指定ファイルのみコピー
--output-recursive [NAME] s3 ディレクトリのパス, 再帰的にコピー
環境変数のセット
--env [NAME] 環境変数
--secret-env [NAME] 暗号化した環境変数 (後述)
コメントは `#` で始めて、ヘッダの前に記載してください。

例 (./examples/tasks-wordcount.tsv)

--env NAME	--input INPUT_FILE	--input-recursive SCRIPT	--output OUTPUT_FILE
Hamlet	s3://ecsub-ohaio/wordcount/input/hamlet.txt	s3://ecsub-ohaio/wordcount/python	s3://ecsub-ohaio/output/hamlet-count.txt
Kinglear	s3://ecsub-ohaio/wordcount/input/kinglear.txt	s3://ecsub-ohaio/wordcount/python	s3://ecsub-ohaio/output/kinglear-count.txt


1) ecsub_tools コマンドを使用して、秘密にしたい文字列を暗号化します。
$ ecsub_tools encrypt password      # <--- 秘密にしたい文字列
AQICA(省略)ZMTlAsFP4w==             # <--- 暗号化された文字列

2) 作成した文字列をフィールド名 --secret-env をつけて tasks.tsv に記入します。

--secret-env PW	--env NAME	--input INPUT_FILE	--input-recursive SCRIPT	--output OUTPUT_FILE
AQICA(省略)ZMTlAsFP4w==	Hamlet	s3://bucket/input.txt	s3://bucket/input-dir	s3://bucket/output.txt


## サンプルを実行する

ecsub をダウンロードしたディレクトリにサンプルデータが置いてありますので、以下のコマンドで利用することができます。

```
ecsub submit \
--script ~/gitlab/ecsub-testdata/examples-iret/run-wordcount.sh \
--tasks ~/gitlab/ecsub-testdata/examples-iret/tasks-wordcount-1.tsv \
--aws-s3-bucket  s3://aokad-ana-singapore/ecsub-test \
--image python:2.7.14 \
--aws-ec2-instance-type t2.micro \
--disk-size 1
```

# 
## 実行中のログを確認する

```
2018-12-18 16:49:44.473816 [tasks-wordcount-1-qyD56:000] For detail, see log-file: https://ap-northeast-1.console.aws.amazon.com/cloudwatch/home?region=ap-northeast-1#logEventViewer:group=ecsub-tasks-wordcount-1-qyD56;stream=ecsub/tasks-wordcount-1-qyD56_task/330419b5-c48a-4483-bb1a-1c14d6625a04
```

## 途中で止めたい

ecsub 実行中のコンソールで Ctrl-C を入力してください。  
その後以下のような終了処理が走りますので、そのままお待ちください。

```
KeyboardInterrupt
2018-12-18 16:19:49.683496 [tasks-wordcount-1-nk2Vs] + aws ec2 terminate-instances --instance-ids i-067e2dfc2a7d3809b i-01bfa1f3a4d17ac63
2018-12-18 16:19:54.675539 [tasks-wordcount-1-nk2Vs] + aws ec2 wait instance-terminated --instance-ids i-067e2dfc2a7d3809b i-01bfa1f3a4d17ac63
2018-12-18 16:20:45.795659 [tasks-wordcount-1-nk2Vs] + aws ec2 cancel-spot-instance-requests --spot-instance-request-ids sir-e5piabrh sir-2mvrbq6j sir-bnggbv4h
2018-12-18 16:20:51.735453 [tasks-wordcount-1-nk2Vs] + aws ecs delete-cluster --cluster arn:aws:ecs:ap-northeast-1:047717877309:cluster/tasks-wordcount-1-nk2Vs
2018-12-18 16:20:57.028853 [tasks-wordcount-1-nk2Vs] + aws ecs deregister-task-definition --task-definition arn:aws:ecs:ap-northeast-1:047717877309:task-definition/tasks-wordcount-1-nk2Vs:1
2018-12-18 16:21:02.446327 [tasks-wordcount-1-nk2Vs] + aws ec2 delete-key-pair --key-name tasks-wordcount-1-nk2Vs
```

## スポットインスタンスを使用する

`--spot` オプションをつけて実行してください。  
`--aws-ec2-instance-type` オプションの代わりに `--aws-ec2-instance-type-list`  オプションを使用することをお勧めします。  

`--aws-ec2-instance-type-list` オプションは指定された順にインスタンスタイプを使用し、ジョブが成功するまでリトライします。  
インスタンスのリストをカンマ区切りで優先度の高い順に記述してください。  

```
ecsub submit \
(省略)
--aws-ec2-instance-type-list m5.2xlarge,t3.2xlarge,m4.2xlarge,t2.2xlarge \
--spot
```

## ジョブのコストを知りたい

タスクごとに以下ファイルに出力されています。

`/tmp/ecsub/{job}/log/summary.xxx.log`

## ジョブのレポートを表示する

```
$ ecsub report --help
usage: ecsub report [-h] [--wdir path/to/dir] [--past] [-f]
                    [-b [YYYYMMDDhhmm]] [-e [YYYYMMDDhhmm]] [--max 20]
                    [--sortby sort_key]

optional arguments:
  -h, --help            show this help message and exit
  --wdir path/to/dir    {PATH} when 'ecsub submit --wdir {PATH}'
  --past                display summary in previous version.
  -f, --failed          display failed or abnoraml exit status job only.
  -b [YYYYMMDDhhmm], --begin [YYYYMMDDhhmm]
                        The earliest createdAt time for jobs to be summarized,
                        in the format [YYYYMMDDhhmm]
  -e [YYYYMMDDhhmm], --end [YYYYMMDDhhmm]
                        The latest createdAt time for jobs to be summarized,
                        in the format [YYYYMMDDhhmm]
  --max 20              Maximum display count
  --sortby sort_key     Sort summary key
```

For example,

```Bash
ecsub report --wdir /tmp/ecsub -b 201901250000 --max 5
```

<pre>
| exitCode| taskname|  no| Spot|          job_startAt|            job_endAt| instance_type| cpu| memory| disk_size|    instance_createAt|      instance_stopAt|                                       log_local|
|        0|  sample1| 000|    F| 2019/01/25 18:07:40 | 2019/01/25 18:13:46 |      t2.micro|   1|    900|         1| 2019/01/25 18:07:40 | 2019/01/25 18:13:46 | /tmp/ecsub/sample1/log/describe-tasks.000.0.log|
|      255|  sample2| 000|    F| 2019/01/25 16:42:00 | 2019/01/25 16:46:33 |      t2.micro|   1|    800|         1| 2019/01/25 16:42:00 | 2019/01/25 16:46:33 | /tmp/ecsub/sample2/log/describe-tasks.000.0.log|
|       NA|  sample3| 000|    F| 2019/01/25 17:14:58 |                     |              |    |       |         1| 2019/01/25 17:14:58 |                     |                                                |
|        0|  sample4| 000|    F| 2019/01/25 22:06:30 | 2019/01/25 22:20:24 |    i2.8xlarge|  32| 245900|         1| 2019/01/25 22:06:30 | 2019/01/25 22:20:24 | /tmp/ecsub/sample4/log/describe-tasks.000.0.log|
|        1|  sample5| 000|    F| 2019/01/26 07:20:48 | 2019/01/26 07:20:48 |    x1e.xlarge|   0|      0|         1| 2019/01/26 07:20:48 | 2019/01/26 07:20:48 |                                                |
</pre>

## ジョブの実行ログを表示する

ecsub creates logs on AWS CloudWatch.
If you need, you can download log-files to local directory, and remove log-streams from AWS.

```
$ ecsub logs --help
usage: ecsub logs [-h] [--wdir path/to/dir] [--prefix task-name] [--rm] [--dw]

optional arguments:
  -h, --help          show this help message and exit
  --wdir path/to/dir  {PATH} when 'ecsub submit --wdir {PATH}'
  --prefix task-name  prefix of LogGroupName in AWS CloudWatch
  --rm                flag for remove from AWS
  --dw                flag for download from AWS
```

For example,

```Bash
ecsub logs --wdir /tmp/ecsub --prefix tasks-wordcount --dw
```

## ジョブを削除する

**Attention!** If task ends normally (exit with 0, 1, 255...), it does not need to be executed.  
`delete` subcommand is used for jobs that have a creation date ("instance_createAt") but no end date ("instance_stopAt") as shown below.

<pre>
| exitCode| taskname|  no| ... |    instance_createAt| instance_stopAt| log_local|
|       NA|  sample3| 000| ... | 2019/01/25 17:14:58 |                |          |
</pre>

```
$ ecsub delete --help
usage: ecsub delete [-h] [--wdir path/to/dir] task-name

positional arguments:
  task-name           task name

optional arguments:
  -h, --help          show this help message and exit
  --wdir path/to/dir  {PATH} when 'ecsub submit --wdir {PATH}'
```

For example,

```Bash
ecsub delete --wdir /tmp/ecsub sample2-bRnfG
```

## docker in docker


## 
