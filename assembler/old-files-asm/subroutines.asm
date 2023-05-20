speed 2
clra
clrb
lifo %_system

@main
push 4

call @factorial

loadb
storeb
prt

halt

##sub routings down here
@factorial

#get here the input value
storem %_system
push 1
loadm %_system

multi

:loop
    storeb
    clrb

    ex
    decb
    jumpt :halt

    storeb
    clrb

    multi

jump :loop

:halt
    ret