@stackssys
    speed 0

    push '+'
    index @plus 

    push '-'
    index @minus 

    push '*'
    index @mul 

    push '/'
    index @div 

    push '%'
    index @mod 

    push '!'
    index @factorial

    push 'GCD'
    index @_gcd

    push '=='
    index @eq

    push '!='
    index @neq

   
    push '<'
    index @lt

    push '>'
    index @gt

    push 'DUP'
    index @dup

    speed 0

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