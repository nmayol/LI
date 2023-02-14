
%           [missioners1,canibals1,missioners2,canibals2]
unPaso(1,   [M1,C1,M2,C2], [M3,C1,M4,C2]):- M1 >= 2, M1-2 >= C1, M3 is M1-2, M4 is M2+2.  % Transportem dos missioners
unPaso(1,   [M1,C1,M2,C2], [M1,C3,M2,C4]):- C1 >= 2, not(C2+2 > M2), C3 is C1-2, C4 is C2+2. % Transportem dos canibals
unPaso(1,   [M1,C1,M2,C2], [M3,C3,M4,C4]):- M1 >= 1, C1 >= 1, M2+1 >= C2+1, M3 is M1-1, M4 is M2+1, C3 is C1-1, C4 is C2+1.  % Transportem un missioner i un canibal
unPaso(1,   [M1,C1,M2,C2], [M3,C1,M4,C2]):- M1 >= 1, M1-1>=C1, M3 is M1-1, M4 is M2+1.  % Transportem un missioner
unPaso(1,   [M1,C1,M2,C2], [M1,C3,M2,C4]):- C1 >= 1, not(C2+1 > M2), C3 is C1-1, C4 is C2+1.  % Transportem un canibal




main :- EstadoInicial = [3,3,0,0], EstadoFinal = [0,0,3,3],
between(1, 1000, CosteMax), % Buscamos solución de coste 0; si no, de 1, etc.
camino( CosteMax, EstadoInicial, EstadoFinal, [EstadoInicial], Camino ),
reverse(Camino, Camino1), write(Camino1), write(' con coste '), write(CosteMax), nl, halt.

camino( 0, E,E, C,C ). % Caso base: cuando el estado actual es el estado final.
camino( CosteMax, EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal ) :-
    CosteMax > 0,
    unPaso( CostePaso, EstadoActual, EstadoSiguiente ),
    \+ member( EstadoSiguiente, CaminoHastaAhora ),
    CosteMax1 is CosteMax-CostePaso,
    camino(CosteMax1, EstadoSiguiente, EstadoFinal, [EstadoSiguiente | CaminoHastaAhora], CaminoTotal).