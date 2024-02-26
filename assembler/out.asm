@main
settimer 0
speed 0
array *array
push 3
storem *array
push 5
storem *array
push 9
storem *array

call @input

storem $zoek
push 1
storem $_0_array
:_0_start_each
    loadm $_0_array
    readelm *array
    jumpf :_0_end_each
        call @dup
        loadm $zoek
        call @eq
        loada
        testz
        clra
        jumpf :_1_goto_end
            jump :found
        :_1_goto_end
            pull
            loadm $_0_array
            loadb
            incb
            moveb
            storem $_0_array
    jump :_0_start_each
:_0_end_each
jump :notfound

:found
    prt
:notfound
    prttimer 0
    ret
