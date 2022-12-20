@main
    lifo %inputBuffer
    array *wordList

    call :mapping
:repl
    call :readInput

    loada
    testz
    jumpt :repl

    storem $word
    loadm $word
    loada

    push 'exit'
    loadb
    teste
    jumpt :exit

    push 'null'
    loadb
    teste
    jumpt :repl

    push ':'
    loadb
    teste
    jumpf :checklist
    call @makeWord
    jump :repl


:checklist
    call @check-wordlist
#jump :repl

:is-cmd
    loadm $word
    clra
    clrb
    calli
    jump :repl

:exit
    clra
    clrb
ret

@check-wordlist
    storea
    storem $word

    loadm *wordList
    loada
    testz
    jumpt :eindecheck
    ex

:checkloop
    storeb
    readelm *wordList

    loada
    #storeb
    loadm $word
    loadb

    teste
    storeb
    jumpt :validword

    loadb
    decb
    jumpt :eindecheck

    jump :checkloop


:validword
    push 1
    loadb

:copyword
    storeb
    loadm $word
    readelmi
    jumpf :eindecheck
    storem %inputBuffer
    incb
    jump :copyword

:eindecheck
    #loada
    clra
    clrb
    ret



@makeWord
    call :readInput
    loada
    testz
    jumpt :error
    loada
    storea
    storea
    storea

    set *ARRAY
    storem *wordList
    storem $word

:readword
    call :readInput
    loada
    testz
    jumpt :writenum

:writestring
    loada

    push ';'
    loadb
    teste
    jumpt :stop

    storea
    push 1
    loadm $word
    storei
    loadm $word
    storei
    jump :readword

:writenum
    push 0
    loadm $word
    storei 
    loadm $word
    storei
    jump :readword

:stop
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

:readInput
    input %_kbd
    loadm %_kbd
ret

:error  
    halt
