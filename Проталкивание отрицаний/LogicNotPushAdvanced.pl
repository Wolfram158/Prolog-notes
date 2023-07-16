push(and(X, 0), 0) :- !.
push(and(0, X), 0) :- !.
push(and(X, 1), Z) :- 
    push(X, Z),
    !.
push(and(1, X), Z) :- 
    push(X, Z),
    !.
push(and(X, Y), and(U, V)) :- 
    push(X, U), 
    push(Y, V), 
    !.
push(or(X, 0), Z) :- 
    push(X, Z), 
    !.
push(or(0, X), Z) :- 
    push(X, Z), 
    !.
push(or(X, 1), 1) :- !.
push(or(1, X), 1) :- !.
push(or(X, Y), or(U, V)) :- 
    push(X, U), 
    push(Y, V),
    !.
push(not(0), 1) :- !.
push(not(1), 0) :- !.
push(not(and(X, Y)), or(U, V)) :- 
    push(not(X), U), 
    push(not(Y), V), 
    !.
push(not(or(X, Y)), and(U, V)) :- 
    push(not(X), U), 
    push(not(Y), V), 
    !.
push(not(not(X)), Z) :- 
    push(X, Z),
    !.
push(X, X).

simplify(or(1, X), 1) :- !.
simplify(or(X, 1), 1) :- !.
simplify(or(0, X), Z) :-
    simplify(X, Z),
    !.
simplify(or(X, 0), Z) :-
    simplify(X, Z),
    !.
simplify(or(X, Y), Z) :- 
    simplify(X, U), 
    simplify(Y, V), 
    \+ number(U),
    \+ number(V),
    Z = or(U, V),
    !.
simplify(or(X, Y), Z) :-
    simplify(X, U),
    simplify(Y, V),
    simplify(or(U, V), Z),
    !.
simplify(and(0, X), 0) :- !.
simplify(and(X, 0), 0) :- !.
simplify(and(1, X), Z) :- 
    simplify(X, Z),
    !.
simplify(and(X, 1), Z) :- 
    simplify(X, Z),
    !.
simplify(and(X, Y), Z) :-
    simplify(X, U),
    simplify(Y, V),
    \+ number(U),
    \+ number(V),
    Z = and(U, V),
    !.
simplify(and(X, Y), Z) :-
    simplify(X, U),
    simplify(Y, V),
    simplify(and(U, V), Z),
    !.

get(X, X) :- !.

simplify(not(0), 1) :- !.
simplify(not(1), 0) :- !.
simplify(not(X), Z) :-
    simplify(X, U),
    \+ number(U),
    get(not(U), Z),
    !.
simplify(not(X), Z) :-
    simplify(X, U),
    simplify(not(U), Z),
    !.

simplify(X, X).

push_and_simplify(X, Z) :-
    push(X, U),
    simplify(U, Z).
