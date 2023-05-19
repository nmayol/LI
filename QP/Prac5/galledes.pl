% Hacer aguas: disponemos de un grifo de agua, un cubo de 5 litros y otro de 8 litros.
% Se puede verter el contenido de un cubo en otro (hasta vaciar el primero, o hasta llenar el otro),
% llenar un cubo, o vaciar un cubo del todo. Escribir un programa Prolog que diga la secuencia
% m ́as corta de operaciones para obtener exactamente 4 litros de agua en el cubo de 8 litros.

main:- EstadoInicial = [0,0], EstadoFinal = [0,4],
    between(1,1000,CosteMax), % Buscamos soluci ́on de coste 0; si no, de 1, etc.
    camino( CosteMax, EstadoInicial, EstadoFinal, [EstadoInicial], Camino ),
    reverse(Camino,Camino1), write(Camino1), write(' con coste '), write(CosteMax), nl, halt.

camino( 0, E,E, C,C ). % Caso base: cuando el estado actual es el estado final.
camino( CosteMax, EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal ):-
    CosteMax>0,
    unPaso( CostePaso, EstadoActual, EstadoSiguiente ), % En B.1 y B.2, CostePaso es 1.
    \+member( EstadoSiguiente, CaminoHastaAhora ),
    CosteMax1 is CosteMax-CostePaso,
    camino(CosteMax1,EstadoSiguiente,EstadoFinal, [EstadoSiguiente|CaminoHastaAhora], CaminoTotal).

%%%%%%% omplir una de les dos galledes %%%%%%%
% omplir la 1a %
unPaso(1,[A5,A8],[5,A8]).
% omplir la 2a %
unPaso(1,[A5,A8],[A5,8]).

%%%%%%% buidar una de les dos galledes %%%%%%%
% buidar la 1a %
unPaso(1,[A5,A8],[0,A8]).
% buidar la 2a %
unPaso(1,[A5,A8],[A5,0]).

%%%%%%% buidar a l'altre cub %%%%%%%
% buidar 1a a 2a
unPaso(1,[A5,A8],[B5,B8]):- B8 is min(A8+A5,8), B5 is A5 - B8 + A8.

% buidar 2a a 1a
unPaso(1,[A5,A8],[B5,B8]):- B5 is min(A8+A5,5), B8 is A8 - B5 + A5.

