filter([A | B], Index, Limit, Value, [C | D]) :-
    Index < Limit,
    A < Value,
    C is Index,
    Next is Index + 1,
    filter(B, Next, Limit, Value, D),
    !.
filter([A | B], Index, Limit, Value, [C | D]) :-
    Index < Limit,
    Next is Index + 1,
    filter(B, Next, Limit, Value, [C | D]),
    !.
filter([A | B], Index, Limit, Value, []) :- !. 

max(Prev, [A], X) :-
    A >= Prev,
    X is A,
    !.
max(Prev, [A], X) :-
    X is Prev,
    !.
max(Prev, [A | B], X) :-
    A >= Prev,
    Next is A,
    max(Next, B, X),
    !.
max(Prev, [A | B], X) :-
    max(Prev, B, X),
    !.

ith_element([A | B], 0, A) :- !.
ith_element([A | B], Index, Res) :-
    Num is Index - 1,
    Num >= 0,
    ith_element(B, Num, Res),
    !.

get_d([A], Dynamic, [E]) :-
    ith_element(Dynamic, A, E),
    !.
get_d([A | B], Dynamic, [E | F]) :-
    ith_element(Dynamic, A, E),
    get_d(B, Dynamic, F),
    !.
get_d([], Dynamic, []) :- !.

append([B | C], A, [U | V]) :-
    U is B,
    append(C, A, V),
    !.
append([], A, [A]) :- !.

d([A | B], 0, Limit, M, [C | D]) :- 
    C is 1,
    T = [],
    append(T, 1, T1),
    d([A | B], 1, Limit, T1, D),
    !.
d([A | B], Index, Limit, Dynamic, [C | D]) :-
    Index < Limit,
    ith_element([A | B], Index, Element),
    filter([A | B], 0, Index, Element, List),
    \+ List = [],
    get_d(List, Dynamic, [First | Rest]),
    max(First, [First | Rest], Max),
    C is Max + 1,
    Next is Index + 1,
    append(Dynamic, C, Current),
    d([A | B], Next, Limit, Current, D),
    !.
d([A | B], Index, Limit, Dynamic, [C | D]) :-
    Index < Limit,
    C is 1,
    Next is Index + 1,
    append(Dynamic, C, Current),
    d([A | B], Next, Limit, Current, D),
    !.
d([A | B], Index, Limit, Dynamic, []) :- !. 

lis_length([], 0) :- !.

lis_length(S, Answer) :-
    length(S, Length),
    d(S, 0, Length, Y, [First | Rest]),
    max(First, [First | Rest], Answer),
    !.
