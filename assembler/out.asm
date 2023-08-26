@main
settimer 0
call @stackssys
push 0
call @input
storem $einde
:_0_condition_start
push 1
call @plus
call @dup
call @dup
loadm $einde
call @neq
loada
testz
clra
jumpf :_0_repeat_end
call @abs
call @plot
jump :_0_condition_start
:_0_repeat_end
pull
pull
prttimer 0
ret
