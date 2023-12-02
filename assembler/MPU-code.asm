@main

    push 5
    storem $n 
    push 'inputpointer'
    index $n 

    push 'inputpointer'
    job @twice

    push 'inputpointer'
    job @twice


    :lus
        result
    jumpf :lus

    loadm $result
    call @plot

    pending 
    loada
    testz
    clra
    jumpf :lus


ret



@core 
    :loop
        join
        push 1
        call @sleep
    jump :loop
ret



@twice
    push 1
    call @sleep
    loadm $n 
    push 2
    call @mul
    storem $result 

done $result