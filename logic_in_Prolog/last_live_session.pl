%% member/2: member(X,Y) = X är element av lista Y
member(X,[X|_]).
member(X,[_|R]) :- member(X,R),!.

%% remove_duplicates/2: remove_duplicates(X,Y) = Y har varje element
%% av X men bara en gang
remove_duplicates([X|R],Y) :- member(X,R), remove_duplicates(R,Y).
remove_duplicates([X|R1],[X|R2]) :- remove_duplicates(R1,R2).
remove_duplicates([],[]).

%% append/3: append(X,Y,Z) = Z är X++Y
append([],Y,Y).
append([X|R],Y,[X|Z]) :- append(R,Y,Z).

%% join/2: join(X,Y) = Y är resultat av appender alla listor i X
join([],[]).
join([X|R],Y) :- join(R,Z), append(X,Z,Y).

%% ger en lista av alla länder i kartan X
regions(X,Y) :- join(X,Z), remove_duplicates(Z,Y).

%% X och Y är elementer i en lista av 2-element-listor R
share_border(X,Y,R) :- member([X,Y],R) ; member([Y,X],R).

all_colored_ordered([],_,[]).
all_colored_ordered([C|Countries],Colors,[[C,F]|Coloring]) :-
    member(F,Colors),
    all_colored_ordered(Countries,Colors,Coloring).

all_colored([],_,[]).
all_colored(Countries,Colors,Coloring) :-
    permutation(Countries,X),
    all_colored_ordered(X,Colors,Coloring).


conflict([[X,Y]|_],Coloring) :- %%[X,F] och [Y,F] finns i Coloring (för samma F)
    member([X,F],Coloring),
    member([Y,F],Coloring).
conflict([_|R],Coloring) :- conflict(R,Coloring).

color(Map,Colors,Coloring) :-
    regions(Map,Countries),
    all_colored(Countries,Colors,Coloring),
    \+ conflict(Map,Coloring).
