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


% 7. Escribe un predicado suma_demas(L) que, dada una lista de enteros L, se satisface si existe algun
% elemento en L que es igual a la suma de los demas elementos de L, y falla en caso contrario.

suma_demas([]).
suma_demas(L):-
    rm(X,L,NL), suma(NL,X).

suma([],0).
suma([Y|NL],R):-
    suma(NL,R1), R is R1 + Y.


% 8. Escribe un predicado suma ants(L) que, dada una lista de enteros L, se satisface si existe algun
% elemento en L que es igual a la suma de los elementos anteriores a el en L, y falla en caso
% contrario.

suma_ants([]).
suma_ants(L):-
    append(L1,[X|L2],L), 
    suma(L1,X).

% 9. Escribe un predicado card(L) que, dada una lista de enteros L, escriba la lista que, para cada
% elemento de L, dice cuantas veces aparece este elemento en L.
 
pert_con_resto(X, L, R) :-
	append(L1, [X|L2], L),
    append(L1, L2, R).

car([],[]).
car([X|L],[[X,N1]|Cr]):-
    car(L,C),
    pert_con_resto([X,N],C,Cr), !,
    N1 is N+1.
car([X|L],[[X,1]|C]):-car(L,C).

card(L):-car(L,C),write(C).


% 10. Escribe un predicado esta ordenada(L) que signique: \la lista L de numeros enteros esta
% ordenada de menor a mayor". Por ejemplo, a la consulta:

esta_ordenada([]).
esta_ordenada([_]).   
esta_ordenada([L1,L2|L]):-
    L1 < L2,
    esta_ordenada([L2|L]).
    
% 11. Escribe un predicado ord(L1,L2) que signique: \L2 es la lista de enteros L1 ordenada de
% menor a mayor". Por ejemplo: si L1 es [4,5,3,3,2] entonces L2 sera [2,3,3,4,5]. Hazlo en
% una linea, usando solo los predicados permutacion y esta ordenada.

ord(L1,L2):- permutation(L1,L2), esta_ordenada(L2).


% 12. Escribe un predicado diccionario(A,N) que, dado un alfabeto A de simbolos y un natural N,
% escriba todas las palabras de N simbolos, por orden alfabetico (el orden alfabetico es segun el
% alfabeto A dado).

diccionario(A,N):- perm(A,N,R), printP(R), write(', '), fail.

perm(_,0,[]):- !.
perm(A, N, [PA|R]):-
    member(PA,A),
    N1 is N-1,
    perm(A, N1, R).

printP([]).
printP([Relem|R]):- write(Relem), printP(R). 


% 13. Escribe un predicado palindromos(L) que, dada una lista de letras L, escriba todas las per-
% mutaciones de sus elementos que sean palindromos (capicuas)

pld([]).
pld([_]).
pld([L1|L]):-
    ultim(L, Last),
    L1 = Last,
    rm(Last,L,NL),
    pld(NL).

palindromos(L):- permutation(L,R), pld(R), printP(R), write(', '), fail.

% 14. Encuentra mediante un programa Prolog, usando el predicado permutacion, que 8 digitos difer-
% entes tenemos que asignar a las letras S, E, N, D, M, O, R, Y, de manera que se cumpla la suma
% siguiente:

solve:-
    LLETRES = [S, E, N, D, M, O, R, Y, _, _],
    VALORS = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
    permutation(LLETRES,VALORS),
    Suma is (1000 * S) + (100 * E) + (10 * N) + (D) +
            (1000 * M) + (100 * O) + (10 * R) + (E),

    Suma is (10000 * M) + (1000 * O) + (100 * N) + (10 * E) + (Y),
    print(LLETRES).

print([S, E, N, D, M, O, R, Y, _, _]):-
    write('S = '), write(S), write(' / '),
    write('E = '), write(E), write(' / '),
    write('N = '), write(N), write(' / '),
    write('D = '), write(D), write(' / '),
    write('M = '), write(M), write(' / '),
    write('O = '), write(O), write(' / '),
    write('R = '), write(R), write(' / '),
    write('Y = '), write(Y).

% 15. Escribe un predicado simplifica que pueda usarse en combinacion con el programa de calcular
% derivadas.

