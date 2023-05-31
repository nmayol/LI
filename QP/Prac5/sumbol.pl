


programa(P):-
    append([begin], P1, P),
    append(Prog,[end],P1),
    write(Prog), nl,
    instrucciones(Prog),
    write('yes').
programa(_):-write('no').


instrucciones(Inst):-
    instruccion(Inst).
instrucciones(Insts):-
    append(Inst,[';'|I],Insts), instruccion(Inst), instrucciones(I).
instrucciones(Insts):-
    append(['if'|Inst],['endif',';'|I],Insts), instruccion(Inst), instrucciones(I).
instrucciones(Insts):-
    append(['if'|Inst],['endif'],Insts), instruccion(Inst), instrucciones(Insts).

instruccion([A,'=',B,'+',C]):-
    v(A), v(B), v(C).
instruccion(Cond):-
    append([ A, '=', B],I,Cond),
    v(A), v(B),
    append(['then'|X],['else'|Y],I),
    instrucciones(X), instrucciones(Y).

    

v(Char):- Char = 'x'.
v(Char):- Char = 'y'.
v(Char):- Char = 'z'.

% programa([begin,x,=,y,+,z,;,if,z,=,z,then,x,=,x,+,z,;,y,=,y,+,z,else,z,=,z,+,y,endif,;,x,=,x,+,z,end])

