---
layout: post
title: "C++笔记(7)"
date: 2015-01-10 14:29:57 +0800
comments: true
categories: C++
---
函数这章的东西真的很多，而且很多东西也是一知半解，还是需要用，不过先知道下，真的用的时候，如果有问题再看
<!-- more -->
### 函数
1. 形参列表中的形参用逗号隔开，每个形参都需要含有一个声明符的声明，即使形参的类型一样，也必须要把两个类型分开，在其他一些语言中，是不需要两个类型都写的，但是看声明的时候也很不清晰
2. 函数的返回类型不能是数组类型或者是函数类型，但可以是指向数组或者函数的指针
3. 我们把只存在于块执行期间的对象成为自动对象，就是自动创建，自动销毁
4. 局部变量如果本身不包含初始值，执行默认初始化，这意味着内置类型的未初始化局部变量将产生未定义的值。但是我测试了下，对于`int`，`float`还是有做初始化，不过在以前遇到过，因为局部变量没有初始化，造成了一些很奇怪的问题，所以所有的变量都是设定初始值会比较好
5. 在函数里面定义的静态变量会一直存在，直到程序被销毁了
6. 函数和变量一样，都应该在头文件里面声明，在源文件里面定义
7. 形参的类型决定了实参和形参的交互方式，如果类型是引用，他将绑定到对应的实参上，否则讲实参的值拷贝给形参
8. 形参指针也是进行拷贝操作，相当于创建了另一个指针指向了和实参指向的对象
9. 当函数无需修改引用形参的值时最好使用常量引用
10. 当实参初始化形参时，会忽略顶层const，所以`void fcn(const int i )`和`void fcn(int i)`是一样的
11. 当使用数组作为形参时，传递一个数组实参时，实际上传递的是指向数组首元素的指针
12. 因为数组是作为指针传递给函数，所以函数不知道数组的大小，所以需要提供获取数组大小的方法

	1. 数组需要包括一个结束字符，例如C风格字符串的空字符
	2. 直接传递数组的首元素和尾后元素
	3. 显示传递一个表示数组大小的形参，这是比较常用的方法

13. 可以用`initializer_list`声明可变参数，如果函数的实参数量未知，但是全部实参的类型都相同，可以用`initializer_list`来定义
14. 给`initializer_list`形参中传递一个值的序列，则必须把序列放在一对花括号内
15. 可以用`...`省略符来定义，不过是为了访问一些C标准库而设置的

### 返回类型和return语句
1. 返回值返回的是一个临时副本，如果是引用也有可能是临时对象的引用，这是要注意，如果是临时对象，函数执行完他就要被干掉了，这时如果使用改引用会出问题的，所以不要返回局部变量的的引用或指针
2. 定义一个返回数组指针的函数比较麻烦，使用类型别名比较简单

		typedef int arrT[10];
		arrT* func(int i);

3. 一般定义`Type (*func(int i))[dimension]`，确实比较恶心人的一种方式
4. C++11新标准中还有一种可以简化声明的方法，就是尾置返回类型，任何函数的定义都能使用尾置返回，尾置返回类型跟在形参列表后面并以一个`->`符号开头，例如:`auto func(int i) -> int(*)[10]`


### 函数重载
1. 如果同一作用域内的几个函数名字相同但形参列表不同，我们称之为重载函数
2. `main`函数不能重载
3. 对于重载的函数来说，他们应该在形参数量或形参类型上有所不同
4. 当调用重载函数时有三种可能的结果:
	1. 编译器找到一个与实参最佳匹配的函数，病生成调用该函数的代码
	2. 找不到任何一个函数与调用的实参匹配，此时编译器发出无匹配的错误信息
	3. 有多于一个函数可以匹配，但是每一个都不是明显的最佳选择，此时也将发生错误，成为二义性调用

5. 在不同的作用域无法重载函数名，意思就是编译器会先查找当前作用域的函数名，如果查找到了，那么外部作用域的函数就会被屏蔽掉，那么无论当前作用域的函数是否匹配，都不会去访问外部作用域的
6. 在C++语言中，名字查找发生在类型检查之前

### 特殊用途语言特性（默认实参，内联函数，constexpr）
1. 默认形参，在定义中给每个形参设置默认值，不过一旦某个形参被赋予了默认值，它后面的所有形参必须有默认值
2. 在给定的作用域中一个形参只能被赋予一次默认实参
3. 通常，应该在函数声明中指定默认实参，并将该声明放在合适的头文件中
4. 局部变量不能作为默认实参，除此之外，只要表达式的类型能转换成形参所需的类型，该表达式就能作为默认实参
5. 用做默认实参的名字在函数生命所在的作用域内解析，而这些名字的求值过程发生在函数调用时
6. 内联函数就在该函数调用点“内联地”展开，例如`shorterString`是一个内联函数

		cout << shorterString(s1,s2) << endl
相当于

		cout << (s1.size() < s2.size() ?s1:s2) << endl
7. 使用`inline`将函数定义为内联函数
8. `constexpr`函数是值能用于常量表达式的函数,该函数的返回类型以及所有形参的类型都得是字面值类型
9. 内联函数和`constexpr`函数一般放在头文件

### NDEBUG预处理变量
编译器定义了几个调使用的名字    
1. `__func__` 输出当前调试的函数的名字
2. `__FILE__` 存放文件名的字符串字面值
3. `__LINE__` 存放当前行号的整型字面值
4. `__TIME__` 存放文件编译时间的字符串字面值
5. `__DATE__` 存放文件编译日期的字符串字面值

### 函数指针
1. 函数指针指向的是函数而非对象
2. 想要声明一个可以指向该函数的指针，只需要用指针替换函数名即可
3. 我们可以直接使用函数指针，而无需提前解引用指针
4. 我们可以直接把函数作为实参使用，此时它会自动转换成指针
5. 使用decltype返回的是函数类型，需要在加`*`
6. 定义指向函数的指针跟定义指向数组的指针方式一样，但是可读性上尽量使用类型别名或者尾置类型

部分文字来自[《C++ Primer》](http://www.amazon.cn/gp/product/B00ESUIL0O/ref=as_li_ss_tl?ie=UTF8&camp=536&creative=3132&creativeASIN=B00ESUIL0O&linkCode=as2&tag=robinwu-23)
