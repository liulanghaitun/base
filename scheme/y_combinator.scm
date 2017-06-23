Y组合子使得匿名函数递归成为了可能. 一般的有名函数的递归如下：
(define len
  (lambda (list)
    (cond
      ((null? list) 0)
      ((+ 1  (len (cdr list)))))))
通过绑定的函数名来进行递归运算,该函数返回列表的长度,运算结果如下：
> (len '(1 2 3 4 5))
结果是5
但是对于匿名函数是无法通过函数名来进行递归，但是Y组合子可以使一个非递归函数转换为递归函数.

匿名函数的形式如下：
  (lambda (list)
    (cond
      ((null? list) 0)
      ((+ 1  (len (cdr list))))))
这是一个有问题的表达式，len现在已经不存在，因此无法通过函数名来调用.但是可以换一种方式来思考,
如果无法通过函数名来进行调用，我可以通过返回一个同构函数来实现.如果要返回一个同构函数，则必须将其自身包含在另一个函数体内
构造后的函数如下 ：
(lambda (exp)
  (lambda (list)
    (cond
      ((null? list) 0)
      ((+ 1  (len (cdr list)))))))
为了能够进行函数调用,可以给该函数命名,形式如下:
(define base
(lambda (exp)
  (lambda (list)
    (cond
      ((null? list) 0)
      ((+ 1  (len (cdr list))))))))
将该函数命名为base,上述函数可以变换为如下形式:
(define base
(lambda (exp)
  (lambda (list)
    (cond
      ((null? list) 0)
      ((+ 1  ((base exp) (cdr list))))))))
这是一个递归函数,运行结果如下:
> ((base 'a) '(1 2 3 4 5))
5
这个表达式中exp是任意的，以后可以看到，该位置是Y组合子的一个关键位置.
但是上述依然是一个有名函数的递归，因此我们必须将base抽取出来，exp是任意的，
所以我们可以同传入参数将其化归,为了化归我们将base归为入参,上述的表达式可以转换为
(define base
(lambda (param)
  (lambda (list)
    (cond
      ((null? list) 0)
      ((+ 1  ((param exp) (cdr list)))))) base))
将其转换为一个函数调用，传入参数是一个函数base.
运行该函数，结果如下:
> (base base)
#<procedure:base>
该函数的结果返回了自己，base是一个不动点,作用于自己并且返回自己.
但是我们依然无法递归，现在递归后回产生exp的调用，从而中断调用,
最直接的方式是将exp=base,但是这样会将base继续绑定,既然我们已经从
外部传入了一个base，我们可以 令exp=param,结果上述的表达式转换为以下
的形式:
(define base
(lambda (param)
  (lambda (list)
    (cond
      ((null? list) 0)
      ((+ 1  ((param param) (cdr list)))))) base))
运行该函数，结果如下:
> (base base)
#<procedure:base
这与上一个表达式的结果相同.现在我们已经知道了base的基本形式.
(define base
(lambda (param)
  (lambda (list)
    (cond
      ((null? list) 0)
      ((+ 1  ((param param) (cdr list))))))))
现在已经与base无关了，现在的函数调用如下:
> (base base)
#<procedure:...记\chapter7.rkt:19:2>
这个会产生一个自生拷贝，也就说已经完成了递归调用,结果如下：
> ((base base) '(1 2 3 4 5))
5
上述的表达式可以抽象为:(base base) list)，我们现在可以进行替换了,base由其定义来替换，结果的形式如下：
((base base) list)变换为如下形式:
(((lambda (param)
  (lambda (list)
    (cond
      ((null? list) 0)
      ((+ 1  ((param param) (cdr list)))))))
(lambda (param)
  (lambda (list)
    (cond
      ((null? list) 0)
      ((+ 1  ((param param) (cdr list))))))))  list)
由于base中param在函数体内进行了变换，我们可以进一步的抽象出来,
((param param) (cdr list)）等价于((lambda (x) ((param param) x))(cdr list)
进行替换之后，将((lambda (x) ((param param) x))提取出来，base变成了
(lambda (procedure)
(lambda (param)
  (lambda (list)
    (cond
      ((null? list) 0)
      ((+ 1  (param (cdr list)))))))((lambda (x) ((procedure procedure) x))))
其中
(lambda (param)
  (lambda (list)
    (cond
      ((null? list) 0)
      ((+ 1  (param (cdr list)))))))
可以抽取出来，结果变成
(lambda (y)
(lambda (procedure)
( y (lambda (x) ((procedure procedure) x)))))
将上面的表达式带入 ((base base) list) 产生的结果就是
(((lambda (y)
  ((lambda (procedure)
     (y (lambda (x) ((procedure procedure) x))))
   (lambda (procedure)
     (y (lambda (x) ((procedure procedure) x))))))
(lambda (parm)
  (lambda (list)
    (cond
      ((null? list) 0)
      ((+ 1 (parm (cdr list)))))))) '(1 2 3 4 5))
这就是无参函数调用,结果是：
> (((lambda (y)
  ((lambda (procedure)
     (y (lambda (x) ((procedure procedure) x))))
   (lambda (procedure)
     (y (lambda (x) ((procedure procedure) x))))))
(lambda (parm)
  (lambda (list)
    (cond
      ((null? list) 0)
      ((+ 1 (parm (cdr list)))))))) '(1 2 3 4 5))
5
Y组合子就是:
(lambda (y)
  ((lambda (procedure)
     (y (lambda (x) ((procedure procedure) x))))
   (lambda (procedure)
     (y (lambda (x) ((procedure procedure) x))))))
通过该组合子可以将非递归转换为递归.
上述递归表达式中的y为:
(lambda (parm)
  (lambda (list)
    (cond
      ((null? list) 0)
      ((+ 1 (parm (cdr list)))))))
x为输入的参数:'(1 2 3 4 5)
