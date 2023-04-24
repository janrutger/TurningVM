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
    storem $currentPOS


    :mainloop
        clra
        clrb

        loadm 'currentlist'
        loadm $currentPOS
        call @minus
        storem $cursor


        loadm $cursor
        readelm 'currentlist'
        call @dup
        call @mul

        loadb
        loadm $maxprimes
        loada
        testg
        jumpt :wrapup

        
        

    
    :wrapup

ret