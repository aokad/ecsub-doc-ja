---
layout: default
title: Getting started
permalink: ./setup
page_index: 1
sublinks:
  - title: Install and Setup
    link: install-and-setup
  - title: Getting started on AWS
    link: getting-started-on-aws
---

# Getting started

## Install and Setup

### 1. Dependency

`ecsub` は github のリポジトリからダウンロードしてインストールすることができます。  
Python で作成されており、実行するには python2.7 もしくは python3.5 以上が必要です。

ecsub の実行には AWS が提供しているコマンドラインツールおよび aws アクセスのための python パッケージが必要です。

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
まず、簡単な実行スクリプトと、タスクファイルをダウンロードします。

```Bash
mkdir ecsub_hello
cd ecsub_hello
wget https://aokad.github.io/ecsub-doc-ja/assets/tiny/run_hello.sh
wget https://aokad.github.io/ecsub-doc-ja/assets/tiny/tasks_hello.tsv
```

次に ecsub の作業用に AWS S3 バケットを作成します。  
任意の名前を付けることができますが、AWS 全アカウントでユニークである必要があるため、あまり安易な名前は既に使用されている可能性があります。  

[バケット命名規則](https://docs.aws.amazon.com/ja_jp/AmazonS3/latest/dev/BucketRestrictions.html)

```Bash
export YOUR_BUCKET=${任意のバケット名}
aws s3 mb s3://${YOUR_BUCKET}
```

ジョブを実行します。

 - **script:**  ダウンロードした `run_hello.sh` ファイルのパスを指定してください
 - **tasks:**  ダウンロードした `tasks_hello.tsv` ファイルのパスを指定してください
 - **aws-s3-bucket:**  作成したバケット名を指定してください

```Bash
ecsub submit \
--script ./run_hello.sh \
--tasks ./tasks_hello.tsv \
--aws-s3-bucket  s3://${YOUR_BUCKET}/ecsub \
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
 - AmazonECS_FullAccess
 - S3_S3FullAccess [^1]
 - AWSPriceListServiceFullAccess 
 - CloudWatchLogsFullAccess
 - CloudWatchReadOnlyAccess

※S3 への Read/Write 権限は限定できるなら絞った方がより良いです。

### 3. AWS でロールを作成します。

以下の権限を付け、"ecsInstanceRole" という名前でロールを作成してください。

 - AmazonEC2ContainerServiceforEC2Role
 - S3_S3FullAccess [^1]
 - CloudWatchMetricFullAccess（create yourself. Choose "CloudWatch:\*Metric\*"）

※ 

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

 - 1: ここでは解説のため S3FullAccess をつけていますが、与える権限は目的に応じて必要最低限にすることを推奨します。
