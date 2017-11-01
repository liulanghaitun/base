;;factorial
(define factorial
  (lambda (number)
	(cond
	  [(zero? number) 1]
	  [else (* number (factorial (- number 1)))])))
;;factorial=====>cps
(define factorial&co
  (lambda (number co)
	(cond
	  [(zero? number) (co 1)]
	  [else (factorial&co (- number 1) (lambda (x) (co (* number x))))])))

;;delete first element
(define rember
  (lambda (element ls)
	(cond
	  [(null? ls) '()]
	  [(eq? element (car ls)) (cdr ls)]
	  [else (cons (car ls) (rember element (cdr ls)))])))
;;delete first element=====>cps
(define rember&co
  (lambda (element ls co)
	(cond
	  [(null? ls) (co '())]
	  [(eq? element (car ls)) (co (cdr ls))]
	  [else (rember? element (cdr ls) (lambda (x) (co (cons (car ls) x))))])))

;;obtain first element
(define first
  (lambda (ls)
	(cond
	  [(null? ls) '()]
	  [else (cons (car (car ls)) (first (cdr ls)))])))
;;obtain first element=====>cps
(define first&co
  (lambda (ls co)
	(cond
	  [(null? ls) (co '())]
	  [else (first&co (cdr ls) (lambda (x) (co (cons (car (car ls)) x))))]))) 

;;insert right element
(define insertR
  (lambda (element value ls)
	(cond
	  [(null? ls) '()]
	  [(eq? element (car ls)) (cons element (cons value (cdr ls)))]
	  [else (cons (car ls) (insertR element value (cdr ls)))])))
;;insert right element=====>cps
(define insertR&co
  (lambda (element value ls co)
	(cond
	  [(null? ls) (co '())]
	  [(eq? element (car ls)) (co (cons element (cons value (cdr ls))))]
	  [else (insertR&co element value (cdr ls) (lambda (x) (co (cons (car ls ) x))))])))

;;insert left element
(define insertL
  (lambda (element value ls)
	(cond
	  [(null? ls) '()]
	  [(eq? element (car ls)) (cons value ls)]
	  [else (cons (car ls) (insertL element value (cdr ls)))])))
;;insert left element=====>cps
(define insertL&co
  (lambda (element value ls co)
	(cond
	  [(null? ls) (co '())]
	  [(eq? element (car ls)) (co (cons value ls))]
	  [else (insertL&co element value (cdr ls) (lambda (x) (co (cons (car ls) x))))])))

;;relace element
(define replace
  (lambda (element value ls)
	(cond
	  [(null? ls) '()]
	  [(eq? element (car ls)) (cons value (cdr ls))]
	  [else (cons (car ls) (replace element value (cdr ls)))])))
;;replace element=====>cps
(define replace&co
  (lambda (element value ls co)
	(cond 
	  [(null? ls) '()]
	  [(eq? element (car ls)) (co (cons value (cdr ls)))]
	  [else (replace&co element value (cdr ls) (lambda (x) (co (cons (car ls) x))))])))

;;delete all element
(define deleteAll
  (lambda (element ls)
	(cond
	  [(null? ls) '()]
	  [(eq? element (car ls)) (deleteAll element (cdr ls))]
	  [else (cons (car ls) (deleteAll element (cdr ls)))])))
;;delete all element=====>cps
(define deleteAll&co
  (lambda (element ls co)
	(cond
	  [(null? ls) (co '())]
	  [(eq? element (car ls)) (deleteAll&co element (cdr ls) (lambda (x) (co x)))]
	  [else (deleteAll&co element (cdr ls) (lambda (x) (co (cons (car ls ) x))))])))

;;insert right ALL element
(define insertRAll
  (lambda (element value ls)
	(cond
	  [(null? ls) '()]
	  [(eq? element (car ls)) (cons element (cons value (insertRAll element value (cdr ls))))]
	  [else (cons (car ls) (insertRAll element value (cdr ls)))])))
;;insert right ALL element=====>cps
(define insertRAll&co
  (lambda (element value ls co)
	(cond
	  [(null? ls) (co '())]
	  [(eq? element (car ls)) (insertRAll&co element value (cdr ls) (lambda (x) (co (cons element (cons value x)))))]
	  [else (insertRAll&co element value (cdr ls) (lambda (x) (co (cons (car ls) x))))])))

;;insert left ALL element
(define insertLAll
  (lambda (element value ls)
	(cond
	  [(null? ls) '()]
	  [(eq? element (car ls)) (cons value (cons element (insertLAll element value (cdr ls))))]
	  [else (cons (car ls) (insertLAll element value (cdr ls)))])))
;;insert left ALL element=====>cps
(define insertLAll&co
  (lambda (element value ls co)
	(cond
	  [(null? ls) (co '())]
	  [(eq? element (car ls)) (insertLAll&co element value (cdr ls) (lambda (x) (co (cons value (cons element x)))))]
	  [else (insertLAll&co element value (cdr ls) (lambda (x) (co (cons (car ls) x))))])))

;;replace all element
(define replaceAll
  (lambda (element value ls)
	(cond
	  [(null? ls) '()]
	  [(eq? element (car ls)) (cons value (replaceAll element value (cdr ls)))]
	  [else (cons (car ls) (replaceAll element value (cdr ls)))])))
;;relace all element=====>cps
(define replaceAll&co
  (lambda (element value ls co)
	(cond
	  [(null? ls) (co '())]
	  [(eq? element (car ls)) (replaceAll&co element value (cdr ls) (lambda (x) (co (cons value x))))]
	  [else (replaceAll&co element value (cdr ls) (lambda (x) (co (cons (car ls) x))))])))
;;caculate list length
(define list-length
  (lambda (ls)
	(cond
	  [(null? ls) 0]
	  [else (+ 1 (list-length (cdr ls)))])))
;;caculate list length=====>cps
(define list-length&co
  (lambda (ls co)
	(cond
	  [(null? ls) (co 0)]
	  [else (list-length&co (cdr ls) (lambda (x) (co (+ 1 x))))])))
