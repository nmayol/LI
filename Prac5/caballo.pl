
unPaso(1,   [XI,YI], [XF,YF], N):-     XI + 2 <  N,    YI - 1 >= 0, XF is XI + 2, YF is YI - 1. % dreta dalt
unPaso(1,   [XI,YI], [XF,YF], N):-     XI + 2 <  N,    YI + 1 <  N, XF is XI + 2, YF is YI + 1. % dreta baix
unPaso(1,   [XI,YI], [XF,YF], N):-     XI - 2 >= 0,    YI - 1 >= 0, XF is XI - 2, YF is YI - 1. % esquerra dalt
unPaso(1,   [XI,YI], [XF,YF], N):-     XI - 2 >= 0,    YI + 1 <  N, XF is XI - 2, YF is YI + 1. % esquerra baix
unPaso(1,   [XI,YI], [XF,YF], N):-     XI - 1 >= 0,    YI - 2 >= 0, XF is XI - 1, YF is YI - 2. % dalt esquerra
unPaso(1,   [XI,YI], [XF,YF], N):- not(XI + 1 >= N),   YI - 2 >= 0, XF is XI + 1, YF is YI - 2. % dalt dreta
unPaso(1,   [XI,YI], [XF,YF], N):-     XI - 1 >= 0,    YI + 2 <  N, XF is XI - 1, YF is YI + 2. % baix esquerra
unPaso(1,   [XI,YI], [XF,YF], N):- not(XI + 1 >= N),   YI + 2 <  N, XF is XI + 1, YF is YI + 2. % baix dreta

% Movem el caball a la dreta(dalt), a l'esquerra, a dalt i a baix

main(N,P) :- EstadoInicial = [0,0], EstadoFinal = [3,5],
camino( P, EstadoInicial, EstadoFinal, [EstadoInicial], Camino, N),
reverse(Camino, Camino1), write(Camino1), write(' con coste '), write(P), nl, halt.

camino( 0, E,E, C,C,N ). % Caso base: cuando el estado actual es el estado final.
camino( CosteMax, EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal, N) :-
    CosteMax > 0,
    unPaso( CostePaso, EstadoActual, EstadoSiguiente, N),
    \+ member( EstadoSiguiente, CaminoHastaAhora ),
    CosteMax1 is CosteMax-CostePaso,
    camino(CosteMax1, EstadoSiguiente, EstadoFinal, [EstadoSiguiente | CaminoHastaAhora], CaminoTotal,N).