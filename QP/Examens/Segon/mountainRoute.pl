%% 3 points.
%% Complete the following prolog program that writes the optimal path in a topographic map
%% to go from the initial location (marked i) to the final location (marked f).
%% The cost of moving to a location is indicated with a positive integer 1, 2 or 3,
%% and the cost of moving to the final state (marked f) is 1.
%% The path cannot go through rivers, lakes, cliffs, ... (marked with x).

    
% topoMap([                      %   An optimal path is:
%             [x,3,1,1,i,x],     %     x       i x
%             [x,2,x,2,1,1],     %     x   x   1 1
%             [x,2,x,x,x,2],     %     x   x x x 2 
%             [x,1,x,3,1,1],     %     x   x   1 1 
%             [x,1,f,3,1,2],     %     x   f 3 1   
%             [x,x,x,2,x,1]      %     x x x   x   
%         ] ).                   %   with cost: 1+1+2+1+1+1+3+1(f) = 11

topoMap([                                  %   An optimal path is:
            [x,x,x,x,x,x,x,x,x,x,x,x],     %     x x x x x x x x x x x x
            [x,1,x,3,2,1,1,1,2,2,2,x],     %     x   x                 x
            [x,2,x,3,2,2,2,x,3,3,f,x],     %     x   x         x     f x
            [x,1,2,3,x,x,x,x,1,3,3,x],     %     x       x x x x     3 x
            [x,2,2,2,x,1,1,x,2,2,2,x],     %     x       x     x     2 x
            [x,1,1,1,x,3,2,3,1,2,2,x],     %     x 1 1 1 x           2 x
            [x,2,3,2,2,1,3,3,1,1,1,x],     %     x 2   2 2 1     1 1 1 x
            [x,2,x,x,x,1,1,2,1,x,x,x],     %     x 2 x x x 1 1 2 1 x x x
            [x,2,2,2,x,1,1,1,1,2,3,x],     %     x 2     x             x
            [x,1,i,1,x,x,x,x,3,2,x,x],     %     x 1 i   x x x x     x x
            [x,2,1,1,1,2,3,x,3,x,x,x],     %     x             x   x x x
            [x,x,x,x,x,x,x,x,x,x,x,x]      %     x x x x x x x x x x x x
        ] ).                               %   with cost: 31


% topoMaxCost(Max): Max is an overestimation of the maximum cost of any path
topoMaxCost(Max) :-
    topoMap(M), length(M,NR), M = [Row1|_], length(Row1,NC),
    Max is NR*NC*3.           %% 3 is the maximum cost of one step


estadoInicial([X,Y]) :-
    topoMap(M), nth1(X,M,Row), nth1(Y,Row,i), !.   %% nth1(N,L,X) means "the Nth element of list L is X"

estadoFinal([X,Y]) :-
    topoMap(M), nth1(X,M,Row), nth1(Y,Row,f), !.   %% nth1(N,L,X) means "the Nth element of list L is X"

estadoNormal([X,Y],V) :-
    topoMap(M), nth1(X,M,Row), nth1(Y,Row,V), !.   %% nth1(N,L,X) means "the Nth element of list L is X"


main:-
    estadoInicial(EstadoInicial), estadoFinal(EstadoFinal),
    topoMaxCost(Max),
    between( 1, Max, CosteMax ),               % Buscamos solucion de coste 1; si no, de 2, etc.
    camino( CosteMax, EstadoInicial, EstadoFinal, [EstadoInicial], Camino ),
    displaySol( Camino ), nl,
    write('with cost: '), write(CosteMax), nl, halt.


camino( 0, E, E, C, C ):- !.
camino( CosteMax, EstadoActual, EstadoFinal, CaminoHastaAhora, [EstadoSiguiente|CaminoTotal] ) :-
    topoMap(M), length(M,NR), M = [Row1|_], length(Row1,N),
   % write(EstadoActual), write(' -> '), 
    unPaso( CostePaso, EstadoActual, EstadoSiguiente,N,NR),
   % write(EstadoSiguiente), nl,
    \+ member(EstadoSiguiente, CaminoHastaAhora),
    CosteMax1 is CosteMax-CostePaso,
    camino( CosteMax1, EstadoSiguiente, EstadoFinal, [EstadoSiguiente|CaminoHastaAhora], CaminoTotal ).


%% costPos(E, C): the cost of moving to a topoMap location with content E is C.
%% May be used in the predicate unPaso
costPos(f, 1) :- !.  % move to the final state (f): cost 1.
costPos(E, E).       % move to a normal position in the topoMap: cost 1, 2 or 3

unPaso(C,   [XI,YI], [XF,YI],N,NR):-     XI > 1,       XF is XI - 1, coste(C, [XF,YI]). % Vertical
unPaso(C,   [XI,YI], [XF,YI],N,NR):-     XI + 1 =< NR,  XF is XI + 1, coste(C, [XF,YI]). % Horitzontal
unPaso(C,   [XI,YI], [XI,YF],N,NR):-     YI > 1,       YF is YI - 1, coste(C, [XI,YF]). % Esquerra
unPaso(C,   [XI,YI], [XI,YF],N,NR):-     YI + 1 =< N,  YF is YI + 1, coste(C, [XI,YF]). % Dreta

coste(C, [Xf,Yf]):- topoMap(M), nth1(Xf,M,Row), nth1(Yf,Row,L), L \= x, L \= i, costPos(L,C), !.

displaySol(Camino) :-
    topoMap(M), nth1(X,M,Row), nl, nth1(Y,Row,E), writePos(E,X,Y,Camino), fail.
displaySol(_).

writePos(E, _, _, _     ) :- member(E, [i,f,x]),    write(E), write(' '), !.
writePos(E, X, Y, Camino) :- member([X,Y], Camino), write(E), write(' '), !.
writePos(_, _, _, _     ) :- write('  '), !.

