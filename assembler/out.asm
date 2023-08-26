@main
settimer 0
call @stackssys
speed 5
push 1
storem $n
call @input
storem $einde
:_0_condition_start
loadm $n
loadm $einde
call @neq
loada
testz
clra
jumpf :_0_repeat_end
loadm $n
call @abs
call @plot
loadm $n
push 1
call @plus
storem $n
jump :_0_condition_start
:_0_repeat_end
prttimer 0
ret
