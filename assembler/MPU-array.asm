@main
    speed 1
    settimer 0
    array *vars

    push 845325
    storem *vars
    Push 9562387
    storem *vars 
    push 'inputpointer'
    index *vars


    push 'inputpointer'
    job @job


    :getresult
        speed 50
        result
    jumpt :result
        speed 0
        join
        #nop
    jump :getresult

    :result
        push 3
        readelm *vars
        #call @plot
        prt

        pending 
        loada
        testz
        clra
    jumpf :getresult



    push 'DONE'
    call @char2prtbuff
    call @printbuff
    prttimer 0
ret





@core 
    speed 0
    :loop
        join
        push 1
        call @sleep
    jump :loop
ret


@job
    push 1
    readelm *vars
    loada
    push 2
    readelm *vars
    add
    storea
    storem *vars
done *vars