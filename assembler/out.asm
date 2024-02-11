@main
settimer 0
speed 0
push 1000
storem $base
push 1
storem $deler
push 0
storem $sum
:_0_condition_start
loadm $deler
loadm $base
call @gt
loada
testz
clra
jumpf :_0_repeat_end
loadm $sum
push 10
call @div
call @plot
loadm $base
loadm $deler
call @div
loadm $sum
call @plus
storem $sum
loadm $deler
push 2
call @plus
storem $deler
loadm $sum
push 10
call @div
call @plot
loadm $sum
loadm $base
loadm $deler
call @div
call @minus
storem $sum
loadm $deler
push 2
call @plus
storem $deler
jump :_0_condition_start
:_0_repeat_end
prttimer 0
ret
