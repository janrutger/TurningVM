speed 0
clra
clrb
lifo %_system
lifo %result


push 1
storem $q
push 0
storem $r
push 1
storem $t
push 1
storem $k
push 3
storem $n
push 3
storem $l 

push 0
storem $first
push 0
storem $count


:pi
    #first part of IF 
    push 4        
    loadm $q  
    multi
    ex
    loadm $r
    add
    storea
    loadm $t
    clra
    clrb
    sub
    storeb      #first value

    #second part of IF
    clra        
    clrb
    loadm $n
    loadm $t
    multi
    storeb      #second value
    loada
    loadb
    testg
    #jumpt for debugging, jumpf is the rightone
    jumpf :else

    #if 
        #save result
        loadm $n
        storem %result

        clra
        clrb
speed 5
        call :calc_nr_if
halt

    :else
        clra
        clrb

        call :calc_nr_else
        call :calc_nn_else
        call :calc_else 

    :endif

jump :pi


#calculate nr
:calc_nr_if
    loadm $n
    loadm $t
    multi
    loadm $r
    storeb

    clra
    clrb
    sub
halt
    push 10
    storeb
    clra
    clrb
    multi
    storeb
    storem $nr
    clra
    clrb
ret 

:calc_nr_else
    push 2
    loadm $q
    multi
    ex
    loadm $r
    add
    storea
    clra
    clrb
    loadm $l 
    multi
    storeb
    storem $nr
    clra
    clrb
ret 

#calculate nn
:calc_nn_else
    loadm $r   
    loadm $l   
    multi
    storeb
    clra
    clrb
    loadm $q
    push 7
    loadm $k
    multi
    storeb
    clra
    clrb
    multi
    ex
    clrb
    push 2
    add
    add
    storea #first value for division

    clra
    loadm $t 
    loadm $l
    multi
    storeb #second value for division

    call :div

    storea
    storem $nn

    clra
    clrb
ret 



:div 
    push 0
    storem $count

    loada
    loadb

    testz 
    jumpt :DivZeroError

    :while
        testg
        jumpt :done
   
    :do  
        storea
        storeb
        storea
        clra
        clrb
        sub
        loadm $count
        push 1
        loada
        add
        storea
        storem $count

        loada

        jump :while

    :done
        teste
        jumpt :do
        loadm $count
        loada

ret 

:DivZeroError
    clra
    clrb
halt


#some other else stuff
:calc_else 
    loadm $q
    loadm $k
    multi
    storea
    storem $q
    clra
    clrb

    loadm $t 
    loadm $l 
    multi
    storea
    storem $t 
    clrb

    loadm $l 
    push 2
    loada
    add
    storea 
    storem $l
    clra

    loadm $k 
    push 1
    loada
    add
    storea 
    storem $k
    clra

    loadm $nn
    storem $n

    loadm $nr
    storem $r

ret 