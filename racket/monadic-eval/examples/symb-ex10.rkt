#lang monadic-eval
(ev-base@ monad-symbolic@ alloc-con@ delta-symbolic@ ev-symbolic@)
(fix (ev-symbolic ev))

(! ((ref 5) := 7))