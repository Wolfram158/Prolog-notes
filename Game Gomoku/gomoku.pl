row([[B, C, D, E] | R], Color) :-
    row(R, Color),
    !.
row([[A, B, C, D, E | F] | R], Color) :-
    A = Color,
    B = Color,
    C = Color,
    D = Color,
    E = Color,
    !.
row([[A, B, C, D, E | F] | R], Color) :-
    row([[B, C, D, E | F] | R], Color),
    !.

transform([], []) :- !.
transform([A | B], [C | D]) :-
    atom_chars(A, A1),
    C = A1,
    transform(B, D),
    !.

row_case(Board, Color) :-
    transform(Board, Derived),
    row(Derived, Color),
    !.

map([], _, []).
map([H | T], F, [RH | RT]) :- G =.. [F, H, RH], call(G), map(T, F, RT).

transpose([[] | _], []) :- !.
transpose(M, [RH | RT]) :-
    map(M, head, RH),
    map(M, tail, Tails),
    transpose(Tails, RT).

head([H | _], H).
tail([_ | T], T).

col_case(Board, Color) :-
    transform(Board, Derived1),
    transpose(Derived1, Derived2),
    row(Derived2, Color),
    !.

input_data([[] | C], X, Y, I, J) :-
    I < Y,
    I1 is I + 1,
    input_data(C, X, Y, I1, 0),
    !.
input_data([[A | B] | C], X, Y, I, J) :-
    I < Y,
    J < X,
    assert(cell(I, J, A)),
    J1 is J + 1,
    input_data([B | C], X, Y, I, J1),
    !.

start([A | B]) :-
    transform([A | B], [C | D]),
    length(C, LenX),
    length([C | D], LenY),
    input_data([C | D], LenX, LenY, 0, 0),
    !.

main_diag_case(Color) :-
    cell(I, J, Color),
    I1 is I + 1,
    J1 is J + 1,
    cell(I1, J1, Color),
    I2 is I + 2,
    J2 is J + 2,
    cell(I2, J2, Color),
    I3 is I + 3,
    J3 is J + 3,
    cell(I3, J3, Color),
    I4 is I + 4,
    J4 is J + 4,
    cell(I4, J4, Color),
    !.

not_main_diag_case(Color) :-
    cell(I, J, Color),
    I1 is I + 1,
    J1 is J - 1,
    cell(I1, J1, Color),
    I2 is I + 2,
    J2 is J - 2,
    cell(I2, J2, Color),
    I3 is I + 3,
    J3 is J - 3,
    cell(I3, J3, Color),
    I4 is I + 4,
    J4 is J - 4,
    cell(I4, J4, Color),
    !.

checkColor(Board, Color) :-
    (row_case(Board, Color);
    col_case(Board, Color);
    main_diag_case(Color);
    not_main_diag_case(Color)),
    !.
    
gomoku(Board, Result) :-
    (start(Board) ; true),
    checkColor(Board, 'B'),
    checkColor(Board, 'W'),
    Result = both,
    !.
gomoku(Board, Result) :-
    checkColor(Board, 'B'),
    Result = black,
    !.
gomoku(Board, Result) :-
    checkColor(Board, 'W'),
    Result = white,
    !.
gomoku(Board, Result) :-
    Result = none,
    !. 
