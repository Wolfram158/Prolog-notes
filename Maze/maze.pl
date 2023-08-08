first_step([], []) :- !.
first_step([A | B], [C | D]) :-
    atom_chars(A, A1),
    C = A1,
    first_step(B, D),
    !.

find(List, V, Target, Cur, Cur) :-
    V is Target,
    !.
find(List, V, Target, Cur, Res) :-
    member((V, X), List),
    \+ member((V, X), Cur),
    \+ member((X, V), Cur),
    append(Cur, [(V, X)], Cur1),
    find(List, X, Target, Cur1, Res).

listOfFree([], I, J, Hor, Cur, Cur) :- !.
listOfFree([[] | B], I, J, Hor, Cur, Res) :-
    J1 is J + 1,
    listOfFree(B, 1, J1, Hor, Cur, Res),
    !.
listOfFree([[F | G] | B], I, J, Hor, Cur, Res) :-
    F = '.',
    Calc is J - 1,
    Cell is Calc * Hor + I,
    append(Cur, [Cell], Cur1),
    I1 is I + 1,
    listOfFree([G | B], I1, J, Hor, Cur1, Res),
    !.
listOfFree([[F | G] | B], I, J, Hor, Cur, Res) :-
    I1 is I + 1,
    listOfFree([G | B], I1, J, Hor, Cur, Res),
    !.

edges(Free, Hor, Edge) :-
    member(X, Free),
    X1 is X - 1,
    member(X1, Free),
    (Edge = (X, X1) ; Edge = (X1, X)).
edges(Free, Hor, Edge) :-
    member(X, Free),
    X1 is X + 1,
    member(X1, Free),
    (Edge = (X, X1) ; Edge = (X1, X)).
edges(Free, Hor, Edge) :-
    member(X, Free),
    X1 is X - Hor,
    member(X1, Free),
    (Edge = (X, X1) ; Edge = (X1, X)).
edges(Free, Hor, Edge) :-
    member(X, Free),
    X1 is X + Hor,
    member(X1, Free),
    (Edge = (X, X1) ; Edge = (X1, X)).

unique_edges([], Cur, Cur) :- !.
unique_edges([A | B], Cur, Res) :-
    \+ member(A, Cur),
    append(Cur, [A], Cur1),
    unique_edges(B, Cur1, Res),
    !.
unique_edges([A | B], Cur, Res) :-
    unique_edges(B, Cur, Res),
    !.    

almost1_solve(List, Answer) :-
    first_step(List, [A | B]),
    length(A, Length1),
    listOfFree([A | B], 1, 1, Length1, [], Free),
    findall(Edge, edges(Free, Length1, Edge), X),
    unique_edges(X, [], Unique),
    length([A | B], Length2),
    Target is Length1 * Length2,
    find(Unique, 1, Target, [], Answer).

min_list([], CurLength, CurList, CurLength, CurList) :- !.
min_list([A | B], CurLength, CurList, ResLength, ResList) :-
    length(A, Length1),
    Length1 < CurLength,
    min_list(B, Length1, A, ResLength, ResList),
    !.
min_list([A | B], CurLength, CurList, ResLength, ResList) :-
    min_list(B, CurLength, CurList, ResLength, ResList),
    !.

almost2_solve(List, ResLength, ResList) :-
    findall(Res, almost1_solve(List, Res), X),
    min_list(X, 999999, [], ResLength, ResList),
    !.
