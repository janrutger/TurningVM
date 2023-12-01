@main

    push 5
    storem $n 
    push 'inputpointer'
    index $n 

    push 'inputpointer'
    job @twice

ret



@core 
    :loop
        start
        push 2
        call @sleep
    jump :loop
ret



@twice
 nop
ret