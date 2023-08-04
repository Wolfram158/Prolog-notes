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
    write(Length),
    retractall(trueResult(X)),
    assert(trueResult(A)),
    find_min(B, Length),
    !.
find_min([A | B], Y) :-
    find_min(B, Y),
    !.

% How to use: 
% Let Input be the list of input cities, CityFirst and CityLast be the first and the last cities respectively.
% Then call:
% 1. solve_stage1(Input, CityFirst, CityLast)
% 2. getArray(Any)
% 3. array(T), find_min(T, 9999999)
% 4. trueResult(X)
% 5. X is the answer.
% To call again call retractall(answer(X)), retractall(city(X)).
