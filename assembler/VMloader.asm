nop
nop
nop
nop
nop
nop
nop
nop
nop
nop

@init_vmachine
    speed 10
    clra
    clrb
    iobuff %_plotter
    output %_plotter
    iobuff %_kbd

    push 75
    storem $_aRandom
    push 35
    storem $seed
    push 74
    storem $_cRandom
    push 65536
    storem $_mRandom
    speed 300
ret

@plus
    loada
    add
    storea
    clra
ret

@minus
    sub
    storeb
    call :clearAB
ret

@mul
    multi
    storeb
    call :clearAB
ret

@div 
    call @modulo
    storea
    call :clearAB
ret

@mod
    call @modulo 
    storeb
    call :clearAB
ret 

@print
    prt 
ret

@swap
    loada
    loadb
    storea
    storeb
    call :clearAB
ret

@dup
    loada
    storea
    storea
    clra
ret

@over
    loada
    loadb
    storeb
    storea
    storeb
    call :clearAB
ret

@eq
    loada
    loadb
    teste
    jumpt :settrue_eq
    push 1
    jump :end_eq
    :settrue_eq
        push 0
    :end_eq
        call :clearAB
ret

@neq
    loada
    loadb
    teste
    jumpf :settrue_neq
    push 1
    jump :end_neq
    :settrue_neq
        push 0
    :end_neq
        call :clearAB
ret

@gt
    loada
    loadb
    testg
    jumpt :settrue_gt
    push 1
    jump :end_gt
    :settrue_gt
        push 0
    :end_gt
        call :clearAB
ret

@lt
    loadb
    loada
    testg
    jumpt :settrue_lt
    push 1
    jump :end_lt
    :settrue_lt
        push 0
    :end_lt
        call :clearAB
ret

:clearAB
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
        clra
        clrb
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


@rand
    speed 0
    loadm $_aRandom
    loadm $seed
    call @mul
    loadm $_cRandom
    call @plus
    loadm $_mRandom
    call @mod
    call @dup
    storem $seed
    push 655
    call @div 
ret