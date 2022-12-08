@main
    call :mapping
:repl
    call :readKBD

    loada
    testz
    jumpt :repl

    loada

    push 'exit'
    loadb
    teste
    jumpt :exit

    push 'null'
    loadb
    teste
    jumpf :is-cmd
    #input
    jump :repl

:is-cmd
    storea
    clra
    clrb
    calli
    jump :repl

:exit
    clra
    clrb
ret



:mapping
    push '+'
    index @plus 

    push '-'
    index @minus 

    push '*'
    index @mul 

    push '/'
    index @div 

    push '%'
    index @mod 

    push '.'
    index @print

    push '!'
    index @factorial

    push 'swap'
    index @swap

    push '='
    index @eq



ret

:readKBD
    input %_kbd
    loadm %_kbd
ret