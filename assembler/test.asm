@main
speed 0

    array *list0
    push 'currentlist'
    index *list0

    push 11
    push 1
    call @plus
    storem $maxprimes


    loadm $maxprimes
    loada
    push 2
    loadb
    :initlist
        storeb
        storem 'currentlist'
        incb 
        teste
    jumpf :initlist

    :mainloop
        array *list1
        push 'newlist'
        index *list1

        call @setCursor
        loadm $cursor
        call @checkForDone
        jumpt :wrapup
        call @checkForPrime
halt

        push 'currentlist'
        index *list1
        array *list0
        push 'newlist'
        index *list0

        call @setCursor
        loadm $cursor
        call @checkForDone
        jumpt :wrapup
        call @checkForPrime

        push 'currentlist'
        index *list0


    jump :mainloop
    :wrapup

ret

@checkForPrime
    loadm $cursor
    readelm 'currentlist'
    
    call @dup
    storem $currentVal

    loadm $cursor
    loadb

    :checkList
        incb
        storeb
        #storeb
        storem $currentPOS
        loadm $maxprimes
        loada
        teste
        jumpt :endCheckList

        storeb
        readelm 'currentlist'
        call @dup
        loadm $currentVal
        
        call @mod

        loada
        testz
        jumpt :didCkeck
            storem 'newlist'
            loadm $currentPOS
            loadb
        jump :checkList

        :didCkeck
            pull
            loadm $currentPOS
            loadb
        jump :checkList

    :endCheckList
    loadm $cursor
    readelm 'currentlist'
    prt
halt
ret

    
@checkForDone
    readelm 'currentlist'
    call @dup
    clrb
    call @mul
    loada
    loadm $maxprimes
    loadb
    testg
ret

@setCursor
    push 1
    storem $cursor
ret