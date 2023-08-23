@main
speed 0

settimer 0

settimer 1

loadb
decb
:lus
    gettimer 1
    loada 
    testg 
    jumpt :eind
    jump :lus

:eind
clra
clrb
prttimer 0

ret