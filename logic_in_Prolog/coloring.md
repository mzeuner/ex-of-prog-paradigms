# Coloring Maps

The goal of this set of exercises is to write a Prolog program
that can color in maps. The four-color-theorem states that
*any* map can be colored with just four different colors:
https://en.wikipedia.org/wiki/Four_color_theorem

## Part I: Lists
Let's get started by writing some basic predicates on lists that
we can then use in the main program.

### Exercise 1 (🌶)
Write a binary predicate `member/2` representing membership in a list.
`member(X,XS)` should be true if and only if `X` is a member of the list `XS`.

### Exercise 2 (🌶🌶)
Write a binary predicate `remove_duplicates/2` such that
`remove_duplicates(XS,YS)` is true if and only if `XS`
has the same members as `YS` in the same order, but with every element only occurring once.

**Hint:** Use a cut `!`.

### Exercise 3 (🌶)
Write a ternary predicate `append/3` representing appending two lists.
`append(XS,YS,ZS)` should be true if and only if `ZS` is the result of appending
the lists `XS` and `YS`.

### Exercise 4 (🌶)
Write a binary predicate `join/2` representing joining all elements in a list of lists.
`join(XSS,YS)` should be true if and only if `YS` is the result of appending
all the lists in `XSS`.

### Exercise 5 (🌶🌶)
Write a binary predicate `reverse/2` representing reversing a list.
`reverse(XS,YS)` should be true if and only if `YS` is `XS` reversed.

There is another way of reversing lists, using a ternary predicate:
```prolog
%% reverse/3
reverse([X|Y],Z,W) :- reverse(Y,[X|Z],W).
reverse([],X,X).

%% reverse/2
reverse(X,Y) :- reverse(X,[],Y).
```
Explain why this works.

**Hint:** Visualize how `reverse/3` works with the help of *search trees*.



## Part II: Coloring
One common way to represent maps is to use *adjacency lists*.
To each country on the map we associate the list of
adjacent, i.e. neighboring, countries. In Prolog we can write the
adjacency list of Scandinavia as follows:

```prolog
scandinavia([["Sweden",["Norway","Finland"]],
	     ["Finland",["Russia","Norway","Sweden"]],
	     ["Norway",["Russia","Finland","Sweden"]],
	     ["Denmark",["Germany"]]
	    ]).
```

### Exercise 1 (🌶🌶)
Write a predicate `countries/2` that relates an adjacency list/map
with the list of occurring countries. In our example you could run

```prolog
testCountries(Y) :- scandinavia(X),countries(X,Y).
```

and get something like

```prolog
?- testCountries(Y).
Y = ["Denmark", "Germany", "Russia", "Sweden", "Norway", "Finland"].
```

### Exercise 2 (🌶)
Write a predicate `shareBorder/3` such that
`shareBorder(X,Y,Map)` is true if only if `X` is a member of `Y`'s adjacency
list in `Map` or vice versa. In our example you could run

```prolog
testShareBorder(Y) :- scandinavia(X),shareBorder("Sweden",Y,X).
```

and get something like

```prolog
?- testShareBorder(Y).
Y = "Norway" ;
Y = "Finland" ;
false.
```

### Exercise 3 (🌶)
Given a list of colors, e.g.
```prolog
colors(["blue","green","red","yellow"]).
```
a coloring is a list of country-color pairs, e.g. `[["Sweden","green"],["Norway","blue"]]`.

Write a predicate `conflict/2` such that
`conflict(Map,Coloring)` is true if and only if neighboring countries in the adjacency
list `Map` get assigned the same color in `Coloring`.
In our example you could run

```prolog
testConflict1 :- scandinavia(X),conflict(X,[["Sweden","green"],["Norway","blue"]]).
testConflict2 :- scandinavia(X),conflict(X,[["Sweden","green"],["Norway","green"]]).
```

and get something like

```prolog
?- testConflict1.
false.

?- testConflict2.
true .
```

### Exercise 4 (🌶🌶)
Write a predicate `allColored/3` such that
`allColored(Countries,Colors,Coloring)` is true if and only if
every member of the list `Countries` is paired with a member from `Colors`
in the coloring `Coloring`. In our example running the following should return true:

```prolog
testAllColored :- colors(X),allColored(["Sweden", "Norway"],X,[["Norway","green"],["Sweden","blue"]]).
```

### Exercise 5 (🌶🌶🌶)
Putting everything together, write a predicate `color/3` such that
`color(Map,Colors,Coloring)` is true if and only if the coloring `Coloring`
assigns each "country" in the adjacency list `Map` a color from `Color`
such that no conflict arises. In our example you could run

```prolog
testColor(Z) :- scandinavia(X),colors(Y),color(X,Y,Z).
```

and get something like

```prolog
?- testColor(Z).
Z = [["Denmark", "blue"], ["Germany", "green"], ["Russia", "blue"], ["Sweden", "blue"], ["Norway", "green"], ["Finland", "red"]] .
```

**Hint:** use `\+` for negation.