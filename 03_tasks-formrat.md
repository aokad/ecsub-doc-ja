---
layout: default
title: Format of tasks.tsv
permalink: /tasks-format
page_index: 3
---

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
