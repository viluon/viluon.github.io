

We have to express human concepts in code if we want machines to take over the tasks that only humans can do today.

- model the human mind
	- a close-enough approximation to be useful to user interface design
- we have to express high-level concepts like "making the user happy" or "making the user think this system is helpful"
- we need these very high-level goals to understand
	- why do users use the system
	- what do users want from an interface
		- could be information, could be side-effects
		- often they understand the system as a tool which helps achieve an external high-level goal
- if the user thinks about economics while using the system ("it is my duty as this system's administrator to monitor its performance, otherwise I won't get paid") then we should have an encoding for the concept of economics
- captcha is a (sub)system for verifying that assumptions about the model of a user can be made safely
	- more generally: assign to each model for every user at any point in time a probability with which the model's predictions can be trusted
		- do not forget to express an "unknown" models -- new
- (also consider parsing and pretty-printing as a one-way isomorphism on models (ASTs or whatever))

Coming up with a framework for _thinking_ about systems is difficult. Advancements made so far:
- it's probably better to replace the term "system" with "agent" or "actor," as "system" implies something non-biological
- interfaces are really actors facilitating the communication between other actors
- MVC (model-view-controller) is a decent framework for talking about side-effects, which are central to understanding actors and their interactions
	- the _model_ is the memory of an actor
	- the _controller_ interprets incoming side-effects as changes to the model
	- the _view_ effects side-effects on other actors by reading the model
- however, we'd like to assign another meaning to the term _model_, closer in spirit to _modelling_, which really ought to represent correlation between some area of the memory, the controller, and the view of one actor and the the memory, the controller, and the view of another actor
- specifically we want to _model another actor $B$_ using the MVC of actor $A$, which means dedicating some parts of $A$'s MVC to the interpretation of $B$'s side-effects and the prediction of $B$'s future side-effects. This subset of $A$'s MVC is _$A$'s model of $B$_
	- a good model of $B$ is able to predict $B$'s actions -- side-effects -- with high accuracy/probability
	- to do so, it must take into account past evidence of $B$'s side-effects, which implies dedicating some part of the memory and of the controller to this task
	- if these changes to the memory and the controller of $A$ don't influence the relationship between incoming and outgoing side-effects, $A$ is semantically equivalent to a simpler version without the changes required to model $B$. Thus, $A$'s view must also reflect $B$'s actions (incoming side-effects from $B$)
	- this implies that if any of $A$'s M, V, C tries to model $B$, the other two components must also put positive "effort" into modelling $B$, otherwise these attempts are irrelevant
	- $A$'s model of $B$ creates a causal relationship between the two actors -- the outgoing side-effects from $A$ are no longer independent of $B$'s outgoing side-effects
- actors can model other actors via composition of actors -- the relationship between a human and the universe can be expressed as the relationship between two actors $H$ and $U$, where $H$'s model of $U$ involves the composition of many actors, including the actors $H_1, H_2, \ldots$ representing other humans
	- note that the inner structure of $U$ is irrelevant, and actually unknown -- in this way the framework resembles a category in category theory and actors resemble category-theoretical objects. If an actor $A$ "wants to" observe a side-effect $E$ from $U$, it should choose a strategy maximising the expected probability of $E$
	- **TODO**: we'd like to make a case for the hypothesis that a strategy (a plan to effect side-effects) of $A$ which tries to make $U$ effect $E$ on $A$ is in some sense inferior to a strategy of $A'$ which tries to make $U$ effect $E$ on $A'$ if $A'$ has a model of $U$ but $A$ does not
		- naturally it is not enough to distinguish between having and not having a model, we need a way to order models as well, probably by accuracy and complexity (a simple accurate model is better than a complex accurate one, an accurate model is better than an inaccurate one)
- it would probably be better to call "incoming side-effects" "observations" and "outgoing side-effects" simply "effects"
- it is also desirable to change the nomenclature once again and replace the term "actor" with "agent," which is a term in decision theory, game theory, and artificial intelligence
- it's important to realise that the capabilities of a controller filter the observations -- the universe can shoot gamma rays at the retina of a human eye but the retina is unable to sense them, thus a human cannot directly observe gamma rays
- similarly, the capabilities of a view _define_ the effects the agent is capable of producing
- armed with this knowledge, let's refine the framework once again


An **agent** is an ordered 6-tuple $(O, a, S, s_0, e, E)$ where
- $O$ is a set of _observations_
- $a : M \times O \to M$ is a _sensor_
- $S$ is a set of _states_
- $s_0 \in S$ is the _initial state_
- $e : M \to E$ is an _effector_
- $E$ is a set of _effects_
