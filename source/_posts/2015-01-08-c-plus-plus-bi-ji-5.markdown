---
layout: post
title: "C++笔记(5)"
date: 2015-01-08 22:03:01 +0800
comments: true
categories: C++
---
以后都是一章一个笔记了    
这次是命令空间，string,vector,数组，C风格字符串
<!-- more-->
### 命名空间的using声明
1. `std::cin`中`::`表示从操作符左侧名字所示的作用域中寻找右侧的名字
2. 可以使用`using std::cin;`，以后使用cin就不需要`std::`，不是很明白为什么要`::`而不使用其他的符号，反正我觉得用`::`有点反人类
3. 每一个单独的方法都需要单独声明，当然也可以直接`using namespace std`来告诉某某某(也许是编译器吧)，从这个作用域里面找。类似于python的`from math import sqrt`和`from math import *`

### string
1. 初始化，为什么说C++复杂，一个初始化都可以搞出这么多种方案，而且C++的赋值相当于copy才是我最难理解的地方。

			string s1;
			string s2(s1);
			string s3 = s1;
			string s4("value");
			string s5 = "value";
			string s6(10,'c');
2. `string::size_type` 这是string配套的类型，标准库类型都定义了集中配套的类型，想要让标准库类型与机器无关，而`string::size_type`表示的就是字符串的大小类型，看名字也知道，至于他真正的类型，谁知道呢，所以只能把他当作一个够用的类型，呵呵
3. 因为`sting::size_type`应该是一个`unsigned`类型，所以使用`string.size`方法时就要注意了，不能让`string.size`和一个负值进行比较，因为负值要先变成`unsiged`类型，那么他的值就变了，不过判断字符串的长度跟一个负数做比较，那家伙绝对够stupid
4. 首页`"test"`和`string("test")`是两种不同的类型，一种是C语言的，另外一个标准库类型，所以string支持的方法，对于C语言的字符串是不合适的，例如字符串相加`"string" +  "string"`觉得是错误的。
5. C++支持c语言的标准库，并在他们的名字前加了一个c

### vector
1. 标准库类型vector表示对象的集合，集合中的所有对象类型都应该相同。那是不是就不能想OC那样了？如果所有的类都是某一个类的子类，那么应该也是同一个类型
2. vector是一个类模板，不过我现在还不清楚类模板啥意思
3. 好吧，vector表示的是对象的集合，所以引用又被踢掉了
4. vector只是模板，那么就需要添加类型`vector<int>`，那么编译器就会去生成对应的类型
5. vector的初始化跟string一样，也是各种多,事实上我希望语言可以简单一点，因为我不希望去思考这语言有什么特性，而是去思考如果把语言的特性用来实际项目中，所以要C++融会贯通，那可不容易，那些简历上写精通的，谁知道是不是精通

		vector<int> v1;
		vector<int> v2(v1);
		vector<int> v3 = v1;
		vector<int> v4(10,1);
		vector<int> v5(10);
		vector<int> v6{1,2,3,4};
		vector<int> v7={1,2,34};

6. vector的初始化有时候会依赖于是用花括号还是用圆括号，圆括号用来构造，花括号为列表初始值，不过当花括号提供的值不能用来做为列表初始值，就会考虑用这些值来构造
7. 通过`push_back`方法可以添加元素到集合里面
8. 范围for语句体内不应改变所遍历序列的大小
9. 只有当元素可以比较时，vector才可以比较

### 迭代器
1. 有迭代器的类型同时拥有返回迭代器的成员，通过迭代器的成员进行迭代，例如:`begin`和`end`
2. 至于迭代器真正的类型谁也知道，C++的迭代器是我见过的最奇怪的一种，当然C++是比较早期的语言，我接触的语言很多都是后面才有的，可能都是吸取了C++的经验
3. 迭代器类似于指针，存放容器某一个元素的地址，所以需要`*iter`来获取对应的值,而使用`iter->mem`，会自动帮我们解引用，并且指向对应的成员
4. 通过对迭代器进行+1或者-1的操作进行移动位置，但是不要去移动到一个不存在的位置上，那么就会出现**不可预计**的后果
5. 在C++语言里面，for循环用的最多的`!=` ，而在我以前的语言的里面用的最多的是`<`，因为在C++的里面，并不是所有的容器都支持下标查询，所以用`!=`会更统一，不过以我的编程习惯，还是会去`<`，因为我又不是只是用这一种语言，语言间的切换有时候是很坑爹的
6. 迭代器的类型是`iterator`和`const_iterator`当前不同的类型不同定义，例如`string::iterator`
7. `const_iterator`是能读取不能修改，而`iterator`能读能改
8. 所谓的迭代器指的是支持一套操作，这套操作使得我们能访问容器的元素，并且一个元素移动到另一个元素
9. 而所谓的迭代器类型值得是该类型支持这套操作
10. 迭代器的算术运算获得的还是一个迭代器，只是移动了相应的位置

### 数组
1. 使用`"string"`给数组赋值时要注意，C语言字符串后面还有一个空字符，所以数组的长度要多+1
2. 数组允许拷贝和赋值
3. 定义数组的指针和数组的引用需要特别注意，`int (*Parray)[10]`定义的一个指针，指向10个整数的数组，	`int (&Parray)[10]`是是个10个整数的数组的引用，读得时候，从里到外，从左到右
4. 在用到数组的地方，编译器会自动将其替换为一个指向数组的指针
5. 两个指针相减得到的是一个`ptrdiff_t`的标准库类型,这个类型和`size_t`一样都是在`cstddef`头文件里，并且与机器相关
6. 标准库限定使用的下标必须是无符号类型，而内置的下标运算则没有这个要求。说明对于`string`和`vector`使用下标只能`>=0`

### C风格字符串
1. `strlen(p)`返回长度
2. `strcmp(p1,p2)`返回两个字符串的相等性
3. `strcat(p1,p2)`将p2附加到p1上，返回p1
4. `strcpy(p1,p2)`将p2拷贝给p1，返回p1
5. C风格字符串一定是跟着一个空字符串的
6. 直接拿两个C风格字符串进行比较，比较的是他们的指针

### 多维数组
1. 在对多维数组进行for循环时，要注意，除了最内层的循环外，其他所有循环的控制变量都应该是引用类型，如果不是引用类型，那么编译器会把该变量转换为该数组内首元素的指针，那么用一个指针去for循环是不对的,因为指针是没有迭代器的，而用了引用，相当于就是一个数组，而数组是有迭代器的，那么就可以进行迭代

部分文字来自[《C++ Primer》](http://www.amazon.cn/gp/product/B00ESUIL0O/ref=as_li_ss_tl?ie=UTF8&camp=536&creative=3132&creativeASIN=B00ESUIL0O&linkCode=as2&tag=robinwu-23)
