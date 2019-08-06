---
layout: default
title: Quick Start
permalink: /quick-start
page_index: 0
---

# Quick Start

```Bash
pip install ecsub

ecsub submit \
--script ~/gitlab/ecsub-testdata/examples-iret/run-wordcount.sh \
--tasks ~/gitlab/ecsub-testdata/examples-iret/tasks-wordcount-1.tsv \
--aws-s3-bucket  s3://aokad-ana-singapore/ecsub-test \
--image python:2.7.14 \
--aws-ec2-instance-type t2.micro \
--disk-size 1
```
