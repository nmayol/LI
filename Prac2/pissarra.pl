
% INTRODUCCIÓ a Prolog: document p6.pdf
% Exemple de relacions

pare(joan,pere).      % el pare de joan és pere
pare(maria,pere).
germa(pere,victor).
germa(pere,albert).
oncle(X,Y) :-
  pare(X,Z),
  germa(Z,Y).

% Per executar lintèrpret:
% swipl
% apareix el prompt ?-
% escrivim [fitxer]. (en aquest cas, [prolog]) i ja
% podem fer consultes

% Interacció: enter (o .), espai (o ;), a (abortar execució)

% oncle(maria,X).
% oncle(X,Y).


% SINTAXI
% Terme: àtom, nombre, variable, terme compost

% Àtom: comença per minúscula
%   oncle, maria, albert

% es pot consultar si un terme és un àtom amb
% ?- atom(X).
% false.
% ?- atom(atom).
% true.

% Nombre: seqüència de dígits (amb - opcional a linici)

% Variable: comença per majúscula o _
% X, _443, _, Variable

% Terme compost: àtom amb arguments entre parèntesis
% germa(pere,albert), oncle(X,Y), f(g(X,_),8)

% es pot consultar si un terme és compost amb
% ?- compound(f(x)).
% true.
% ?- compound(f).
% false.

% Predicat: àtom o terme compost.

% Fet: predicat seguit de punt:
% 	mes_gran(balena,_). 
% 	la_vida_es_bella.

% Regla: consta dun cap (predicat) i un cos
% (seqüència de predicats separats per comes)

% Clàusula: fet o regla

% Programa: seqüència de clàusules
                                
% Estil: comentaris amb %, indentació


% UNIFICACIÓ

% Com executa lintèrpret un programa Prolog?
% Busca la primera clàusula el cap de la qual sigui
% unificable amb lobjectiu

% unificar = donades dues expressions, donar valors a les seves
% variables perquè siguin iguals

%  el símbol = vol dir és unificable

% | ?- f(X,a) = f(b,Y).
% | ?- f(f(X),a)  =  f(Y,Y).
% | ?- f(f(X),a) \=  f(Y,Y).
% | ?- f(f(X),a)  =  f(Y,Z).

% Seria certa la igualtat següent?
% estima(maria,joan) = estima(Joan,Maria).

% Un altre exemple dunificació
% f(a,g(X,Y)) = f(X,Z), Z = g(W,h(X)).

% EXECUCIÓ DOBJECTIUS
% Quan un objectiu sunifica amb el cap d una regla,
% es fan les instanciacions de variables dins del cos de la regla
% i això dona subobjectius que cal satisfer.
% Prolog sempre prova d unificar l objectiu en l ordre
% en què apareixen les regles.

% L argument clàssic
% Tots els homes són mortals
% Sòcrates és una home
% -----
% Per tant, Sòcrates és mortal
%
% es tradueix en Prolog com

mortal(X) :- home(X).
home(socrates).

% Ara, si preguntem
% ?- mortal(socrates).
% true.

% com fa Prolog la recerca d una demostració?


% LLISTES: seqüències de termes entre parèntesis quadrats
% [elefant, cavall, ruc, gos]
% Poden ser mes complexes:
% [elefant, [], X, pare(joan,Y), [a, b], f(67)]
% [a, b, f(a), g(f(a,X)), [c], X]

% Notació
% [] és la llista buida
% [ a, b | L ] 
% la | separa els primers elements de la resta de la llista

% ?- [a,b,c] = [X|L].

% nota: en realidad una lista [a,b,c] es una notación elegante para el término:   .( a, .(b, .(c,[]) ) )

% Prolog és programació declarativa, no imperativa
% Això fa que els programes siguin versàtils: la mateixa definició
% serveix per molts tipus de consultes.
% Per exemple, podem declarar (definir) què és pertànyer a una llista:
% pert(X,L): X pertany a la llista L
% (ja existeix i es diu member)

pert(X,[X|_]).
pert(X,[_|L]):- pert(X,L).

% concat(L1,L2,L3) =  L3 és la concatenació de L1 amb L2      
% (ja existeix i es diu append)               

