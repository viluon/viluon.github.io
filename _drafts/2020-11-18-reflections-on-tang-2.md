---
layout: post
title: Reflections on Tang N°2
---

I am once again getting some ideas, which, as we all know, is dangerous.

The core representation must be orthogonal both to the frontend and to the backend. I knew this before, but I didn't fully comprehend the implications of the latter, and I'm sure I still don't thoroughly understand them now. An important realisation is that the backend _defines_ the complexity analysis we can do with the representation. In a way, _complexity analysis has nothing to do with evaluation_, or, at the very least, it has little in common with the internal representation itself (come to think of it, it's probably the internal representation that has nothing to do with evaluation. Huh). This renders the naive approach to encoding complexity bounds as types invalid: there is no single complexity bound one can assign to a function (or so I think) to express its running time as a function of the size (for some definition of "size") of the input. In fact, without knowing _all the possible computation models_ the function can be evaluated with in advance, one can't even describe the set of all possible complexities the function could have (or at least limit it to something that doesn't include all functions).

This is an important realisation. I knew we'll need "frontend metadata" to keep track of evaluation-independent information that is relevant to the humans actually writing Tang code. Now, not only does the backend require metadata as well (in order to support _at least_ some form of complexity analysis[^1]), but, as it turns out, the intermediate representation is orthogonal to evaluation! A deeply troubling result, for sure.

It's funny how a new realisation which invalidates previous assumptions serves as a garbage collection cycle for ideas, but it's not funny that I'm now, in a sense, even further away from a rigorous description of what the internal representation actually is. It is high time I looked for previous results in... wait, what is this field even called? Crap...

> Does learning the law prevent you from being a criminal?
> Formally manipulating logical theories isn't synonymous with living by them. I'm confident that Caroline/CKG can become a capable metatheory _and_ an autonomous agent for developing and reasoning about any kind of science, without fear of running into major contradictions.[^2]
>
> ~ my humble self

Anyway, this is actually also related to the topic of "encodings" which I believe I haven't written about, although I've been thinking about them for quite some time now. The idea is that Tang should treat isomorphic types / structures / whatever identically (seamlessly convert between isomorphic concepts). I'm not sure to what extent this should be visible in the frontends, what parts of it should really be automatic, and what parts should require deliberate intervention, but the idea is that since optimisations are really transformations of the core representation, which are really equivalences between terms, the compiler shouldn't be a black box which just applies hardcoded transformations in a hardly predictable manner, but rather a tool that applies user-supplied equivalence relations to the code.

For example, if there's a Church encoding of natural numbers and a binary encoding of naturals (or really of any type that is structured the way Church numbers are), the compiler should pick the one with better complexity qualities when compiling code for a specific evaluator (the knowledge of the evaluation model and its complexity properties is crucial, see above). Conventional compilers use hardcoded rules or perhaps special annotations which specify the encoding used for an entire type. This is limiting, however, as several encodings may be desirable in various scenarios. The same goes for functions; various implementations, related by the user- or standard library-provided equivalences on terms, may be chosen in a single project. Different callsites can invoke different function implementations based not only on the circumstances at the callsite, but on the runtime state as well. Indeed, JITs do this with deoptimisation in response to a change in workload, but they don't do this in general or to the extent Tang aims to.

The view on optimisations as relations on terms seemingly permits an almost computable approach: when compiling a term for an evaluator, sort all the terms a term is related to by their complexity and pick the least complex one. The set of terms that a term is related to is, however, likely infinite. Moreover, there may not exist a single best choice of a complexity measure – even the conventional Turing machines have time _and space_ complexity. For the choice of built-in integer arithmetic over Church encodings, however, one can observe a dramatic improvement in both complexity measures (even when overflows and underflows are closely monitored).

[^1]: … Which is required for optimisations, by the way.
[^2]: What exactly are _minor_ contradictions, you idiot?
