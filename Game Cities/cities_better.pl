getLast([X], X) :- !.
getLast([X | Y], Last) :-
    getLast(Y, Last).

getFirst([X | Y], X) :- !.

init([A | B]) :-
    assert(city(A)),
    init(B),
    !.

start(Current, Target, X) :-
    atom_chars(Current, Current1),
    getLast(Current1, Last),
    Last = Target,
    X = [].
start(Current, Target, [X | Y]) :-
    city(City),
    \+ Current = City,
    atom_chars(City, City1),
    atom_chars(Current, Current1),
    getFirst(City1, First),
    getLast(Current1, Last),
    Last = First,
    X = City,
    start(City, Target, Y).
