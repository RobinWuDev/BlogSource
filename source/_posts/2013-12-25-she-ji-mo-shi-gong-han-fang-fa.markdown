---
layout: post
title: "设计模式-工厂方法"
date: 2013-12-25 14:37:11 +0800
comments: true
categories: 设计模式
---
	工厂方法模式:定义创建对象的接口，让子类决定实例化哪一个类。工厂方法使得一个类的实例化延迟到其子类。
  <!-- more -->
工厂方法我觉得就是用来封装细节的，当使用工厂方法进行创建实例，不需要知道下面到底是怎么创建，直接就可以创建一个出来使用，将解析都封装下面。

{% img /blogFiles/images/20131225.png %}

从上面的的类图可以看出，Dog和Duck都有具体的工厂来进行生产，而我们在使用的时候就直接使用对应的工厂了，而不用关心具体的动物是怎么创建的。工厂的含义就是这样，我们在使用工厂生产出来的东西的时候，并不会去关心工厂怎么生产东西，而是关心东西怎么用。

这时我突然有点疑问，为什么要使用协议？为什么要使用继承的方式。看着类图，感觉如果只是为了封装，直接创建对应的工厂不就好了吗？呵呵，因为这只是demo的类图，如果是具体项目的类图是不会如此简单的，将一些东西抽象出来，整个项目会更加整洁，拓展性会更好。

我直接上附件了，就不弄代码了。

<a href="/blogFiles/download/20131225.zip" >demo</a>


