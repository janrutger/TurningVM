@main
speed 2

:factorial
push 1

#get here the input value
push 999

multi

:loop
    storeb
    #clrb
    push 0
    loadb

    ex
    decb
    jumpt :halt

    storeb
    #clrb
    push 0
    loadb

    multi

jump :loop

:halt
    loadb
    storeb
    prt

    halt