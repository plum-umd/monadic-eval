#lang scribble/manual
@(require scriblib/figure
	  "evals.rkt"
	  scribble/eval)

@title{An Alternative Abstraction}

@figure["pres-delta" "An alternative abstraction for precise primitives"]{
@filebox[@racket[precise-δ@]]{
@racketblock[
(define (δ . ovs)
  (match ovs
    [`(add1 ,(? number? n))  (_return (add1 n))]
    [`(sub1 ,(? number? n))  (_return (sub1 n))]
    [`(-    ,(? number? n))  (_return (- n))]
    [`(+    ,(? number? n₁)
            ,(? number? n₂)) (_return (+ n₁ n₂))]
    [`(-    ,(? number? n₁)
            ,(? number? n₂)) (_return (- n₁ n₂))]
    [`(*    ,(? number? n₁)
            ,(? number? n₂)) (_return (* n₁ n₂))]
    [`(quotient ,(? number? n₁) ,(? number? n₂))
     (if (= 0 n₂)
         _fail
         (_return (quotient n₁ n₂)))]
    [`(add1 ,_) (_return 'N)]
    [`(sub1 ,_) (_return 'N)]
    [`(+ ,_ ,_) (_return 'N)]
    [`(- ,_ ,_) (_return 'N)]
    [`(* ,_ ,_) (_return 'N)]
    [`(quotient ,_ ,(? number? n₂))
     (if (= 0 n₂) _fail (_return 'N))]
    [`(quotient ,_ ,_)
     (_mplus (_return 'N) _fail)]))

(define (zero? v)
  (match v
    ['N (_mplus (_return #t) (_return #f))]
    [_  (_return (zero? v))]))
]}
@filebox[@racket[store-crush@]]{
@racketblock[
(define (find a)
  (do σ ← _get-store
      (for/monad+ ([v (σ a)])
        (_return v))))

(define (number*? n) (or (eq? 'N n) (number? n)))

(define (crush v vs)
  (if (number*? v)
      (set-add 
        (for/set ([v* vs] 
                  #:when (not (number*? v*))) 
          v*) 
        'N)
      (set-add vs v)))

(define (ext a v)
  (update-store
   (λ (σ)
     (if (∈ a σ)
         (σ a (crush v (σ a)))
         (σ a (set v))))))
]}}

In this section, we demonstrate how easy it is to experiment with
alternative abstraction strategies by swapping out components.  In
particular we look at an alternative abstraction of the interpretation
of primitive operations and store joins.

@Figure-ref{pres-delta} defines two new components:
@racket[precise-δ@] and @racket[store-crush@].  The first is yet
another interpretation of the primitive operations.  The
distinguishing feature of this varaint of @racket[δ] is that it is
@emph{precision preserving}.  Unlike @racket[δ^@], it does not
introduce abstraction, it merely propagates it.  So if you add two
concrete numbers together, you will get a concrete number.  But if you
add a concrete and abstract number, you will get an abstract number.

This interpretation of primitive operations clearly doesn't impose a
finite abstraction on it's own.  And if used in concert with the
@racket[store-nd@] implementation of the store, termination is not
guaranteed.  

The @racket[store-crush@] implementation of the store is designed to
work with the precise version of @racket[δ] by having a different
strategy for joining values into the store.  Using the precise
@racket[δ] and the standard store implementation, it's possible that
an infinite number of base values could be written into a single store
set.  What @racket[store-crush@] does is widen base values to
@racket['N] whevener there are multiple concrete numbers in a store
location.  Used together, it should be clear that termination is
ensured since there's no way to write an infinite set of values in a
store location (and there are still a finite number of addresses due
to @racket[alloc^]).  While still decidable, this abstraction offers a
high-level of precision.  For example, ``straight-line'' arithmetic
operations are computed with full precision:
@interaction[#:eval the-alt-eval
(* (+ 3 4) 9)
]
Even linear binding and arithmetic preserves precision:
@interaction[#:eval the-alt-eval
((λ (x) (* x x)) 5)
]
It's only when the approximation of binding structure comes in to
contact with base values that we see a loss in precision:
@interaction[#:eval the-alt-eval
(let f (λ (x) x)
  (* (f 5) (f 5)))]

If this sets off worries about non-termination, try to construct a
program that computes an infinite set of numbers with a finite number
of variable bindings over the life of the program.  Hint: you won't be
able to.  (This last example suggests an easy refinement to the
@racket[store-crush@] strategy: only widen when @emph{different} base
values are written to a shared location.  We leave this as an easy
exercise for the reader.)

Here we see one of the strengths of our approach.  This strategy
appears quite natural, and to the best of our knowledge, is novel.
It's hard to imagine how it could be formulated as, say, a
constraint-based flow analysis.