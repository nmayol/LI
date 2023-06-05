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
    length(D1, 6), length(D2, 6), length(D3, 6), length(D4, 6),

    flatten([D1,D2,D3,D4],Vars),
    Vars ins 1..24,
    all_distinct(Vars),

    findall(W, word(W), Words),
    dicesHaveAllWords(Words, D1, D2, D3, D4),   

    labeling([ff],Vars),
    write('D1: '), writeN(D1), nl,
    write('D2: '), writeN(D2), nl,
    write('D3: '), writeN(D3), nl,
    write('D4: '), writeN(D4), nl,
    halt.

writeN(D):- findall(X,(member(N,D),num(X,N)),L), write(L), nl, !.

dicesHaveAllWords([], _, _, _, _).
dicesHaveAllWords([W|Words], D1, D2, D3, D4) :-
    diceHasWord(W, D1, D2, D3, D4),
    
    dicesHaveAllWords(Words, D1, D2, D3, D4).

diceHasWord([A, B, C, D], D1, D2, D3, D4) :-
    num(A, AN), num(B, BN), num(C, CN), num(D, DN),
    
    lettersDifferentDices(AN, BN, CN, DN, D1, D2, D3, D4),!.

lettersDifferentDices(A, B, C, D, D1, D2, D3, D4) :-
    
    dontCoincide(A, B, C, D, D1),
    dontCoincide(A, B, C, D, D2),
    dontCoincide(A, B, C, D, D3),
    dontCoincide(A, B, C, D, D4),!.

dontCoincide(A, B, C, D, Dx) :-
    
    memberDice(A, Dx, ResA),  memberDice(B, Dx, ResB), memberDice(C, Dx, ResC),  memberDice(D, Dx, ResD),
    notmemberDice(A, Dx, ResA1), notmemberDice(B, Dx, ResB1), notmemberDice(C, Dx, ResC1), notmemberDice(D, Dx, ResD1),

    (ResA #/\ (ResB1) #/\ (ResC1) #/\ (ResD1)) #\/
    (ResB #/\ (ResA1) #/\ (ResC1) #/\ (ResD1)) #\/
    (ResC #/\ (ResA1) #/\ (ResB1) #/\ (ResD1)) #\/
    (ResD #/\ (ResA1) #/\ (ResB1) #/\ (ResC1)).

    
    
notmemberDice(N, [C1,C2,C3,C4,C5,C6], Res) :-
    % write(N),   write(':'), nl,
    % write('['), num(X1,C1), write(X1), write(','), num(X2,C2), write(X2), write(','), num(X3,C3), write(X3), write(','), num(X4,C4), write(X4), write(','), num(X5,C5), write(X5), write(','), num(X6,C6), write(X6), write(']'), nl,
    Res = (N #\= C1 #/\ N #\= C2 #/\ N #\= C3 #/\ N #\= C4 #/\ N #\= C5 #/\ N #\= C6).

memberDice(N, [C1,C2,C3,C4,C5,C6], Res) :-
    %write(N),   write(':'), nl,
    %write('['), num(X1,C1), write(X1), write(','), num(X2,C2), write(X2), write(','), num(X3,C3), write(X3), write(','), num(X4,C4), write(X4), write(','), num(X5,C5), write(X5), write(','), num(X6,C6), write(X6), write(']'), nl,
    Res = (N #= C1 #\/ N #= C2 #\/ N #= C3 #\/ N #= C4 #\/ N #= C5 #\/ N #= C6).

