% Problema A: Dadas cinco personas, que tienen cinco casas de colores diferentes, y cinco pro-
% fesiones, animales, bebidas y nacionalidades diferentes, y sabiendo que:


% escribe un programa Prolog que averigue para cada persona todas sus caracterısticas de la forma
%   [numcasa,color,profesion,animal,bebida,pais] averiguables.
%       Nota: partiendo de una soluci ́on [ [1,A1,B1,C1,D1,E1],...,[5,A5,B5,C5,D5,E5] ], se
% pueden imponer todas las condiciones sobre  ́esta con member o similares.


solucio( SOL ):-
    SOL = [ [1,_C1,_Pr1,_A1,_B1,_Pa1],  % numcasa,col,prof,animal,beguda,pais
            [2,_C2,_Pr2,_A2,_B2,_Pa2],
            [3,_C3,_Pr3,_A3,_B3,_Pa3],
            [4,_C4,_Pr4,_A4,_B4,_Pa4],
            [5,_C5,_Pr5,_A5,_B5,_Pa5]],
    % 1 - El que vive en la casa roja es de Peru
    member([_,vermell,_,_,_,peru],SOL),

    % 2 - Al frances le gusta el perro
    member([_,_,_,gos,_,frances],SOL),
    
    % 3 - El pintor es japones
    member([_,_,pintor,_,_,japones],SOL),
    
    % 4 - Al chino le gusta el ron
    member([_,_,_,_,ron,xines],SOL),
    
    % 5 - El hungaro vive en la primera casa
    member([1,_,_,_,_,hongares],SOL),
    
    % 6 - Al de la casa verde le gusta el conac
    member([_,verd,_,_,conac,_],SOL),
    
    % 7 - La casa verde esta justo a la izquierda de la blanca
    member([X,verd,_,_,_,_],SOL),
    X1 is X + 1,
    member([X1,blanc,_,_,_,_],SOL),
    
    % 8 - El escultor cria caracoles
    member([_,_,escultor,cargols,_,_],SOL),
    
    % 9 - El de la casa amarilla es actor
    member([_,groc,actor,_,_,_],SOL),
    
    % 10 - El de la tercera casa bebe cava
    member([3,_,_,_,cava,_],SOL),
    
    % 11 - El que vive al lado del actor tiene un caballo
    member([X11a,_,actor,_,_,_],SOL),
    member([X11b,_,_,cavall,_,_],SOL),
    Resta11 is X11a-X11b, Aux11 is abs(Resta11), Aux11 = 1,
    
    % 12 - El hungaro vive al lado de la casa azul
    member([X12a,_,_,_,_,hongares],SOL),
    member([X12b,blau,_,_,_,_],SOL),
    Resta12 is X12a-X12b, Aux12 is abs(Resta12), Aux12 = 1,
    
    % 13 - Al notario la gusta el whisky
    member([_,_,notari,_,whiskey,_],SOL),
    
    % 14 - El que vive al lado del medico tiene un ardilla
    member([X14a,_,_,esquirol,_,_],SOL),
    member([X14b,_,metge,_,_,_],SOL),
    Resta14 is X14a-X14b, Aux14 is abs(Resta14), Aux14 = 1,

    writeSol(SOL),!.

writeSol(Sol):-
    member(Casa,Sol), write(Casa), nl, fail.
writeSol(_).