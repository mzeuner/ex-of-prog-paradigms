
%% member/2: member(X,Y) = X är element av lista Y
member(X,[X|_]).
member(X,[_|R]) :- member(X,R).

%% remove_duplicates/2: remove_duplicates(X,Y) = Y har varje element
%% av X men bara en gang
remove_duplicates([X|R],Y) :- member(X,R), remove_duplicates(R,Y).
remove_duplicates([X|R1],[X|R2]) :- remove_duplicates(R1,R2).
remove_duplicates([],[]).

%% append/3: append(X,Y,Z) = Z är X++Y
append([],Y,Y).
append([X|R],Y,[X|Z]) :- append(R,Y,Z).

%% reverse/2: reverse(X,Y) = Y är X reverserad
reverse([],[]).
reverse([X|R],Y) :- reverse(R,Z), append(Z,[X],Y).

my_reverse([X|R],Y,Z) :- my_reverse(R,[X|Y],Z).
my_reverse([],X,X).

my_reverse(X,Y) :- my_reverse(X,[],Y).

%% join/2: join(X,Y) = Y är resultat av appender alla listor i X
join([],[]).
join([X|R],Y) :- join(R,Z), append(X,Z,Y).

regions(X,Y) :- join(X,Z), remove_duplicates(Z,Y).

share_border(X,Y,R) :- member([X,Y],R) ; member([Y,X],R).
%% X och Y är elementer i en lista av 2-element-listor R
