@main
speed 0

    array *list0
    array *list1

    push 'currentlist'
    index *list0

    push 11
    storem $maxprimes


    loadm $maxprimes
    loadb
    push 1
    loada
    :initlist
        storeb
        storem 'currentlist'
        decb
        teste
    jumpf :initlist

    push 0
    :mainloop
        storem $currentPOS
        call @setCursor

        loadm $cursor
        call @checkForDone
        jumpt :wrapup

        call @checkForPrime

        loadm $currentPOS
        loadb
        incb 
        storeb




    jump :mainloop
    :wrapup

ret

@checkForPrime
    loadm $cursor
    readelm 'currentlist'
    call @dup 
    storem $current

    


    prt
ret

    
@checkForDone
    readelm 'currentlist'
    call @dup
    call @mul
    loada
    loadm $maxprimes
    loadb
    testg
ret

@setCursor
    clra
    clrb
    loadm 'currentlist'
    loadm $currentPOS
    call @minus
    storem $cursor
ret