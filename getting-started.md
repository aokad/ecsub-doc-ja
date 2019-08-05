---
layout: default
title: Getting Started
permalink: /getting-started
page_index: 0
---

> This page describes how to get started with `hotsub` command. 

# 0. Prerequisites

You need 2 softwares installed on your environment

- [docker-machine](#install-docker-machine)
- [AWS CLI](#install-aws-cli)

and 2 permissions on AWS account

- [EC2 Full Access](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_examples_ec2_region.html) // TODO: fix
- [IAM Full Access](https://docs.aws.amazon.com/IAM/latest/UserGuide/getting-started_create-admin-group.html) // TODO: fix

{% include note.html type="info" content="These 2 permissions are **sufficient condition**. Check ['Support HIPAA'](/support-hipaa) for more detail." %}

## Install docker-machine

You can skip this step if following command already works well on your computer.

```sh
% docker-machine version
```

Otherwise, you need to install `docker-machine`.

- [Install Docker Machine - Docker Documentation](https://docs.docker.com/machine/install-machine/){:target="_blank"}
- **or** [Docker Toolbox overview - Docker Documentation](https://docs.docker.com/toolbox/overview)

## Install AWS CLI

You can skip this step if following command already works well on your computer.

```sh
% aws configure list
```

Otherwise, you need to install `awscli` and configure it with your credentials.

- [Installing the AWS Command Line Interface - AWS Command Line Interface](https://docs.aws.amazon.com/cli/latest/userguide/installing.html){:target="_blank"}
- **and** [Configuring the AWS CLI - AWS Command Line Interface ](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html){:target="_blank"}

# 1. Install hotsub

{% include note.html type="info" content="`hotsub` is currently stable on MacOS and Linux environment. Windows support is coming soon." %}

Choose binary for your OS from [this release page](https://github.com/otiai10/hotsub/releases) and, if you want, locate extracted executable file to your `PATH`.

# 2. Hello World!

You can generate `Hello, World` project by using `template` command.

```sh
% hotsub template
Successfully created template project
    at helloworld_201810041451
Go to the directory and check README.md
% cd helloworld_201810041451
% ls
README.md	hello.csv	hello.sh
```

These are all you need to run `Hello, World`

```sh
% hotsub run \
    --script hello.sh \
    --tasks hello.csv \
    --verbose
```

Then you will get following output

```
2018/10/04 14:53:46 [COMMAND]	Your tasks file is parsed and decoded to 2 job(s) ✅
2018/10/04 14:53:46 [COMMAND]	See logs here -> /Users/otiai10/proj/hotsub/github.io/helloworld_201810041451/log/20181004_145346
[hello.csv 0]	[CREATE]	Creating computing instance for this job...
[hello.csv 1]	[CREATE]	Creating computing instance for this job...
[hello.csv 1]	[CONSTRUCT]	Constructing containers for this job...
[hello.csv 1]	[CONSTRUCT]	Constructing workflow container inside the computing instance...
[hello.csv 1]	[CONSTRUCT]	Constructing routine container inside the computing instance...
[hello.csv 0]	[CONSTRUCT]	Constructing containers for this job...
[hello.csv 0]	[CONSTRUCT]	Constructing workflow container inside the computing instance...
[hello.csv 0]	[CONSTRUCT]	Constructing routine container inside the computing instance...
[hello.csv 0]	[EXECUTE]	&1> Hello! My name is Tom.
[hello.csv 0]	[EXECUTE]	&1> I'm a cat.
[hello.csv 1]	[EXECUTE]	&1> Hello! My name is Jerry.
[hello.csv 1]	[EXECUTE]	&1> I'm a mouse.
[hello.csv 0]	[DESTROY]	Terminating computing instance for this job...
[hello.csv 1]	[DESTROY]	Terminating computing instance for this job...
2018/10/04 15:00:03 [COMMAND]	All of your 2 job(s) are completed 🎉
```

Congrats! You first jobs are completed.

Let's follow what happened in this trial.

-> [How it works](/how-it-works)
