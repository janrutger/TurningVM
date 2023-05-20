@main
    
    iobuff %inputBuffer
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
    storeb
    storem $checkindex
    loadm $word
    loadb

    teste
    jumpt :validword

    loadm $checkindex
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
    jumpf :setword
    storem %inputBuffer
    incb
    jump :copyword


:setword
    push 'nop'
    storem $word

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

    push 1
    storea
    loadm $word
    storei
    loadm $word
    storei
    jump :readword

:writenum  
    storem $tmp
    push 0
    loadm $tmp
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

    push 'nop'
    index @nop

    push 'dup'
    index @dup
ret

:readInput
    push 0
    readelm %inputBuffer
    jumpf :gokbd
    storem $rommel
    loadm %inputBuffer
    loadm %inputBuffer
ret
:gokbd
    input %_kbd
    loadm %_kbd
ret

:error  
    halt


@nop
    ret
