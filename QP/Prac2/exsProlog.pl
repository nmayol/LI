%%%%%%%% EXERCICI 1 %%%%%%%%
prod([],1).
prod([X|L],P):-
    prod(L,P1),
    P is P1 * X.

%%%%%%%% EXERCICI 2 %%%%%%%%
pescalar([],[],0).
pescalar([X|L1],[Y|L2],P):-
    pescalar(L1,L2,P1),
    P is X * Y + P1.

%%%%%%%% EXERCICI 3 %%%%%%%%

unio([],[],[]).
unio([],[Y|L2],[Y|LU1]):- unio([],L2,LU1).
unio([X|L1],[],[X|LU1]):- unio(L1,[],LU1).
unio([X|L1],[Y|L2],[X,Y|LU1]):- unio(L1,L2,LU1).


interseccio([],[],[]).
interseccio(_,[],[]).
interseccio([],_,[]).
interseccio([X|L1],L2,[X|LI]):- member(Y,L2), X = Y, interseccio(L1,L2,LI).
interseccio([X|L1],L2,LI):- member(Y,L2), X \= Y, interseccio(L1,L2,LI).

%%%%%%%% EXERCICI 4 %%%%%%%%
% Usando append, escribe un predicado para calcular el 
% ultimo elemento de una lista dada, y otro para calcular 
% la lista inversa de una lista dada.

inverseList([],[]).
inverseList([X|L],LI):-
    inverseList(L,LI1),
    append(LI1,[X],LI).

lastElem(L,X):-
    inverseList(L,LI),
    append([X],L2,LI),!.


%%%%%%%% EXERCICI 5 %%%%%%%%
% Escribe un predicado fib(N,F) que signifique: "F es el N-esimo numero
% de Fibonacci para la N dada". Estos numeros se definen as: fib(1) = 1,
% fib(2) = 1, y si N > 2 entonces fib(N) = fib(N − 1) + fib(N − 2).

fib(1,1).
fib(2,1).
fib(N,F):-
    N1 is N-1,
    fib(N1,F1),
    N2 is N-2,
    fib(N2,F2),
    F is F1 + F2.

%%%%%%%% EXERCICI 6 %%%%%%%%
% Escribe un predicado dados(P,N,L) que signifique: “la lista L expresa una 
% manera de sumar P puntos lanzando N dados”. Por ejemplo: si P es 5 y N es 2,
% una solucion seria [1,4] (notese que la longitud de L es N). Tanto P 
% como N vienen instanciados. El predicado debe ser capaz de generar todas 
% las soluciones posibles.
dados(0,0,[]).
dados(P,N,[X|L]):-
    N \= 0,
    member(X,[1,2,3,4,5,6]),
    P1 is P - X,
    N1 is N - 1,
    dados(P1,N1,L).
    

%%%%%%%% EXERCICI 7 %%%%%%%%
% Escribe un predicado suma demas(L) que, dada una lista de enteros L, se satisface
% si existe algun elemento en L que es igual a la suma de los demas elementos de L,
% y falla en caso contrario.

sumList([],0).
sumList([X|L],S):-
    sumList(L,S1),
    S is S1 + X.

suma_demas([]).
suma_demas(L):-
    select(X,L,NL), sumList(NL,X).


%%%%%%%% EXERCICI 8 %%%%%%%%
% Escribe un predicado suma ants(L) que, dada una lista de enteros L, se satisface si
% existe algun elemento en L que es igual a la suma de los elementos anteriores a el
% en L, y falla en caso contrario
suma_ants([]).
suma_ants(L):-
    member(X,L),
    % write(X), write(' '), write(L), nl,
    append(L1,[X|L2],L),
    sumList(L1,X).

%%%%%%%% EXERCICI 9 %%%%%%%%
% Escribe un predicado card(L) que, dada una lista de enteros L, escriba la lista que,
% para cada elemento de L, dice cuantas veces aparece este elemento en L. Por ejemplo,
% si hacemos la consulta card( [1,2,1,5,1,3,3,7] ) el interprete escribira:
%     [[1,3],[2,1],[5,1],[3,2],[7,1]].

card(L):- cards(L,Res), write(Res).

cards([],[]).
cards([X|L],[[X,Occ]|Res]):-
    delete(L, X, LR),
    %write(L), write(' '), write(LR), write(' '), write(X), nl,
    length(L,SL),
    length(LR,SR),
    Occ is SL - SR + 1,
    % write([X,Occ]), 
    cards(LR,Res).
    
    
%%%%%%%% EXERCICI 10 %%%%%%%%
% Escribe un predicado esta ordenada(L) que signifique: "la lista L de numeros enteros
% esta ordenada de menor a mayor". Por ejemplo, a la consulta: ?-esta ordenada([3,45,67,83]).
% el interprete responde yes, y a la consulta: ?-esta ordenada([3,67,45]). responde no.

esta_ordenada([_]):-!.
esta_ordenada([X,Y|L]):-
    X =< Y,
    %write(X),
    append([Y],L,L1),
    %write(L1),
    esta_ordenada(L1).


%%%%%%%% EXERCICI 11 %%%%%%%%
% Escribe un predicado ord(L1,L2) que signifique: “L2 es la lista de enteros L1 ordenada
% de menor a mayor”. Por ejemplo: si L1 es [4,5,3,3,2] entonces L2 seria [2,3,3,4,5]. Hazlo
% en una linea, usando solo los predicados permutacion y esta ordenada.

ord(L1,L2):- permutation(L1,L2), esta_ordenada(L2).


%%%%%%%% EXERCICI 12 %%%%%%%%
% Escribe un predicado diccionario(A,N) que, dado un alfabeto A de simbolos y un natural N,
% escriba todas las palabras de N simbolos, por orden alfabetico (el orden alfabetico es segun
% el alfabeto A dado). Por ejemplo, diccionario( [ga,chu,le],2) escribiria:
%     gaga gachu gale chuga chuchu chule lega lechu lele.
diccionario(A,N):-
    subset()
