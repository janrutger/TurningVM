@main
call @stackssys
push 6
storem $number
push 0
storem $som
:_0_condition_start
push 1000
loadm $som
call @lt
loada
testz
clra
jumpf :_0_repeat_end
loadm $som
loadm $number
call @plus
storem $som
loadm $som
push 1
call @minus
call @dup
push 5
call @mod
push 0
call @neq
loada
testz
clra
jumpf :_1_do_end
prt
:_1_do_end
loadm $som
push 1
call @plus
call @dup
push 5
call @mod
push 0
call @neq
loada
testz
clra
jumpf :_2_do_end
prt
:_2_do_end
:_3_condition_start
call @dup
push 5
call @neq
loada
testz
clra
jumpf :_3_repeat_end
pull
jump :_3_condition_start
:_3_repeat_end
jump :_0_condition_start
:_0_repeat_end
prt
ret
