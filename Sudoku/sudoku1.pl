board([], I, J, []) :- !.
board([[] | C], I, J, F) :-
    J1 is J + 1,
    board(C, 0, J1, F),
    !.
board([[A | B] | C], I, J, [F | R]) :-
    F = [I, J, A],
    I1 is I + 1,
    board([B | C], I1, J, R),
    !.

first_unfilled(X, Y) :-
    member([A, B, 0], X),
    Y = [A, B, 0],
    !.

not_is_row(Cells, Y, Num) :-
    member([X, Y, Z], Cells),
    Z = Num,
    !.

not_is_column(Cells, X, Num) :-
    member([X, Y, Z], Cells),
    Z = Num,
    !.

not_is_square(Cells, StartRow, StartColumn, Num) :-
    member(I, [0, 1, 2]),
    member(J, [0, 1, 2]),
    I1 is StartRow + I,
    J1 is StartColumn + J,
    member([J1, I1, Num], Cells),
    !.
    
replace([], New, I, J, []) :- !.
replace([A | B], New, I, J, [C | D]) :-
    \+ I = J,
    C = A,
    I1 is I + 1,
    replace(B, New, I1, J, D),
    !.
replace([[X, Y, Z] | B], New, I, J, [C | D]) :-
    C = [X, Y, New],
    I1 is I + 1,
    replace(B, New, I1, J, D),
    !.
    
sol(Board, Current, Current) :-
    \+ first_unfilled(Current, T),
    !.
sol(Board, Current, Derived) :-
    first_unfilled(Current, [X, Y, N]),
    Index is X + Y * 9,
    member(Num, [1, 2, 3, 4, 5, 6, 7, 8, 9]),
    \+ not_is_row(Current, Y, Num),
    \+ not_is_column(Current, X, Num),
    StartRow is Y - Y mod 3,
    StartColumn is X - X mod 3,
    \+ not_is_square(Current, StartRow, StartColumn, Num),
    replace(Current, Num, 0, Index, Diff),
    sol(Board, Diff, Derived),
    !.

normalize([], Ind, Cur, Curr, P) :- 
    append(Curr, [Cur], Curr1),
    P = Curr1,
    !.

normalize([[I, J, T] | F], Ind, Cur, Curr, Res) :-
    Ind < 9,
    append(Cur, [T], Cur1),
    Ind1 is Ind + 1,
    normalize(F, Ind1, Cur1, Curr, Res),
    !.

normalize([[I, J, T] | F], Ind, Cur, Curr, Res) :-
    append(Curr, [Cur], Curr1),
    Ind1 is 0,
    Cur1 = [],
    normalize([[I, J, T] | F], Ind1, Cur1, Curr1, Res),
    !.

solve(Board, Res) :-
    board(Board, 0, 0, Derived),
    sol(Derived, Derived, X),
    normalize(X, 0, [], [], Res),
    !.

% yes.
% X / [[2,3,9,7,1,8,4,6,5],[1,8,6,5,4,2,9,3,7],[4,7,5,3,6,9,8,1,2],[5,1,8,4,2,3,6,7,9],[7,9,4,6,5,1,3,2,8],[6,2,3,9,8,7,5,4,1],[8,4,2,1,3,5,7,9,6],[9,6,1,8,7,4,2,5,3],[3,5,7,2,9,6,1,8,4]]
% Solution: solve([[0,0,0,7,0,0,4,0,0],[0,8,0,5,0,0,9,0,0],[0,7,5,3,0,0,0,1,0],[0,1,0,0,2,0,6,0,0],[7,0,4,0,0,0,0,0,0],[6,0,0,0,8,0,0,4,0],[0,0,0,0,0,0,0,0,0],[0,6,0,8,0,0,0,0,3],[0,5,0,0,9,0,1,0,0]],[[2,3,9,7,1,8,4,6,5],[1,8,6,5,4,2,9,3,7],[4,7,5,3,6,9,8,1,2],[5,1,8,4,2,3,6,7,9],[7,9,4,6,5,1,3,2,8],[6,2,3,9,8,7,5,4,1],[8,4,2,1,3,5,7,9,6],[9,6,1,8,7,4,2,5,3],[3,5,7,2,9,6,1,8,4]])
