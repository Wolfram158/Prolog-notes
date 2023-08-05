game(Now, Stage, Future) :-
    go(Now, Future, Stage, 1),
    !.

assert_lifes([]) :- !.
assert_lifes([life(A, B) | T]) :-
    \+ life(A, B),
    assert(life(A, B)),
    assert_lifes(T),
    !.

isLife(life(I, J), 1) :-
    life(I, J),
    !.
isLife(life(I, J), 0) :- !.

explore(X, Y, Z) :-
    I1 is X + 1,
    J1 is Y,
    isLife(life(I1, J1), Inc1),
    I2 is X - 1, 
    isLife(life(I2, J1), Inc2),
    I3 is X,
    J3 is Y + 1,
    isLife(life(I3, J3), Inc3),
    J4 is Y - 1,
    isLife(life(I3, J4), Inc4),
    I5 is X - 1,
    isLife(life(I5, J4), Inc5),
    I6 is X + 1,
    J6 is Y + 1,
    isLife(life(I6, J6), Inc6),
    I7 is X - 1,
    isLife(life(I7, J6), Inc7),
    I8 is X + 1,
    J8 is Y - 1,
    isLife(life(I8, J8), Inc8),
    Z is Inc1 + Inc2 + Inc3 + Inc4 + Inc5 + Inc6 + Inc7 + Inc8,
    !.

new_lifes([], Y, List, Res) :- Res = List, !.
new_lifes([life(A, B) | T], 1, List, Res) :-
    I1 is A + 1,
    J1 is B,
    explore(I1, J1, Z1),
    Z1 is 3,
    \+ member(life(I1, J1), [life(A, B)  | T]),
    \+ member(life(I1, J1), List),
    append(List, [life(I1, J1)], X),
    new_lifes([life(A, B) | T], 2, X, Res),
    !.
new_lifes([life(A, B) | T], 1, List, Res) :-
    new_lifes([life(A, B) | T], 2, List, Res),
    !.
new_lifes([life(A, B) | T], 2, List, Res) :-
    I1 is A - 1,
    J1 is B,
    explore(I1, J1, Z1),
    Z1 is 3,
    \+ member(life(I1, J1), [life(A, B)  | T]),
    \+ member(life(I1, J1), List),
    append(List, [life(I1, J1)], X),
    new_lifes([life(A, B) | T], 3, X, Res),
    !. 
new_lifes([life(A, B) | T], 2, List, Res) :-
    new_lifes([life(A, B) | T], 3, List, Res),
    !.
new_lifes([life(A, B) | T], 3, List, Res) :-
    I1 is A,
    J1 is B + 1,
    explore(I1, J1, Z1),
    Z1 is 3,
    \+ member(life(I1, J1), [life(A, B)  | T]),
    \+ member(life(I1, J1), List),
    append(List, [life(I1, J1)], X),
    new_lifes([life(A, B) | T], 4, X, Res),
    !. 
new_lifes([life(A, B) | T], 3, List, Res) :-
    new_lifes([life(A, B) | T], 4, List, Res),
    !.
new_lifes([life(A, B) | T], 4, List, Res) :-
    I1 is A,
    J1 is B - 1,
    explore(I1, J1, Z1),
    Z1 is 3,
    \+ member(life(I1, J1), [life(A, B)  | T]),
    \+ member(life(I1, J1), List),
    append(List, [life(I1, J1)], X),
    new_lifes([life(A, B) | T], 5, X, Res),
    !. 
new_lifes([life(A, B) | T], 4, List, Res) :-
    new_lifes([life(A, B) | T], 5, List, Res),
    !.
new_lifes([life(A, B) | T], 5, List, Res) :-
    I1 is A + 1,
    J1 is B + 1,
    explore(I1, J1, Z1),
    Z1 is 3,
    \+ member(life(I1, J1), [life(A, B)  | T]),
    \+ member(life(I1, J1), List),
    append(List, [life(I1, J1)], X),
    new_lifes([life(A, B) | T], 6, X, Res),
    !. 
new_lifes([life(A, B) | T], 5, List, Res) :-
    new_lifes([life(A, B) | T], 6, List, Res),
    !.
new_lifes([life(A, B) | T], 6, List, Res) :-
    I1 is A - 1,
    J1 is B - 1,
    explore(I1, J1, Z1),
    Z1 is 3,
    \+ member(life(I1, J1), [life(A, B)  | T]),
    \+ member(life(I1, J1), List),
    append(List, [life(I1, J1)], X),
    new_lifes([life(A, B) | T], 7, X, Res),
    !. 
new_lifes([life(A, B) | T], 6, List, Res) :-
    new_lifes([life(A, B) | T], 7, List, Res),
    !.
new_lifes([life(A, B) | T], 7, List, Res) :-
    I1 is A + 1,
    J1 is B - 1,
    explore(I1, J1, Z1),
    Z1 is 3,
    \+ member(life(I1, J1), [life(A, B)  | T]),
    \+ member(life(I1, J1), List),
    append(List, [life(I1, J1)], X),
    new_lifes([life(A, B) | T], 8, X, Res),
    !. 
new_lifes([life(A, B) | T], 7, List, Res) :-
    new_lifes([life(A, B) | T], 8, List, Res),
    !.
new_lifes([life(A, B) | T], 8, List, Res) :-
    I1 is A - 1,
    J1 is B + 1,
    explore(I1, J1, Z1),
    Z1 is 3,
    \+ member(life(I1, J1), [life(A, B)  | T]),
    \+ member(life(I1, J1), List),
    append(List, [life(I1, J1)], X),
    new_lifes(T, 1, X, Res),
    !. 
new_lifes([life(A, B) | T], 8, List, Res) :-
    new_lifes(T, 1, List, Res),
    !.

saved_lifes([], List, List) :- !.
saved_lifes([life(A, B) | T], List, Res) :-
    explore(A, B, Z),
    (Z is 2; Z is 3),
    append(List, [life(A, B)], X),
    saved_lifes(T, X, Res),
    !.
saved_lifes([life(A, B) | T], List, Res) :-
    saved_lifes(T, List, Res),
    !. 
