:- use_module(library(clpfd)).

ejemplo(0,   26, [1,2,5,10] ).  % Solution: [1,0,1,2]
ejemplo(1,  361, [1,2,5,13,17,35,157]).

main:- 
    ejemplo(1,Amount,Coins),
    nl, write('Paying amount '), write(Amount), write(' using the minimal number of coins of values '), write(Coins), nl,nl,
    length(Coins,N), 
    length(Vars,N), % get list of N prolog vars    
    Vars ins 0..Amount,
    pescalar(Vars,Coins,Am),
    Am #= Amount,
    sumVect(Vars,X),
    labeling([min(X)], Vars),
    nl, write(Vars), nl,nl, halt.


pescalar([],[],0).
pescalar([L1|List1],[L2|List2],R1 + L1*L2):- pescalar(List1,List2,R1).

sumVect([],0).
sumVect([L|List],Sum+L):-
    sumVect(List,Sum).