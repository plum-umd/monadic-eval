#lang monadic-eval
(ev-base@ ev-dead@ eval-dead@ monad-dead@ alloc-con@ delta-con@)
(eval-dead (fix (ev-dead ev)))

(rec f (λ (x)
         (if0 x x
              (add1 (f (+ x -1)))))
     (f 5))