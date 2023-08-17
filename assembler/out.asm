@main
call @stackssys
push 1
storem $start
call @input
storem $end
:_0_condition_start
loadm $start
loadm $end
call @neq
loada
testz
clra
jumpf :_0_repeat_end
loadm $end
loadm $start
call @mod
call @plot
loadm $start
push 1
call @plus
storem $start
jump :_0_condition_start
:_0_repeat_end
ret
