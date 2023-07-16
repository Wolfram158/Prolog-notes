min([A], X, Min) :- 
    A > X,
    Min is X,
    !.
min([A], X, Min) :-
    Min is A,
    !.
min([A, B | C], X, Min) :-
    A > X,
    min([B | C], X, Min),
    !.
min([A, B | C], X, Min) :-
    min([B | C], A, Min),
    !. 

remove([A | B], A, B) :- !.
remove([B | C], A, [M | N]) :- 
    A \= B,
    M is B,
    remove(C, A, N),
    !.

sort([], []) :- !.
sort([X], [X]) :- !.
sort([A | B], [T | R]) :-
    min([A | B], A, T),
    remove([A | B], T, New),
    sort(New, R),
    !.
