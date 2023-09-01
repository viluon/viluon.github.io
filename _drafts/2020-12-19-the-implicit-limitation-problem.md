---
layout: post
title: The Implicit Limitation Problem
---

> **Warning**: This glorified scrapbook of a post is still under heavy
> construction.

I've discovered an issue with conventional programming languages which, I
believe, runs deep in their theory and design. I call this "The Implicit
Limitation Problem," because it is a constraint on the generality of written
code implicit in the language itself.

## A tight coupling of semantics and evaluation

```haskell
fib : Int -> Int
fib 0 = 1
fib 1 = 1
fib n = fib (n - 1) + fib (n - 2)
```
When you define a function, in any of the programming languages we use today,
you implicitly specify the way to compute that function, whether you like it or
not.  Take the above definition of Fibonacci numbers. There may be a plethora of
ways to compute `fib 5`: you could interpret the definition you've given, you
could compile it to another language (such as x86 instructions) with or without
optimisations, those optimisations could add memoisation or significantly
transform the implementation, both interpretation and execution could be
parallelised, or even distributed over a network, you could compile the function
to compute shaders which you would then execute on a GPGPU, you could synthesise
hardware instructions that configure an FPGA to implement this function, etc.

However, in a conventional programming language, you don't have control over
such things. The best you can do is pass some oxygen (`-O2`) on the command line
to tell the black-box compiler to try harder to come up with something that
will, hopefully, run a little faster.  Needless to say, oxygen won't introduce
any parallelism or distribution or GPGPU programming or hardware synthesis, it
will just attempt a few transformations which you can't
specify[^enable-disable-but-not-add] guided by heuristics you don't even see and
give you an executable that's very difficult to analyse any further.

## Dependent type theory to the rescue
Some functional languages seem to do better. Dependent type systems let the
programmer use strong equational theories to reason about and transform
programs within the language itself. The flexibility of these approaches to
typing enables the expression of high level properties, such as invariants
maintained by complex data structures, and their automated verification. Such
innovations necessarily complicate the task of type inference, which is the
price to pay for the reification of advanced proofs within the language.

The expressiveness of dependent types makes many kinds of analysis first-class
citizens of the language. Take Kotlin's ["smart
casts,"](https://kotlinlang.org/docs/reference/typecasts.html#smart-casts) for
example:

<iframe style="width: 100%; border: none"
src="https://pl.kotl.in/P9mBHkIFO?theme=darcula&from=7&to=12"></iframe>

<noscript>

