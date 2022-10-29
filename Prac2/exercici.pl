
% 1. Escribe un predicado prod(L,P) que signifique: "P es el producto de los elementos de la lista
% de enteros dada L". Debe poder generar la P y tambien comprobar una P dada.
prod([],1).
prod([L1|List], P):- prod(List, P1), P is L1*P1.


% 2. Escribe un predicado pescalar(L1,L2,P) que signifique: "P es el producto escalar de los
% vectores L1 y L2", donde los vectores se representan como listas de enteros. El predicado debe
% fallar si los dos vectores tienen longitudes distintas.

pescalar([],[],0).
pescalar([L1|List1],[L2|List2],R):- pescalar(List1,List2,R1), R is R1 + L1*L2.


% 3. Representando conjuntos con listas sin repeticiones, escribe predicados para las operaciones de
% interseccion y union de conjuntos dados.

% unio:
union([],L,L).
union([X|L1],L2,L3):-
	member(X,L2), !,  	
	union(L1,L2,L3).
union([X|L1],L2,[X|L3]):-
    union(L1,L2,L3).

%interseccio:
interseccion([], _, []).
interseccion([X|L1], L2, [X|L3]):-
    member(X, L2), !,
    rm(X,L2,L21),
    interseccion(L1,L21,L3).
interseccion([_|L1], L2, L3):- 
    interseccion(L1, L2, L3).

rm(X, L, NewL):- append(L1, [X|L2], L), append(L1, L2, NewL).


% 4. Usando append, escribe un predicado para calcular el ultimo elemento de una lista dada, y otro
% para calcular la lista inversa de una lista dada.

ultim(L,Last):- append(X, [Last], L).

reverse([],[]).
reverse(L,Last|X):- ultim(L,Last),
    rm(Last,L,NewL), reverse(NewL,X). % predicat rm definit a exercici 4.

% 5. Escribe un predicado fib(N,F) que significa que: \F es el N-esimo numero de Fibonacci para la
% N dada". Estos numeros se definen asi: fib(1) = 1, fib(2) = 1, y si N > 2 entonces fib(N) =
% fib(N - 1) + fib(N - 2).

fib(0,0).
fib(2,1).
fib(1,1).
fib(N,F):-
    N1 is N - 1,
    N2 is N - 2,
    fib(N2,F2),
    fib(N1,F1),
    F is F1 + F2.


% 6. Escribe un predicado dados(P,N,L) que signique: \la lista L expresa una manera de sumar
% P puntos lanzando N dados". Por ejemplo: si P es 5 y N es 2, una solucion sera [1,4] (notese
% que la longitud de L es N). Tanto P como N vienen instanciados. El predicado debe ser capaz de
% generar todas las soluciones posibles.

dados(0,0,[]).
dados(P,N,[X|L]):-
    N \= 0,
    member(X, [1,2,3,4,5,6]),
    P1 is P - X, N1 is N-1,
    dados(P1, N1, L).


