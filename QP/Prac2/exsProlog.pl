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

%%%%%%%% EXERCICI 13 %%%%%%%%
% Escribe un predicado palindromos(L) que, dada una lista de letras L, escriba todas las 
% permutaciones de sus elementos que sean palindromos (capicuas). Por ejemplo, con la consulta
% palindromos([a,a,c,c]) se escribe [a,c,c,a] y [c,a,a,c].

palindromos(L):- palindrom(L,X), write(X), fail.

palindrom([],[]).
palindrom([X],[X]).

% paraules de mida parell
palindrom(L,L1):-
    length(L,Size), N is Size // 2,

    permutation(L,L1),
    append(L11,L12,L1),
    
    length(L11,N), length(L12,N),
    inverseList(L12,L12R),
    L11 = L12R.

% paraules de mida senar
palindrom(L,L1):-
    length(L,Size), N is Size // 2,

    permutation(L,L1),
    append(L11,[Middle|L12],L1),
     
    length(L11,N), length(L12,N),
    inverseList(L12,L12R),
    L11 = L12R.

%%%%%%%% EXERCICI 14 %%%%%%%%
% Encuentra mediante un programa Prolog, usando el predicado permutacion, que
% 8 dıgitos diferentes tenemos que asignar a las letras S, E, N, D, M, O, R, Y,
% de manera que se cumpla la suma siguiente:
%
%       S   E   N   D
%   +   M   O   R   E
%  --------------------
%   M   O   N   E   Y  
%

result:- sendMoreMoney([S, E, N, D, M, O, R, Y]),
    write('S = '), write(S), nl,
    write('E = '), write(E), nl,
    write('N = '), write(N), nl,
    write('D = '), write(D), nl,
    write('M = '), write(M), nl,
    write('O = '), write(O), nl,
    write('R = '), write(R), nl,
    write('Y = '), write(Y), nl,
    !.

sendMoreMoney([S, E, N, D, M, O, R, Y]):-
    Digits = [0,1,2,3,4,5,6,7,8,9],
    Res = [S, E, N, D, M, O, R, Y, _, _],
    permutation(Digits,Res),

    Money is Y + 10*E + 100*N + 1000*O + 10000*M,
    Send is D + 10*N + 100*E + 1000*S,
    More is E + 10*R + 100*O + 1000*M,

    SendMore is Send + More,
    SendMore = Money.



%%%%%%%% EXERCICI 16 %%%%%%%%
% Queremos obtener en Prolog un predicado dom(L) que, dada una lista L de fichas de
% domino (en el formato de abajo), escriba una cadena de domino usando todas las 
% fichas de L, o escriba “no hay cadena” si no es posible. Por ejemplo, 
%     ?- dom( [ f(3,4), f(2,3), f(1,6), f(2,2), f(4,2), f(2,1) ] ).
% escribe la cadena correcta:
%     [ f(2,3), f(3,4), f(4,2), f(2,2), f(2,1), f(1,6) ].
% Tambien podemos girar alguna ficha como f(N,M), reemplazandola por f(M,N). Asi, para:
%     ?- dom ([ f(4,3), f(2,3), f(1,6), f(2,2), f(2,4), f(2,1) ]).
% solo hay cadena si se gira alguna ficha (por ejemplo, hay la misma cadena que antes).
% El siguiente programa Prolog aun no tiene en cuenta los posibles giros de fichas, ni
% tiene implementado el predicado ok(P), que significa: "P es una cadena de domino
% correcta (tal cual, sin necesidad ya de girar ninguna ficha)":

p([],[]).
p(L,[X|P]) :- select(X,L,R), p(R,P).

dom(L) :- p(L,P), 
    ok(P),
    write(P),
    nl.
dom(_) :- write('no hay cadena'), nl.

% (a) ¿Que significa el predicado p(L,P) para una lista L dada? La deixa absolutament igual
% (b) Escribe el predicado ok(P) que falta.


