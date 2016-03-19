#lang racket/base

(define-syntax-rule (require-provide f ...)
  (begin
    (require f ...)
    (provide (all-from-out f ...))))

(require-provide
 ;; evals
 "evals/eval-dead.rkt"
 "evals/eval-coind.rkt"

 ;; open evs
 "evs/ev.rkt"
 "evs/ev-bang.rkt"

 ;; ext envs
 "evs/ev-ref.rkt"
 "evs/ev-gc.rkt"
 "evs/ev-echo.rkt"
 "evs/ev-cycle.rkt"
 "evs/ev-dead.rkt"
 "evs/ev-reach.rkt"
 "evs/ev-symbolic.rkt"
 "evs/ev-trace.rkt"
 "evs/ev-cache.rkt"
 "evs/ev-cache0.rkt"
 "evs/ev-compile.rkt"
 "evs/ev-debug.rkt"

 ;; monads
 "monad/monad-by-hand.rkt"
 "monad/monad.rkt"
 "monad/monad-alt.rkt"
 "monad/monad-cycle.rkt"
 "monad/monad-dead.rkt"
 "monad/monad-output.rkt"
 "monad/monad-nd.rkt"
 "monad/monad-trace-nd.rkt"
 "monad/monad-cache.rkt"
 "monad/monad-grabbag.rkt"
 "monad/monad-pdcfa.rkt"
 "monad/monad-pdcfa-show-store.rkt"
 "monad/monad-pdcfa-gc.rkt"
 "monad/monad-pdcfa-widen.rkt"
 "monad/monad-symbolic.rkt"

 ;; alloc
 "metafuns/alloc.rkt"
 "metafuns/alloc-bang.rkt"
 "metafuns/alloc-0cfa.rkt"
 "metafuns/alloc-x.rkt"

 ;; state
 "metafuns/state.rkt"
 "metafuns/state-crush.rkt"
 "metafuns/state-nd.rkt"

 ;; δ
 "metafuns/delta.rkt"
 "metafuns/delta-pres.rkt"
 "metafuns/delta-symbolic.rkt"
 "metafuns/delta-abs.rkt"

 ;; monoids
 "transformers.rkt"
 )