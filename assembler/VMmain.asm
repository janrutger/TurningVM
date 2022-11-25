@main
    call :mapping
:repl
    call :readKBD

    loada
    testz
    jumpt :repl

    loada

    push 'halt'
    loadb
    teste
    jumpt :exit

    push 'null'
    loadb
    teste
    jumpf :is-string

    input
    jump :repl

:is-string
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

    push '.'
    index @print

ret

:readKBD
    loadm %_kbd
    loadm %_kbd
ret