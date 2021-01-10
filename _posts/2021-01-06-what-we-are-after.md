---
layout: post
title: What We Are After
---

Quadtrees, cellular automata, procedural abstraction, Solomonoff's theory of inductive inference, compression, intelligence.

I can't help but feel like these are all parts of the same running theme.

The recognition of complex patterns which form theories which in turn produce useful predictions in the form of probability distributions on future observations.

At a very simple, low level, the Standard Model of particle physics differentiates between 17 elementary particles, which obey clearly defined rules. The Standard Model is incomplete and possibly fundamentally flawed in many other ways (for example, it does not include gravity), but it still produces useful predictions about particle physics at small scales.

As we focus on "larger" phenomena, we come across other flawed and perhaps predictably wrong[^predictably-wrong] theories, such as Newton's laws of motion. Such theories work with rough approximations of the real world and produce even rougher estimates of future observations, made worse by their flawed internal understandings of spacetime. Yet, their approximations are still relevant, and the tradeoffs presented in terms of computational complexity and prediction accuracy often make them highly useful for real world reasoning.

What we seek is a law that transcends all others, a principle of abstraction abstracting abstraction, relevant at any scale, with arbitrary precision. It is not right to dismiss such quests handwavingly and assume such a law to be an unachievable ideal, much less to claim that no single law could have such properties. People criticising these pursuits do not comprehend the simple ideas of set union and intersection.

The statement "there can be no universal programming language," is simply wrong; there can be a universal programming language, but such a language would not look like what one would expect it to. If the possible syntaxes are too varied to yield a singular textual representation, then the language cannot be textual. If there are too many specific features to every programming language, then one needs to take the intersection of all of them, or a generalising principle that serves all their goals simultaneously, and include that above any specific machinery that conventional approaches admit.

Those same critics would not have a problem with the idea of a single person understanding every programming language or paradigm, and that person's ability to express a concept (a function, if you will) in all of them. Such facts speak to the existence[^mathematical-existence] of a unifying framework; a language should be a medium for conveying ideas first, and a tool for controlling computers second.

But I digress. What we seek is a unifying law, an automaton that could function as a quadtree rather than a grid – a self-similar hierarchical structure repeated an arbitrary number of times, each layer of the model corresponding to a layer of abstraction, driven ultimately by the laws governing the leaves, but with a logic that transcends levels and yields approximative rules for all higher levels all the way up to the root. Computations are only carried out to the depth required to reach a certain level of accuracy.

Such an automaton would exhibit an unprecedented level of similarity to biological life. (Literally) high-level goals would naturally require a degree of redundancy at levels farther from the root. The structures proliferating thanks to the rules relevant at their level of residence would have varied local goals guided by the high-level, global priorities of higher-level structures. Simple organisms known from automata such as the Game of Life would apppear at the leaf level as well, but would additionally give rise to patterns at higher levels, similarly to how unicellular life gives rise to multicellular organisms.

The unsolved problem here is not an approximative, hierarchical cellular automaton. The unsolved problem is one of scaling. The key feature of the proposed automaton is its ability to derive increasingly higher-level rules from base-level ones, a capability currently only possessed by a very peculiar type of computer, a human. I see this in mathematics, where capable individuals understand abstract objects which fit a wider range of scenarios while being shorter to define. I see this in engineering, where talented people need to form accurate models of many physical properties of components as they design them, and need to understand how these models fit together. I see this in chemistry, which describes rules for predicting the evolution of properties of collections of molecules over time without requiring precise and costly physics-based simulations.

Any cognitively demanding skill requires at least a drop of the human secret sauce: the decomposition of problems into subproblems and the recomposition of subsolutions into solutions. On one hand, the hierarchical cellular automaton derives rules in a bottom-up manner. On the other hand, we build and refine complex models based on our observations and use them to predict the future all the time. Humans did not wait for Newton to describe gravity to derive that if Greg jumps off a cliff, Greg falls. This kind of approximate, high-level reasoning that is so crucial for survival is inaccessible to computers. We begin our search for truth at some point in the hierarchy of abstraction most relevant to our own scale, and look in both directions. I have yet to discover a scheme which would enable computers to decompose problems which lack a structural definition (then again, I am no closer to coming up with an approach for the bottom-up rule derivation either).

## A use-case in game development
I have previously shared the following idea. Imagine a swarm of zombies in a video game driven by a collection of individual AI controllers which, in a context with other rules such as those given by a simple collision system, produces a fluid-like behaviour. If the high-level behavioural properties of the swarm can be approximated by a single AI controller for the whole collection, one can dynamically substitute this swarm controller and simulate the zombie agents based on its instructions whenever the computational complexity of individual simulations exceeds that of the swarm controller.

Such "approximate AI" could have many other uses as well, for instance, if accurate simulation of video game agents is necessary for an immersive experience, it can be used only while players are directly observing the agents. Simplified models can substitute this kind of simulation in other cases, such as when all players leave the relevant area, as long as their decisions are consistent with the precise AI controllers in the long-term. These considerations do not seem compelling for most games, although if suitable approximate AI controllers were developed, this approach could enable the simulation of much larger game worlds.

The hierarchical automaton would essentially construct the AI controller approximations automatically, simply by deriving higher-level rules from the base level ones.



[^predictably-wrong]: A predictable bias of a model or a theory can be corrected. Even though such straightforward corrections don't make the new model perfect, they do measurably improve accuracy, leaving unpredictable or unpredicted biases untouched.
[^mathematical-existence]: That is, existence in the mathematical sense, i.e. the opposite of impossibility. I am not aware of any precise definitions of the kind of mathematical object that I am describing.
