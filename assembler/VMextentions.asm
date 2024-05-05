@abs 
  abs
  movea
ret


@bc  
  bc 
  movea
ret


@input 
    :_input_loop
        input %_kbd
        input %_kbd
        loada
        testz
        jumpt :_input_loop_end
        storem $rommel
        jump :_input_loop
    :_input_loop_end
    clra 
ret

@rawin
    input %_kbd
    input %_kbd
ret


@plot
    storem %_plotter
    output %_plotter
ret

@plotnew
    iobuff %_plotter
ret

@_plotarray
    push 1
    loadb
    :lus_plotarray 
        storeb
        readelm '_input_plotarray'
        jumpf :klaar_plotarray
        storem %_plotter
        incb
    jump :lus_plotarray
    :klaar_plotarray
    output %_plotter
    clrb
ret

@draw
    storem %_xygraph
    storem %_xygraph
    #output %_xygraph
ret

@drawCommit
    output %_xygraph
ret

@char2prtbuff
    storem %_display
    push 1
    storem %_display
ret

@num2prtbuff
    storem %_display
    push 0
    storem %_display
ret

@printbuff
    output %_display
    iobuff %_display
ret

@_gcd
    call @gcd
    storeb
    clrb
ret

@lcm
    storem $b_lcm
    storem $a_lcm
    loadm $a_lcm
    loadm $b_lcm
    loadm $a_lcm
    loadm $b_lcm
    call @_gcd
    call @div
    call @mul
ret


@sleep
    speed 0
    settimer 1
    loadb
    decb
    :lus_sleep
        gettimer 1
        loada 
        testg 
        jumpt :eind_sleep
        jump :lus_sleep
    :eind_sleep
    clra
    clrb
ret

@isqrt
    storem $y_isqrt
    push 0
    storem $L_isqrt
    loadm $y_isqrt
    push 1
    call @plus
    storem $R_isqrt
    :_0_condition_start_isqrt
    loadm $L_isqrt
    loadm $R_isqrt
    push 1
    call @minus
    call @neq
    loada
    testz
    clra
    jumpf :_0_repeat_end_isqrt
    loadm $L_isqrt
    loadm $R_isqrt
    call @plus
    push 2
    call @div
    storem $M_isqrt
    loadm $M_isqrt
    loadm $M_isqrt
    call @mul
    loadm $y_isqrt
    call @lt
    loada
    testz
    clra
    jumpf :_1_do_end_isqrt
    loadm $M_isqrt
    storem $R_isqrt
    jump :done
    :_1_do_end_isqrt
    loadm $M_isqrt
    storem $L_isqrt
    :done
    jump :_0_condition_start_isqrt
    :_0_repeat_end_isqrt
    loadm $L_isqrt
ret


@core 
    speed 0
    :loop_core
        join
        push 1
        call @sleep
    jump :loop_core
ret



@__illegal_Array_Index
    push 'Illegal\_INDEX\_error\_'
    call @char2prtbuff
    call @printbuff
halt

@__MemAllocGlobels
    call @init_vmachine
    push 'mem\_configuration\_definition\_not\_defined'
    call @char2prtbuff
    call @printbuff
halt