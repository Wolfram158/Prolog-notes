game(Configuration, 0, Configuration) :- !.

game(Configuration, Stage, Res) :-
    next(Configuration, Next),
    Stage1 is Stage - 1,
    game(Next, Stage1, Res),
    !.

next(Configuration, Next) :-
    new_lifes(Configuration, Configuration, 1, [], NewLifes),
    saved_lifes(Configuration, Configuration, [], SavedLifes),
    append([], NewLifes, X),
    append(X, SavedLifes, Next),
    !.

isLife(life(I, J), Configuration, 1) :-
    member(life(I, J), Configuration),
    !.
isLife(life(I, J), Configuration, 0) :- !.

explore(life(X, Y), Configuration, Z) :-
    I1 is X + 1,
    J1 is Y,
    isLife(life(I1, J1), Configuration, Inc1),
    I2 is X - 1, 
    isLife(life(I2, J1), Configuration, Inc2),
    I3 is X,
    J3 is Y + 1,
    isLife(life(I3, J3), Configuration, Inc3),
    J4 is Y - 1,
    isLife(life(I3, J4), Configuration, Inc4),
    I5 is X - 1,
    isLife(life(I5, J4), Configuration, Inc5),
    I6 is X + 1,
    J6 is Y + 1,
    isLife(life(I6, J6), Configuration, Inc6),
    I7 is X - 1,
    isLife(life(I7, J6), Configuration, Inc7),
    I8 is X + 1,
    J8 is Y - 1,
    isLife(life(I8, J8), Configuration, Inc8),
    Z is Inc1 + Inc2 + Inc3 + Inc4 + Inc5 + Inc6 + Inc7 + Inc8,
    !.

new_lifes(Immutable, [], Y, List, List) :- !.
new_lifes(Immutable, [life(A, B) | T], 1, List, Res) :-
    I1 is A + 1,
    J1 is B,
    explore(life(I1, J1), Immutable, Z1),
    Z1 is 3,
    \+ member(life(I1, J1), Immutable),
    \+ member(life(I1, J1), List),
    append(List, [life(I1, J1)], X),
    new_lifes(Immutable, [life(A, B) | T], 2, X, Res),
    !.
new_lifes(Immutable, [life(A, B) | T], 1, List, Res) :-
    new_lifes(Immutable, [life(A, B) | T], 2, List, Res),
    !.
new_lifes(Immutable, [life(A, B) | T], 2, List, Res) :-
    I1 is A - 1,
    J1 is B,
    explore(life(I1, J1), Immutable, Z1),
    Z1 is 3,
    \+ member(life(I1, J1), Immutable),
    \+ member(life(I1, J1), List),
    append(List, [life(I1, J1)], X),
    new_lifes(Immutable, [life(A, B) | T], 3, X, Res),
    !. 
new_lifes(Immutable, [life(A, B) | T], 2, List, Res) :-
    new_lifes(Immutable, [life(A, B) | T], 3, List, Res),
    !.
new_lifes(Immutable, [life(A, B) | T], 3, List, Res) :-
    I1 is A,
    J1 is B + 1,
    explore(life(I1, J1), Immutable, Z1),
    Z1 is 3,
    \+ member(life(I1, J1), Immutable),
    \+ member(life(I1, J1), List),
    append(List, [life(I1, J1)], X),
    new_lifes(Immutable, [life(A, B) | T], 4, X, Res),
    !. 
new_lifes(Immutable, [life(A, B) | T], 3, List, Res) :-
    new_lifes(Immutable, [life(A, B) | T], 4, List, Res),
    !.
new_lifes(Immutable, [life(A, B) | T], 4, List, Res) :-
    I1 is A,
    J1 is B - 1,
    explore(life(I1, J1), Immutable, Z1),
    Z1 is 3,
    \+ member(life(I1, J1), Immutable),
    \+ member(life(I1, J1), List),
    append(List, [life(I1, J1)], X),
    new_lifes(Immutable, [life(A, B) | T], 5, X, Res),
    !. 
new_lifes(Immutable, [life(A, B) | T], 4, List, Res) :-
    new_lifes(Immutable, [life(A, B) | T], 5, List, Res),
    !.
new_lifes(Immutable, [life(A, B) | T], 5, List, Res) :-
    I1 is A + 1,
    J1 is B + 1,
    explore(life(I1, J1), Immutable, Z1),
    Z1 is 3,
    \+ member(life(I1, J1), Immutable),
    \+ member(life(I1, J1), List),
    append(List, [life(I1, J1)], X),
    new_lifes(Immutable, [life(A, B) | T], 6, X, Res),
    !. 
new_lifes(Immutable, [life(A, B) | T], 5, List, Res) :-
    new_lifes(Immutable, [life(A, B) | T], 6, List, Res),
    !.
new_lifes(Immutable, [life(A, B) | T], 6, List, Res) :-
    I1 is A - 1,
    J1 is B - 1,
    explore(life(I1, J1), Immutable, Z1),
    Z1 is 3,
    \+ member(life(I1, J1), Immutable),
    \+ member(life(I1, J1), List),
    append(List, [life(I1, J1)], X),
    new_lifes(Immutable, [life(A, B) | T], 7, X, Res),
    !. 
new_lifes(Immutable, [life(A, B) | T], 6, List, Res) :-
    new_lifes(Immutable, [life(A, B) | T], 7, List, Res),
    !.
new_lifes(Immutable, [life(A, B) | T], 7, List, Res) :-
    I1 is A + 1,
    J1 is B - 1,
    explore(life(I1, J1), Immutable, Z1),
    Z1 is 3,
    \+ member(life(I1, J1), Immutable),
    \+ member(life(I1, J1), List),
    append(List, [life(I1, J1)], X),
    new_lifes(Immutable, [life(A, B) | T], 8, X, Res),
    !. 
new_lifes(Immutable, [life(A, B) | T], 7, List, Res) :-
    new_lifes(Immutable, [life(A, B) | T], 8, List, Res),
    !.
new_lifes(Immutable, [life(A, B) | T], 8, List, Res) :-
    I1 is A - 1,
    J1 is B + 1,
    explore(life(I1, J1), Immutable, Z1),
    Z1 is 3,
    \+ member(life(I1, J1), Immutable),
    \+ member(life(I1, J1), List),
    append(List, [life(I1, J1)], X),
    new_lifes(Immutable, T, 1, X, Res),
    !. 
new_lifes(Immutable, [life(A, B) | T], 8, List, Res) :-
    new_lifes(Immutable, T, 1, List, Res),
    !.

saved_lifes(Immutable, [], List, List) :- !.
saved_lifes(Immutable, [life(A, B) | T], List, Res) :-
    explore(life(A, B), Immutable, Z),
    (Z is 2; Z is 3),
    append(List, [life(A, B)], X),
    saved_lifes(Immutable, T, X, Res),
    !.
saved_lifes(Immutable, [life(A, B) | T], List, Res) :-
    saved_lifes(Immutable, T, List, Res),
    !. 
