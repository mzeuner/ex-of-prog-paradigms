

member(X,[X|_]).
member(X,[_|R]) :- member(X,R).

remove_duplicates([],[]).
remove_duplicates([X|Y],Z) :- member(X,Y), remove_duplicates(Y,Z), !.
remove_duplicates([X|Y],[X|Z]) :- remove_duplicates(Y,Z).

%% append/3: las argument is the result of appending
%% the first two lists
append([],X,X).
append([X|Y],Z,[X|W]) :- append(Y,Z,W).

reverse([],[]).
reverse([X|Y],Z) :- reverse(Y,W), append(W,[X],Z).

%% Some Prolog magic:
reverse2([X|Y],Z,W) :- reverse2(Y,[X|Z],W).
reverse2([],X,X).

reverse2(X,Y) :- reverse2(X,[],Y).



%% Coloring a map
flatten_map([[X,Y]|Z],W) :- append([X,Y],U,W), flatten_map(Z,U).
flatten_map([],[]).

countries(Map,X) :- flatten_map(Map,Y), remove_duplicates(Y,X).

share_border(X,Y,Map) :- member([X,Y],Map) ; member([Y,X],Map).

conflict(Map,Coloring) :-
    member([X,C],Coloring),
    member([Y,C],Coloring),
    share_border(X,Y,Map).

all_colored([Country|Countries],Colors,[[Country,Color]|Coloring]) :-
    member(Color,Colors),
    all_colored(Countries,Colors,Coloring).
all_colored([],_,[]).

color(Map,Colors,Coloring) :-
    countries(Map,Countries),
    all_colored(Countries,Colors,Coloring),
    \+ conflict(Map,Coloring).

%% running:
%% ?- color([["Sweden","Norway"],["Norway","Finland"],["Finland","Sweden"]],["yellow","blue","red"],X).
%% gives: X = [["Norway", "yellow"], ["Finland", "blue"], ["Sweden", "red"]] .
