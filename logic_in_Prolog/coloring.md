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
has the same members as `YS` in the same order, but with every element only occuring once.

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

### Exercise 1
Write a predicate `countries/2` that relates an adjacency list/map
with the list of occurring countries. In our example you should get
something like

```prolog
?- scandinavia(X),countries(X,Y).
X = [["Sweden", ["Norway", "Finland"]], ["Finland", ["Russia", "Norway", "Sweden"]], ["Norway", ["Russia", "Finland", "Sweden"]], ["Denmark", ["Germany"]]],
Y = ["Denmark", "Germany", "Russia", "Sweden", "Norway", "Finland"].
```