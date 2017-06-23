                                    第二章
1.判断列表中是否每个S表达式都是原子
(define debug
      (lambda (x) (begin (display x) (newline))))
;;测试当前打印语句
;;(debug "hello world!")

;;定义原子操作
(define atom?
    (lambda (x)
      (and (not (pair? x)) (not (null? x)))))

;;测试原子操作
;;(debug (atom? "hello world!"))
;;(debug (atom? '("hello" "world")))

;;判断每个元素是否为原子
(define lat?
  (lambda (l)
    (cond
      ((null? l) #t)
      ((atom? (car l)) (lat? (cdr l)))
      (else #f))))
;;测试lat
(debug (lat? '(bacon and eggs)))
(debug (lat? '((Jack) Sprat could eat no chicken fat)))

2.判断某个元素是否为列表中的元素
;;判断某个元素是否为列表中的元素
(define member?
  (lambda (a lat)
    (cond
      ((null? lat) #f)
      (else (or (eq? a (car lat)) (member? a (cdr lat)))))))

(debug (member? 'meat '(mashed potatoes and meat gravy)))
(debug (member? 'liver '(bagels and lox)))
