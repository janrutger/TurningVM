@main

    push 0
    push 1

    push 10
    storem %_system


    :loop
        loada
        loadb
        storeb
        storea
        storeb
        add
        storea

        loadm %_system
        loadb
        decb
        jumpt :done
        storeb
        storem %_system

        jump :loop

    :done
        
        halt