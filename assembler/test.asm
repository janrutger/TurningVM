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


    jump :mainloop
    :wrapup

ret

@checkForPrime
    loadm $cursor
    readelm 'currentlist'
    
    call @dup
    storem $currentVal

    loadm 'currentlist'
    storeb

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
        call $dup
        loadm $currentVal
        call @mod

        loada
        testz
        jumpt :didCkeck




        :didCkeck
            pop
            loadm $currentPOS


    jump :checkList
    :endCkeckList
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