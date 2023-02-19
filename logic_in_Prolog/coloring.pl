:- include(lists).

%% Coloring a map
%% countries/2 gathers first components of "adjacency lists of countries"
countries([],[]).
countries([[C,N]|Map],X) :- countries(Map,Y), append(Y,[C|N],Z),
			    remove_duplicates(Z,X),!.

shareBorder(X,Y,Map) :- member([X,Z],Map) ,!, member(Y,Z);
		        member([Y,Z],Map) ,!, member(X,Z).

conflict(Map,Coloring) :-
    member([X,C],Coloring),
    member([Y,C],Coloring),
    shareBorder(X,Y,Map).

allColoredOrdered([],_,[]).
allColoredOrdered([C|Countries],Colors,[[C,F]|Coloring]) :-
    member(F,Colors),
    allColoredOrdered(Countries,Colors,Coloring).

allColored(Countries,Colors,Coloring) :-
    permutation(Countries,X),
    allColoredOrdered(X,Colors,Coloring).

color(Map,Colors,Coloring) :-
    countries(Map,Countries),
    allColored(Countries,Colors,Coloring),
    \+ conflict(Map,Coloring).


%% tests
scandinavia([["Sweden",["Norway","Finland"]],
	     ["Finland",["Russia","Norway","Sweden"]],
	     ["Norway",["Russia","Finland","Sweden"]],
	     ["Denmark",["Germany"]]
	    ]).

colors(["blue","green","red","yellow"]).

testCountries(Y) :- scandinavia(X),countries(X,Y).

testShareBorder(Y) :- scandinavia(X),shareBorder("Sweden",Y,X).

testConflict1 :- scandinavia(X),conflict(X,[["Sweden","green"],["Norway","blue"]]).
testConflict2 :- scandinavia(X),conflict(X,[["Sweden","green"],["Norway","green"]]).

testAllColored :- colors(X),allColored(["Sweden", "Norway"],X,[["Norway","green"],["Sweden","blue"]]).

testColor(Z) :- scandinavia(X),colors(Y),color(X,Y,Z).
