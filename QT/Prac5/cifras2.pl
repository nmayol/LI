permutacion([],[]).
permutacion(L,[X|P]) :- pert_con_resto(X,L,R), permutacion(R,P).

pert_con_resto(X,L,Resto):- append(L1,[X|L2],L), append(L1,L2,Resto).

subcjto([],[]).  %subcjto(L,S) significa "S es un subconjunto de L".
subcjto([X|C],[X|S]):-subcjto(C,S).
subcjto([_|C],S):-subcjto(C,S).

cifras(L,N):- subcjto(L,S), permutacion(S,P), expresion(P,E), N is E, write(E), nl, !.                       

expresion([X],X).                                             
expresion(L,E1+E2):- append(L1,L2,L),  L1\=[],L2\=[],         
                     expresion(L1,E1), expresion(L2,E2).      
expresion(L,E1-E2):- append(L1,L2,L),  L1\=[],L2\=[],         
                     expresion(L1,E1), expresion(L2,E2).      
expresion(L,E1*E2):- append(L1,L2,L),  L1\=[],L2\=[],         
                     expresion(L1,E1), expresion(L2,E2).

        
%%%%%%%%%%%%%% Afegir divisio %%%%%%%%%%%%%%
expresion(L,E1//E2):-   append(L1,L2,L),  L1\=[],L2\=[],         % Dividir la llista en dos subllistes
                        expresion(L1,E1), expresion(L2,E2),      % Recursiu de les dos expressions
 		                E2 \= 0, 0 is E1 mod E2.         % Comprovar que el modul sigui 0.

