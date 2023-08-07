@main
call @stackssys
push 4
storem $number
call @input
storem $end
:_0_condition_start
loadm $number
loadm $end
call @neq
loada
testz
clra
jumpf :_0_repeat_end
loadm $number
loadm $number
push 2
call @div
:_1_condition_start
call @dup
call @dup
call @mul
loadm $number
call @lt
loada
testz
clra
jumpf :_1_repeat_end
push 1
call @minus
jump :_1_condition_start
:_1_repeat_end
call @dup
call @mul
call @minus
call @dup
call @plot
prt
loadm $number
push 1
call @plus
storem $number
jump :_0_condition_start
:_0_repeat_end
ret
