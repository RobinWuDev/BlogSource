---
layout: post
title: android studio的ndk子模块打断点配置
date: 2017-05-25 21:44:44
comments: true
tags: android
category: android
---
最近在使用ndk，不过我是把ndk放在了一个子模块中，然后发现无法打断点，后来调查下，发现需要以下的配置。<!--more-->
1.在子模块的build.gradle文件中，添加publishNonDefault  true
```
apply plugin: 'com.android.library'

android {
    publishNonDefault  true
    }
```

2.在app模块中的build.gradle文件中修改导入配置。
将原来的**compile project(path: ':submoduleName')** 改成 **compile project(path: ':submoduleName'', configuration: 'debug')**

这样应该就可以在submodule中打断点了
