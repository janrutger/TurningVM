@main
call @stackssys
:loop
:_0_condition_start
call @rawin
push 1
call @eq
loada
testz
clra
jumpf :_0_repeat_end
call @dup
push 'q'
call @eq
loada
testz
clra
jumpf :_1_do_end
pull
jump :endloop
:_1_do_end
call @dup
push '+'
call @eq
loada
testz
clra
jumpf :_2_do_end
pull
call @plus
:_2_do_end
call @dup
push '-'
call @eq
loada
testz
clra
jumpf :_3_do_end
pull
call @minus
:_3_do_end
call @dup
push '*'
call @eq
loada
testz
clra
jumpf :_4_do_end
pull
call @mul
:_4_do_end
call @dup
push '/'
call @eq
loada
testz
clra
jumpf :_5_do_end
pull
call @div
:_5_do_end
call @dup
push '.'
call @eq
loada
testz
clra
jumpf :_6_do_end
pull
prt
:_6_do_end
jump :_0_condition_start
:_0_repeat_end
jump :loop
:endloop
ret
