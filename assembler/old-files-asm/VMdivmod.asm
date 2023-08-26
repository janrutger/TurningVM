@_divmod 
    push 0
    storem $quotient_divmod

    push 0
    storem $counter_divmod

    storem $divisor_divmod
    storem $number_divmod

    loadm $divisor_divmod
    push 3
    loada
    loadb
    testg    
    jumpf :_0_goto_end_divmod
    jump :uitzonderingen_divmod
    :_0_goto_end_divmod

    :_1_condition_start_divmod
        
        loadm $counter_divmod
        loadm $number_divmod
        loada
        loadb
        testg  
        clra
        clrb
        jumpf :_1_repeat_end_divmod
            loadm $counter_divmod
            loadm $divisor_divmod
            call @plus
            storem $counter_divmod

            loadm $quotient_divmod
            push 1
            call @plus
            storem $quotient_divmod

    jump :_1_condition_start_divmod
    :_1_repeat_end_divmod

    loadm $number_divmod
    loadm $counter_divmod
    loada
    loadb
    testg  
    clra
    clrb
    jumpf :_2_do_end_divmod
        loadm $counter_divmod
        loadm $divisor_divmod
        call @minus

        storem $counter_divmod
        loadm $quotient_divmod
        push 1
        call @minus

        storem $quotient_divmod
    :_2_do_end_divmod

    loadm $number_divmod
    loadm $counter_divmod
    call @minus
    storem $_remainder_divmod
    jump :einde_divmod

    :uitzonderingen_divmod
        push 1
        loadm $divisor_divmod
        loada
        loadb
        teste
        clra
        clrb
            jumpf :_3_do_end_divmod
                loadm $number_divmod
                storem $quotient_divmod

                push 0
                storem $_remainder_divmod

                jump :einde_divmod
            :_3_do_end_divmod

        push 2
        loadm $divisor_divmod
        loada
        loadb
        teste
        clra
        clrb
            jumpf :_4_do_end_divmod
                loadm $number_divmod
                ssr
                jumpt :_remainder1_divmod
                push 0
                jump :_next1_divmod

                :_remainder1_divmod
                push 1

                :_next1_divmod
                storem $_remainder_divmod
                storem $quotient_divmod
            jump :einde_divmod
            :_4_do_end_divmod

        push 0
        loadm $divisor_divmod
        loada
        loadb
        teste
        clra
        clrb
        jumpf :_5_do_end_divmod
            push $FATAL
            halt
        :_5_do_end_divmod

    :einde_divmod
ret



@div 
    call @_divmod
    loadm $quotient_divmod
ret

@mod
    call @_divmod
    loadm $_remainder_divmod
ret

@divmod 
    call @_divmod
    loadm $quotient_divmod
    loadm $_remainder_divmod
