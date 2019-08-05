---
layout: default
permalink: /
---

# Welcome to GitHub Pages

* Table Of Contents
{:toc}

You can use the [editor on GitHub](https://github.com/aokad/ecsub-doc-ja/edit/master/README.md) to maintain and preview the content for your website in Markdown files.

Whenever you commit to this repository, GitHub Pages will run [Jekyll](https://jekyllrb.com/) to rebuild the pages in your site, from the content in your Markdown files.

## Markdown

Markdown is a lightweight and easy-to-use syntax for styling your writing. It includes conventions for

```markdown
Syntax highlighted code block

# Header 1
## Header 2
### Header 3

- Bulleted
- List

1. Numbered
2. List

**Bold** and _Italic_ and `Code` text

[Link](url) and ![Image](src)
```

For more details see [GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/).

## Jekyll Themes

Your Pages site will use the layout and styles from the Jekyll theme you have selected in your [repository settings](https://github.com/aokad/ecsub-doc-ja/settings). The name of this theme is saved in the Jekyll `_config.yml` configuration file.

## Support or Contact

Having trouble with Pages? Check out our [documentation](https://help.github.com/categories/github-pages-basics/) or [contact support](https://github.com/contact) and we’ll help you sort it out.

# What is hotsub?

`hotsub` is a command line tool to execute batch jobs on cloud services, like AWS, GCP and so.   For example,

```sh
hotsub --script ./hello.sh --tasks ./world.csv
```

![Example 001](/assets/img/example-001.png)

This command will automatically launch several EC2 instances on AWS and execute your `./hello.sh` on the instances for each sample which is specified as a row in your `./world.csv`.

![Example Animation](/assets/img/example-animated.gif)

More details about what it does are explained in this page. Please check it out.

-> [Getting Started](/getting-started)<br>
-> [How it works](/how-it-works)

# Why hotsub?

`hotsub` doesn't require any new knowledge to get started with. Only you need is shell script file you want to execute.

Launching VMs on cloud, provisionong, downloading and uploading files to storage are all automated by `hotsub`.

There are more differences with other existing tools, check this page for more details.

-> [ETL and ExTL](/etl-and-extl)

# How to use?

You need `docker-machine` installed and `.aws/credentials` which can generate with `aws configure`.

For more friendly tutorial to get started, please check this page.

-> [Getting Started](/getting-started)
