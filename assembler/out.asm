@main

    push 5
    storem $n 
    push 'inputpointer'
    index $n 

    push 'inputpointer'
    job @twice


ret

@resulttest
    result
ret



@twice
 nop
ret