@main
settimer 0
speed 0
push 1
storem $y
:_0_condition_start
loadm $y
push 2000
call @neq
loada
testz
clra
jumpf :_0_repeat_end
push 0
storem $L
loadm $y
push 1
call @plus
storem $R
:_1_condition_start
loadm $L
loadm $R
push 1
call @minus
call @neq
loada
testz
clra
jumpf :_1_repeat_end
loadm $L
loadm $R
call @plus
push 2
call @div
storem $M
loadm $M
loadm $M
call @mul
loadm $y
call @lt
loada
testz
clra
jumpf :_2_do_end
loadm $M
storem $R
jump :done
:_2_do_end
loadm $M
storem $L
:done
jump :_1_condition_start
:_1_repeat_end
loadm $L
call @plot
loadm $y
push 1
call @plus
storem $y
jump :_0_condition_start
:_0_repeat_end
prttimer 0
ret
