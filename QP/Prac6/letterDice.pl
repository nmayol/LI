:- use_module(library(clpfd)).

%% A (6-sided) "letter dice" has on each side a different letter.
%% Find four of them, with the 24 letters abcdefghijklmnoprstuvwxy such
%% that you can make all the following words: bake, onyx, echo, oval,
%% gird, smug, jump, torn, luck, viny, lush, wrap.

% Some helpful predicates:

word([b, a, k, e]).
word([o, n, y, x]).
word([e, c, h, o]).
word([o, v, a, l]).
word([g, i, r, d]).
word([s, m, u, g]).
word([j, u, m, p]).
word([t, o, r, n]).
word([l, u, c, k]).
word([v, i, n, y]).
word([l, u, s, h]).
word([w, r, a, p]).

% Index corresponds to element
num(X, N) :- nth1(N, [a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, r, s, t, u, v, w, x, y], X).

p:-
    length(D1, 6),
    length(D2, 6),
    length(D3, 6),
    length(D4, 6),

    D1 ins 0..23,
    D2 ins 0..23,
    D3 ins 0..23,
    D4 ins 0..23,

    look4Words(D1, D2, D3, D4),

    write('D1'), writeN(D1), nl,
    write('D2'), writeN(D2), nl,
    write('D3'), writeN(D3), nl,
    write('D4'), writeN(D4), nl,
    halt.

writeN(D) :- findall(X, (member(N, D), num(X, N)), L), write(L), nl, !.

look4Words(D1, D2, D3, D4) :-
    word(W),
    declareConstraints(W, D1, D2, D3, D4).


declareConstraints(W, D1, D2, D3, D4) :-
    nth0(0, W, L1),
    num(L1, N1),
    element(1, D1, N1),

    nth0(1, W, L2),
    num(L2, N2),
    element(1, D2, N2),

    nth0(2, W, L3),
    num(L3, N3),
    element(1, D3, N3),

    nth0(3, W, L4),
    num(L4, N4),
    element(1, D4, N4),!.


% 1	2	3	4
% 		4	3
% 	3	2	4
% 		4	2
% 	4	2	3
% 		3	2

declareConstraints(W, D1, D2, D3, D4) :- declareConstraints(W, D1, D2, D4, D3).
declareConstraints(W, D1, D2, D3, D4) :- declareConstraints(W, D1, D3, D2, D4).
declareConstraints(W, D1, D2, D3, D4) :- declareConstraints(W, D1, D3, D4, D2).
declareConstraints(W, D1, D2, D3, D4) :- declareConstraints(W, D1, D4, D2, D3).
declareConstraints(W, D1, D2, D3, D4) :- declareConstraints(W, D1, D4, D3, D2).


% 2	1	3	4
% 		4	3
% 	3	1	4
% 		4	1
% 	4	1	3
% 		3	1

declareConstraints(W, D1, D2, D3, D4) :- declareConstraints(W, D2, D1, D4, D3).
declareConstraints(W, D1, D2, D3, D4) :- declareConstraints(W, D2, D3, D1, D4).
declareConstraints(W, D1, D2, D3, D4) :- declareConstraints(W, D2, D3, D4, D1).
declareConstraints(W, D1, D2, D3, D4) :- declareConstraints(W, D2, D4, D1, D3).
declareConstraints(W, D1, D2, D3, D4) :- declareConstraints(W, D2, D4, D3, D1).
declareConstraints(W, D1, D2, D3, D4) :- declareConstraints(W, D2, D1, D3, D4).


% 3	1	2	4
% 		4	2
% 	2	1	4
% 		4	1
% 	4	1	2
% 		2	1

declareConstraints(W, D1, D2, D3, D4) :- declareConstraints(W, D3, D1, D4, D2).
declareConstraints(W, D1, D2, D3, D4) :- declareConstraints(W, D3, D2, D1, D4).
declareConstraints(W, D1, D2, D3, D4) :- declareConstraints(W, D3, D2, D4, D1).
declareConstraints(W, D1, D2, D3, D4) :- declareConstraints(W, D3, D4, D1, D2).
declareConstraints(W, D1, D2, D3, D4) :- declareConstraints(W, D3, D4, D2, D1).
declareConstraints(W, D1, D2, D3, D4) :- declareConstraints(W, D3, D1, D2, D4).


% 4	1	2	3
% 		3	2
% 	2	1	3
% 		3	1
% 	3	1	2
% 		2	1

declareConstraints(W, D1, D2, D3, D4) :- declareConstraints(W, D4, D1, D3, D2).
declareConstraints(W, D1, D2, D3, D4) :- declareConstraints(W, D4, D2, D1, D3).
declareConstraints(W, D1, D2, D3, D4) :- declareConstraints(W, D4, D2, D3, D1).
declareConstraints(W, D1, D2, D3, D4) :- declareConstraints(W, D4, D3, D1, D2).
declareConstraints(W, D1, D2, D3, D4) :- declareConstraints(W, D4, D3, D2, D1).
declareConstraints(W, D1, D2, D3, D4) :- declareConstraints(W, D4, D1, D2, D3).
