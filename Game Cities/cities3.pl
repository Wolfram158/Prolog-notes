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

solve_stage1([A | B], CityFirst, CityLast) :-
    (init([A | B]) ; true),
    atom_chars(CityFirst, DerivedCF),
    getLast(DerivedCF, Last),
    atom_chars(CityLast, DerivedCL),
    getFirst(DerivedCL, First),
    start(Last, First, PotentialAnswer),
    assert(answer(PotentialAnswer)).

array([]) :- !.

getArray(Any) :-
    answer(X),
    array(P),
    \+ member(X, P),
    append(P, [X], P1),
    retractall(array(Q)),
    assert(array(P1)).

trueResult([]) :- !.

find_min([], Y) :- !.
find_min([A | B], Y) :-
    length(A, Length),
    Length < Y,
    retractall(trueResult(X)),
    assert(trueResult(A)),
    find_min(B, Length),
    !.
find_min([A | B], Y) :-
    find_min(B, Y),
    !.

final(Input, First, Last) :-
    (solve_stage1(Input, First, Last) ; true),
    getArray(Any),
    array(T),
    find_min(T, 9999999).

retract_all(Any) :-
    retractall(city(X)),
    retractall(answer(X)),
    !.
    
% How to use: 
% Let Input be the list of input cities, CityFirst and CityLast be the first and the last cities respectively.
% Then call:
% 1. final(Input, CityFirst, CityLast)
% 2. trueResult(X)
% 3. X is the answer.
% To call again call retract_all(Any)
