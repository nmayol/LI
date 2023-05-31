main:- EstadoInicial = [0,0,0,0,0], EstadoFinal = [1,1,1,1,1],
    between(1,1000,CosteMax), % Buscamos soluci´on de coste 0; si no, de 1, etc.
    camino( CosteMax, EstadoInicial, EstadoFinal, [EstadoInicial], Camino ),
    reverse(Camino,Camino1), write(Camino1), write(' con coste '), write(CosteMax), nl, halt.
camino( 0, E,E, C,C ). % Caso base: cuando el estado actual es el estado final.
camino( CosteMax, EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal ):-
    CosteMax>0,
    unPaso( CostePaso, EstadoActual, EstadoSiguiente ), % En B.1 y B.2, CostePaso es 1.
    \+member( EstadoSiguiente, CaminoHastaAhora ),
    CosteMax1 is CosteMax-CostePaso,
camino(CosteMax1,EstadoSiguiente,EstadoFinal, [EstadoSiguiente|CaminoHastaAhora], CaminoTotal).


unPaso(1,[0,P2,P5,P8,0],[1,P2,P5,P8,1]). 
unPaso(1,[1,P2,P5,P8,1],[0,P2,P5,P8,0]). 

unPaso(2,[P1,0,P5,P8,0],[P1,1,P5,P8,1]). 
unPaso(2,[P1,1,P5,P8,1],[P1,0,P5,P8,0]). 

unPaso(5,[P1,P2,0,P8,0],[P1,P2,1,P8,1]). 
unPaso(5,[P1,P2,1,P8,1],[P1,P2,0,P8,0]). 

unPaso(8,[P1,P2,P5,0,0],[P1,P2,P5,1,1]). 
unPaso(8,[P1,P2,P5,1,1],[P1,P2,P5,0,0]). 


unPaso(2,[0,0,P5,P8,0],[1,1,P5,P8,1]). 
unPaso(2,[1,1,P5,P8,1],[0,0,P5,P8,0]). 

unPaso(5,[0,P2,0,P8,0],[1,P2,1,P8,1]). 
unPaso(5,[1,P2,1,P8,1],[0,P2,0,P8,0]). 

unPaso(8,[0,P2,P5,0,0],[1,P2,P5,1,1]). 
unPaso(8,[1,P2,P5,1,1],[0,P2,P5,0,0]).


unPaso(5,[P1,0,0,P8,0],[P1,1,1,P8,1]). 
unPaso(5,[P1,1,1,P8,1],[P1,0,0,P8,0]). 

unPaso(8,[P1,0,P5,0,0],[P1,1,P5,1,1]). 
unPaso(8,[P1,1,P5,1,1],[P1,0,P5,0,0]). 


unPaso(8,[P1,P2,0,0,0],[P1,P2,1,1,1]). 
unPaso(8,[P1,P2,1,1,1],[P1,P2,0,0,0]).
