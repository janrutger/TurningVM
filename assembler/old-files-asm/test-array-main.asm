@main


push 6
push 7
push 8

array *brommer

storem *brommer
storem *brommer
storem *brommer

loadm *brommer
loadb

:down
    storeb
    readelm *brommer
    prt

    decb
    jumpf :down

:up
    storeb
    readelm *brommer
    jumpf :klaar
    
    prt
    incb
    jump :up


:klaar
    ret


