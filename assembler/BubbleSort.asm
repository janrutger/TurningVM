@main
    settimer 0
    call @stackssys


    call @input
    storem $numbers

    array *list0
    push 'unsorted'
    index *list0

    array *list1
    push 'sorted'
    index *list1

    call :initlist
    prttimer 0
    call :plot_unsorted

    push 3
    call @sleep
    settimer 0
    :start_sort
        push 0
        storem $gesorteerd

        call :sort
        
        push 'unsorted'
        index *list1
        array *list0
        push 'sorted'
        index *list0

        call :plot_unsorted
        call :sort

        push 'unsorted'
        index *list0
        array *list1
        push 'sorted'
        index *list1

        call :plot_unsorted

        loadm $gesorteerd
        loada
        testz
        clra
    jumpf :start_sort
prttimer 0
ret

:sort
speed 0
    push 1
    storem $p
    loadm $p
    loadb
    incb
    moveb
    storem $pp

    :next_elm
        loadm $pp
        readelm 'unsorted'
        jumpf :last_elm
        loadm $p 
        readelm 'unsorted'
        #call @gt 
        loada
        loadb
        testg
        jumpt :store_pp
            loadm $p
            readelm 'unsorted'
            storem 'sorted'

            loadm $pp
            storem $p
            loadm $pp
            loadb
            incb
            moveb
            storem $pp
        jump :next_elm
        :store_pp
            loadm $pp
            readelm 'unsorted'
            jumpf :last_elm
                storem 'sorted'

                loadm $pp
                loadb
                incb
                moveb
                storem $pp

                push 1
                storem $gesorteerd
            jump :next_elm
            :last_elm
                loadm $p
                readelm 'unsorted'
                storem 'sorted'
ret





:initlist
    :filllist
        call @rand
        storem 'unsorted'

        loadm $numbers
        loadb
        decb
        moveb
        storem $numbers

    jumpf :filllist
ret


:plot_unsorted
    iobuff %_plotter
    push 1
    loadb
    :lus
        storeb
        readelm 'unsorted'
        jumpf :done 
            storem %_plotter
            incb
        jump :lus
    :done
    clrb
    output %_plotter
ret

