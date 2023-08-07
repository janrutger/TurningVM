@main
call @stackssys
push 4
storem $n
call @input
storem $end
:_0_condition_start
loadm $n
loadm $end
call @neq
loada
testz
clra
jumpf :_0_repeat_end
push 1
push 8
loadm $n
call @mul
call @plus
push 4
call @div
:_1_condition_start
call @dup
call @dup
call @mul
loadm $n
call @lt
loada
testz
clra
jumpf :_1_repeat_end
push 1
call @minus
jump :_1_condition_start
:_1_repeat_end
storem $m
:_2_condition_start
push 1
loadm $m
call @plus
loadm $m
call @mul
push 2
loadm $n
call @mul
call @mod
push 0
call @neq
loada
testz
clra
jumpf :_2_repeat_end
loadm $m
push 1
call @plus
storem $m
jump :_2_condition_start
:_2_repeat_end
loadm $m
call @plot
loadm $n
push 1
call @plus
storem $n
jump :_0_condition_start
:_0_repeat_end
ret
