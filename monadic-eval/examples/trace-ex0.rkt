#lang monadic-eval
(ListO@ monad-output@ alloc@ state@ δ@ ev-trace@ ev!@)
(fix (ev-trace ev!))

(add1 0)
((λ (n) (if0 n (add1 3) 8)) 0)
5
(+ 5 11)
(λ (x) x)
((λ (x) x) 5)
((λ (x) (λ (_) x)) 5)
(if0 0 7 8)
(if0 1 7 8)
((rec f (λ (x)
         (if0 x x
              (add1 (f (+ x -1))))))
 5)

