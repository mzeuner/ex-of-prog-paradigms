:- include(lists).

%% Coloring a map
countries(Map,X) :- join(Map,Y), remove_duplicates(Y,X).

share_border(X,Y,Map) :- member([X,Y],Map) ; member([Y,X],Map).

conflict(Map,Coloring) :-
    member([X,C],Coloring),
    member([Y,C],Coloring),
    share_border(X,Y,Map).

all_colored_ordered([],_,[]).
all_colored_ordered([C|Countries],Colors,[[C,F]|Coloring]) :-
    member(F,Colors),
    all_colored_ordered(Countries,Colors,Coloring).

all_colored([],_,[]).
all_colored(Countries,Colors,Coloring) :-
    permutation(Countries,X),
    all_colored_ordered(X,Colors,Coloring).


color(Map,Colors,Coloring) :-
    countries(Map,Countries),
    all_colored(Countries,Colors,Coloring),
    \+ conflict(Map,Coloring).

%% running:
%% ?- color([["Sweden","Norway"],["Norway","Finland"],["Finland","Sweden"]],["yellow","blue","red"],X).
%% gives: X = [["Norway", "yellow"], ["Finland", "blue"], ["Sweden", "red"]] .
