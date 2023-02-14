
%%%%%%%%%%%%%%%%%%%%% PREDICATS DE TORNADA %%%%%%%%%%%%%%%%%%%%%%%%%%%
unPaso(1,   [0 ,A2,A5,A8,0], [1 ,A2,A5,A8,1]).  % torna 1
unPaso(2,   [A1,0 ,A5,A8,0], [A1,1 ,A5,A8,1]).  % torna 2
unPaso(5,   [A1,A2,0 ,A8,0], [A1,A2,1 ,A8,1]).  % torna 5
unPaso(8,   [A1,A2,A5,0 ,0], [A1,A2,A5,1 ,1]).  % torna 8 

%%%%%%%%%%%%%%%%%%%% PREDICATS ANADA 1 PERS %%%%%%%%%%%%%%%%%%%%%%%%%%
unPaso(1,   [1 ,A2,A5,A8,1], [0 ,A2,A5,A8,0]).  % va 1
unPaso(2,   [A1,1 ,A5,A8,1], [A1,0 ,A5,A8,0]).  % va 2
unPaso(5,   [A1,A2,1 ,A8,1], [A1,A2,0 ,A8,0]).  % va 5
unPaso(8,   [A1,A2,A5,1 ,1], [A1,A2,A5,0 ,0]).  % va 8

%%%%%%%%%%%%%%%%%%%% PREDICATS ANADA 2 PERS %%%%%%%%%%%%%%%%%%%%%%%%%%
unPaso(2,   [1 ,1 ,A5,A8,1], [0 ,0 ,A5,A8,0]).  % va 1 i 2
unPaso(5,   [1 ,A2,1 ,A8,1], [0 ,A2,0 ,A8,0]).  % va 1 i 5
unPaso(8,   [1 ,A2,A5,1 ,1], [0 ,A2,A5,0 ,0]).  % va 1 i 8

unPaso(5,   [A1,1 ,1 ,A8,1], [A1,0 ,0 ,A8,0]).  % va 2 i 5
unPaso(8,   [A1,1 ,A5,1 ,1], [A1,0 ,A5,0 ,0]).  % va 2 i 8

unPaso(8,   [A1,A2,1 ,1 ,1], [A1,A2,0 ,0 ,0]).  % va 5 i 8

% Estructura estat: 1 marca si la persona [1|2|5|8] es a l'origen, l'ultima posicio marca si la llanterna es a l'origen.
main :- EstadoInicial = [1,1,1,1,1], EstadoFinal = [0,0,0,0,0],
between(1, 1000, CosteMax), % Buscamos solución de coste 0; si no, de 1, etc.
camino( CosteMax, EstadoInicial, EstadoFinal, [EstadoInicial], Camino ),
reverse(Camino, Camino1), write(Camino1), write(' con coste '), write(CosteMax), nl, halt.

camino( 0, E,E, C,C ). % Caso base: cuando el estado actual es el estado final.
camino( CosteMax, EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal ) :-
    CosteMax > 0,
    unPaso( CostePaso, EstadoActual, EstadoSiguiente),
    \+ member( EstadoSiguiente, CaminoHastaAhora ),
    CosteMax1 is CosteMax-CostePaso,
    camino(CosteMax1, EstadoSiguiente, EstadoFinal, [EstadoSiguiente | CaminoHastaAhora], CaminoTotal).