concat([],L,L).
concat([X|L1],L2,[X|L3]):- concat(L1,L2,L3).

% ARITMÈTICA

% Podem provar el següent:
% ?- 7 + 4 = 11.
% false.

% Prolog ha provat d unificar 7 + 4 amb 11 i no és possible
% Per avaluar expressions fem servir l operador is

% Var is Expressió   =  unifica el resultat d avaluar Expressió amb Var 

% X is 7 + 4.
% X = 11.

% Ara podem definir, per exemple, el factorial:
% fact(N,F) =  F és el factorial de N   
% F serà  N * (N-1) * ... * 1

fact(0,1):- !.
fact(N,F):- N1 is N-1,  fact(N1,F1), F is N * F1.

% Notem que N no es pot deixar sense instanciar perquè si no
% l operador  is  no podria avaluar el segon argument

% mida(L,N) =  la mida de L és N        
% (ja existeix i es diu length)

mida([],0).
mida([_|L],N):- mida(L,N1), N is N1+1.


% permutacio(L,P) =  P és una permutació de la llista L 
% (ja existeix is es diu permutation)

permutacio([],[]).
permutacio([X|L], P):- 
	permutacio(L,P1),     
	concat(Pa,Pb,P1),
	concat(Pa,[X|Pb],P).

% podem generar totes les permutacions de [a,b,c] amb la consulta
% permutacio([a,b,c],S), write(S), nl, false.


% subcjt(L,S) =  S és un subconjunt de L 
% un conjunt de n elements té 2^n subconjunts

subcjt([],[]).
subcjt([_|L],S):- 
	subcjt(L,S).
subcjt([X|L],[X|S]):- 
	subcjt(L,S).

% podem generar tots els subconjunts de [a,b,c,d,e,f] amb
% subcjt([a,b,c,d,e,f],S), write(S), write(   ), false.

% xifres(L,N) escriu les maneres d obtenir N a partir de +, -, * dels
% elements de la llista L

% exemple:
% ?- xifres( [4,9,8,7,100,4], 380 ).
%    4 * (100-7) + 8         <-------------
%    ((100-9) + 4 ) * 4
%    ...

xifres(L,N):-
    subcjt(L,S),          % S = [4,8,7,100]
    permutation(S,P),     % P = [4,100,7,8]
    expressio(P,E),       % E = 4 * (100-7) + 8 
    N is E,
    write(E), nl, fail.


% E = ( 4  *  (100-7) )    +    8
%            +
%          /   \
%         *     8
%        / \
%       4   -
%          / \
%        100  7


expressio([X],X).
expressio( L, E1 +  E2 ):- append( L1, L2, L), 
			  L1 \= [], L2 \= [],
			  expressio( L1, E1 ),
			  expressio( L2, E2 ).
expressio( L, E1 -  E2 ):- append( L1, L2, L), 
			  L1 \= [], L2 \= [],
			  expressio( L1, E1 ),
			  expressio( L2, E2 ).
expressio( L, E1 *  E2 ):- append( L1, L2, L), 
			  L1 \= [], L2 \= [],
			  expressio( L1, E1 ),
			  expressio( L2, E2 ).

% Com afegir la divisió entera?


%expressio( L, E1 // E2 ):- append( L1, L2, L), 
%			  L1 \= [], L2 \= [],
%			  expressio( L1, E1 ),
%			  expressio( L2, E2 ),
%                  K is E2, K\=0.
% evitem que es produeixin divisions per zero



% der(E,V,D)  ==  la derivada de E respecte de V és D 

der(X,X,1):- var(X), !. 
% ! es fa servir per aturar la cerca de solucions
der(C,_,0):- 
	number(C).
der(A+B,X,U+V):- 
	der(A,X,U), 
	der(B,X,V). 
der(A*B,X,A*V+B*U):- 
	der(A,X,U), 
	der(B,X,V). 
% ...


% reunio(L1,L2,R) ==  R es la reunió de L1 amb L2 
% (com a conjunts, sense repeticions) 

reunio([],L,L).
reunio([X|L1],L2,U) :-     
	member(X,L2),   
	reunio(L1,L2,U).
reunio([X|L1],L2,[X|U]) :- 
	not(member(X,L2)),  	
	reunio(L1,L2,U).

