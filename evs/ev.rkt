#lang racket/unit
(require racket/match
         "../transformers.rkt"
         "../syntax.rkt"
         "../signatures.rkt")

(import monad^ menv^ state^ δ^ alloc^)
(export ev^)
(init-depend monad^)

(define-monad M)

(define ((ev ev) e)
  (match e
    [(vbl x)
     (do ρ ← ask-env
         (find (ρ x)))]
    
    [(num n) (return n)]
    
    [(ifz e₀ e₁ e₂)
     (do v ← (ev e₀)
         b ← (truish? v)
         (ev (if b e₁ e₂)))]

    [(op1 o e0)
     (do v ← (ev e0)
         (δ o v))]
    
    [(op2 o e₀ e₁)
     (do v₀ ← (ev e₀)
         v₁ ← (ev e₁)
         (δ o v₀ v₁))]

    [(lrc f e₀ e₁) 
     (do ρ  ← ask-env
         a  ← (alloc f)
         (ext a (cons e₀ (ρ f a)))
         (local-env (ρ f a) (ev e₁)))]

    [(lam x e₀)
     (do ρ ← ask-env
       (return (cons (lam x e₀) ρ)))]

    [(app e₀ e₁)
     (do (cons (lam x e₂) ρ) ← (ev e₀)
         v₁ ← (ev e₁)
         a  ← (alloc x)        
         (ext a v₁)
         (local-env (ρ x a) (ev e₂)))]

    ['err fail]))