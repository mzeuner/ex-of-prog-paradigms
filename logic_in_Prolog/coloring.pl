:- include(lists).

%% Coloring a map
%% countries/2 gathers first components of "adjacency lists of countries"
countries([],[]).
countries([[C,N]|Map],X) :- countries(Map,Y), append(Y,[C|N],Z),
			    remove_duplicates(Z,X),!.

share_border(X,Y,Map) :- member([X,Z],Map) , member(Y,Z);
		         member([Y,Z],Map) , member(X,Z).

conflict(Map,Coloring) :-
    member([X,C],Coloring),
    member([Y,C],Coloring),
    share_border(X,Y,Map).

all_colored([],_,[]).
all_colored([C|Countries],Colors,[[C,F]|Coloring]) :-
    member(F,Colors),
    all_colored(Countries,Colors,Coloring).

color(Map,Colors,Coloring) :-
    countries(Map,Countries),
    all_colored(Countries,Colors,Coloring),
    \+ conflict(Map,Coloring).


%% tests
scandinavia([["Sweden",["Norway","Finland"]],
	     ["Finland",["Russia","Norway","Sweden"]],
	     ["Norway",["Russia","Finland","Sweden"]],
	     ["Denmark",["Germany"]]
	    ]).

colors(["blue","green","red","yellow"]).

test(Z) :- scandinavia(X),colors(Y),color(X,Y,Z).
