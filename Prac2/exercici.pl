
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

union([],[],[]).
union([L1|List1],[L2|List2],[L3|List3]):-

interseccion([],[],[]).