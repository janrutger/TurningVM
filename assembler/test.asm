@main
speed 0

    array *list0
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

    :mainloop
        array *list1
        push 'newlist'
        index *list1

        call @setCursor
        loadm $cursor
        call @checkForDone
        jumpt :wrapup
        call @checkForPrime

        push 'currentlist'
        index *list1
        array *list0
        push 'newlist'
        index *list0

        call @setCursor
        loadm $cursor
        call @checkForDone
halt
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

    loadm 'currentlist'
    loadb

    :checkList
        decb
        storeb
        storeb
        storem $currentPOS
        loada
        testz
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
    prt
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
    loadm 'currentlist'
    storem $cursor
ret