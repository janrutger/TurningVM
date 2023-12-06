@main
    speed 1
    settimer 0
    push 0
    storem $n 
    push 'inputpointer'
    index $n 

    #push 3000
    #loada 

    #push 1
    #loadb

    #:makejob
    #    storeb
    #    storem $n
    #    push 'inputpointer'
    #    job @job2

    #   incb 
    #   testg
    #   jumpt :makejob
    #   clrb 
    #   clra

    push 1500
    loadb 

    :makejob
        storeb
        storem $n
        push 'inputpointer'
        job @job2

        decb
        storeb
        loada 
        testz
        jumpf :makejob
        clrb 
        clra

   
    :getresult
        speed 5
        result
    jumpt :result
        speed 0
        join
    jump :getresult

    :result
        call @plot
        #prt

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
    loadm $n 
    #loadm $n
    call @factorial
    storem $result 
done $result


@job2
    push 1
    push 8
    loadm $n
    call @mul
    call @plus
    storem $s
    push 2
    loadm $s
    call @lt
    loada
    testz
    clra
    jumpf :_0_do_end
    push 1
    jump :einde
    :_0_do_end
    loadm $s
    push 2
    call @div
    storem $x0
    loadm $s
    loadm $x0
    call @div
    loadm $x0
    call @plus
    push 2
    call @div
    storem $x1
    :_1_condition_start
    loadm $x0
    loadm $x1
    call @lt
    loada
    testz
    clra
    jumpf :_1_repeat_end
    loadm $x1
    storem $x0
    loadm $s
    loadm $x0
    call @div
    loadm $x0
    call @plus
    push 2
    call @div
    storem $x1
    jump :_1_condition_start
    :_1_repeat_end
    loadm $x0
    :einde
    push 1
    call @minus
    push 2
    call @div
    storem $m
    :_2_condition_start
    push 1
    loadm $m
    call @plus
    loadm $m
    call @mul
    push 2
    loadm $n
    call @mul
    call @mod
    push 0
    call @neq
    loada
    testz
    clra
    jumpf :_2_repeat_end
    loadm $m
    push 1
    call @plus
    storem $m
    jump :_2_condition_start
    :_2_repeat_end
done $m