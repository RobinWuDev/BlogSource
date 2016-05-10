---
title: 从octopress到hexo
date: 2016-05-10 17:39:39
tags: octopress hexo 博客
comments: true
categories: 其他
---
以前一直在用octopress，后来因为自己的电脑的数据被清了，所以只能又从github那边同步代码下来。
结果同步下来后，本地环境一直出错，一直没法生成文件，ruby也一直出问题。
后来看了唐巧的文章，就又发现了hexo，所以也打算迁移到hexo上。

### 迁移步骤

1. 安装[hexo](https://hexo.io)

    `$ npm install -g hexo-cli`

2. 初始化项目
    ```
    $ hexo init <folder>
    $ cd <folder>
    $ npm install
    ```
3. 把octopress的文章和静态资源放到到hexo中。

    1. 将octopress中的source/_posts中的文件复制到hexo的source/_posts中
    2. 将octopress中的静态文件也复制到hexo的source目录下。例如：我的代码中有一个BlogFiles放的是所以的博客的引用文件（文件，音乐，图片等），把这个文件夹复制到hexo的source下，这样就可以了。

4. 然后根据自己的需要，配置hexo。

5. 管理代码

  首先hexo的机制跟octopress是一样的，也就是我们看到的都是项目的源码，然后通过hexo generate会将生成网页代码，然后放到public文件夹下，这时候我们只需要将public的文件放到github或者我们自己的服务器上就可以了。而项目的源码我们还是通过github来管理。

因为我在github上已经有一个pages了，所以我就还是用那个，但是hexo的源码我不想跟pages放在一起了，所以我又创建了项目，专门用来管理hexo的源码。

然后我根据唐巧的脚本改成自己需要的脚本。
```
#! /bin/bash
hexo clean
hexo generate
cd public

git init
git add .
git commit -m "update at `date` "

git remote add origin https://github.com/RobinWuDev/RobinWuDev.github.io.git >> /dev/null 2>&1
echo "### Pushing to Github..."
git push origin master -f
echo "### Done"
echo "### update Source Code to Github"
cd ..
git add .
git commit -a -m "update blog"
git push origin master
echo "### Done"
```
