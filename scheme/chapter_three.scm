1)编译平台:gentoo 
$uname -a 
Linux gentoo 4.12.12-gentoo #2 SMP Thu Sep 14 21:32:14 CST 2017 x86_64 Intel(R) Core(TM) i7-3720QM CPU @ 2.60GHz GenuineIntel GNU/Linux

2)编译软件:chez scheme
$scheme -v 或者使用(petite -v)
Chez Scheme Version 9.4
Copyright 1984-2016 Cisco Systems, Inc.

3)编辑软件:Vim
$vim -v
VIM - Vi IMproved 8.0 (2016 Sep 12, compiled Sep  8 2017 05:09:57)
Included patches: 1-386                           
Modified by Gentoo-8.0.0386  
Compiled by renwei@gentoo 

新建文件: lesson3.scm

1) 删除首次出现的元素,并且返回列表
(define rember                                                                       
  (lambda (a lat)
	(cond
	  ((null? lat) '())
	  ((eq? a (car lat)) (cdr lat))
	  (else (cons (car lat) (rember a (cdr lat)))))))
启动chez scheme,可以使用tab补全函数,退出scheme使用(exit)
$ scheme
Chez Scheme Version 9.4
Copyright 1984-2016 Cisco Systems, Inc.

>(load "lesson3.scm")
> (rember 'bacon '(bacon lettuce and tomato))
(lettuce and tomato)
>(rember 'hello '(bacon lettuce and tomato))
(bacon lettuce and tomato)
>(rember 'cup '(coffee cup tea cup and hick cup)) 
(coffee tea cup and hick cup) 

2)获取列表的首个元素形成的列表
(define firsts                                                                       
  (lambda (l)
	(cond
	  ((null? l) '())
	  (else (cons (car (car l)) (firsts (cdr l)))))))

$ scheme
Chez Scheme Version 9.4
Copyright 1984-2016 Cisco Systems, Inc.

> (load "lesson3.scm")
> (firsts '((a b) (c d) (e f)))
(a c e)
> (firsts '((five plums) (four) (eleven green oranges)))
(five four eleven)
> (firsts '(((five plums) four) (eleven green oranges) ((no) more)))
((five plums) eleven (no))

;;3)在第一个旧元素的右侧插入新元素，返回对应的列表
(define insertR                                                                      
  (lambda (new old lat)
	(cond
	  ((null? lat) '())
	  ((eq? old (car lat)) (cons old (cons new (cdr lat))))
	  (else (cons (car lat) (insertR new old (cdr lat)))))))

$ scheme
Chez Scheme Version 9.4
Copyright 1984-2016 Cisco Systems, Inc.

> (load "lesson3.scm")
> (insertR 'topping 'fudge '(ice cream with fudge for dessert))
(ice cream with fudge topping for dessert)
> (insertR 'jalapeno 'and '(tacos tamales and salsa))
(tacos tamales and jalapeno salsa)
> (insertR 'e 'd '(a b c d f g d h))
(a b c d e f g d h)

4)在第一个旧元素的左边插入新元素，并且返回对应的列表
(define insertL                                                                      
  (lambda (new old lat)
	(cond
	  ((null? lat) '())
	  ((eq? old (car lat)) (cons new lat))
	  (else (cons (car lat) (insertL new old (cdr lat)))))))

$ scheme
Chez Scheme Version 9.4
Copyright 1984-2016 Cisco Systems, Inc.

> (load "lesson3.scm")
> (insertL 'd 'e '(a b c e g d h))
(a b c d e g d h)

5)使用新元素代替第一个出现的旧元素，并且返回列表
(define subst                                                                        
  (lambda (new old lat)
	(cond
	  ((null? lat) '())
	  ((eq? old (car lat)) (cons new (cdr lat)))
	  (else (cons (car lat) (subst new old (cdr lat)))))))

$ scheme
Chez Scheme Version 9.4
Copyright 1984-2016 Cisco Systems, Inc.

> (load "lesson3.scm")
> (subst 'topping 'fudge '(ice cream with fudge  for dessert))
(ice cream with topping for dessert)

6)使用新元素替换两个元素，并且返回列表
(define subst2                                                                       
  (lambda (new old1 old2 lat)
	(cond
	  ((null? lat) '())
	  ((eq? old1 (car lat)) (cons new (cdr lat)))
	  ((eq? old2 (car lat)) (cons new (cdr lat)))
	  (else (cons (car lat) (subst2 new old1 old2 (cdr lat)))))))

$ scheme
Chez Scheme Version 9.4
Copyright 1984-2016 Cisco Systems, Inc.

> (load "lesson3.scm")
> (subst2 'vanilla 'chocolate 'banana '(banana ice cream with chocolate topping))
(vanilla ice cream with chocolate topping)

7)删除所有符合要求的元素，并且返回列表
(define multirember                                                                  
  (lambda (a lat)
	(cond
	  ((null? lat) '())
	  ((eq? a (car lat)) (multirember a (cdr lat))) 
	  (else (cons (car lat) (multirember a (cdr lat))))))) 

$ scheme
Chez Scheme Version 9.4
Copyright 1984-2016 Cisco Systems, Inc.

> (load "lesson3.scm")
> (multirember 'cup '(coffee cup tea cup and hick cup))
(coffee tea and hick)

8)在所有的旧元素右侧插入新元素,并且返回列表
(define multiinsertR                                                                 
  (lambda (new old lat)
	(cond
	  ((null? lat) '()) 
	  ((eq? old (car lat))
	   (cons old (cons new (multiinsertR new old (cdr lat)))))
	  (else (cons (car lat) (multiinsertR new old (cdr lat)))))))

$ scheme
Chez Scheme Version 9.4
Copyright 1984-2016 Cisco Systems, Inc.

> (load "lesson3.scm")
> (multiinsertR 'x 'a '(a b c d e a a b))
(a x b c d e a x a x b)

9)在所有旧元素左边插入新元素，并且返回列表
(define multiinsertL                                                                 
  (lambda (new old lat)
	(cond
	  ((null? lat) '()) 
	  ((eq? old (car lat))
	   (cons new (cons old (multiinsertL new old (cdr lat)))))
	  (else (cons (car lat) (multiinsertL new old (cdr lat)))))))

$ scheme
Chez Scheme Version 9.4
Copyright 1984-2016 Cisco Systems, Inc.

> (load "lesson3.scm")
> (multiinsertL 'fried 'fish '(chips and fish or fish and fired))
(chips and fried fish or fried fish and fired)

10)用新元素替换所以的旧元素，并且返回列表
(define multisubst                                                                   
  (lambda (new old lat)
	(cond
	  ((null? lat) '())
	  ((eq? old (car lat))
	   (cons new (multisubst new old (cdr lat))))
	  (else (cons (car lat) (multisubst new old (cdr lat)))))))

$ scheme
Chez Scheme Version 9.4
Copyright 1984-2016 Cisco Systems, Inc.

> (load "lesson3.scm")
> (multisubst 'x 'a '(a b c d e a a b))
(x b c d e x x b)

