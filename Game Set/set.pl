% after each query call retractall(array(P, Q))

isCorrectCard(card(Form, Color, Texture, Count)) :-
    (Form = ellipse; Form = romb; Form = other),
    (Color = red; Color = green; Color = purple),
    (Texture = white; Texture = partically; Texture = whole),
    (Count = 1; Count = 2; Count = 3),
    !.

isSet(card(Form1, Color1, Texture1, Count1), card(Form2, Color2, Texture2, Count2), card(Form3, Color3, Texture3, Count3)) :-
    isCorrectCard(card(Form1, Color1, Texture1, Count1)),
    isCorrectCard(card(Form2, Color2, Texture2, Count2)),
    isCorrectCard(card(Form3, Color3, Texture3, Count3)),
    ((Form1 \= Form2, Form2 \= Form3, Form1 \= Form3);
    (Form1 = Form2, Form2 = Form3)),
    ((Color1 \= Color2, Color2 \= Color3, Color1 \= Color3);
    (Color1 = Color2, Color2 = Color3)),
    ((Texture1 \= Texture2, Texture2 \= Texture3, Texture1 \= Texture3);
    (Texture1 = Texture2, Texture2 = Texture3)),
    ((Count1 \= Count2, Count2 \= Count3, Count1 \= Count3);
    (Count1 = Count2, Count2 = Count3)),
    !.

init([card(Form, Color, Texture, Count)], I) :-
    assert(array(I, card(Form, Color, Texture, Count))),
    I1 is I + 1,
    assert(len(I1)),
    !.

init([card(Form, Color, Texture, Count) | T], I) :-
    assert(array(I, card(Form, Color, Texture, Count))),
    I1 is I + 1,
    init(T, I1),
    !.

find_sets(List, A, B, C, [X, Y, Z]) :-
    init(List, 0),
    array(A, X),
    array(B, Y),
    array(C, Z),
    isSet(X, Y, Z),
    A < B,
    B < C.

% find_sets([card(ellipse, green, whole, 1),card(ellipse, green, whole, 2), card(romb, green, whole, 3), card(other, green, whole, 3), card(ellipse, green, partically, 1), card(romb, green, partically, 1), card(romb, green, partically, 2), card(ellipse, green, partically, 2), card(romb, green, white, 3), card(ellipse, purple, whole, 1), card(other, purple, whole, 2), card(ellipse, purple, whole, 2), card(other, red, whole, 3), card(ellipse, purple, partically, 2), card(other, purple, partically, 3), card(romb, purple, partically, 3)], A, B, C, [X, Y, Z])
% find_sets([card(ellipse, green, whole, 1),card(ellipse, green, whole, 2), card(romb, green, whole, 3), card(other, green, whole, 3), card(ellipse, green, partically, 1), card(romb, green, partically, 1), card(romb, green, partically, 2), card(ellipse, green, partically, 2), card(romb, green, white, 3), card(ellipse, purple, whole, 1), card(other, purple, whole, 2), card(ellipse, purple, whole, 2), card(other, red, whole, 3), card(ellipse, purple, partically, 2), card(other, purple, partically, 3), card(romb, purple, partically, 3), card(ellipse, purple, partically, 3)], A, B, C, [X, Y, Z])
