@main
call @stackssys
push 1
storem $i
push 100
storem $end
push 1
storem $s
:_0_condition_start
loadm $i
loadm $end
call @neq
loada
testz
clra
jumpf :_0_repeat_end
loadm $i
loadm $i
call @mul
loadm $s
loadm $s
call @mul
call @plus
storem $j
loadm $j
push 2
call @div
:_1_condition_start
call @dup
call @dup
call @mul
loadm $j
call @lt
loada
testz
clra
jumpf :_1_repeat_end
push 1
call @minus
jump :_1_condition_start
:_1_repeat_end
push 1
call @plus
storem $k
loadm $k
call @plot
loadm $k
loadm $k
call @mul
loadm $j
call @minus
storem $s
loadm $i
push 1
call @plus
storem $i
jump :_0_condition_start
:_0_repeat_end
ret