der(X, X, 1):-!.
der(C, _, 0) :- number(C).
der(A+B, X, A1+B1) :- der(A, X, A1), der(B, X, B1).
der(A-B, X, A1-B1) :- der(A, X, A1), der(B, X, B1).
der(A*B, X, A*B1+B*A1) :- der(A, X, A1), der(B, X, B1).
der(sin(A), X, cos(A)*B) :- der(A, X, B).
der(cos(A), X, -sin(A)*B) :- der(A, X, B).
der(e^A, X, B*e^A) :- der(A, X, B).
der(ln(A), X, B*1/A) :- der(A, X, B).


simplifica(E,E1):- unpaso(E,E2),!, simplifica(E2,E1).
simplifica(E,E).

unpaso(A+B,A+C):- unpaso(B,C),!.
unpaso(B+A,C+A):- unpaso(B,C),!.
unpaso(A*B,A*C):- unpaso(B,C),!.
unpaso(B*A,C*A):- unpaso(B,C),!.
unpaso(0*_,0):-!.
unpaso(_*0,0):-!.
unpaso(1*X,X):-!.
unpaso(X*1,X):-!.
unpaso(0+X,X):-!.
unpaso(X+0,X):-!.
unpaso(N1+N2,N3):- number(N1), number(N2), N3 is N1+N2,!.
unpaso(N1*N2,N3):- number(N1), number(N2), N3 is N1*N2,!.
unpaso(N1*X+N2*X,N3*X):- number(N1), number(N2), N3 is N1+N2,!.
unpaso(N1*X+X*N2,N3*X):- number(N1), number(N2), N3 is N1+N2,!.
unpaso(X*N1+N2*X,N3*X):- number(N1), number(N2), N3 is N1+N2,!.
unpaso(X*N1+X*N2,N3*X):- number(N1), number(N2), N3 is N1+N2,!.


% 16.

% Codi donat de l'enunciat:

p([],[]).
p(L,[X|P]) :- select(X,L,R), p(R,P).

% select esborra l'element X de L i posa el resultat a R.
% a) p tindra una combinacio de les fitxes.

dom(L) :- p(L,P), ok(P), write(P), nl.
dom( ) :- write('no hay cadena'), nl.

% b) Predicat ok.

ok([_]):-!.
ok([Y|P]):-
    append([Y1],[Y2],Y),
    append([E],P1,P),
    append([E1],[E2],E),
    E1 = Y2,
    ok(P).

% c) tornar a escriure p

dom2(L) :- p2(L,P), ok(P), write(P), nl.
dom2( ) :- write('no hay cadena'), nl.

p2([],[]).
p2(L,P):-p21(L,_,P).

p21([],_,[]):-!.
p21(L,Element,[X1|P]):-
    select(X,L,R),
    
    permutation(X,X1),
    append([Element1],[Element2],X1),
    p21(R,Element2,P).

% 17. Complete the following backtracking procedure for SAT in Prolog. Program everything, except
% the predicate readclauses(F), which reads a list of clauses, where each clause is a list of integers.
% For example, p3 _ :p6 _ p2 is represented by [3,-6,2]. Do things as simple as possible.

% decision_lit(F,Lit):-
%     select(Lit,F,R).

% p:- readclauses(F), sat([],F).
% p:- write('UNSAT'),nl.
% sat(I,[]):- write('IT IS SATISFIABLE. Model: '), write(I),nl,!.
% sat(I,F):-
%     decision_lit(F,Lit), % Select unit clause if any; otherwise, an arbitrary one.
%     simplif(Lit,F,F1), % Simplifies F. Warning: may fail and cause backtracking
%     sat(,).


% 18. Consider two groups of 10 people each. In the first group, as expected, the percentage of people
% with lung cancer among smokers is higher than among non-smokers. In the second group, the
% same is the case. But if we consider the 20 people of the two groups together, then the situation
% is the opposite: the proportion of people with lung cancer is higher among non-smokers than
% among smokers! Can this be true? Write a little Prolog program to and it out.

num(X):- between(1,7,X). % below, e.g. SNC1 denotes "num. smokers with no cancer group 1".

