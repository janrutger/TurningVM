@main

    push 5
    storem $n 
    push 'inputpointer'
    index $n 

    push 'inputpointer'
    job @twice

    join

ret



@core 
    :loop
        join
        push 1
        call @sleep
    jump :loop
ret



@twice
    nop
    loadm $n 
    push 2
    call @mul
ret