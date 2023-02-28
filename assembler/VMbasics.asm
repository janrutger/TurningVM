@basicsys
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

    push '=='
    index @eq

    push '!='
    index @neq

    push '>'
    index @gt

    push '<'
    index @lt

    speed 1

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