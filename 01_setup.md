---
layout: default
title: Getting started
permalink: /setup
page_index: 1
sublinks:
  - title: Install and Setup
    link: install
  - title: Getting started on AWS
    link: getting-started-on-aws
---

# Getting started

## Install and Setup

### 1. Dependency

`ecsub` は github のリポジトリからダウンロードしてインストールすることができます。  

Python で作成されており、実行するには python2.7 もしくは python3.5 以上が必要です。  

また、ecsub の実行には AWS が提供しているコマンドラインツールおよび aws アクセスのための python パッケージが必要です。

 - [awscli](https://docs.aws.amazon.com/streams/latest/dev/kinesis-tutorial-cli-installation.html)
 - [boto3](https://github.com/boto/boto3)

### 2. インストール

まず、awscli と boto3 をインストールします。  
もしインストール済みであれば、念のためアップグレードしておきます。  

```Bash
pip install awscli boto3 --upgrade
```

次にecsub をインストールします。

```Bash
git clone https://github.com/aokad/ecsub.git
cd ecsub
python setup.py build install
```

### 3. AWS CLI の設定

awscli に AWS ユーザを登録します。  
事前に [AWSアカウントの設定](#getting-started-on-aws) を行ってください。

```Bash
aws configure
    AWS Access Key ID [None]: <YOUR ACCESS KEY>
    AWS Secret Access Key [None]: <YOUR SECRET ACCESS KEY>
    Default region name [None]: <REGION>
    Default output format [None]: json
```

### 4. インストールの確認

動作確認のために簡単なジョブを実行してみます。  
まず、実行スクリプトと、タスクファイルをダウンロードします。

```Bash
mkdir ecsub-example
wget https://aokad.github.io/ecsub-doc-ja/assets/examples/run-hello.sh -P ecsub-example/
wget https://aokad.github.io/ecsub-doc-ja/assets/examples/tasks-hello.tsv -P ecsub-example/
```

次に AWS S3 にバケットを作成します。  
ecsub の作業ディレクトリです。

```Bash
aws s3 mb s3://${yourbucket}
```

ジョブを実行します。

 - **script:**  ダウンロードした `run-hello.sh` ファイルのパスを指定してください
 - **tasks:**  ダウンロードした `tasks-hello-1.tsv` ファイルのパスを指定してください
 - **aws-s3-bucket:**  作成したバケット名を指定してください

```Bash
ecsub submit \
--script ecsub-example/run-hello.sh \
--tasks ecsub-example/tasks-hello.tsv \
--aws-s3-bucket  s3://${yourbucket}/ecsub \
--image python:2.7.14 \
--aws-ec2-instance-type t2.micro \
--disk-size 1
```

実行できましたか？  
"ecsub completed successfully!" と表示されていれば成功です。

ecsub の実行のデモは以下 URL で見ることができます。

[ecsub demo](https://asciinema.org/a/xEAxjBe5CjyOck9PGBNtAfNbr)


## Getting started on AWS

### 1. AWS にサインアップします

### 2. AWS でユーザグループを作成します

以下の権限を付け、"ecsub-user" という名前でグループを作成してください。

 - AmazonEC2FullAccess
 - S3_S3FullAccess (It is better to limit "Resource:")
 - AmazonECS_FullAccess
 - AWSPriceListServiceFullAccess 
 - CloudWatchLogsFullAccess
 - CloudWatchReadOnlyAccess

### 3. AWS でロールを作成します。

以下の権限を付け、"ecsInstanceRole" という名前でロールを作成してください。

 - AmazonEC2ContainerServiceforEC2Role
 - S3_S3FullAccess
 - CloudWatchMetricFullAccess（create yourself. Choose "CloudWatch:\*Metric\*"）

作成したロールの「信頼関係」を編集し、サービスに `"ecs-tasks.amazonaws.com", "ec2.amazonaws.com"` を登録します。

```Json
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": ["ecs-tasks.amazonaws.com", "ec2.amazonaws.com"]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
```

### 4. AWS でユーザを作成します。

作成したユーザを "ecsub-user" グループに所属させます。

