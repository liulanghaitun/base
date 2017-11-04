;;定义获取列表长度
(define len
  (lambda (ls)
	(cond
	  [(null? ls) 0]
	  [else (add1 (len (cdr ls)))])))
;;因为没法通过函数名调用,所以通过高阶函数返回一个自身
(define make-len
  (lambda (proc)
	(lambda (ls)
	  (cond
		[(null? ls) 0]
		[else (add1 ((make-len proc) (cdr ls)))]))))
;;因为对于任何proc,make-len都可以获取到len
;;(make-len proce)===>len
;;所以可以令proc==make-len
(define make-len
  (lambda (proc)
	(lambda (ls)
	  (cond
		[(null? ls) 0]
		[else (add1 ((make-len make-len) (cdr ls)))]))))
;;可以包make-len抽取出来
(define make-len
  (lambda (proc)
	(lambda (input)
	  (lambda (ls)
		(cond
		  [(null? ls) 0]
		  [else (add1 ((input input) (cdr ls)))]))) make-len))
;;将定义部分抽取出来
(define base
  (lambda (input)
	(lambda (ls)
	  (cond
		[(null? ls) 0]
		[else (add1 ((input input) (cdr ls)))]))))
;;上述定义可以转化为
(define make-len (lambda (proc) (base make-len)))
;;因为对于一切的proc都有
(define make-len (base make-len))
;;又因为(base base) ===>等价与len,将base带入等式中
((lambda (input)
   (lambda (ls)
	 (cond
	   [(null? ls) 0]
	   [else (add1 ((input input) (cdr ls)))])))
 (lambda (input)
   (lambda (ls)
	 (cond
	   [(null? ls) 0]
	   [else (add1 ((input input) (cdr ls)))]))))
;;又因为((input input) (cdr ls))等价于((lambda (x) ((input input) x))(cdr list))
(lambda (input)
  ((lambda (procedure)
	 (lambda (ls)
	   (cond
		 [(null? ls) 0]
		 [else (add1 (procedure (cdr ls)))]))) (lambda (x) ((input input) x))))
;;再次抽取
(lambda (procedure)
  (lambda (ls)
	(cond
	  [(null? ls) 0]
	  [else (add1 (procedure (cdr ls)))])))
;;得到Y算子
(((lambda (y)
	((lambda (input)
	   (y (lambda (x) ((input input) x))))
	 (lambda (input)
	   (y (lambda (x) ((input input) x))))))
