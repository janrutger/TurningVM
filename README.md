# TurningVM
A Forth like virtual machine using a 4 tape Turing compatible ALU


Inspired by:
- Turing https://nl.wikipedia.org/wiki/Alan_Turing
- Turing State machine https://en.wikipedia.org/wiki/Turing_machine
- von Neumann https://nl.wikipedia.org/wiki/Von_Neumann-architectuur
- Stack computing https://en.wikipedia.org/wiki/Stack_machine
- Forth https://en.wikipedia.org/wiki/Forth_(programming_language)
- Bytecode https://en.m.wikipedia.org/wiki/Bytecode 
- Z80 https://nl.wikipedia.org/wiki/Z80
- ZX81 https://nl.wikipedia.org/wiki/Sinclair_ZX81
- PDP https://nl.wikipedia.org/wiki/PDP-11

also inspriration from:
- OEIS A133058 https://oeis.org/A133058 
- Ben Eater https://youtu.be/TardkN4OGJg
- Bens sleep https://youtu.be/g_koa00MBLg
- MMU https://nl.wikipedia.org/wiki/Memory_management_unit

Specials
- from @AZHenley https://github.com/AZHenley/teenytinycompiler 


The Grammer of TeenySTACKS

    program    ::=	{statement}
    statement  ::=  "LABEL" ident nl
                |   "GOTO" ident nl
                |   "TIMER" INTEGER ("SET" | "PRINT" | "GET") nl
                |   "DEFINE" ident nl {statement} nl "END" nl
                |   "{" (expression | st) "}" "REPEAT" nl {statement} nl "END" nl	   
                |   (expression | st) ( "PRINT" nl
                                    | "PLOT" nl
                                    | "WAIT" nl
                                    | "AS" ident nl
                                    | "DO"   nl {statement} nl "END" nl
                                    | "GOTO" ident nl
                                    |  nl )



    expression ::=	(INTEGER | STRING | "`" ident "`" | ident | word )+
    word       ::=	('+'|'-'|'*'|'/'|'%'|'=='|'!='|'>'|'<'|'GCD'|'!'|'DUP'|'SWAP'|'OVER'|'DROP'|'INPUT'|'RAWIN')
    ident      ::=	(variable | function | STRING)

    st         ::=	('.'|'..')
    nl         ::= '\n'+