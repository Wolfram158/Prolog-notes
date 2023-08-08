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

rem(X, Y, Rem) :-
    Rem is X mod Y,
    !.

edges(Free, Hor, Edge) :-
    member(X, Free),
    X1 is X - 1,
    rem(X, Hor, Rem),
    Rem > 1,
    member(X1, Free),
    (Edge = (X, X1) ; Edge = (X1, X)).
edges(Free, Hor, Edge) :-
    member(X, Free),
    X1 is X + 1,
    rem(X, Hor, Rem),
    Rem > 0,
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

used_cells([], Cur, Cur) :- !.
used_cells([(X, Y) | B], Cur, Res) :-
    \+ member(X, Cur),
    append(Cur, [X], Cur1),
    (\+ member(Y, Cur) -> append(Cur1, [Y], Cur2), used_cells(B, Cur2, Res) ; used_cells(B, Cur1, Res)),
    !.
used_cells([(X, Y) | B], Cur, Res) :-
    \+ member(Y, Cur),
    append(Cur, [Y], Cur1),
    used_cells(B, Cur1, Res),
    !.

get_vertices([], Cur, Hor, Cur) :- !.
get_vertices([X | B], Cur, Hor, Vertices) :-
    \+ member(X, Cur),
    Div is ceiling(X / Hor),
    Rem is X - (Div - 1) * Hor,
    append(Cur, [(Rem, Div)], Cur1),
    get_vertices(B, Cur1, Hor, Vertices),
    !.

print_answer([], Vertices, I, J) :- !.
print_answer([[] | B], Vertices, I, J) :-
    nl,
    J1 is J + 1,
    print_answer(B, Vertices, 1, J1),
    !.
print_answer([[F | G] | B], Vertices, I, J) :-
    \+ member((I, J), Vertices),
    write(F),
    I1 is I + 1,
    print_answer([G | B], Vertices, I1, J),
    !.
print_answer([[F | G] | B], Vertices, I, J) :-
    write('+'),
    I1 is I + 1,
    print_answer([G | B], Vertices, I1, J),
    !.

solve([A | B], Answer) :-
    almost2_solve([A | B], Len, Res1),
    used_cells(Res1, [], Res2),
    atom_chars(A, A1),
    length(A1, Hor),
    get_vertices(Res2, [], Hor, Answer),
    first_step([A | B], C),
    print_answer(C, Answer, 1, 1),
    !.
