# TurningVM
An virtual machine using a 4 Tape Turing Machine as ALU

Supports:
- positive intergers (only)
- All ALU operations are done by Turing State Machines
- The ALU monitor shows the register values
- integrated Memory and I/O management
- An Console printing and an Y-plotter output
- support for Array and String datatype
- support for timers eg performance
- support for a-sync jobs
- Small instruction set < 70


STACKS: An RPN-based Language for the TuringVM Machine

- STACKS is a programming language inspired by Forth, a powerful stack-based language. It uses Reverse Polish Notation (RPN), where operands are placed before the operator, making it concise and efficient. STACKS is designed to generate code specifically for the TuringVM virtual machine, which utilizes Turing State Machines for its ALU operations. (by Bard)



The Grammer of TeenySTACKS Version 4

    Version 4: Including THING object and Match instruction
    Version 3: Including Array datatype and a-sync Jobs
    Version 2: Includes Functions
    Version    Initial (thanks for AZHenley)
    ----------------------------------------------------

    program    ::=	[(define)] {statement}


    define	::=	"DEFINE" nl
                    [ (("VALUE" variable [INTEGER] nl) | ("ARRAY" array ['['(INTEGER)+']'] nl))+ ]				
                    [ ("FUNCTION" function nl {statement} nl "END" nl)+ ]

                    [ ("THING" thing nl 
                         "INIT" nl {statement} nl "END" nl
                         "THIS" function nl {statement} nl "END" nl
                        ["THIS" function nl {statement} nl "END" nl]+ 
                    "END" nl)+]

                    [ ("JOB" job "USE" (variable | array) nl {statement} nl "RETURN" (variable | array) nl)+ ]
                "END" nl


    statement  ::=  "LABEL" label nl
                |   "GOTO"  label nl
                |   "TIMER" INTEGER ("SET" | "PRINT" | "GET") nl
                |   ("DEFINE" | "FUNCTION") function nl {statement} nl "END" nl
                |   "ARRAY" [“THIS”] array ['['(INTEGER)+']'] nl
                |   “QUEUE” job nl
                |   “JOIN” nl 
                |   “RESULT”  nl {statement} nl "END" nl
                |   “WITH” [“THIS”] array (“EACH” nl {statement} nl "END" | “COPY” [“THIS”] array | "PLOT" ["NEW"]) nl
                |   "{" (expression) "}" ("REPEAT" | "DO") nl {statement} nl "END" nl		
                |   (expression | tos) ( "PRINT" nl
                                    | "PLOT"  nl
                                    | ¨WAIT¨  nl
                                    | "AS" [“THIS”] (variable | '['array']') nl
                                    | “MATCH” nl 
                                        "ON" (expression) "DO" ['=='|'!='|'>'|'<'] nl {statement} nl "END" nl 
                                        [("ON" (expression) "DO" ['=='|'!='|'>'|'<'] nl {statement} nl "END" nl)+]
                                        [ "NO" nl {statement} nl "END" nl]
                                    "END" nl
                                    | "DO" nl {statement} nl "END" nl
                                    | "GOTO" label nl
                                    |  nl )

    expression ::=	(INTEGER | STRING | function | "`"function | [“THIS”] variable | [“THIS”] array | [“THIS”] '['array']' | thing function | word)+
    word       ::=	('+'|'-'|'*'|'/'|'%'|'=='|'!='|'>'|'<'|'GCD'|'!'|'DUP'|'SWAP'|'OVER'|'DROP'|'DEPTH'|'INPUT'|'RAWIN')
                                
    label      ::=  ident
    job        ::=  ident
    array	   ::=  ident
    function   ::=  ident
    variable   ::=  ident
    thing      ::=  ident


    tos        ::=	('.'|'..')
    nl         ::= '\n'+
    ident      ::= [a-zA-Z][a-zA-Z0-9]*


Inspired by:
- Turing https://nl.wikipedia.org/wiki/Alan_Turing
- Turing State machine https://en.wikipedia.org/wiki/Turing_machine
- von Neumann https://nl.wikipedia.org/wiki/Von_Neumann-architectuur
- Stack computing https://en.wikipedia.org/wiki/Stack_machine
- Forth https://en.wikipedia.org/wiki/Forth_(programming_language)
- Z80 https://nl.wikipedia.org/wiki/Z80
- ZX81 https://nl.wikipedia.org/wiki/Sinclair_ZX81
- PDP https://nl.wikipedia.org/wiki/PDP-11

also inspriration from:
- OEIS A133058 https://oeis.org/A133058 
- Ben Eater https://youtu.be/TardkN4OGJg
- Bens sleep https://youtu.be/g_koa00MBLg
- Turtle https://en.wikipedia.org/wiki/Turtle_graphics
- l-systems https://en.wikipedia.org/wiki/L-system 
- MMU https://nl.wikipedia.org/wiki/Memory_management_unit

Specials
- from @AZHenley https://github.com/AZHenley/teenytinycompiler 
