%% Write a Prolog predicate eqSplit(L,S1,S2) that, given a list of
%% integers L, splits it into two disjoint subsets S1 and S2 such that
%% the sum of the numbers in S1 is equal to the sum of S2. It should
%% behave as follows:
%%
%% ?- eqSplit([1,5,2,3,4,7],S1,S2), write(S1), write('    '), write(S2), nl, fail.
%%
%% [1,5,2,3]    [4,7]
%% [1,3,7]    [5,2,4]
%% [5,2,4]    [1,3,7]
%% [4,7]    [1,5,2,3]

subcjt([], []).
subcjt([E|Tail], [E|NTail]):-
    subcjt(Tail, NTail).
subcjt([_|Tail], NTail):-
    subcjt(Tail, NTail).


findRest(Subset,L,R):-
    length(L,NL), length(Subset,NS), 
    subcjt(L,R),
    append(Subset,R,L2),
    permutation(L2,L),
    %write(Subset), write(' '), write(R), write(' ') ,write(L2), nl,
    !.

subsetWithRest(L,Subset,R):-
    subcjt(L,Subset),
    findRest(Subset,L,R).
    % write(Subset), write(' '), write(R), write(' ') , nl,

sumList([],0).
sumList([X|L],S):-
    sumList(L,S1),
    S is S1 + X.

eqSplit(L,Sub,Rest):-
    subsetWithRest(L,Sub,Rest),
    %write(Sub), write(' '), write(Rest), nl,
    sumList(Sub,SumSub),
    sumList(Rest,SumRest),
    SumSub = SumRest.

