@stackssys
    speed 5
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
ret


@plot
    storem %_plotter
    output %_plotter
ret

@_gcd
    call @gcd
    storeb
    clrb
ret