nop
nop
nop
nop
nop
nop
nop
nop

@plus
    loada
    add
    storea
    call :clearRB
ret

@minus
    sub
    storeb
    call :clearRB
ret

@mul
    multi
    storeb
    call :clearRB
ret

@div 
    call @modulo
    storea
    call :clearRB
ret

@mod
    call @modulo 
    storeb
    call :clearRB
ret 

@swap
    loada
    loadb
    storea
    storeb
    call :clearRB
ret

@over
    loada
    loadb
    storeb
    storea
    storeb
    call :clearRB
ret

:clearRB
    clra
    clrb
ret 


@factorial
    storem %_system
    push 1
    loadm %_system

    multi
    :loop
        storeb
        clrb

        ex
        decb
        jumpt :return

        storeb
        clrb

        multi

    jump :loop

    :return
        ret


@modulo
    push 0
    storem $count

    loada
    loadb

    testz 
    jumpt :DivZeroError

    :while0
        testg
        jumpt :done0
    
    :do0 
        storea
        storeb
        storea
        clra
        clrb
        sub
        loadm $count
        push 1
        loada
        add
        storea
        storem $count
        loada

        jump :while0

    :done0
        teste
        jumpt :do0
        loadm $count
        loada

        ret

    :DivZeroError
        clra
        clrb
        halt


@gcd
    loada
    loadb
    testz
    jumpt :done1
    ex
    testz
    jumpt :done1

    :while1
        teste
        jumpt :done1

        testg
        jumpf :Asmaller1
        storeb
        storea
        storeb
        jump :subtract1
    :Asmaller1
        storea
        storeb
        storea

    :subtract1
        clra
        clrb
        sub
        ex
        loadb
        jump :while1


    :done1
        clra
        ret