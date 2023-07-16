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
