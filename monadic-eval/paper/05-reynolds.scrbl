#lang scribble/acmart @acmlarge
@(require "bib.rkt")

@title[#:tag "s:reynolds"]{Pushdown @emph{à la} Reynolds}

By combining the finite abstraction of base values and closures with the
termination-guaranteeing cache-based fixed-point algorithm, we have obtained a
terminating abstract interpreter.  But what kind of abstract interpretation did
we get?
We have followed the basic recipe of AAM, but adapted to a compositional
evaluator instead of an abstract machine.  However, we did manage to skip over
one of the key steps in the AAM method: we never store-allocated continuations.
@emph{In fact, there are no continuations at all!}

A traditional abstract machine formulation of the semantics would model the
object-level stack explicitly as an inductively defined data structure. Because
stacks may be arbitrarily large, they must be finitized like base values and
closures, and like closures, the AAM trick is to thread them through the store,
which itself must become finite. But in the definitional interpreter approach,
the story of this paper, the model of the stack is implicit and simply
inherited from the meta-language.

But here is the remarkable thing: since the stack is inherited from
the meta-language, the abstract interpreter inherits the ``call-return
matching'' of the meta-language, which is to say there is no loss of
precision of in the analysis of the control stack.  This is a property
that usually comes at considerable effort and engineering in the
formulations of higher-order flow analysis that model the stack
explicitly.  So-called higher-order ``pushdown'' analysis has been the
subject of multiple publications and two dissertations
@~cite["dvanhorn:Vardoulakis2011CFA2" "dvanhorn:Earl2010Pushdown"
"local:vardoulakis-diss12" "dvanhorn:VanHorn2012Systematic"
"dvanhorn:Earl2012Introspective" "dvanhorn:Johnson2014Abstracting"
"dvanhorn:Johnson2014Pushdown" "local:p4f" "local:earl-diss14"]. Yet when
formulated in the definitional interpreter style, the pushdown
property requires no mechanics and is simply inherited from the
meta-language.

Reynolds, in his celebrated paper @emph{Definitional Interpreters for
Higher-order Programming Languages} @~cite{dvanhorn:reynolds-acm72},
first observed that when the semantics of a programming language is
presented as a definitional interpreter, the defined language could
inherit semantic properties of the defining metalanguage.  We have now
shown this observation can be extended to @emph{abstract}
interpretation as well, namely in the important case of the pushdown
property.

In the remainder of this paper, we explore a few natural extensions and
variations on the basic pushdown abstract interpreter we have established up to
this point.
