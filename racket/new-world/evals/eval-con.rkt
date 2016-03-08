#lang racket
(provide eval)
(require "../monad/concrete.rkt"
         "../units/alloc-nat.rkt"
         "../units/delta-con.rkt"
         "../units/ev-base.rkt"
         "../units/oev-id.rkt"
         "../units/ref-explicit.rkt"
         "../units/st-explicit.rkt"
         "../fix.rkt")

(define-values/invoke-unit/infer
  (link alloc-nat@
        concrete@
        delta-con@
        ev-base@
        oev-id@
        ref-explicit@
        st-explicit@))

;; eval : e → (cons v σ)
(define (eval e)
  (mrun ((fix (oev ev)) e)))