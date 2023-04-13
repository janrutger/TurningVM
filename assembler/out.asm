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
jump :done
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
jump :done
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
jump :done
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
jump :done
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
jump :done
:_6_do_end
pull
:done
jump :_0_condition_start
:_0_repeat_end
jump :loop
:endloop
ret