p:- num(SC1), num(SNC1), num(NSC1), num(NSNC1),
    10 is SC1+SNC1+NSC1+NSNC1,                                              % Defineix subgrups del grup 1 i comprova que sumin 10.
    SC1/(SC1+SNC1) > NSC1/(NSC1+NSNC1),                                     % Hi ha mes cancer entre els fumadors (grup1)
    num(SC2), num(SNC2), num(NSC2), num(NSNC2), 
    10 is SC2+SNC2+NSC2+NSNC2,                                              % Defineix subgrups del grup 2 i comprova que sumin 10. 
    SC2/(SC2+SNC2) > NSC2/(NSC2+NSNC2),                                     % Hi ha més prop de cancer entre els fumadors.
    (SC1+SC2)/(SC1+SNC1+SC2+SNC2) < (NSC1+NSC2)/(NSC1+NSNC1+NSC2+NSNC2),    % Pero la proporcio de la suma es mes gran per la gent sense cancer
write([ SC1,SNC1,NSC1,NSNC1,SC2,SNC2,NSC2,NSNC2]), nl, fail, !.



% 19. Supongamos que tenemos una maquina que dispone de monedas de valores [X1,...Xn] y tiene
% que devolver una cantidad C de cambio utilizando el minimo numero de monedas. Escribe un
% programa Prolog maq(L,C,M) que, dada la lista de monedas L y la cantidad C, genere en M la
% lista de monedas a devolver de cada tipo. Por ejemplo, si L es [1,2,5,13,17,35,157], y C es
% 361, entonces una respuesta es [0,0,0,1,2,0,2] (5 monedas)

suma_cost(_,0,[]).
suma_cost([X|L],S,[Y|M]):-
    Y >= 0,
    S >= 0,
    S1 is S - X*Y,
    suma_cost(L,S1,M).
    
    
lessThan(_,[]).
lessThan(N,[I|M]):-
    between(0,N,I),
    N2 is N - I,
    lessThan(N2,M).

maq(L,C,M):-
    length(L,SizeL), length(M,SizeL),
    between(0,C,Min),
    lessThan(Min,M),

    suma_cost(L,C,M), !.


% 20. Write in Prolog a predicate flatten(L,F) that flattens" (cast.: \aplana") the list F

flatten([], []) :- !.

flatten([L1|L], F) :- !,
    flatten(L1, F1),
    flatten(L, F2),
    append(F1,F2,F).
flatten(L1, [L1]).

% 21. Escribe un predicado Prolog log(B,N,L) que calcula la parte entera L del logaritmo en base B
% de N, donde B y N son naturales positivos dados. Por ejemplo, ?- log(2,1020,L). escribe L=9?
% Podeis usar la exponenciacion, como en 125 is 5**3. El programa (completo) no debe ocupar
% mas de 3 lineas.

log(_,1,0).
log(B, N, A1):-
    N > 1,
    N1 is N//B,
    log(B, N1, A),
    A1 is A + 1.

% 22. Supongamos que N estudiantes (identificados por un numero entre 1 y N) se quieren matricular
% de LI, pero solo hay espacio para M, con M < N. Ademas nos dan una lista L de pares de estos
% estudiantes que son incompatibles entre si (por ejemplo, porque siempre se copian). Queremos
% obtener un programa Prolog li(N,M,L,S) que, para N, M y L dados, genere un subconjunto S
% con M de los N estudiantes tal que si [x; y] 2 L entonces fx; yg S.

creaEstudiants(0,[]):-!.
creaEstudiants(N,[N|Est]):-
    N1 is N-1,
    creaEstudiants(N1,Est).

subcjto([],[]). 
subcjto([_|C],S) :- subcjto(C,S). 
subcjto([X|C],[X|S]) :- subcjto(C,S).

comprova([],_):-!.
comprova([X|L],S):-
    % write(X),
    not(incompatible(X, S)),
    comprova(L,S).


incompatible(Parella, S):-
    append([P1], [P2], Parella),
    %write(' P1 = '), write(P1), write(' P2 = '), write(P2), write(' '),
    member(P2,S),
    member(P1,S).


li(N,M,L,S):-
    creaEstudiants(N,Est),
    subcjto(Est,C),
    
    length(C,Mida), M = Mida,
    %write(C), nl,
    comprova(L,C),
    write(C), !.


