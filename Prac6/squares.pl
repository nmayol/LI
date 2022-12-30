:- use_module(library(clpfd)).

% ejemplo(_, Big, [S1...SN]): how to fit all squares of sizes S1...SN in a square of size Big?
ejemplo(0,  3,[2,1,1,1,1,1]).
ejemplo(1,  4,[2,2,2,1,1,1,1]).
ejemplo(2,  5,[3,2,2,2,1,1,1,1]).
ejemplo(3, 19,[10,9,7,6,4,4,3,3,3,3,3,2,2,2,1,1,1,1,1,1]).
ejemplo(4, 40,[24,16,16,10,9,8,8,7,7,6,6,3,3,3,2,1,1]).   %<-- aquest ja costa bastant de resoldre...

%Aquests dos ultims son molt durs!!! Poden no sortir-te amb aquesta tècnica!!
ejemplo(5,112,[50,42,37,35,33,29,27,25,24,19,18,17,16,15,11,9,8,7,6,4,2]).
ejemplo(6,175,[81,64,56,55,51,43,39,38,35,33,31,30,29,20,18,16,14,9,8,5,4,3,2,1]).


%% Possible output solution for example 3:
%%  10 10 10 10 10 10 10 10 10 10  9  9  9  9  9  9  9  9  9
%%  10 10 10 10 10 10 10 10 10 10  9  9  9  9  9  9  9  9  9
%%  10 10 10 10 10 10 10 10 10 10  9  9  9  9  9  9  9  9  9
%%  10 10 10 10 10 10 10 10 10 10  9  9  9  9  9  9  9  9  9
%%  10 10 10 10 10 10 10 10 10 10  9  9  9  9  9  9  9  9  9
%%  10 10 10 10 10 10 10 10 10 10  9  9  9  9  9  9  9  9  9
%%  10 10 10 10 10 10 10 10 10 10  9  9  9  9  9  9  9  9  9
%%  10 10 10 10 10 10 10 10 10 10  9  9  9  9  9  9  9  9  9
%%  10 10 10 10 10 10 10 10 10 10  9  9  9  9  9  9  9  9  9
%%  10 10 10 10 10 10 10 10 10 10  7  7  7  7  7  7  7  2  2
%%   6  6  6  6  6  6  4  4  4  4  7  7  7  7  7  7  7  2  2
%%   6  6  6  6  6  6  4  4  4  4  7  7  7  7  7  7  7  2  2
%%   6  6  6  6  6  6  4  4  4  4  7  7  7  7  7  7  7  2  2
%%   6  6  6  6  6  6  4  4  4  4  7  7  7  7  7  7  7  2  2
%%   6  6  6  6  6  6  4  4  4  4  7  7  7  7  7  7  7  2  2
%%   6  6  6  6  6  6  4  4  4  4  7  7  7  7  7  7  7  1  1
%%   3  3  3  3  3  3  4  4  4  4  3  3  3  3  3  3  3  3  3
%%   3  3  3  3  3  3  4  4  4  4  3  3  3  3  3  3  3  3  3
%%   3  3  3  3  3  3  1  1  1  1  3  3  3  3  3  3  3  3  3


main:- 
    ejemplo(3,Big,Sides),
    nl, write('Fitting all squares of size '), write(Sides), write(' into big square of size '), write(Big), nl,nl,
    length(Sides,N),
   
    length(RowVars,N), % get list of N prolog vars: Row coordinates of each small square
    length(ColVars,N),
    Big1 is Big-1,
    RowVars ins 0..Big1,
    ColVars ins 0..Big1,
    write('Rows: '),
    insideBigSquare(N,Big,Sides,RowVars), nl,
    write('Cols: '),
    insideBigSquare(N,Big,Sides,ColVars),nl,
    write('mirem si es solapa: '), nl,
    nonoverlapping(RowVars,ColVars,Sides), nl,
    append(RowVars,ColVars,Vars),
    labeling([],Vars),
    write(Vars),
    displaySol(Big,Sides,RowVars,ColVars), halt.


displaySol(N,Sides,RowVars,ColVars):- 
    between(1,N,Row), nl, between(1,N,Col),
    nth1(K,Sides,S),    
    nth1(K,RowVars,RV),    RVS is RV+S-1,     between(RV,RVS,Row),
    nth1(K,ColVars,CV),    CVS is CV+S-1,     between(CV,CVS,Col),
    writeSide(S), fail.
displaySol(_,_,_,_):- nl,nl,!.

insideBigSquare(0,_,[],[]).
insideBigSquare(N,B,[S|Si],[R|RV]):-
    Max is B - S,
    R #=< Max,
    % Sum #= R + S, Sum #>= 0, Sum #< B, N1 is N-1,
    % write(R),write(' '),write(S),write(' '),write(Sum),write(' '),
insideBigSquare(N1,B,Si,RV).

nonoverlapping([R|Row],[C|Col],[S|Sides]):-
    noOverLap(R,Row,C,Col,S,Sides),
    nonoverlapping(Row,Col,Sides).
nonoverlapping([],[],[]).
    
noOverLap(R,[R1|Rows],C,[C1|Cols],S,[S1|Sides]):-
    R+S #=< R1 #\/ C+S #=< C1 #\/ R1+S1 #=< R #\/ C1+S1 #=< C,
    noOverLap(R,Rows,C,Cols,S,Sides).
noOverLap(_,[],_,[],_,[]).


writeSide(S):- S<10, write('  '),write(S),!.
writeSide(S):-       write(' ' ),write(S),!.

