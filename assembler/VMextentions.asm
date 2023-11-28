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