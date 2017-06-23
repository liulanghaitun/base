                                     第一章
1)基本概念
1.1)S表达式: scheme中所有元素都可以叫做S表达式
1.2)atom: 原子，是指一个非列表的S表达式
1.3)list: 列表，用 `(... ...)` 包围起来的S表达式

2)七条公理
2.1)quote,对后面的表达式不解析(抑制求值)
2.2)atom?: 用来判断一个S表达式是否为一个原子
2.3)eq?: 用来判断两个非数字的的原子是否相等
2.4)car: 返回非空列表中的首个S表达式(操作非空列表)
2.5)cdr: 取出非空列表中的除首个S表达式的列表(操作非空列表)
2.6)cons: 将两个S表达式连接成一个列表，第二个必须是一个列表
2.7)cond: 相当于其它语言中的switch

3)函数相关
3.1)define: 用来定义一个名称，或者一个函数
3.2)lambda: 用来定义一个函数

4)编译环境
$ uname -a
Linux localhost 4.4.26-gentoo #3 SMP Fri Dec 23 21:19:58 CST 2016 x86_64 Intel(R) Core(TM)2 Duo CPU T9300 @ 2.50GHz GenuineIntel GNU/Linux

5)编译软件
$ guile --version
Guile 1.8.8
Copyright (c) 1995, 1996, 1997, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008 Free Software Foundation
Guile may be distributed under the terms of the GNU General Public Licence;
certain other uses are permitted as well.  For details, see the file
`COPYING', which is included in the Guile distribution.
There is no warranty, to the extent permitted by law.

6)代码编译器(vim)
$vim --version
VIM - Vi IMproved 8.0 (2016 Sep 12, compiled Dec 24 2016 15:12:32)
Included patches: 1-106
Modified by Gentoo-8.0.0106

7)代码测试程序
(define debug
      (lambda (x) (begin (display x) (newline))))
;;测试当前打印语句
(debug "hello world!")

8)代码编译结果(上面代码保存为first.scm)
$ guile -s first.scm
hello world!

9)定义原子操作
;;调试语句
(define debug
      (lambda (x) (begin (display x) (newline))))
;;测试当前打印语句
(debug "hello world!")

;;定义原子操作
(define atom?
    (lambda (x)
      (and (not (pair? x)) (not (null? x)))))
;;测试原子操作
(debug (atom? "hello world!"))
(debug (atom? '("hello" "world")))
编译结果:
$ guile -s first.scm
hello world!
#t
#f

更多资源：
https://github.com/search?utf8=%E2%9C%93&q=the+little+scheme
