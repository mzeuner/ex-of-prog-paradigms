%% operations on lists

member(X,[X|_]).
member(X,[_|R]) :- member(X,R).

remove_duplicates([],[]).
remove_duplicates([X|Y],Z) :- member(X,Y), remove_duplicates(Y,Z), !.
remove_duplicates([X|Y],[X|Z]) :- remove_duplicates(Y,Z).

%% the first two lists
append([],X,X).
append([X|Y],Z,[X|W]) :- append(Y,Z,W).

reverse([],[]).
reverse([X|Y],Z) :- reverse(Y,W), append(W,[X],Z).

%% Some Prolog magic:
reverse2([X|Y],Z,W) :- reverse2(Y,[X|Z],W).
reverse2([],X,X).

reverse2(X,Y) :- reverse2(X,[],Y).

%% join/2 : join(X,Y) = Y is the result of appending all lists in X
join([],[]).
join([X|R],Y) :- join(R,Z), append(X,Z,Y).

