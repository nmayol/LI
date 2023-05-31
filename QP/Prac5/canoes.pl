% Buscamos la manera mas rapida para tres misioneros y tres canibales de cruzar un rio
% en una canoa que puede ser utilizada por 1 o 2 personas (misioneros o canibales), pero siempre
% evitando que los misioneros queden en minoria en cualquier orilla (por razones obvias).

% l'estat merca el nombre de missioners i de canibals a la costa B
main:- EstadoInicial = [3,3,0,0,1], EstadoFinal = [0,0,3,3,0],
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


correcte(MAF,CAF,MBF,CBF):-
    MAF =< 3, MAF >= 0,
    CAF =< 3, CAF >= 0,
    MAF >= CAF,
    MBF =< 3, MBF >= 0,
    CBF =< 3, CBF >= 0,
    MBF >= CBF,!.
correcte(MAF,CAF,MBF,CBF):-
    MAF =< 3, MAF >= 0,
    CAF =< 3, CAF >= 0,
    MAF = 0,
    MBF =< 3, MBF >= 0,
    CBF =< 3, CBF >= 0,
    MBF >= CBF,!.
correcte(MAF,CAF,MBF,CBF):-
    MAF =< 3, MAF >= 0,
    CAF =< 3, CAF >= 0,
    MAF >= CAF,
    MBF =< 3, MBF >= 0,
    CBF =< 3, CBF >= 0,
    MBF = 0,!.


printEstat(MA,CA,MB,CB,1):-
    write('A*  | B'), nl,
    write(MA), write('  | '), write(MB),nl,
    write(CA), write('  | '), write(CB),nl,
    write('----------------'),nl.
printEstat(MA,CA,MB,CB,0):-
    write('A   | B*'), nl,
    write(MA), write('  | '), write(MB),nl,
    write(CA), write('  | '), write(CB),nl,
    write('----------------'),nl.

%%%%% passa una persona %%%%%
% missioner A -> B
unPaso(1, [MAI,CAI,MBI,CBI,1], [MAF,CAF,MBF,CBF,0]):-
    MAF is MAI - 1,
    CAF is CAI,
    MBF is MBI+1,
    CBF is CBI,
    correcte(MAF,CAF,MBF,CBF), printEstat(MAF,CAF,MBF,CBF,0).

% missioner B -> A
unPaso(1, [MAI,CAI,MBI,CBI,0], [MAF,CAF,MBF,CBF,1]):-
    MBF is MBI - 1,
    CBF is CBI,
    MAF is MAI+1,
    CAF is CAI,
    correcte(MAF,CAF,MBF,CBF), printEstat(MAF,CAF,MBF,CBF,1).

% canibal A-> B
unPaso(1, [MAI,CAI,MBI,CBI,1], [MAF,CAF,MBF,CBF,0]):-
    CAF is CAI - 1,
    MAF is MAI,
    CBF is CBI+1,
    MBF is MBI,
    correcte(MAF,CAF,MBF,CBF), printEstat(MAF,CAF,MBF,CBF,0).

% canibal B -> A
unPaso(1, [MAI,CAI,MBI,CBI,0], [MAF,CAF,MBF,CBF,1]):-
    CBF is CBI - 1,
    MBF is MBI,
    CAF is CAI+1,
    MAF is MAI,
    correcte(MAF,CAF,MBF,CBF), printEstat(MAF,CAF,MBF,CBF,1).

%%%%% passen dos persones %%%%%
% missioners A -> B
unPaso(1, [MAI,CAI,MBI,CBI,1], [MAF,CAF,MBF,CBF,0]):-
    MAF is MAI - 2,
    CAF is CAI,
    MBF is MBI+2,
    CBF is CBI,
    correcte(MAF,CAF,MBF,CBF), printEstat(MAF,CAF,MBF,CBF,0).

% missioners B -> A
unPaso(1, [MAI,CAI,MBI,CBI,0], [MAF,CAF,MBF,CBF,1]):-
    MBF is MBI - 2,
    CBF is CBI,
    MAF is MAI+2,
    CAF is CAI,
    correcte(MAF,CAF,MBF,CBF), printEstat(MAF,CAF,MBF,CBF,0).

% canibals A-> B
unPaso(1, [MAI,CAI,MBI,CBI,1], [MAF,CAF,MBF,CBF,0]):-
    CAF is CAI - 2,
    MAF is MAI,
    CBF is CBI+2,
    MBF is MBI,
    correcte(MAF,CAF,MBF,CBF), printEstat(MAF,CAF,MBF,CBF,0).

% canibals B -> A
unPaso(1, [MAI,CAI,MBI,CBI,0], [MAF,CAF,MBF,CBF,1]):-
    CBF is CBI - 2,
    MBF is MBI,
    CAF is CAI+2,
    MAF is MAI,
    correcte(MAF,CAF,MBF,CBF), printEstat(MAF,CAF,MBF,CBF,1).

% missioner i canibal A -> B
unPaso(1, [MAI,CAI,MBI,CBI,1], [MAF,CAF,MBF,CBF,0]):-
    MAF is MAI - 1,
    CAF is CAI - 1,
    MBF is MBI+1,
    CBF is CBI+1,
    correcte(MAF,CAF,MBF,CBF), printEstat(MAF,CAF,MBF,CBF,0).

% missioner i canibal B -> A
unPaso(1, [MAI,CAI,MBI,CBI,0], [MAF,CAF,MBF,CBF,1]):-
    MBF is MBI - 1,
    CBF is CBI - 1,
    MAF is MAI+1,
    CAF is CAI+1,
    correcte(MAF,CAF,MBF,CBF), printEstat(MAF,CAF,MBF,CBF,1).