{% assign snippet = "(I understand you don't want to enable JS on every blog
you visit, so here's the code from Kotlin playground)
```kotlin
fun foo(str: String?) {
  println(when {
    str != null -> str.length
    else        -> 0
  })
}
```
" %}
{{ snippet | markdownify }}

</noscript>

Matching on the nullity of `str` safely casts the variable to a `String` in the
context of the corresponding `when` arm. Using `str.length` in any other
context of the function would raise a compile-time error: the compiler makes
sure that runtime `NullPointerException`s are impossible in pure Kotlin
code[^kotlin-npe]. Smart casts are an ergonomic feature, they silently work
around Java's need to explicitly cast variables even after inspecting their
runtime values with `instanceof`.

However, Kotlin is not a dependent language. The proof of `str != null` is not
first-class: you cannot pass it to a function, store it in a variable, or
inspect it in any way. The boolean value you get from the comparison loses the
relevant structure of a proof, the simple values of `true` and `false` no
longer relate `str` and `null`. Thus the analysis required for smart casts is
local in nature and internal to the compiler. Smart casts are a frequent but
special case of a much more general concept relevant to an infinitude of other
expressions that the Kotlin compiler does not recognise.

Dependent languages, on the other hand, understand the value of structure
better. Rather than magically adding structure to booleans, they typically
include special types which express equality. Idris has [the `=`
type](http://docs.idris-lang.org/en/latest/tutorial/theorems.html) for this
purpose, the values of which stand for actual proofs of equality and can be
treated like so. These reified proofs can be passed between functions,
destructured, combined with other proofs, and, perhaps most importantly, used
to rewrite terms.

```haskell

```

- maybe rewrite this and say it explores new ideas, then tie that with analysis
  and inference and synthesis, mention Idris 2

<!-- TODO -->

two sides of the same coin:
- analysis/inference derives high-level properties from concrete implementations
- synthesis derives concrete implementations from high-level properties

there are pros and cons to both:
- concrete implementations are tied to the host model of computation, which
  makes them actually runnable – you can invoke an implementation (perhaps after
  compiling it to some lower-level language) to evaluate the function at a given
  point
- but concrete implementations are difficult to reason about, and, as a result,
  difficult to optimise. When a programmer uses a function, they don't reason
  about its implementation, but about its interface. In _good_ languages, this
  interface is exactly the type of the function. Sadly, there are no good
  languages, though whether this is something the languages themselves should be
  blamed for is questionable.
- high-level properties are much easier to reason about – after all,
  propositions about programs are the sort of high-level properties I have in
  mind. However, these are difficult interpret. Even the simple example of
  defining `or : Bool -> Bool -> Bool` via identities `or True x = True` and `or
  False x = x` runs into the "issue" of parallel or.


okay, I thought about this a little more and I've come up with some other
things:
- the language should focus on abstraction, both in types and in values (MLs do
  a good job by equating LHS's and RHS's of functions)
- "straightforward" program synthesis, where there is exactly one way to
  synthesise a program/proof according to an interface (the type, really) in a
  given context (maybe the context alone is enough), _isn't an achievement_!
  You've already done all the work necessary to specify what exactly you mean,
  by the interface, that interface defines the set of possible implementations.
  If that set has exactly one element you shouldn't be required to spell it out!
  Of course, proofs of existence may be complicated, whether or not they are
  unique, but if they are unique, and the compiler can synthesise them, it
  shouldn't treat the surface language as a cache or memoisation table. The
  proof should only be shown to the programmer if they wish to see it.
- dependence on the judgments? the judgmental structure of a proof
- yeah, so this (the above point) is problematic. Maybe it's another "sad fact
  of life" that you need to depend on some structure in order to express
  anything (though I can imagine both scenarios in which this is trivially true
  and scenarios where this gets complicated), but anyway: if you assume
  Church-encoded naturals in an `add : Nat -> Nat -> Nat` you've tied the notion
  of addition to this structure. You can go on to prove commutativity,
  associativity, etc. of `add`, but changing the underlying structure of the
  numbers even with an isomorphism (such as to/from binary encodings) is
  _tricky_. Commutativity, associativity, etc of `add` on binary nats still
  hold, but they do so via something that's far from computationally efficient.
  These proofs depend on the structure of `add` judgements and transitively on
  the structure of `Nat` judgements (which are the numbers themselves), so they
  require conversion to this format before `add` can be applied (and the
  judgements for these properties don't actually change, they just include the
  conversion to Church numerals at the start and a conversion back at the end).
  However, there is _something_ about `add` that _doesn't care_ what underlying
  structure one uses for the numbers. This is not expressed in the type of
  `add`, it is perhaps expressed after the fact via these high-level properties,
  but those _unfortunately_ depend on the particular implementation of `add`.
  Thus there is _the essence of `add`_ which I don't know how to talk about.
  Dependency on implementations corresponds to dependency on judgements, which
  means this is a problem of the judgemental equational theory itself. Recall
  that the axiom of choice is independent of ZF set theory, but showing so
  requires some intellect: it is probably easier to assume the AoC in ZF proofs
  although it is not actually required. Thus this may be a sad fact of life...
  Or perhaps we need a new logic devoid of these problems...


<!-- except maybe for subsets of proof languages like Agda, since these languages still include ways to sidestep vital components of the compiler such as termination checking. -->



[^enable-disable-but-not-add]: While you can enable or disable the existing
    ones, you can't specify your own optimisations. If you want to add custom
    transformations to improve the efficiency of the optimiser, you have to fork
    and likely compile the entire compiler.

[^kotlin-npe]: … Assuming that any unsafe casts are correct, and there
    are probably other ways to break it (from my experience, it is not very
    difficult to confuse `kotlinc`). Additionally, Kotlin does contain an escape
    hatch for interacting with Java code, which can compromise null safety.
