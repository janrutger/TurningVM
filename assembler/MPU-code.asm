@main
    speed 0
    settimer 0
    push 0
    storem $n 
    push 'inputpointer'
    index $n 

    push 100
    loada 

    push 1
    loadb

    :makejob
        storeb
        storem $n
        push 'inputpointer'
        job @job

        incb 
        testg
        jumpt :makejob


    :getresult
        result
    jumpf :getresult

    loadm $result
    #call @plot
    prt

    pending 
    loada
    testz
    clra
    jumpf :getresult
    clrb 


    push 'DONE'
    call @char2prtbuff
    call @printbuff
    prttimer 0
ret



@core 
    :loop
        join
        push 1
        call @sleep
    jump :loop
ret



@job
    loadm $n 
    #loadm $n
    call @factorial
    storem $result 
done $result