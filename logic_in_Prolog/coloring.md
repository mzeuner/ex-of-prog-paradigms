# Coloring Maps

The goal of this set of exercises is to write a Prolog program
that can color in maps. The four-color-theorem states that
*any* map can be colored with just four different colors:
https://en.wikipedia.org/wiki/Four_color_theorem

## Part I: Lists
Let's get started by writing some basic predicates on lists that
we can then use in the main program.

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